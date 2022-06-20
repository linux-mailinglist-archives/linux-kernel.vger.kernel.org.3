Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283955515E5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239926AbiFTKbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbiFTKbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:31:11 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB87A14018
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:31:09 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220620103108euoutp0158d6092a8a5f34fc51ceaf1d5e3d68fa~6TYoZy18F0449104491euoutp01x
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:31:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220620103108euoutp0158d6092a8a5f34fc51ceaf1d5e3d68fa~6TYoZy18F0449104491euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655721068;
        bh=BurjW1WW2KeTxxxdhC7NErnPk+2pomzAB87ahjLvfu0=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=UyUT6iuF82GKqM+BpK1XsJM5OuE4H6WAdbMjgyNSSEk8AWT1gzckzBoQApgkPUGfA
         QkN0iloctEEPDU0Csxp4rv4AIeSa+1OD5JjddmKs2wnSJFB4VZUUD6ew7qLmKV2/gl
         wM7emUlcrl1eyqcmq4gbolbt4lAs4U389Ww5YmFA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220620103108eucas1p2b65435f45ffac70cf014a1075f20357a~6TYoC_foz3271232712eucas1p20;
        Mon, 20 Jun 2022 10:31:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9D.F8.10067.C6C40B26; Mon, 20
        Jun 2022 11:31:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220620103107eucas1p217192cc1d2c87ed8b7e4c799b4773f1d~6TYnoZDIt1972319723eucas1p27;
        Mon, 20 Jun 2022 10:31:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220620103107eusmtrp124878fdcd4369a8a21ccd5e737afed5d~6TYnnQm8c0342803428eusmtrp1q;
        Mon, 20 Jun 2022 10:31:07 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-3a-62b04c6cb174
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 50.36.09038.B6C40B26; Mon, 20
        Jun 2022 11:31:07 +0100 (BST)
Received: from [106.210.134.141] (unknown [106.210.134.141]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220620103106eusmtip28c55cb16ee518ef155877f61cc050a4a~6TYm4xmFI3070130701eusmtip2w;
        Mon, 20 Jun 2022 10:31:06 +0000 (GMT)
Message-ID: <85be3992-39fb-e95f-6e25-29e73ab6f97f@samsung.com>
Date:   Mon, 20 Jun 2022 12:31:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 1/5] dt-bindings: clock: Add bindings for Exynos7885
 CMU_FSYS
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     phone-devel@vger.kernel.org,
        David Virag <virag.david003@gmail.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
