Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74E25515DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbiFTK33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240819AbiFTK23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:28:29 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1389511470
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:28:26 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220620102820euoutp02fcfa1797471cd118bf414f50122893e9~6TWMEJqju0956309563euoutp029
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:28:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220620102820euoutp02fcfa1797471cd118bf414f50122893e9~6TWMEJqju0956309563euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655720900;
        bh=qp9YVJlu4olz3oYnsD1sNkejmf6dHxDAHbWKn3wrbXs=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=m8sKfqYXwOKq5iRyo4466JVOkrWa0z1iy1XM4gumHu6yoXKRriiPGLto+i78nYnwQ
         SMt+eUYIto0HPecP7TCEueI31x+r31LMo6dKIH6z3yu1p9NQy9V3xoylrOnSepAIEC
         ww91rexUyZHR2VmLQVm2kWpcNd7Gam4v+JWPW47A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220620102820eucas1p257ab2bd019e065e26fc7f61d487100e9~6TWLl3p8S0766307663eucas1p2w;
        Mon, 20 Jun 2022 10:28:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 11.E8.09664.4CB40B26; Mon, 20
        Jun 2022 11:28:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220620102819eucas1p2b03a01c45ca3d0d42ebb9542954f0a4a~6TWLB5yxx1180011800eucas1p2P;
        Mon, 20 Jun 2022 10:28:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220620102819eusmtrp1d406de29bcbd43e98e82e8fcfe0fbfea~6TWLAuDit3265932659eusmtrp1X;
        Mon, 20 Jun 2022 10:28:19 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-d7-62b04bc46c2e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FB.B5.09038.3CB40B26; Mon, 20
        Jun 2022 11:28:19 +0100 (BST)
