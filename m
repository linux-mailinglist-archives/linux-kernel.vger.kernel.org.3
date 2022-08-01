Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F38586337
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbiHAEGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiHAEGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:06:12 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034FE637A
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:06:10 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220801040609epoutp01b5624dbb5c625af2a4fafcc27b7e167c~HHOeo3gYB2659126591epoutp01U
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:06:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220801040609epoutp01b5624dbb5c625af2a4fafcc27b7e167c~HHOeo3gYB2659126591epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659326769;
        bh=1xmuozlUVstGB2fJ4rqWFjLc1ucMPbO4tmMpICPDtFM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=mpc5AAs1+ijnYyVEASQskX6XYwwjnDfQwo/1cgAcdjWAyKe3qaAGYTI2X+Wj4PL4r
         4AqCdt2wUs9D/CKKshlJpqpBihQeJ1IUd7OvqZiJTRf3PszNyfU17ns7l0dkkBNa2y
         1M6k4MLHUReIt8nw4KXtIYuHL6fH+7GbbPWJISk0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220801040608epcas2p196a71867d2ed4b4adbedbdd675b02a68~HHOeED2gl2566225662epcas2p1J;
        Mon,  1 Aug 2022 04:06:08 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.91]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Lx4L80Hs3z4x9Pq; Mon,  1 Aug
        2022 04:06:08 +0000 (GMT)
X-AuditID: b6c32a48-9f7ff700000025be-f2-62e7512f8858
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.4D.09662.F2157E26; Mon,  1 Aug 2022 13:06:07 +0900 (KST)
Mime-Version: 1.0
Subject: RE: RE: [PATCH v0] f2fs: allow direct read for zoned device
Reply-To: eunhee83.rho@samsung.com
Sender: Eunhee Rho <eunhee83.rho@samsung.com>
From:   Eunhee Rho <eunhee83.rho@samsung.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YuXZSTw4reBDtLgk@google.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220801040607epcms2p82da0594039ba5f1ed77c451e2d13c965@epcms2p8>
Date:   Mon, 01 Aug 2022 13:06:07 +0900
X-CMS-MailID: 20220801040607epcms2p82da0594039ba5f1ed77c451e2d13c965
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmqa5+4PMkg6avNhanp55lsnh5SNPi
        55MONosn62cxW1xa5G5xedccNgc2j02rOtk8di/4zOTRt2UVo8fnTXIBLFHZNhmpiSmpRQqp
        ecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAq5UUyhJzSoFCAYnFxUr6
        djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ2RkTj+9jKmjkrPh0
        hbuBcQZ7FyMnh4SAiUT702lANheHkMAORol9TVOYuhg5OHgFBCX+7hAGqREWcJHYt+Y3C4gt
        JKAk8ffgfSaIuK7ElC2TGEFsNgFtiSvH21lBbBEBFYlDiy6DzWQW2M8ocadnBxPEMl6JGe1P
        WSBsaYnty7eCNXMKaElM+vEWKq4h8WNZLzOELSpxc/Vbdhj7/bH5jBC2iETrvbNQNYISD37u
        hopLSNzd2MIGYedL9Dw5CrW3QmLniqtQNfoS1zo2gu3iFfCVOLb0FVg9i4CqxIkpLVA3uEgc
        urEIbD6zgLzE9rdzmEFhwiygKbF+lz6IKSGgLHHkFgvMVw0bf7Ojs5kF+CQ6Dv+Fi++Y9wTq
        GjWJxR8XsE5gVJ6FCOhZSHbNQti1gJF5FaNYakFxbnpqsVGBCTxqk/NzNzGC06CWxw7G2W8/
        6B1iZOJgPMQowcGsJMJ7x+V5khBvSmJlVWpRfnxRaU5q8SFGU6AvJzJLiSbnAxNxXkm8oYml
        gYmZmaG5kamBuZI4r1fKhkQhgfTEktTs1NSC1CKYPiYOTqkGJsMT8ed1bjvwS09Y/PT81qzd
        121cug42CCWcfy/kdZ/LbnJQOee5C7GhvlP3p7z3snzF+/GdnaIjw4U13ROqU0OZxb0rT1+2
        VFXZN/9964dT8Z+4jh7NEzy49oPW1ur373RmFs262Ka4/3N99/6Hto0Pr7M/3qnt6PFKilmc
        bcH9Xe0C3mwT17UpHDi72mvN/2PBGwt/fb/z4m9+rorJA+cpxa5XLrxhPX7S9npUIaOTxlHr
        1VIyr/ak/rnBY932yvDzrPtTQ/e35rfe5OE4b7lQoXp6QXFR2OcrAd/dMnZOnFb371kVs1Z2
        Revmcxb3PxT6v+h7zZWf71bqbXOQYa2EkPCC0rKvG38Yr1G8s0qJpTgj0VCLuag4EQAwmuff
        DAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220729002517epcms2p35eed262c3349287436c1848ab350c2d4
References: <YuXZSTw4reBDtLgk@google.com>
        <20220729002517epcms2p35eed262c3349287436c1848ab350c2d4@epcms2p3>
        <CGME20220729002517epcms2p35eed262c3349287436c1848ab350c2d4@epcms2p8>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 07/29, Eunhee Rho wrote:
>> For zoned devices, f2fs forbids direct IO and forces buffered IO
>> to serialize write IOs. However, the constraint does not apply to
>> read IOs.
>> 
>> Signed-off-by: Eunhee Rho <eunhee83.rho@samsung.com>
>> ---
>>  fs/f2fs/f2fs.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index d0f428aef34b..f69731f17402 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -4471,7 +4471,7 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
>>  	 * for blkzoned device, fallback direct IO to buffered IO, so
>>  	 * all IOs can be serialized by log-structured write.
>>  	 */
>> -	if (f2fs_sb_has_blkzoned(sbi))
>> +	if (f2fs_sb_has_blkzoned(sbi) && (rw == WRITE))
>>  		return true;
>
>Actually we don't need to check the device type, but rely on the
>filesystem allocation policy like the below lfs mode. Can we remove this
>line simply?
>
>>  	if (f2fs_lfs_mode(sbi) && (rw == WRITE)) {
>>  		if (block_unaligned_IO(inode, iocb, iter))
>> -- 
>> 2.25.1
>

Yes, I will reflect on the next patch.
Thanks. 
