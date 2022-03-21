Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE27E4E21A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345073AbiCUIBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244075AbiCUIBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:01:39 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8806B2E0AC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:00:13 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220321080010euoutp027f043458f11543ecbf415d916654b392~eVn12l3UE0236602366euoutp02V
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:00:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220321080010euoutp027f043458f11543ecbf415d916654b392~eVn12l3UE0236602366euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647849610;
        bh=wmpt2tjWG+U0wt9U6Ul9ObyovGJ8vBWAjVswsiVCeBc=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=efQmIbfdWJL0EowGw5N+D5JNsqDW1fw2GzKgul9D49h5gbWhhNAaWNXapiVoBtvNz
         lzmdShOwd5sWwyC14R4IL9SagLve+/Td/64pR/gTcEVH/he1mRi3W/hRWqv913i6Cz
         YtEllkqkg3ZL/So6ADWPLrRfg/2nmwcfV/6JMpe4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220321080010eucas1p14d0cfaae9c8abec761fa359e8111d21b~eVn1eOsKc0890108901eucas1p1s;
        Mon, 21 Mar 2022 08:00:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4A.30.09887.A8038326; Mon, 21
        Mar 2022 08:00:10 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220321080009eucas1p2efb4872d4b1b9a37025dc6b1a5cc5bff~eVn1DF7r13081430814eucas1p2U;
        Mon, 21 Mar 2022 08:00:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220321080009eusmtrp13058155feb11d77c87f76b0b9db2a677~eVn1CO5FF0361803618eusmtrp1H;
        Mon, 21 Mar 2022 08:00:09 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-5f-6238308a0727
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 96.1E.09404.98038326; Mon, 21
        Mar 2022 08:00:09 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220321080008eusmtip22587c7213aa29fe82cdc14e175514f10~eVn0ZgonH2745827458eusmtip2K;
        Mon, 21 Mar 2022 08:00:08 +0000 (GMT)
