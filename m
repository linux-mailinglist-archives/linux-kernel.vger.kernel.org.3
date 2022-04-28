Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212F75130D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiD1KJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbiD1KHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:07:52 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5FC5469E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:57:50 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220428095748euoutp02813f7c6b6e0806f46fed3832e61408d0~qBvZz5O7Q2411524115euoutp02L
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:57:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220428095748euoutp02813f7c6b6e0806f46fed3832e61408d0~qBvZz5O7Q2411524115euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651139869;
        bh=WAr2KBK3YKZ+iruGGjyKb2JAJ8wc45LHSIgHIHE/vJ8=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=EuocrpCAmmxrm9sGP5fbtV3EDWzORFBwmZO/aYmW9C+O8H+T8t8d2sbW4C2ofvEG0
         1ZTFR9uXs7VTfGxv6Pzr+Z/OSZ8ermuBbh4nrLUgEmeF/JtLA8qB0GfEQuyYUQxF51
         5CEoh/vHGkcv3sphp+EcqDQcYMB9GHFutmry+yQA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220428095748eucas1p2d8666fb337ddc9c72e636148eb4b275a~qBvZBNxHv0348303483eucas1p2I;
        Thu, 28 Apr 2022 09:57:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 19.0F.10260.B156A626; Thu, 28
        Apr 2022 10:57:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220428095747eucas1p230eee1041d7f8c378efb33690a8fb98e~qBvYfCVOr3267132671eucas1p2K;
        Thu, 28 Apr 2022 09:57:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220428095747eusmtrp20da395a7ae3647aacd974cfefec69d17~qBvYeDsWZ0971209712eusmtrp2q;
        Thu, 28 Apr 2022 09:57:47 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-c2-626a651b3ee5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 88.BF.09404.B156A626; Thu, 28
        Apr 2022 10:57:47 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220428095746eusmtip237c81ad362a3b4517eb67a4695e64fb6~qBvXaMKAj2387023870eusmtip2i;
        Thu, 28 Apr 2022 09:57:46 +0000 (GMT)
Message-ID: <05c908ce-217f-6938-6745-7405ac39d8ea@samsung.com>
Date:   Thu, 28 Apr 2022 11:57:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH 08/10] ARM: dts: exynos: use proper
 'dma-channels/requests' properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <6981f93a-ef01-6ba0-4451-26526372d666@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djP87oyqVlJBu+zLR7M28Zmsbb3KIvF
        /CPnWC2Ont/NZNH34iGzxd7XW9kt7n89ymix6fE1VovLu+awWcw4v4/J4sDSdhaLN79fsFu8
        exlh8XTmZjaL1r1H2C3+79nBbnH4TTurxbvVTxgtlp/aweIg7LFm3hpGj1n3z7J5bFrVyeZx
        59oeNo/NS+o9+rasYvT4vEnOY+/n3ywBHFFcNimpOZllqUX6dglcGY9bPzEX7Oer2NC0g6mB
        cQpPFyMnh4SAicSBaW2MXYxcHEICKxgllp4/DuV8YZS4sfIvC4TzmVFicf9nNpiWzbs2sEEk
        ljNKdG9tZ4JwPjJK/N//nR2kilfATuLL+vtgNouAqsSlG3uZIeKCEidnPmEBsUUFkiTm7rsH
        FhcWiJF4vHQdI4jNLCAucevJfLChIgJPWCXeXJ7GApFQlLg1bSkTiM0mYCjR9bYL7CROoGUf
        u+dC1chLNG+dzQzSLCFwmFPi0Y1OqLtdJNZsm8ACYQtLvDq+hR3ClpH4vxNkGweQnS/xd4Yx
        RLhC4trrNcwQtrXEnXO/2EBKmAU0Jdbv0ocIO0oc3DAXqpNP4sZbQYgL+CQmbZvODBHmleho
        E4KoVpOYdXwd3M6DFy4xT2BUmoUUKLOQPD8LyS+zEPYuYGRZxSieWlqcm55abJyXWq5XnJhb
        XJqXrpecn7uJEZgST/87/nUH44pXH/UOMTJxMB5ilOBgVhLh/bI7I0mINyWxsiq1KD++qDQn
        tfgQozQHi5I4b3LmhkQhgfTEktTs1NSC1CKYLBMHp1QDE8vxKaVabyIeVTwQPfnz5NHIk8tO
        K5+4KLntxKOlnPxnlR8+UM22Z17hZDdBe7vGbaMUv3P+q1caPS3I3d5n+exF5rkM0x2fNSSD
        ymru35teZDQtQspo6sQrv0+lNUZoXLjhEP7v3AzTg+c2T3M6FL/oxd7wiaIbm5o7vLIvP3vA
        el965iwT/3c3s3epbZl7Zou+xNR73hejNMrd5z/1qG1fxluRe8K4q/zk1W+/Q301rATFpv+P
        +hL1aOOLWcytP2eeaTuXEX89n/WelInT58A7a+boukrY7RDsUp8aYRXF6la7M6xjU6i4JMf1
        vHmWWvKbV2/WfLqFddab5K8zc3hyz7bIZy9pOS5+7/hctn1KLMUZiYZazEXFiQANxGRZ+AMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsVy+t/xe7rSqVlJBrd+S1o8mLeNzWJt71EW
        i/lHzrFaHD2/m8mi78VDZou9r7eyW9z/epTRYtPja6wWl3fNYbOYcX4fk8WBpe0sFm9+v2C3
        ePcywuLpzM1sFq17j7Bb/N+zg93i8Jt2Vot3q58wWiw/tYPFQdhjzbw1jB6z7p9l89i0qpPN
        4861PWwem5fUe/RtWcXo8XmTnMfez79ZAjii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1
        DI3NY62MTJX07WxSUnMyy1KL9O0S9DIet35iLtjPV7GhaQdTA+MUni5GTg4JAROJzbs2sHUx
        cnEICSxllFjZfJsFIiEjcXJaAyuELSzx51oXVNF7RolVM7ezgSR4Bewkvqy/zw5iswioSly6
        sZcZIi4ocXLmE7BBogJJEi+2PWcEsYUFYiQeL10HZjMLiEvcejKfCWSoiMAzVolXP3exQiQU
        JW5NW8oEsW0Pk8SDo8fAOtgEDCW63naBbeYE2vyxey4LRIOZRNfWLqip8hLNW2czT2AUmoXk
        kFlIFs5C0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgalg27GfW3Ywrnz1Ue8Q
        IxMH4yFGCQ5mJRHeL7szkoR4UxIrq1KL8uOLSnNSiw8xmgJDYyKzlGhyPjAZ5ZXEG5oZmBqa
        mFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MBmJcS2y27vL7rOfVkDvizuLT9X1
        bd/V0/Qnq+o7x0+XvC91zsl+PWmShYskmm4yFPU2XPPKPbLAQkp2PZdf8OllBzObTU7LP+Tw
        42N40GBol/9nUm3wQvfN1Q8PrOVkijvwka3bW2L3ttaSW9sW67gcvnvNpTQw+4qA31NH3ZNF
        LBnfFjey5BRHFqlnnWdPntV6MMeR84R3350Va/VSVn6W2fWg7NiFfM6AEqdTnGXzlNqnsm9f
        +Vx5xrRq1YDsOKMClQkcsxPbNvtNf1P94suqOauZn7Uwn6t72lzRMdX8885/7nza+z6v+rrZ
        QIXx+EddvmTbjy+/CDw9Z5GlwXXiRIbTYUWx4iclFj7qSizFGYmGWsxFxYkAFKOep44DAAA=
