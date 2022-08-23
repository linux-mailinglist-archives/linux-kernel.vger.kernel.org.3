Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5DE59D29E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241362AbiHWHvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241424AbiHWHvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:51:15 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED7265670
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:51:09 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220823075106euoutp015c549b251adad840a5ca1fa66f23b7c9~N6fLALcfo0965309653euoutp01_
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:51:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220823075106euoutp015c549b251adad840a5ca1fa66f23b7c9~N6fLALcfo0965309653euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661241066;
        bh=OdAUYDUE0RtxDQJxlta/lTLQKVFbvQ5IcKfejb7SxWc=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=YzmgmcreHTCQyHKzbK7wQcdrFDvjDpGnfAdLxrBybth93xVC13cEfcwL3nXZ9FbsZ
         luZQ/FVXNGsnho4N++2uYNlnSzdyjlGF9TtsV1fmnx3v1z3ZbHzWo3/Cz6QW+LrlII
         moB4MVkgjLPZQj4dR1wy2LEXAOSnqMBRpLoODUsw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220823075105eucas1p27cf58d12d4928050fc3bd26ebe977b56~N6fKaInLg0812408124eucas1p2R;
        Tue, 23 Aug 2022 07:51:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 85.D8.07817.9E684036; Tue, 23
        Aug 2022 08:51:05 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220823075105eucas1p24f6502d7088ffeb65180723f4c7b246c~N6fKA_8PA0769807698eucas1p2l;
        Tue, 23 Aug 2022 07:51:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220823075105eusmtrp105eefa20678a3cf5dac665d1e9457bc8~N6fKAEZ9Y0366903669eusmtrp1w;
        Tue, 23 Aug 2022 07:51:05 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-0e-630486e9ec36
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1A.34.10862.9E684036; Tue, 23
        Aug 2022 08:51:05 +0100 (BST)