Message-ID: <e8b58fc4-fdc2-7fca-f8f5-c45f0891b53b@samsung.com>
Date:   Mon, 21 Mar 2022 09:00:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/4] clocksource/drivers/exynos_mct: Support
 local-timer-index property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <69be9f88-b69b-c149-4387-c5002219bf0a@canonical.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djPc7pdBhZJBu3TWSwezNvGZjHvs6zF
        /CPnWC0+tahabHz7g8li0+NrrBaXd81hs5hxfh+TReveI+wWmzdNZbY4v83fgdvj+roAj1kN
        vWwem1Z1snncubaHzePduXPsHpuX1Hv0bVnF6PF5k1wARxSXTUpqTmZZapG+XQJXxv9zixkL
        3itVTP+6lbmBcblMFyMnh4SAicS2dceZuhi5OIQEVjBKTFo8kwXC+cIo0fjvAhNIlZDAZ0aJ
        Q7sdYTpudD5hhyhazijxd28TVPtHRonWQ89ZQKp4BewkFnZvB+tmEVCVaFjwiREiLihxcuYT
        sBpRgSSJ1dtXs4HYwgIJEtO3HmEGsZkFxCVuPZkP1isikC/RNvMmO0S8gUXi1yIzEJtNwFCi
        620XWC+ngKPE0nUrGCFq5CW2v53DDHKQhEA3p8T0x8fYIc52kXh8ay4jhC0s8er4Fqi4jMTp
        yT0sEA3NjBIPz61lh3B6GCUuN82A6rCWuHPuF9A6DqAVmhLrd+lDhB0lZrWeZwQJSwjwSdx4
        KwhxBJ/EpG3TmSHCvBIdbUIQ1WoSs46vg1t78MIl5gmMSrOQgmUWkvdnIXlnFsLeBYwsqxjF
        U0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQIT2Ol/x7/sYFz+6qPeIUYmDsZDjBIczEoivIs/
        mCcJ8aYkVlalFuXHF5XmpBYfYpTmYFES503O3JAoJJCeWJKanZpakFoEk2Xi4JRqYPLwdJiu
        ODOeb5uCmGh/3Pv3OfqTXs25w250Z4+Yx/bDSpacE78l3V746cCjN3PuSwu/+XRiy5nQlF2x
        bTcSZyztDlb+62Qd8sJ2zT2jOR+6c3edWpYdsFvGW8vNI+TWbD2e6yciv5x0ET+76uI0L8mD
        E65dapx+wXm9o6dY+7fLF7bylsnnRHyfJbtENoN7/w/lZR9YIj68/f2oIdqjozqWv7m2U57/
        wL0ZISfvP56x3p/zoHHStVlla3W8M2tX7LOr/RUkFR8smbbL7P3GCc1xb/m314Zwrmp/myCS
        FOQt/2HT9svRJ+duaGKOEN/+e8L6KYalVc6b3hqmyiRunbMt5mSaA8PcLdv2ui67GfpGiaU4
        I9FQi7moOBEA1Mqv088DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xe7qdBhZJBptXKlg8mLeNzWLeZ1mL
        +UfOsVp8alG12Pj2B5PFpsfXWC0u75rDZjHj/D4mi9a9R9gtNm+aymxxfpu/A7fH9XUBHrMa
        etk8Nq3qZPO4c20Pm8e7c+fYPTYvqffo27KK0ePzJrkAjig9m6L80pJUhYz84hJbpWhDCyM9
        Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jP/nFjMWvFeqmP51K3MD43KZLkZODgkB
        E4kbnU/Yuxi5OIQEljJK3Lm4jxEiISNxcloDK4QtLPHnWhcbRNF7Rok3a2ezgSR4BewkFnZv
        ZwKxWQRUJRoWfGKEiAtKnJz5hAXEFhVIkrjU1Q4WFxZIkJi+9QgziM0sIC5x68l8sF4RgXyJ
        szPawK5gFmhhkVh4sJ0FYttDJolzO1rZQarYBAwlut52gW3mFHCUWLpuBSPEJDOJrq1dULa8
        xPa3c5gnMArNQnLILCQLZyFpmYWkZQEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAqN12
        7OeWHYwrX33UO8TIxMF4iFGCg1lJhHfxB/MkId6UxMqq1KL8+KLSnNTiQ4ymwNCYyCwlmpwP
        TBt5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MOwU33apLXqO6
        2zA8f3mifUfd1K0nnwpVXNl8a+Oyjepph1MKvET+/PW6fXK/bHxw1tRseZ0vih3Gh7UCf2VM
        mJgzf0aPjenlJT9Nb0ecMgvb0mQz97BMgcKtRMf57Ea+HGFuvpl17/kaGn6u3ShjELt1sfU0
        e7951+TvzbIs/O1/3UTKR6/u4jR/28lpl3ZMO1XmLn1ihdDd3sOFJRa15cUTWdec2Xy5/sv9
        NxYLPxQrPXCe8LX256pnPX2cxc9efbMPa3PbeqlPt7wnSEmDvSv4W5mW4sS+i8EKi357LTNI
        ldFYpfut3zLePcc3+mhbdrDqf2V2fwmrl19+Ttp2yU5Q8RvP833v73vt7LJVYinOSDTUYi4q
        TgQAyZtf42MDAAA=
X-CMS-MailID: 20220321080009eucas1p2efb4872d4b1b9a37025dc6b1a5cc5bff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220311125154eucas1p180cf38fcfe33e52757c2442bbd9c2ab3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220311125154eucas1p180cf38fcfe33e52757c2442bbd9c2ab3
References: <20220308142410.3193729-1-vincent.whitchurch@axis.com>
        <20220308142410.3193729-4-vincent.whitchurch@axis.com>
        <226dcb1b-d141-f0d3-68c4-11d2466ca571@canonical.com>
        <20220311113543.GA17877@axis.com>
        <CGME20220311125154eucas1p180cf38fcfe33e52757c2442bbd9c2ab3@eucas1p1.samsung.com>
        <69be9f88-b69b-c149-4387-c5002219bf0a@canonical.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 11.03.2022 13:51, Krzysztof Kozlowski wrote:
