Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244BA5863C3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 07:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbiHAFf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 01:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiHAFfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 01:35:54 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0FF9FF5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 22:35:52 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220801053551epoutp014e251a465a67537242a2f9d0bc09a7df~HIczHhExp1465314653epoutp01v
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:35:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220801053551epoutp014e251a465a67537242a2f9d0bc09a7df~HIczHhExp1465314653epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659332151;
        bh=zNra2Ieju11CQ/z1mTVbBscSXhxWJKuVmYMhiJEc1VI=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=IpsVet8I1YZoCJZKMjU4QDeXc0cjOPhXbTSYZG49ijjGdGzgEeZGAqMNybKkWyg6p
         72hGJ4p81ENMSAxjIqCcbHODyweKqIf2+EsAB9IDRmpv1rP1imSMJjqCuUDj4z3T1U
         rzwsF5sE4ZwcYoBstZliR+Js8LWI5K6A6rbRJ834=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220801053550epcas2p411ecf73e8c08cafab99011e2c4d76965~HIcynvz3l1219812198epcas2p4T;
        Mon,  1 Aug 2022 05:35:50 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.100]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Lx6Kf17fNz4x9Pr; Mon,  1 Aug
        2022 05:35:50 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-ed-62e766360a09
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.A2.09642.63667E26; Mon,  1 Aug 2022 14:35:50 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v5 5/6] scsi: ufs: wb: Modify messages
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
In-Reply-To: <0fccbbcf-2eb0-56b0-8334-0952a03308b3@acm.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220801053549epcms2p34b374c5256cdecab72882cf9e4f55279@epcms2p3>
Date:   Mon, 01 Aug 2022 14:35:49 +0900
X-CMS-MailID: 20220801053549epcms2p34b374c5256cdecab72882cf9e4f55279
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmma5Z2vMkg72vWS1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZouXhzQtFt3YxmRxedccNovu6zvYLJYf/8fkwOVx+Yq3x+I9L5k8
        Jiw6wOjxfX0Hm8fHp7dYPPq2rGL0+LxJzqP9QDdTAEdUtk1GamJKapFCal5yfkpmXrqtkndw
        vHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0IlKCmWJOaVAoYDE4mIlfTubovzSklSFjPzi
        Elul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMi/9WMhV0s1TcvPqKvYFxInMXIyeH
        hICJxKdnj4BsLg4hgR2MEv/nL2PpYuTg4BUQlPi7QxikRljAVuLwrV5WEFtIQEni3JpZjCAl
        wgIGErd6zUHCbAJ6Ej+XzGADGSMicIJZYvuRJ4wQ83klZrQ/ZYGwpSW2L98KFucUsJa48/wV
        G0RcQ+LHsl6oe0Qlbq5+yw5jvz82H2qOiETrvbNQNYISD37uhopLShw69JUN5B4JgXyJDQcC
        IcI1Em+XH4Aq0Ze41rER7AReAV+JG/c+gI1hEVCVePBrDtQJLhLrJjeB1TMLyEtsfzuHGWQk
        s4CmxPpd+hDTlSWO3GKBeaph4292dDazAJ9Ex+G/cPEd854wQbSqSSxqMoIIy0h8PTyffQKj
        0ixEKM9CsnYWwtoFjMyrGMVSC4pz01OLjQqM4RGbnJ+7iRGcUrXcdzDOePtB7xAjEwfjIUYJ
        DmYlEd47Ls+ThHhTEiurUovy44tKc1KLDzGaAj08kVlKNDkfmNTzSuINTSwNTMzMDM2NTA3M
        lcR5vVI2JAoJpCeWpGanphakFsH0MXFwSjUwpTDxOycUn9i/PeCI3p+YqN6NHzMXH7DmeaVm
        HXaiyUh80+xIi3UKL76vLmu0fWMgGLNYZaKRdbyU4ZYLW1UWnxLk/Z34xuttkcuyOa8nzD99
        S6skLnZR0pn1Ge4cFUbytho/f2zTluiv9pt8e8KrRbtrVt4x/xvD/zHfX4Ip//Z9bXbP7Rs4
        jN+6T2uV/XGFP/Lar5nHRVLD43b+epkzoSK8Xu1pzx8b6aJJMdfLArR//5H0CH/8KrH/9nLl
        1IL1+xosm5pT287tD5ouc2nmSv1riZU2b788TJ3ZX/ZT4Pk/juarVbIPtsRPaHOMWLDs4aFd
        b4JUZIu8V9/Q3vEk/P6yFK6Zcf5fKkpVFBe1KrEUZyQaajEXFScCAPyyMvkyBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368
References: <0fccbbcf-2eb0-56b0-8334-0952a03308b3@acm.org>
        <20220729045656epcms2p1e6912ae09ca2122d4d04854878e19b2c@epcms2p1>
        <20220729045600epcms2p45c0f8a5a0a76c7fe85b0961570de89ce@epcms2p4>
        <20220729045433epcms2p77ff2cdde6ddffd9ab0b0810ebe84f0e5@epcms2p7>
        <20220729045252epcms2p7fee5c1cdca5e4bef02a833e40f80649b@epcms2p7>
        <20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p8>
        <20220729045756epcms2p40a1baa2c6bf17772023ccec20aef3f0a@epcms2p4>
        <CGME20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p3>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 7/28/22 21:57, Jinyoung CHOI wrote:
>>   	ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_EN);
>>   	if (ret) {
>> -		dev_err(hba->dev, "%s Write Booster %s failed %d\n",
>> +		dev_err(hba->dev, "%s: Write Booster %s failed %d\n",
>>   			__func__, enable ? "enable" : "disable", ret);
>>   		return ret;
>>   	}
>
>Please also fix the grammar (enable -> enabling; disable -> disabling).
>
>Otherwise this patch looks good to me.
>
>Thanks,
>
>Bart.

OK, I will fix it. 

Thanks,
Jinyoung.