Received: from [106.210.134.141] (unknown [106.210.134.141]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220620102818eusmtip249ef53827dc9ea948a39b0409a3c2ca2~6TWKQ8suX3096730967eusmtip2G;
        Mon, 20 Jun 2022 10:28:18 +0000 (GMT)
Message-ID: <4b132eb8-d823-248f-0fc0-c825ba3754fa@samsung.com>
Date:   Mon, 20 Jun 2022 12:28:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 1/5] dt-bindings: clock: Add bindings for Exynos7885
 CMU_FSYS
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     phone-devel@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
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
In-Reply-To: <20220601233743.56317-2-virag.david003@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djPc7pHvDckGUxYyW7xYN42NovrX56z
        Wsw/co7Vou/FQ2aLTY+vsVp87LnHanF51xw2ixnn9zFZXDzlarHgj51F694j7Bb/rm1ksVi1
        6w+jxfH3jxkd+Dze32hl99g56y67x6ZVnWwed67tYfPYvKTeo2/LKkaPz5vkAtijuGxSUnMy
        y1KL9O0SuDIm3NvOXnCWqaL91EPGBsYZTF2MHBwSAiYSkz/ZdjFycQgJrGCUOLnnABuE84VR
        4vPsaSxdjJxAzmdGiVNXKkFskIaGXfOhipYzSvxofscE4XxklGg7+IwZpIpXwE5iXfcyRhCb
        RUBVon/3Pai4oMTJmU/ApooKJEucO3uVDcQWFgiW+N46jRXEZhYQl7j1ZD4TiC0ioCXx4cxD
        VpAFzAJPmCVutExlB0mwCRhK9B7tA1vACbTs6tFlLBDN8hLb385hBmmQEJjNKXG3bwMjxKMu
        Ej333SBeEJZ4dXwLO4QtI3F6cg8LhF0vMXnKFTYIu4NR4uteMwjbWmLCphNsIGOYBTQl1u/S
        hwg7SjyatwEajHwSN94KQlzAJzFp23RmiDCvREebEES1isTvVdOZIGwpie4n/1kmMCrNQgqU
        WUien4Xkl1kIexcwsqxiFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITGmn/x3/tINx7quP
        eocYmTgYDzFKcDArifDacG9IEuJNSaysSi3Kjy8qzUktPsQozcGiJM6bnLkhUUggPbEkNTs1
        tSC1CCbLxMEp1cDEcKWKte2ttejHzsKcjarcU97rc+7RXp2ztODB1PznfHPPhm/ieXJs+iyh
        vPsr5hRGqa7P1+yRT+TkNBBMLKuafGXHziJjtmXfbsgElNfufxJYcqR5toblNlkezs81vVu0
        WHdO1969c5H2wiP8Ehe7mQRT+nbtvdT69GX13vS4S5K2BV9/fbaQVI3/ZiT441yf78nrImlh
        kzgu1hpW8T7w0NOevmyttvXRpG/VZ0TEP62sFq1QWZcRHfrIpn2yrp9Rt91MppVTJt5Y9n/z
        oWgmbud1S5V0Fh+3rJ2f8265hqqMvG6Fr+1/hglnA9dc9vc4I2O5JEt5bc5u36Lggrk3Thf7
        uRgYt8zL+JKquEeJpTgj0VCLuag4EQBjWi322AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7qHvTckGZxfL2XxYN42NovrX56z
        Wsw/co7Vou/FQ2aLTY+vsVp87LnHanF51xw2ixnn9zFZXDzlarHgj51F694j7Bb/rm1ksVi1
        6w+jxfH3jxkd+Dze32hl99g56y67x6ZVnWwed67tYfPYvKTeo2/LKkaPz5vkAtij9GyK8ktL
        UhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIm3NvOXnCWqaL9
        1EPGBsYZTF2MnBwSAiYSDbvms3UxcnEICSxllDjx7htjFyMHUEJKYn6LEkSNsMSfa11QNe8Z
        Jc7d+8cMkuAVsJNY172MEcRmEVCV6N99DyouKHFy5hMWEFtUIFmiecshsGXCAsES31unsYLY
        zALiEreezAeLiwhoSXw48xAq/oxZouOlJIgtJFAosWlJN1gNm4ChRO/RPrBdnEB7rx5dxgJy
        J7OAusT6eUIQrfIS29/OYZ7AKDQLyRWzkGybhdAxC0nHAkaWVYwiqaXFuem5xUZ6xYm5xaV5
        6XrJ+bmbGIExvO3Yzy07GFe++qh3iJGJg/EQowQHs5IIrw33hiQh3pTEyqrUovz4otKc1OJD
        jKbAkJjILCWanA9MInkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxS
        DUx7Iz4eaJ6cm+mje+rmYfMzsv96lx1LlOTb01HkUztFS1n8w97z66bbRqs4WkhPNNht6bBO
        5KJIPIuUbVPh8mrrmOkTX8t/a2m5N2m78fl8o9CXrO9LDt/4sejVodeTNne3iMetS7miGtWS
        x/zjbL2wuNK90z5eO/9F+u6tvbgiJiWman1Pdormx5UZp/c9eM7/iT02KWLBr8Xnl/xc9Js3
        jKlZUb35cGVbULDrCVX1rsNSb7keiATXrSqPfSWu7XQ/YPcbrxCzqcel5n6fyjhrmvyN+Lbb
        OzJ6uwpWxZYs2ZPCWfaTTUZxY8zR6zNKLwdze9x4NOFm8I+U9w6+Rr+Xavx+uGzKZYXEbb6P
        d/5VYinOSDTUYi4qTgQAZI0iF2oDAAA=
X-CMS-MailID: 20220620102819eucas1p2b03a01c45ca3d0d42ebb9542954f0a4a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220620102819eucas1p2b03a01c45ca3d0d42ebb9542954f0a4a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220620102819eucas1p2b03a01c45ca3d0d42ebb9542954f0a4a
References: <20220601233743.56317-1-virag.david003@gmail.com>
        <20220601233743.56317-2-virag.david003@gmail.com>
        <CGME20220620102819eucas1p2b03a01c45ca3d0d42ebb9542954f0a4a@eucas1p2.samsung.com>
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

On 02.06.2022 01:37, David Virag wrote:
> CMU_FSYS clock domain provides clocks for MMC (MMC_CARD, MMC_EMBD,
> MMC_SDIO), and USB30DRD.
> 
> Add clock indices and bindings documentation for CMU_FSYS domain.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