> On 11/03/2022 12:35, Vincent Whitchurch wrote:
>> On Tue, Mar 08, 2022 at 03:57:55PM +0100, Krzysztof Kozlowski wrote:
>>> On 08/03/2022 15:24, Vincent Whitchurch wrote:
>>>> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
>>>> index f29c812b70c9..5f8b516614eb 100644
>>>> --- a/drivers/clocksource/exynos_mct.c
>>>> +++ b/drivers/clocksource/exynos_mct.c
>>>> @@ -33,7 +33,7 @@
>>>>   #define EXYNOS4_MCT_G_INT_ENB		EXYNOS4_MCTREG(0x248)
>>>>   #define EXYNOS4_MCT_G_WSTAT		EXYNOS4_MCTREG(0x24C)
>>>>   #define _EXYNOS4_MCT_L_BASE		EXYNOS4_MCTREG(0x300)
>>>> -#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * x))
>>>> +#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * (x)))
>>>>   #define EXYNOS4_MCT_L_MASK		(0xffffff00)
>>>>   
>>>>   #define MCT_L_TCNTB_OFFSET		(0x00)
>>>> @@ -75,6 +75,7 @@ enum {
>>>>   static void __iomem *reg_base;
>>>>   static unsigned long clk_rate;
>>>>   static unsigned int mct_int_type;
>>>> +static unsigned int mct_local_idx;
>>> No more static variables. This was wrong design, happens, but let's not
>>> grow the list.
>>>
>>> I propose to conditionally (depending on property samsung,frc-shared)
>>> assign .resume callback to NULL or exynos4_frc_resume. The init can
>>> receive an argument whether to call frc_start().
>> Could we just add the skip-write-register-if-already-started change in
>> exynos4_mct_frc_start() uncondtionally?  Perhaps it could be in a
>> separate patch too?  I was probably being over-cautious when I did it
>> conditionally on mct_local_idx.  Doing it uncondtionally would make it
>> easier to remove the global variable.
>>
>> On my system the FRC is actually started long before Linux, and I assume
>> it's similar on other chips.
> +Cc Marek,
>
> Maybe we could skip it, I don't know. It could be enabled by early boot
> code or by trusted firmware. This would require more testing, on few
> different platforms.
>
> On my Exynos5422 HC1 board the MCT is not running upon boot. The
> EXYNOS4_MCT_G_TCON starts with a reset value (0x0).
>
>>>>   static int mct_irqs[MCT_NR_IRQS];
>>>>   
>>>>   struct mct_clock_event_device {
>>>> @@ -157,6 +158,17 @@ static void exynos4_mct_frc_start(void)
>>>>   	u32 reg;
>>>>   
>>>>   	reg = readl_relaxed(reg_base + EXYNOS4_MCT_G_TCON);
>>>> +
>>>> +	/*
>>>> +	 * If the FRC is already running, we don't need to start it again.  We
>>>> +	 * could probably just do this on all systems, but, to avoid any risk
>>>> +	 * for regressions, we only do it on systems where it's absolutely
>>>> +	 * necessary (i.e., on systems where writes to the global registers
>>>> +	 * need to be avoided).
>>>> +	 */
>>>> +	if (mct_local_idx && (reg & MCT_G_TCON_START))
>>> This contradicts your intentions in commit #2 msg, where you described
>>> that A53 will be started first.
>> Yes, you're right.  The case of the FRC not being running when the A5
>> starts up is only ever hit in our simulation environment where we are
>> able to start Linux on the A5 directly, without having to go via the
>> A53.
>>
>>> 1. If A53 is always started first, is it possible to be here from A5?
>>> 2. If above is possible, how do you handle locking? For example:
>>> a. A53 started with some delay, entered exynos4_mct_frc_start() pass
>>> this check;
>>> b. A5 gets to exynos4_mct_frc_start(), check is still false, so A5
>>> enables the FRC,
>>> c. A53 also enables the FRC.
>> The A5 is normally started from Linux on the A53 (using the remoteproc
>> framework).  This is long after exynos4_mct_frc_start() has been called
>> on the A53.
> If it is 100% like this, let's make it explicit - if it is A53 (lack of
> dedicated property), let's start it. If it A5 (property present), skip it.
>
> Let's wait for Marek thoughts, he was digging the MCT a lot.


Right, I've played a bit with MCT on some older Exynos SoCs (ARM 32bit 
based and even Exynos5433) and it looked that none of it enabled MCT FRC 
timer in their proprietary firmware. I've even proposed a patch for this 
once ([1]), but such approach has been rejected. I think that calling 
exynos4_mct_frc_start() unconditionally won't hurt.

[1] https://lore.kernel.org/all/20181018095708.1527-5-m.szyprowski@samsung.com/

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