Received: from [106.210.134.141] (unknown [106.210.134.141]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220823075104eusmtip236de6fdbca44ee6174d98b378a9f9f27~N6fJaM3L92482924829eusmtip2A;
        Tue, 23 Aug 2022 07:51:04 +0000 (GMT)
Message-ID: <64f39fcd-9dfb-1c40-377c-034f5f043072@samsung.com>
Date:   Tue, 23 Aug 2022 09:51:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] clk: samsung: MAINTAINERS: add Krzysztof Kozlowski
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
In-Reply-To: <20220823073154.359090-1-krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djPc7ov21iSDZ4v0bJ4MG8bm8X1L89Z
        Lfa+3spu8bHnHqvF5V1z2CxmnN/HZHHxlKvFv2sbWSxW7frD6MDp8f5GK7vHzll32T02repk
        87hzbQ+bR9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGW8bT7IWPCduWLe0pdMDYzTmbsYOTkk
        BEwkHp1sZu1i5OIQEljBKPH7w34mCOcLo0T3mruMEM5nRomJC//AtXT0/GOHSCxnlFj5dT6U
        85FRYv7xtUwgVbwCdhJ9b7+ygtgsAqoSF9d9YYSIC0qcnPmEBcQWFUiWePZ/MTuILSzgLnFr
        QRNYPbOAuMStJ/PB7hARuMMk0fjwE1gDm4ChRO/RPrBBnAKuEq/b9rBBNMhLbH87B+q8FxwS
        /euNIWwXiWMn7rJA2MISr45vYYewZSROT+6BitdLTJ5yhQ3C7mCU+LrXDMK2lpiw6QRQnANo
        vqbE+l36EGFHiTML3zKBhCUE+CRuvBWEuIBPYtI2UJiChHklOtqEIKpVJH6vms4EYUtJdD/5
        D7XUQ2LF7k9MExgVZyEFyiwkz89C8tcshBsWMLKsYhRPLS3OTU8tNspLLdcrTswtLs1L10vO
        z93ECExPp/8d/7KDcfmrj3qHGJk4GA8xSnAwK4nwVl9kSBbiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOm5y5IVFIID2xJDU7NbUgtQgmy8TBKdXAxC2S6fW4kPdLksPq69zPVFy8Paf+CLJe4s3e
        l60eblY+2Wd7CsM/vr3e7Z5m2/6JaRVe+mg09WbZrnLV1B3hfGJy8m92sOzZ+SZixgfXx/b3
        WzZwlRyJkjxtPm1H2+3I1U+/Wf37WvTwquTlG+IbPWzfyV8JLt20m5NXUHPr3ScHV75/eM2s
        RrV3e9G2GUI5De0vX1gfOx8/g+PmGyYm5eWfBEwVI7UUrLjnqN4MUZ2i/cOt65eRXf7i29t/
        mdWbLgzUz3kn2/RKksE/N0/PPz91yoZdZ5ykVp3Yc19D3idWlHnqson9LlbzjM7/NPr6N1s9
        UfjExMOXtLYtXqo5W+PVv0mBvrkT3jBqp8x6ocRSnJFoqMVcVJwIANv0p32+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xe7ov21iSDU5f5rV4MG8bm8X1L89Z
        Lfa+3spu8bHnHqvF5V1z2CxmnN/HZHHxlKvFv2sbWSxW7frD6MDp8f5GK7vHzll32T02repk
        87hzbQ+bR9+WVYwenzfJBbBF6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp
        29mkpOZklqUW6dsl6GW8bT7IWPCduWLe0pdMDYzTmbsYOTkkBEwkOnr+sXcxcnEICSxllHi5
        /RqQwwGUkJKY36IEUSMs8edaFxtEzXtGidnXN7GCJHgF7CT63n4Fs1kEVCUurvvCCBEXlDg5
        8wkLiC0qkCyx4NBSMFtYwF3i1oImsHpmAXGJW0/mM4EMFRG4xyTx9eUtJogNMxglVmxaAHYe
        m4ChRO/RPrCpnAKuEq/b9rCBXMcsoC6xfp4QxCB5ie1v5zBPYBSchWT3LCQ7ZiF0zELSsYCR
        ZRWjSGppcW56brGRXnFibnFpXrpecn7uJkZg3G079nPLDsaVrz7qHWJk4mA8xCjBwawkwlt9
        kSFZiDclsbIqtSg/vqg0J7X4EKMp0P8TmaVEk/OBkZ9XEm9oZmBqaGJmaWBqaWasJM7rWdCR
        KCSQnliSmp2aWpBaBNPHxMEp1cC0bN/ZHNPYNjO90JSnLtf5V862bnx4oU3m8II5FtxXv8bZ
        1X89mLyguyxiueRpzqSmY8m37MREcsOjF2sFnZVm+RuzwNLx7rXQYz4rp56QF0nZH2RWrFfr
        tnJ2p71yxtxgt7zM4q7re9Kq5U5JtL75I1ph4My1Kf/Xv9V3Vp1ruO4h8+SksO95YVetGX6c
        M3p6t1y70d3AcF+0VGCd8OSpmcqV8b8EKtTUO+8VZdinNcY+q45V3K90zp1zjsQu0eDlu2vW
        a++fp3TW4seKzuOTj4j+apTLPBayYvEnrsgOOfWmQxESGxM/2s72ME3uUb8hmHvwzdHE9IuN
        OlcLHfinLj73ad/LZZUWy+XZ9iuxFGckGmoxFxUnAgAtkIR/RAMAAA==
X-CMS-MailID: 20220823075105eucas1p24f6502d7088ffeb65180723f4c7b246c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220823073202eucas1p148f4ef93a8469ccfb5f4f2bdc7146555
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220823073202eucas1p148f4ef93a8469ccfb5f4f2bdc7146555
References: <CGME20220823073202eucas1p148f4ef93a8469ccfb5f4f2bdc7146555@eucas1p1.samsung.com>
        <20220823073154.359090-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.08.2022 09:31, Krzysztof Kozlowski wrote:
> Add Krzysztof Kozlowski (already Samsung SoC maintainer) as Samsung SoC
> clock maintainer to handle the patches.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Agreed with Sylwester who is recently busy. Let me handle some patches
> as I already handle rest of Samsung SoC.
> 
> I plan to send pulls the same way Sylwester did - to Stephen.

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

