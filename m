Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E53B5863BF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 07:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbiHAF11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 01:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiHAF1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 01:27:25 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9CCDF71
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 22:27:23 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220801052719epoutp015316ea8d111880c2e8e6ffa18bc7b1c4~HIVWuDLg90581905819epoutp01j
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:27:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220801052719epoutp015316ea8d111880c2e8e6ffa18bc7b1c4~HIVWuDLg90581905819epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659331639;
        bh=4L46FagLgyJ5JDvVZYktopEo4AtRddUa2OuM1hy48r8=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=ZivhipyvXg2hPDadtXBeFORgtUIJzgrKQwbQ2zhtd6tA2CTL/B2NRHYIkvQn22CWw
         S5Ei05zQSceoDr0ix8pkFoZigQ78Tj609eGPu3aV3QmcCiI01TJLCMkkATOMd6hQSP
         Psh/5b8P+uuwDhTWB80tEE9L9p6dEDzWT2I4a+9U=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220801052718epcas2p146f395c293d1db9dd60c2306cb6bd213~HIVWJ556z0677806778epcas2p1D;
        Mon,  1 Aug 2022 05:27:18 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.102]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Lx67p4dZmz4x9Q7; Mon,  1 Aug
        2022 05:27:18 +0000 (GMT)
X-AuditID: b6c32a45-471ff700000025c2-99-62e76436ae3d
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.54.09666.63467E26; Mon,  1 Aug 2022 14:27:18 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v5 3/6] scsi: ufs: wb: Add explicit flush sysfs
 attribute
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <82d1e6da-df4b-31bb-ec46-76099d7c3288@acm.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220801052718epcms2p11e9e1677abbc0e573cddff4e641e212f@epcms2p1>
Date:   Mon, 01 Aug 2022 14:27:18 +0900
X-CMS-MailID: 20220801052718epcms2p11e9e1677abbc0e573cddff4e641e212f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmqa5ZyvMkg6cTlCxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZouXhzQtFt3YxmRxedccNovu6zvYLJYf/8fkwOVx+Yq3x+I9L5k8
        Jiw6wOjxfX0Hm8fHp7dYPPq2rGL0+LxJzqP9QDdTAEdUtk1GamJKapFCal5yfkpmXrqtkndw
        vHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0IlKCmWJOaVAoYDE4mIlfTubovzSklSFjPzi
        Elul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMTZ9mshVME6mYtfEzcwPjX/4uRk4O
        CQETid8PZjN3MXJxCAnsYJTY1XKbvYuRg4NXQFDi7w5hkBphgSCJ489fMoLYQgJKEufWzGIE
        KREWMJC41WsOEmYT0JP4uWQGG8gYEYETzBLbjzxhhJjPKzGj/SkLhC0tsX35VrA4p4C1xNvG
        y+wQcQ2JH8t6mSFsUYmbq9+yw9jvj82HmiMi0XrvLFSNoMSDn7uh4pIShw59ZQO5R0IgX2LD
        gUCIcI3E2+UHoEr0Ja51bAQ7gVfAV+LNuhZWkHIWAVWJbc8LIEpcJJoWrGEFsZkF5CW2v53D
        DFLCLKApsX6XPsRwZYkjt1hgfmrY+Jsdnc0swCfRcfgvXHzHvCdMEK1qEouajCDCMhJfD89n
        n8CoNAsRyLOQrJ2FsHYBI/MqRrHUguLc9NRiowJDeLwm5+duYgQnVC3XHYyT337QO8TIxMF4
        iFGCg1lJhPeOy/MkId6UxMqq1KL8+KLSnNTiQ4ymQP9OZJYSTc4HpvS8knhDE0sDEzMzQ3Mj
        UwNzJXFer5QNiUIC6YklqdmpqQWpRTB9TBycUg1MxyVVX30zv9woWVyjppGms+Lb9VBZht8y
        c8NesO0+JyeZJN0i9rBwH8+Hm28eNL9uud4RXzs1cTnv9jcTgjz2flE8+OH700uKgY25D+LO
        BczrEDUPemH1OFP6oPynEDeN7AKXLaemyH7j0rJb13737wa1MIMdU451FH3NFn7yTbfUWu9n
        oMbT/rVaRbMus8x3WnJs7l6H27x2kdX66eU/PV7JCJ+5lutqrLTbX2rZRX+pT07b+x8Y7TrR
        usY7aSKjy7/SXeclZPRli2yOhK5Y4PlL/pbKfu1dO5k8VU4tOpW+9X2SWkfP4y+fl61yuV13
        4+Mxnze2s7s8XFtfzhLpXFTsILzB/Fp2DLdRXMRvJZbijERDLeai4kQAo0/1KDEEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368
