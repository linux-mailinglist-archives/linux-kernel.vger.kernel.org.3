Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA4B4B7C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245245AbiBPBCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:02:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiBPBCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:02:42 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB60F86E3C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:02:30 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220216010227epoutp0162874000d043a0c1f6547d264a980cb4~UHotGvY1y2383823838epoutp01S
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:02:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220216010227epoutp0162874000d043a0c1f6547d264a980cb4~UHotGvY1y2383823838epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644973347;
        bh=6F2pv03rSyb0l3m/G1mhHi3z2iu7pZETXNe3I0pc9+k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=eK5iZZ8CSbKymNeSrOFHfJAvRTsHxzsISV2UwLebv4KmbDELMAuhFsnmbPDPHQzBt
         hMUa9yG9nMNi6k3dAChJU6GwEV0o7ohug56Mlc+PUBlRoX8w1AOmD+5mZ8CHG1blik
         q75rzyrNCZuY0Grs562G/pRaNGqAVYQffh82v+TI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220216010227epcas1p2a51d4e79fd2b04e19953faf779c392a9~UHos08GNd1366313663epcas1p2P;
        Wed, 16 Feb 2022 01:02:27 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.145]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Jz06j0Lyyz4x9QJ; Wed, 16 Feb
        2022 01:02:21 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.8F.21932.C1D4C026; Wed, 16 Feb 2022 10:02:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220216010219epcas1p16a351e60d11478c3f68f23af2891b48d~UHomJm6jA2569825698epcas1p1o;
        Wed, 16 Feb 2022 01:02:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220216010219epsmtrp20f73d29c32ce3e175d0b3c9747ec3752~UHomIz0X-1789517895epsmtrp26;
        Wed, 16 Feb 2022 01:02:19 +0000 (GMT)
X-AuditID: b6c32a38-929ff700000255ac-73-620c4d1cc9ff
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.C3.08738.B1D4C026; Wed, 16 Feb 2022 10:02:19 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220216010219epsmtip24566ff6c979294f26fa5ea1d8492a855~UHol8aZti0549805498epsmtip2L;
        Wed, 16 Feb 2022 01:02:19 +0000 (GMT)
