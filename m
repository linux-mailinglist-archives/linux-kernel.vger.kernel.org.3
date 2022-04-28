Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62ED5513109
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbiD1KPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345037AbiD1KOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:14:32 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B112E090
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:05:37 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220428100536euoutp024f47be94f9419c870dac7549dfc93fa9~qB2NIBqqS3206632066euoutp02m
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:05:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220428100536euoutp024f47be94f9419c870dac7549dfc93fa9~qB2NIBqqS3206632066euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651140336;
        bh=rNMoswJmasJ1RNqRjeSYB1k5B0BnxjvAK8UQufAn4Eg=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=L46bNQclhKh/afok5LSzGx63Y1q1kBWEwMABGbtLg/VhQfHSsgnU1GFhVfnfpVmuT
         cUgADl+1rahkJp94DaUPFgDflqrgrJiiWaNJtJW8Z0C+lr0c8CB/OUCT96X8NKBHyv
         /tMifdpZ556VZKNm2o37rB3KZjlndz2ENb8qM3Us=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220428100535eucas1p2e712550066617010c3049bdba4eeff40~qB2L-6QAi1557515575eucas1p2V;
        Thu, 28 Apr 2022 10:05:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E6.4D.10009.EE66A626; Thu, 28
        Apr 2022 11:05:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220428100534eucas1p2e44b4579e216ca06d47d0213b44adaaf~qB2K-EXX00832808328eucas1p26;
        Thu, 28 Apr 2022 10:05:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220428100534eusmtrp28fb94c78265d829dc2a1e78ff451247d~qB2K_Aoyj1482914829eusmtrp2B;
        Thu, 28 Apr 2022 10:05:34 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-da-626a66ee082b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E4.5A.09522.DE66A626; Thu, 28
        Apr 2022 11:05:33 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220428100532eusmtip1171d5c80f75d96e5b0953dc900eedec0~qB2J8DWoR1040710407eusmtip1v;
        Thu, 28 Apr 2022 10:05:32 +0000 (GMT)
Message-ID: <99c80fb6-c6cc-9370-b93d-ed736c7f2192@samsung.com>
Date:   Thu, 28 Apr 2022 12:05:33 +0200
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
In-Reply-To: <1399774c-f188-81f1-4d15-367b9d0e4a59@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7djP87rv07KSDM5cZrJ4MG8bm8Xa3qMs
        FvOPnGO1OHp+N5NF34uHzBZ7X29lt7j/9SijxabH11gtLu+aw2Yx4/w+JosDS9tZLN78fsFu
        8e5lhMXTmZvZLFr3HmG3+L9nB7vF4TftrBbvVj9htFh+ageLg7DHmnlrGD1m3T/L5rFpVSeb
        x51re9g8Ni+p9+jbsorR4/MmOY+9n3+zBHBEcdmkpOZklqUW6dslcGWc/KhScECwou/HCqYG
        xht8XYycHBICJhIbT75l6WLk4hASWMEosfH2DGaQhJDAF0aJS8v0IOzPjBI/XjvDNGxdPZcJ
        omE5o8T3g89YIZyPjBL3D/xjA6niFbCTaDw4kRHEZhFQlfi76BYrRFxQ4uTMJywgtqhAksTc
        fffAtgkLxEg8XroOrJ5ZQFzi1pP5YBtEBJ6wSry5PI0FIqEocWvaUiYQm03AUKLrbRfYMk6g
        Zf8OdLJD1MhLNG+dzQzSLCGwn1Pi6I3/QA4HkOMi0XvDGuIFYYlXx7ewQ9gyEv93giwDKcmX
        +DvDGCJcIXHt9RpmCNta4s65X2wgJcwCmhLrd+lDhB0lDm6YC9XJJ3HjrSDEAXwSk7ZNh9rJ
        K9HRJgRRrSYx6/g6uJ0HL1xinsCoNAspTGYh+X0WkldmIexdwMiyilE8tbQ4Nz212DAvtVyv
        ODG3uDQvXS85P3cTIzAZnv53/NMOxrmvPuodYmTiYDzEKMHBrCTC+2V3RpIQb0piZVVqUX58
        UWlOavEhRmkOFiVx3uTMDYlCAumJJanZqakFqUUwWSYOTqkGJmGJzQ43p4j/vTb1pXCL1/vF
        /85u8Y5k+fHWxXP70YdSfJ3rf+dWJ5UdUFB5IP74AH/OHYvIoP9CRgdSSpqndV87V3eOVXuj
        Uc5up/RFL17OyjeqqPh/5GHMRYsfl1q8Z/3a6XXk1LpN1xTesyxuMxZ/b/1R75fWySOTj3z3
        8PV/3FZ291/RyqjGql6nSWxbGPadv/RJIdzDSqZJpNI4hNVL+tU0lkUqkZ4vM1M+2K1ZxrhW
        /tJ5xV8+6Zsmh6h/M/96Y82lQKnWhsy0Bau/8t09M2OfxmmhyoOPak1zG93PeOk/ye663nri
        Eu/jKVq7FH0ev+9d7LNwnmB61qY3sXPMH+5/PsNW3OCu+MOvx2KVWIozEg21mIuKEwFYj2Fx
        9QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsVy+t/xu7pv07KSDJrW2Fg8mLeNzWJt71EW
        i/lHzrFaHD2/m8mi78VDZou9r7eyW9z/epTRYtPja6wWl3fNYbOYcX4fk8WBpe0sFm9+v2C3
        ePcywuLpzM1sFq17j7Bb/N+zg93i8Jt2Vot3q58wWiw/tYPFQdhjzbw1jB6z7p9l89i0qpPN
        4861PWwem5fUe/RtWcXo8XmTnMfez79ZAjii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1
        DI3NY62MTJX07WxSUnMyy1KL9O0S9DJOflQpOCBY0fdjBVMD4w2+LkZODgkBE4mtq+cydTFy
        cQgJLGWUmP3qIyNEQkbi5LQGVghbWOLPtS42iKL3jBJ9M9rBingF7CQaD04Es1kEVCX+LrrF
        ChEXlDg58wkLiC0qkCTxYttzsBphgRiJx0vXgdnMAuISt57MB9ssIvCMVeLVz12sEAlFiVvT
        lsKcxCxxdOt8sA42AUOJrrcgZ3BycAJt/negkx2iwUyia2sX1FR5ieats5knMArNQnLILCQL
        ZyFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzARLDt2M/NOxjnvfqod4iRiYPx
        EKMEB7OSCO+X3RlJQrwpiZVVqUX58UWlOanFhxhNgaExkVlKNDkfmIrySuINzQxMDU3MLA1M
        Lc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYGMTOvg3TqDLhUPG5v/m932yPVJkaN9eI
        Bs27817cm/3tz4Hgc7IRwYvdQzIMD/YeiChVdVU/bJ6je0tjVSTXtLh214CUaCbnm7s5ison
        a0UlLu6sZ7idcHyhik/4/84kruKru6Q/hp05r7wy4UGJd968nrr674FnFOV/nJK0l9L0tjLr
        tH0fWrZ21y/piwvXuCekzxJ74O4qsqXV0UucNdddYefHvSd72K7Nv9T7SMHDUWzy+zMz/1Xz
        /500/4vt98TKh0Xih2xctzIGztV0mBwmddDG+/+TeR8Kn+x8t8G8IT6pV2Z3cXBfmWaL2rv7
        spzr9/28/J55RV3Wqu8JdwUOCcxYp/NV8YRHYqgSS3FGoqEWc1FxIgCXE64ajQMAAA==
