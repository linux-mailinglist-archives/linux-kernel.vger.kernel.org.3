Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FD753C3CE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 06:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbiFCEeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 00:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiFCEeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 00:34:07 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CC536323
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 21:34:01 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220603043356epoutp02d7180d2a899e88f6222ecec66fdafdfc~1Ai5XYT4y0482604826epoutp02c
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 04:33:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220603043356epoutp02d7180d2a899e88f6222ecec66fdafdfc~1Ai5XYT4y0482604826epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654230836;
        bh=Bjg9nXj462IMIr5qb5SJpdPuDBVXCpWmWsSmQSOdq70=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=ZlCwI8QR8LIsWncCtfqYu2hRK49pkxuMt5mjfEBNtDgATaRdn+qrEd2m8PDOZdv+b
         kk8pJDhN/VVYMXcH3rl2HUvvvdfF/ceEXj5IMsLxBGLsNPhxmB60/XxygAhG+TTZ9i
         G6iModzcfL+E8mhEnKMcSPWEl1cp9s793R8kbh2Y=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220603043355epcas2p43b7ddaf46104a6f70d3c5491e5165971~1Ai4qq_en0894908949epcas2p4T;
        Fri,  3 Jun 2022 04:33:55 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.90]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LDqlQ3myNz4x9Pt; Fri,  3 Jun
        2022 04:33:54 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FE.CE.10028.23F89926; Fri,  3 Jun 2022 13:33:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220603043353epcas2p383b491b9e919f77376b029410a6413c8~1Ai2wa_9D2320823208epcas2p3l;
        Fri,  3 Jun 2022 04:33:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220603043353epsmtrp1e940120083defcd3461af79e2a692608~1Ai2vhMYV0429804298epsmtrp1B;
        Fri,  3 Jun 2022 04:33:53 +0000 (GMT)
X-AuditID: b6c32a47-589ff7000000272c-c9-62998f321968
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.F1.11276.13F89926; Fri,  3 Jun 2022 13:33:53 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220603043353epsmtip2a7f902cfd44ff37a1147ccc4c107d60c~1Ai2fAyxR2191321913epsmtip2V;
        Fri,  3 Jun 2022 04:33:53 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Tomasz Figa'" <tomasz.figa@gmail.com>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Linus Walleij'" <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
In-Reply-To: <20220601152720.232383-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH v2 0/7] pinctrl/arm: dt-bindings: deprecate header with
 register constants