X-CMS-MailID: 20220428095747eucas1p230eee1041d7f8c378efb33690a8fb98e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220427160347eucas1p23ce51e0fb49160d437961d98fd682c28
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160347eucas1p23ce51e0fb49160d437961d98fd682c28
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
        <CGME20220427160347eucas1p23ce51e0fb49160d437961d98fd682c28@eucas1p2.samsung.com>
        <20220427155840.596535-9-krzysztof.kozlowski@linaro.org>
        <5eeac2a0-4293-675e-9dc2-25ed8ab3fb8f@samsung.com>
        <6981f93a-ef01-6ba0-4451-26526372d666@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.04.2022 11:54, Krzysztof Kozlowski wrote:
> On 28/04/2022 11:50, Marek Szyprowski wrote:
>> On 27.04.2022 17:58, Krzysztof Kozlowski wrote:
>>> pl330 DMA controller bindings documented 'dma-channels' and
>>> 'dma-requests' properties (without leading hash sign), so fix the DTS to
>>> match the bindings.
>>>
>>> Reported-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Are those properties really needed for PL330 driver on Exynos SoCs? I've
>> removed them and I still see the proper values read from registers and
>> reported in the log (Exynos4210):
>>
>> dma-pl330 12680000.dma-controller: Loaded driver for PL330 DMAC-141330
>> dma-pl330 12680000.dma-controller:       DBUFF-32x4bytes Num_Chans-8
>> Num_Peri-32 Num_Events-32
>> dma-pl330 12690000.dma-controller: Loaded driver for PL330 DMAC-141330
>> dma-pl330 12690000.dma-controller:       DBUFF-32x4bytes Num_Chans-8
>> Num_Peri-32 Num_Events-32
>> dma-pl330 12850000.dma-controller: Loaded driver for PL330 DMAC-141330
>> dma-pl330 12850000.dma-controller:       DBUFF-64x8bytes Num_Chans-8
>> Num_Peri-1 Num_Events-32
>>
>> I also don't see any code that would read those properties. IMHO they
>> should be simply removed at all, at least for the PL330 related nodes.
> In current Linux implementation they indeed are not used. Nothing parses
> them. However:
> 1. They describe (hopefully correct) the hardware.
> 2. They might be used by other implementations of pl330 driver.
>
> I would not remove them from existing sources, but indeed maybe there is
> no need to add for new files.

What's the point in having dt properties duplicating data that might be 
read from the driver registers?


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