References: <82d1e6da-df4b-31bb-ec46-76099d7c3288@acm.org>
        <20220729045433epcms2p77ff2cdde6ddffd9ab0b0810ebe84f0e5@epcms2p7>
        <20220729045252epcms2p7fee5c1cdca5e4bef02a833e40f80649b@epcms2p7>
        <20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p8>
        <20220729045600epcms2p45c0f8a5a0a76c7fe85b0961570de89ce@epcms2p4>
        <CGME20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p1>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 7/28/22 21:56, Jinyoung CHOI wrote:
>> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
>> index 6b248abb1bd7..7e9e1db55d60 100644
>> --- a/Documentation/ABI/testing/sysfs-driver-ufs
>> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
>> @@ -1417,6 +1417,16 @@ Description:	This node is used to set or display whether UFS WriteBooster is
>>   		platform that doesn't support UFSHCD_CAP_CLK_SCALING, we can
>>   		disable/enable WriteBooster through this sysfs node.
>>   
>> +What:		/sys/bus/platform/drivers/ufshcd/*/wb_buf_flush_en
>> +What:		/sys/bus/platform/devices/*.ufs/wb_buf_flush_en
>> +Date:		July 2022
>> +Contact:	Jinyoung Choi <j-young.choi@samsung.com>
>> +Description:	This node is used to set or display whether WriteBooster
>                      ^^^^
>
>Please change "node" into "attribute" (here and below). Sysfs files are 
>called attributes.
>

The wb_on description is also written as node.
This will also be changed to other commit.


>> +		buffer flusing is enabled. The data written in the WriteBooster
>                        ^^^^^^^
>                        flushing?
>> +		Buffer can be flushed by an explicit host command or
>> +		implicitly while in hibernate (HIBERN8) state.
>
>The above sentence is misleading because it suggests that setting this 
>attribute causes the WB buffer to be flushed in its entirety. That is 
>not correct - what this attribute controls is whether or not the UFS 
>device is allowed to start with flushing the WB buffer.
>

It seems to have been written so briefly.
Because each device manufacturer may have different flush policies,
So, I did not describe the amount. This is the same as the ufs spec.
I will add more explanation.
And, I don't fully understand your comment (That is not correct ~)
If you explain it more, I will consider it.


>> +	if (!ufshcd_is_wb_allowed(hba) ||
>> +	    (hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL)) {
>> +		dev_warn(dev, "It is not allowed to configure WB buf flush!\n");
>
>flush -> flushing
>

OK, I will fix it.


>> +	ufshcd_rpm_get_sync(hba);
>> +	res = ufshcd_wb_toggle_buf_flush(hba, wb_buf_flush_en);
>> +	ufshcd_rpm_put_sync(hba);
>> +out:
>> +	up(&hba->host_sem);
>> +	return res < 0 ? res : count;
>> +}
>
>Please leave a blank line above goto labels as requested by the kernel 
>coding style guide.
>
>Thanks,
>
>Bart.

OK, I will fix it.
wb_on_store() will also be modified with this. (other commit)

Kind Regards,
Jinyoung