Date:   Fri, 3 Jun 2022 13:33:53 +0900
Message-ID: <000501d87703$211ff7a0$635fe6e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWHmU798Y7haEPVJB1jko1Mvp8lAHBvrEtrLO6ubA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmua5R/8wkgz3vZCwezNvGZjH/yDlW
        i74XD5kt9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWM87vY7Jo3XuE3eLwm3ZWi1W7/jA6
        8HjsnHWX3WPTqk42jzvX9rB5bF5S79G3ZRWjx+dNcgFsUdk2GamJKalFCql5yfkpmXnptkre
        wfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUA3KimUJeaUAoUCEouLlfTtbIryS0tSFTLy
        i0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM/pmrGAvOM1a8XjqJ+YGxr0sXYyc
        HBICJhLXdq5i62Lk4hAS2MEocejOBUYI5xOjxOS136Ay3xglep/dYoVpubBgJTNEYi9Q1bEX
        LBDOC0aJn2uXMYFUsQnoS7zs2AbWISLQySLxq98FxOYUcJW4e3g3O4gtLJAgsfHiSrB6FgEV
        iQNXNzOC2LwClhKTzxxhh7AFJU7OfAJ2LLOAvMT2t3OYIa5QkPj5dBnUfCuJ7gtbmSFqRCRm
        d7aBXSchsIND4vL0s0BFHECOi8SWHbUQvcISr45vYYewpSRe9rdB2cUSS2d9YoLobWCUuLzt
        FxtEwlhi1rN2RpA5zAKaEut36UOMVJY4cgvqND6JjsN/2SHCvBIdbUIQjeoSB7ZPhwa1rET3
        nM/QMPSQeHHvPPMERsVZSJ6cheTJWUiemYWwdwEjyypGsdSC4tz01GKjAmN4ZCfn525iBCdf
        LfcdjDPeftA7xMjEwXiIUYKDWUmEt2TX1CQh3pTEyqrUovz4otKc1OJDjKbAYJ/ILCWanA9M
        /3kl8YYmlgYmZmaG5kamBuZK4rxeKRsShQTSE0tSs1NTC1KLYPqYODilGpjK/rK4n7xnf0e4
        5fZz9XM6Hcc4G+7fFJNKTeExXXJjtez/Facbq8NPpTyZ8u3LiRMfPZuOa+qceXZVSpGNJ8zU
        WLJzqv9Z+asTeW82zuY2cBS3nuZa3tJ4sOz9C+spTP8t55w+w+Aj2h4VFln8R/Hc17d/zOfF
        XPqtVhc5L5xvqmHCCYnuVX+K9DYmXeBgXWB7cE3NLKfyqrwfvza1WNdEq6y6G9bLl2H//XFE
        /EVphxsOj87I7xac+fJCnuumJTOzSvZPPRDFl/Buntwam5ylBhbZ80JqM7fdtT33v+ax4+N7
        vv12VS3rHwjXJ1bejd78sEP0z4uaxfzMr08EVtfLL7gqUNhxsi1R9EWx3zwlluKMREMt5qLi
        RAB4195pRwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSvK5h/8wkg+kNfBYP5m1js5h/5Byr
        Rd+Lh8wWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLGef3MVm07j3CbnH4TTurxapdfxgd
        eDx2zrrL7rFpVSebx51re9g8Ni+p9+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6Mvhkr2AtO
        s1Y8nvqJuYFxL0sXIyeHhICJxIUFK5lBbCGB3YwSLzZFQsRlJZ6928EOYQtL3G85wtrFyAVU
        84xR4uTRmUwgCTYBfYmXHdtYQWwRgYksEldXJEIUTWOUWPDpFVgRp4CrxN3Du8EmCQvESZyY
        dpQNxGYRUJE4cHUzI4jNK2ApMfnMEXYIW1Di5MwnQNdxcDAL6Em0bQQrYRaQl9j+dg4zxEEK
        Ej+fLoPaayXRfWErM0SNiMTszjbmCYxCs5BMmoUwaRaSSbOQdCxgZFnFKJlaUJybnltsWGCY
        l1quV5yYW1yal66XnJ+7iREcbVqaOxi3r/qgd4iRiYPxEKMEB7OSCG/JrqlJQrwpiZVVqUX5
        8UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTDNsy7ctSyU5ei60/Wm2scn
        21bVWO79rnYtTmrTWh97LRkr5xhmMf7J3pc7/89ra3gn4XPU9uaOV2EBLNpTte0/8rLeEVXz
        vHKQXcRYL/jUlPK7Gz4lX02b8k7629rwcybMHnwbjn2Mv3PhcuAUv1fp/GIsbs3pstmyXpvr
        le5uXh8rPl3O8stpOSfDAmG1A1a6x2QDMiWeJlZyHdhzqvSu9b+X70/sUU7XFN4lWfS958gS
        nVlhaTt2/Xi5STEtNvTq6+hPe9ZOzrv3/k2V5Vzp3Sq7FZTvzs9o01wsd89upcRLH5uTm/o3
        rj0UU3Cr4ZZim3HGXqXVO1X++rNWMPa4tnUn7o5dzjWBwWDW5TolluKMREMt5qLiRAAA2Qa6
        JQMAAA==
X-CMS-MailID: 20220603043353epcas2p383b491b9e919f77376b029410a6413c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220601152757epcas2p30927b9924e9371cdfa79986c6efb6eaf
References: <CGME20220601152757epcas2p30927b9924e9371cdfa79986c6efb6eaf@epcas2p3.samsung.com>
        <20220601152720.232383-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Krzysztof Kozlowski (7):
>   ARM: dts: s3c2410: use local header for pinctrl register values
>   ARM: dts: s3c64xx: use local header for pinctrl register values
>   ARM: dts: s5pv210: use local header for pinctrl register values
>   ARM: dts: exynos: use local header for pinctrl register values
>   arm64: dts: exynos: use local header for pinctrl register values
>   arm64: dts: fsd: use local header for pinctrl register values
>   dt-bindings: pinctrl: deprecate header with register constants

nit: Put the comment closure to the next line.

+ * Author: Krzysztof Kozlowski <krzk@kernel.org>  */

Otherwise,
Reviewed-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

