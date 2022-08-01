Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C12586327
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 05:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbiHADpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 23:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiHADpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:45:43 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27B060DD
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 20:45:41 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220801034540epoutp04d842788720f8cfd10bdcae2da59415a2~HG8mP4p5Q2279922799epoutp04N
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 03:45:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220801034540epoutp04d842788720f8cfd10bdcae2da59415a2~HG8mP4p5Q2279922799epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659325540;
        bh=ymLE9gFZmGJ45hBlzXD584V1zn4y6YEzfrxY1b4vzeQ=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=Ju+cO3wxSdLkUjup5h0E/pfDRd0ST53gqR2hAUUQvwkTUR81lpCwzEv4BB7q1S7K6
         xI5aLqmUapjB6kqASEXpQHu4DFX4tVOBA2XYTJr71zrXYbRn448azPiRwDBY/GQHjf
         KG+3RZWtiTRiAQUb5e1VXyKuRBgoqy34fIua+uqY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220801034539epcas2p4bcd25c77870a4ed1f7d5995dd7751a0b~HG8lprVtR1363313633epcas2p4l;
        Mon,  1 Aug 2022 03:45:39 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.97]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Lx3tW0X9cz4x9Pv; Mon,  1 Aug
        2022 03:45:39 +0000 (GMT)
X-AuditID: b6c32a45-471ff700000025c2-0b-62e74c626b13
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.98.09666.26C47E26; Mon,  1 Aug 2022 12:45:39 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v5 2/6] scsi: ufs: wb: Change functions name and
 modify parameter name
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
In-Reply-To: <01a30932-adae-a499-1194-57c925a3633f@acm.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220801034538epcms2p270ca60820681d09de109a2df504a3806@epcms2p2>
Date:   Mon, 01 Aug 2022 12:45:38 +0900
X-CMS-MailID: 20220801034538epcms2p270ca60820681d09de109a2df504a3806
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmqW6yz/MkgzfTGC1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZouXhzQtFt3YxmRxedccNovu6zvYLJYf/8fkwOVx+Yq3x+I9L5k8
        Jiw6wOjxfX0Hm8fHp7dYPPq2rGL0+LxJzqP9QDdTAEdUtk1GamJKapFCal5yfkpmXrqtkndw
        vHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0IlKCmWJOaVAoYDE4mIlfTubovzSklSFjPzi
        Elul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMx+fWshbMZKnYMPclUwPjJuYuRk4O
        CQETicUNb9i7GLk4hAR2MErcvzCXrYuRg4NXQFDi7w5hkBphgXiJuXfnsYHYQgJKEufWzGIE
        KREWMJC41WsOEmYT0JP4uWQGG8gYEYETzBLbjzxhhJjPKzGj/SkLhC0tsX35VrA4p4C1xMfX
        y5kg4hoSP5b1Qt0jKnFz9Vt2GPv9sflQc0QkWu+dhaoRlHjwczdUXFLi0KGvYCdLCORLbDgQ
        CBGukXi7/ABUib7EtY6NYCfwCvhKTFv/F2wti4CqxI8XH6BqXCSmX38EtpZZQF5i+9s5zCAj
        mQU0Jdbv0oeYrixx5BYLzFMNG3+zo7OZBfgkOg7/hYvvmPeECaJVTWJRkxFEWEbi6+H57BMY
        lWYhQnkWkrWzENYuYGRexSiWWlCcm55abFRgCI/Y5PzcTYzglKrluoNx8tsPeocYmTgYDzFK
        cDArifDecXmeJMSbklhZlVqUH19UmpNafIjRFOjhicxSosn5wKSeVxJvaGJpYGJmZmhuZGpg
        riTO65WyIVFIID2xJDU7NbUgtQimj4mDU6qBqWWfgdar8s3S/NzcX3929lepHz+/3PvT9NuP
        HrOxP2pamp644Oyu1eHZspfnRf/70qYsvPS7zbt9DP0zlq7IyDI87bZd+cOeq723OFde8ncV
        PnxB5Y/7dO3Fhxeo6L4y1N4QXMZ98sTZyRYdnGGva1Jf8V8IbzrD/ePF5NKfmzt38mtvZ4/M
        2Gy4Y7n3rQiPFIvwFLs3Hyy2tXltffVd13vp3jN+fKs4gnfG9SrXnvm197JcnM3Can/J14yG
        Rku5O2fWXXwf/j2IgXt/dw1b2CW+0mLp9Ab91JWcj1M+r2cLqd/xe8q2GAG+hwIu2RsldL5L
        lSi1XBH9JrJ16mLdhWcKUtn/RkkyLLkW+//obCWW4oxEQy3mouJEABv055cyBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368
References: <01a30932-adae-a499-1194-57c925a3633f@acm.org>
        <20220729045252epcms2p7fee5c1cdca5e4bef02a833e40f80649b@epcms2p7>
        <20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p8>
        <20220729045433epcms2p77ff2cdde6ddffd9ab0b0810ebe84f0e5@epcms2p7>
        <CGME20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p2>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 7/28/22 21:54, Jinyoung CHOI wrote:
>> -static inline void ufshcd_wb_config(struct ufs_hba *hba)
>> +static void ufshcd_wb_set_default_flags(struct ufs_hba *hba)
>
>It is not clear to me why the new name is considered an improvement? The 
>old name looks better to me. If you want to rename this function anyway, 
>how about ufshcd_configure_wb()?
>
>Thanks,
>
>Bart.

It is desirable to express it as configure because it sets several values.
I will change it.
Thank you for your opinion.

Kind Regards,
Jinyoung.