X-CMS-MailID: 20220428100534eucas1p2e44b4579e216ca06d47d0213b44adaaf
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
        <05c908ce-217f-6938-6745-7405ac39d8ea@samsung.com>
        <1399774c-f188-81f1-4d15-367b9d0e4a59@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.04.2022 12:00, Krzysztof Kozlowski wrote:
> On 28/04/2022 11:57, Marek Szyprowski wrote:
>> On 28.04.2022 11:54, Krzysztof Kozlowski wrote:
>>> On 28/04/2022 11:50, Marek Szyprowski wrote:
>>>> On 27.04.2022 17:58, Krzysztof Kozlowski wrote:
>>>>> pl330 DMA controller bindings documented 'dma-channels' and
>>>>> 'dma-requests' properties (without leading hash sign), so fix the DTS to
>>>>> match the bindings.
>>>>>
>>>>> Reported-by: Rob Herring <robh@kernel.org>
>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Are those properties really needed for PL330 driver on Exynos SoCs? I've
>>>> removed them and I still see the proper values read from registers and
>>>> reported in the log (Exynos4210):
>>>>
>>>> dma-pl330 12680000.dma-controller: Loaded driver for PL330 DMAC-141330
>>>> dma-pl330 12680000.dma-controller:       DBUFF-32x4bytes Num_Chans-8
>>>> Num_Peri-32 Num_Events-32
>>>> dma-pl330 12690000.dma-controller: Loaded driver for PL330 DMAC-141330
>>>> dma-pl330 12690000.dma-controller:       DBUFF-32x4bytes Num_Chans-8
>>>> Num_Peri-32 Num_Events-32
>>>> dma-pl330 12850000.dma-controller: Loaded driver for PL330 DMAC-141330
>>>> dma-pl330 12850000.dma-controller:       DBUFF-64x8bytes Num_Chans-8
>>>> Num_Peri-1 Num_Events-32
>>>>
>>>> I also don't see any code that would read those properties. IMHO they
>>>> should be simply removed at all, at least for the PL330 related nodes.
>>> In current Linux implementation they indeed are not used. Nothing parses
>>> them. However:
>>> 1. They describe (hopefully correct) the hardware.
>>> 2. They might be used by other implementations of pl330 driver.
>>>
>>> I would not remove them from existing sources, but indeed maybe there is
>>> no need to add for new files.
>> What's the point in having dt properties duplicating data that might be
>> read from the driver registers?
> Hm, indeed, there is no point in this. Since they are read from
> registers, what was the idea behind in commit 42cf20980cde?

#dma-cells is indeed required, but the rest seems to be the cargo-cult 
of some kind.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