In-Reply-To: <6178d685-5a87-6057-1200-e41baa3ece7d@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djP87o5PhuSDKbNYrV4MG8bm8X1L89Z
        LeYfOcdq0ffiIbPF3tdb2S02Pb7GavGx5x6rxeVdc9gsZpzfx2Rx8ZSrxYI/dhate4+wW/y7
        tpHFYtWuP4wWx98/ZnTg93h/o5XdY+esu+wem1Z1snncubaHzWPzknqPvi2rGD0+b5ILYI/i
        sklJzcksSy3St0vgyvi8I6hgK2tF94cF7A2M61m6GDk5JARMJDa8fMXUxcjFISSwglHi/qEt
        zBDOF0aJ9/Mms0E4nxkljkyaCtey5dpKdojEckaJOz+6oKo+Mko8fLyNHaSKV8BO4se0lUwg
        NouAqsSLTV+YIeKCEidnPgGbJCqQLHHu7FU2EFtYIFjie+s0VhCbWUBc4taT+WC9IgIWEos3
        LGQFWcAs0McisfHSSrBBbAKGEr1H+xhBbE6gZee3zGGEaJaX2P52DtgTEgLLOSXuzZvCDHG3
        i8SSj79YIWxhiVfHt7BD2DISpyf3QP1WLzF5yhU2CLuDUeLrXjMI21piwqYTQHEOoAWaEut3
        6UOEHSUWdGxnBwlLCPBJ3HgrCHECn8SkbdOZIcK8Eh1tQhDVKhK/V01ngrClJLqf/GeZwKg0
        CylUZiH5fhaSZ2Yh7F3AyLKKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMMGd/nf8yw7G
        5a8+6h1iZOJgPMQowcGsJMJrw70hSYg3JbGyKrUoP76oNCe1+BCjNAeLkjhvcuaGRCGB9MSS
        1OzU1ILUIpgsEwenVAPT0t1rN0QaP9ztkOUSa56l1qi1c+qeWzz/X3o5u1+SXHPpSo3RnJYM
        8yuWxm959e5UTZu1Z2kVz6HD7pfsrht0nzr6Kef0ad7OCW+jXmfPZDywbvZBgSwxpmdH31Su
        EeqyzFl2amPxrbp1fu7yU/Q2f4zb9FvXeebmbj4xwy83DxcwZ0SfD9tz+IDcudvv4pY8r29i
        3JvOoBOkZOHWtfh0+QKHM18217EmiKxJ3rtS+sNX73XiydeeCK8u2luT4PXkfu9NgUWrPfpe
        mXzNkOO3arHj/K18LOya7bFPAbe1DX/Kh5yzqdyffeqwoe/nR90nddZa7fr77/uk/OwNc6MS
        Xs6/MU/D0iEv8dynzVu5TimxFGckGmoxFxUnAgDCZKob3wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xe7rZPhuSDJ5sULd4MG8bm8X1L89Z
        LeYfOcdq0ffiIbPF3tdb2S02Pb7GavGx5x6rxeVdc9gsZpzfx2Rx8ZSrxYI/dhate4+wW/y7
        tpHFYtWuP4wWx98/ZnTg93h/o5XdY+esu+wem1Z1snncubaHzWPzknqPvi2rGD0+b5ILYI/S
        synKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy/i8I6hg
        K2tF94cF7A2M61m6GDk5JARMJLZcW8kOYgsJLGWUWPPctIuRAyguJTG/RQmiRFjiz7Uuti5G
        LqCS90Al79eB9fIK2En8mLaSCcRmEVCVeLHpCzNEXFDi5MwnYDWiAskSzVsOgdUICwRLfG+d
        xgpiMwuIS9x6Mh8sLiJgIbF4w0JWkAXMAhNYJHaef8YKse0no8T+1o1gHWwChhK9R/sYQWxO
        oM3nt8xhBLmUWUBdYv08IYih8hLb385hnsAoNAvJHbOQ7JuF0DELSccCRpZVjCKppcW56bnF
        RnrFibnFpXnpesn5uZsYgdG87djPLTsYV776qHeIkYmD8RCjBAezkgivDfeGJCHelMTKqtSi
        /Pii0pzU4kOMpsCwmMgsJZqcD0wneSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakF
        qUUwfUwcnFINTK1Oq3rsE9PZogTFD92tlNntuP7/qslOPkeezk7ucCzkr5z575vx4UXq2yWC
        BbZO55x47fl/HtVFF9wi978p0Ot1DdOexz9Puk8pq+fXITHLpRKh1g77pjK8YzBc3Txhx7EF
        IlP+3ml6J8szt+D/es5OoSdaWrssRTPK366OEjfie33c4RQ3z3XlO8XPpmzpPnLBbIZqTJHp
        hCX+lpdCQ+P8hZ9V5ZkaNa16cS92zu8G3tiwbZ8qSzSFdnD+nLMss+7gMlc+xQt1C7+tWvdH
        Umj6G8FPDfxXMg/ONBF4vbfaevVj+9euFi9DTc957Jqw87HV5PQPaVNXflJoEOz05Dv89cXG
        JQf2190Kikv1PKPEUpyRaKjFXFScCAA5NIm7bwMAAA==
X-CMS-MailID: 20220620103107eucas1p217192cc1d2c87ed8b7e4c799b4773f1d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220608151219eucas1p20af4138a6cc6c471791240b00ecffade
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220608151219eucas1p20af4138a6cc6c471791240b00ecffade
References: <20220601233743.56317-1-virag.david003@gmail.com>
        <20220601233743.56317-2-virag.david003@gmail.com>
        <CGME20220608151219eucas1p20af4138a6cc6c471791240b00ecffade@eucas1p2.samsung.com>
        <6178d685-5a87-6057-1200-e41baa3ece7d@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.06.2022 17:12, Krzysztof Kozlowski wrote:
> On 02/06/2022 01:37, David Virag wrote:
>> CMU_FSYS clock domain provides clocks for MMC (MMC_CARD, MMC_EMBD,
>> MMC_SDIO), and USB30DRD.
>>
>> Add clock indices and bindings documentation for CMU_FSYS domain.
>>
>> Signed-off-by: David Virag <virag.david003@gmail.com>
>> ---
>>  .../clock/samsung,exynos7885-clock.yaml       | 27 ++++++++++++++++
>>  include/dt-bindings/clock/exynos7885.h        | 31 ++++++++++++++++++-

> It seems the clock IDs from bindings are used by both driver and DTS.
> Sylwester, can I take them to Samsung Soc and send you a pull request?

Sure, let's do it that way.

-- 
Regards,
Sylwester