Subject: Re: [PATCH -next] extcon: Fix some kernel-doc comments
To:     Yang Li <yang.lee@linux.alibaba.com>, myungjoo.ham@samsung.com
Cc:     linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2bde97d8-6575-0e0f-81bb-dd98f5b60607@samsung.com>
Date:   Wed, 16 Feb 2022 10:26:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20220104084359.41051-1-yang.lee@linux.alibaba.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmvq6sL0+SwdcYi3d7p7FZXN41h83i
        duMKNot3jYcZHVg8dj609OjbsorR4/MmuQDmqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMz
        A0NdQ0sLcyWFvMTcVFslF58AXbfMHKBdSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSC
        lJwC0wK94sTc4tK8dL281BIrQwMDI1OgwoTsjIWb9jAX9AtUXNy8mq2BcTZvFyMnh4SAicSM
        rT1MXYxcHEICOxgl5mzuY4dwPjFKXNl4nBHC+cwo8fzmHBaYljVLe9ggErsYJc5v2wnV/55R
        4sTdf4wgVcIC9hK/FywE6xARcJJYvm8PE4jNLOAusfTpfLA4m4CWxP4XN9hAbH4BRYmrPx6D
        9fIK2En8/buDFcRmEVCVuLTzDViNqECYxMltLVA1ghInZz4Bm8Mp4CDxfs80doj54hK3nsyH
        2iUvsf3tHGaQ4yQEvrJL7Nm4kRHiBReJFV+uskHYwhKvjm9hh7ClJD6/28sG0dDMKNHw4jYj
        hNPDKHH0WR80AIwl9i+dDLSCA2iFpsT6XfoQYUWJnb/nMkJs5pN497WHFaREQoBXoqNNCKJE
        WeLyg7tMELakxOL2TrYJjEqzkPwzC8kPs5D8MAth2QJGllWMYqkFxbnpqcWGBSbw+E7Oz93E
        CE6JWhY7GOe+/aB3iJGJg/EQowQHs5IIb9xZziQh3pTEyqrUovz4otKc1OJDjKbAEJ7ILCWa
        nA9Mynkl8YYmlgYmZkbGJhaGZoZK4ry9U08nCgmkJ5akZqemFqQWwfQxcXBKNTDFNFS/ZeI6
        EN+/xa9gJbdXNceBsklqDlX7bzHmtlb29XyJX5bpW1NqOT2qf07uRIfeRfUR7UG/M4wCNvzd
        2hXc+G3jgacLFi0N3hMaXNOROimtTm9y8KnKbd72KmUznlyvqHK1rZbe93xL6Hflujv7+uYr
        dNxqDFpqNKtVcRvr2huSYo9uCm4V+cZ6aWZq2zVz+fUnNPTf8J+bymT/xOhO0p2IycvLZk1+
        aneXIzuheeZX5djze5ubLgRf4MwJffGvu/PKxWMt7esyFmQseLubcWeMqrph/4Fya/G428kZ
        J+fwv8hUPfftpldW4cHz0/UCEhwnFYY+/31/O8/3QAneNd1Fu4oinkTr9J88wqTEUpyRaKjF
        XFScCACKAodrEgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSvK60L0+SwdUeY4t3e6exWVzeNYfN
        4nbjCjaLd42HGR1YPHY+tPTo27KK0ePzJrkA5igum5TUnMyy1CJ9uwSujIWb9jAX9AtUXNy8
        mq2BcTZvFyMnh4SAicSapT1sXYxcHEICOxglzq4GcUASkhLTLh5l7mLkALKFJQ4fLgYJCwm8
        ZZQ4uIITxBYWsJf4vWAhC4gtIuAksXzfHiYQm1nAXWLp0/ksEDMnM0oceXobLMEmoCWx/8UN
        sPn8AooSV388ZgSxeQXsJP7+3cEKYrMIqEpc2vkGrEZUIExi55LHTBA1ghInZz4BW8Yp4CDx
        fs80dohl6hJ/5l1ihrDFJW49mQ91hLzE9rdzmCcwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCc
        m55bbFhglJdarlecmFtcmpeul5yfu4kRHBlaWjsY96z6oHeIkYmD8RCjBAezkghv3FnOJCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYGCrFij4mrOHR
        Fgvieffdx7Lw0mmX9m1BGxmVTusJfm2UNs1yjn901OF2215hIa3TAmUnvX+fu1a8f97/H5yp
        tvEi6YIVl+aqRk6+pHB6tZ6rrehUnVzLVcdc3t7OOMgUV5GX9M9mXdm2wyzrM7UXvJpyPvjn
        /AbWN6t0mxWntbJcXbFls8p3lcpce9X7Cw9t5TLuK64yLHnxKLnY6duuH4fbN+x7I1fBMiNW
        qnJhp3U2f4ha+4Jkt6l33URaOjgOmb/60HD1l5LKq1NbI7h2Zs/MauU6e0h7TljuMXMtxU5p
        JwVV9g/Xtdas817npHsoKaBE+L7imXUuD3382/7cS9kitC7hir2aHkf1Pn4lluKMREMt5qLi
        RACs6M34+wIAAA==
X-CMS-MailID: 20220216010219epcas1p16a351e60d11478c3f68f23af2891b48d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220104084415epcas1p3e904babe27a1a45ab66f3793fb68890d
References: <CGME20220104084415epcas1p3e904babe27a1a45ab66f3793fb68890d@epcas1p3.samsung.com>
        <20220104084359.41051-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 5:43 PM, Yang Li wrote:
> Add the description of @id in extcon_sync() kernel-doc comment
> and @edev, @id, @prop in extcon_set_property_sync() kernel-doc
> comment to remove warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
> drivers/extcon/extcon.c:409: warning: Function parameter or 
> member 'id' not described in 'extcon_sync'
> drivers/extcon/extcon.c:750: warning: Function parameter or 
> member 'edev' not described in 'extcon_set_property_sync'
> drivers/extcon/extcon.c:750: warning: Function parameter or 
> member 'id' not described in 'extcon_set_property_sync'
> drivers/extcon/extcon.c:750: warning: Function parameter or 
> member 'prop' not described in 'extcon_set_property_sync'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/extcon/extcon.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index a09e704fd0fa..1e71ad489a83 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -399,6 +399,7 @@ static ssize_t cable_state_show(struct device *dev,
>  /**
>   * extcon_sync() - Synchronize the state for an external connector.
>   * @edev:	the extcon device
> + * @id:		the unique id indicating an external connector
>   *
>   * Note that this function send a notification in order to synchronize
>   * the state and property of an external connector.
> @@ -736,6 +737,9 @@ EXPORT_SYMBOL_GPL(extcon_set_property);
>  
>  /**
>   * extcon_set_property_sync() - Set property of an external connector with sync.
> + * @edev:	the extcon device
> + * @id:		the unique id indicating an external connector
> + * @prop:	the property id indicating an extcon property
>   * @prop_val:	the pointer including the new value of extcon property
>   *
>   * Note that when setting the property value of external connector,
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
