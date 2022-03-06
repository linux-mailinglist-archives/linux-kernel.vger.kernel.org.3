Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983894CEC74
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 18:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbiCFRVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 12:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCFRVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:21:47 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42107245AD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 09:20:55 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220306172053epoutp040d3d10c76b803567ba192f4ffd245709~Z2mIdqe340130501305epoutp04Q
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 17:20:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220306172053epoutp040d3d10c76b803567ba192f4ffd245709~Z2mIdqe340130501305epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646587253;
        bh=1EaveVM354I680wWKepTv9UbYT4N+OVNjrhkaMrn/L8=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=dBk3RJZV4K7crLPPar9iXacsPWzl7598uZWM4ZyQf2BpDw/jizUKI+BSHlNWNhXfP
         7xdx2tGex6TXwaM51lsHJx1KAmZj+y2pTrTJSl0dBaFqiW8J1r89bPZqHoNueyJsSP
         5jJL1hReiGtlViEwH3/IeRhdoC/oW+mOPNqTKPxI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220306172053epcas5p24938608e20db954659a1cd97e5c9bd34~Z2mIFastw3024730247epcas5p2t;
        Sun,  6 Mar 2022 17:20:53 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KBSzP1tjtz4x9Pp; Sun,  6 Mar
        2022 17:20:49 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.BA.06423.17DE4226; Mon,  7 Mar 2022 02:20:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220306172048epcas5p330a3e9da5ab36716e8b6c316f98ac6b6~Z2mDZ1lsy2172321723epcas5p3d;
        Sun,  6 Mar 2022 17:20:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220306172048epsmtrp18ee4c9c42d77c8937fce28cb7980af59~Z2mDZGf7n0697306973epsmtrp1g;
        Sun,  6 Mar 2022 17:20:48 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-75-6224ed717739
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.C7.29871.07DE4226; Mon,  7 Mar 2022 02:20:48 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220306172046epsmtip28a499aa5f81aa185eb38ce66c5f02375~Z2mCNGZIW0287202872epsmtip2a;
        Sun,  6 Mar 2022 17:20:46 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20220304122424.307885-5-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH v2 4/4] arm64: dts: tesla: add a specific compatible to
 MCT on FSD
Date:   Sun, 6 Mar 2022 22:50:45 +0530
Message-ID: <000501d8317e$8563cc20$902b6460$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF3mhFkGb8Ybu5ilR4JKjDBi+CLBwKCJolaAjT+dSKtTg+nUA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmpm7hW5Ukg7+nuCzmfZa1mH/kHKvF
        xrc/mCw2Pb7GanF51xw2ixnn9zFZtO49wm6xedNUZgcOj1kNvWwem1Z1snncubaHzePduXPs
        HpuX1Ht83iQXwBaVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITvj040brAUHeCq+nXjE1MB4g6uLkZNDQsBE4sGkjcxdjFwcQgK7GSXWX77G
        BJIQEvjEKHH7ijpE4hujxK4dnewwHROvL4Xq2Mso8f7jTzYI5yWjxOv+z2wgVWwCuhI7FreB
        JUQELjFJnOhoAZvLKeAhseRbA1iRsECExIXvG5hBbBYBFYnzr46xdDFycPAKWEo8uZ8JEuYV
        EJQ4OfMJC4jNLCAvsf3tHGaIKxQkfj5dxgpiiwg4Sayc+ZQVokZc4uXRI+wgeyUE5nJIzJzz
        F6rBRaK7/yMbhC0s8er4Fqh3pCRe9rexg+yVEMiW6NllDBGukVg67xgLhG0vceDKHLDTmAU0
        Jdbv0odYxSfR+/sJE0Qnr0RHmxBEtapE87urUJ3SEhO7u1khSjwkjr9Tg4TUTUaJf39bWCYw
        KsxC8uQsJE/OQvLMLITFCxhZVjFKphYU56anFpsWGOallsOjOzk/dxMjOK1qee5gvPvgg94h
        RiYOxkOMEhzMSiK898+rJAnxpiRWVqUW5ccXleakFh9iNAUG/ERmKdHkfGBizyuJNzSxNDAx
        MzMzsTQ2M1QS5z2dviFRSCA9sSQ1OzW1ILUIpo+Jg1OqgSn1AVPtlfJl3cY/Pn38fHHO/+km
        UVO+N6808Zt9sUmdp/iRz52f75Jedpk9/lajaeHvckOBYV+k3oN9Ot0PWwr8ejTY2OcY90za
        fEfxUpJhJkOV0YsZt91Etx7+o5TvzWY/yfxCaMkOhv5mJle7LkuTia5lpdN7ZtpY65a5q3A+
        mr+6UU+C4VDD6biDKq8cPt19aSoaGL/tq3L8rVf2+soP7e5aqNZzuofFPFu6L+v91gNx98Ly
        Ti/z8Hv6LvrALSc5zqf+O784/Nm/tyK301Qz5Hj3pEYrzRUKz1/8Lo/tcJx+P/wmu+XR783K
        lorvru5z2u5X2/tTM7KF797MtDbrfI+URR/d8n/IOQnxKrEUZyQaajEXFScCAOS/VS00BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSvG7BW5Ukg23t3BbzPstazD9yjtVi
        49sfTBabHl9jtbi8aw6bxYzz+5gsWvceYbfYvGkqswOHx6yGXjaPTas62TzuXNvD5vHu3Dl2
        j81L6j0+b5ILYIvisklJzcksSy3St0vgyvh04wZrwQGeim8nHjE1MN7g6mLk5JAQMJGYeH0p
        cxcjF4eQwG5GiZkbprFAJKQlrm+cwA5hC0us/PecHaLoOaPEq9+9YEVsAroSOxa3sYEkRARu
        MElMP3CTCaLqKqPExL/HmUGqOAU8JJZ8awCq4uAQFgiTePFOHiTMIqAicf7VMRaQMK+ApcST
        +5kgYV4BQYmTM5+AhZkF9CTaNjKChJkF5CW2v53DDHGPgsTPp8tYQWwRASeJlTOfskLUiEu8
        PHqEfQKj0Cwkk2YhTJqFZNIsJB0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIE
        x5CW5g7G7as+6B1iZOJgPMQowcGsJMJ7/7xKkhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n
        44UE0hNLUrNTUwtSi2CyTBycUg1MLROSJYUKlmznnvDdzk4wYerr+QHaio67ry89pPWk/bOo
        14HuVwohQjeqGNj+7OGTfWTh8Ibr8qKdGbu7t/1gXOX0fre33fFJ97nkrW2+s0W8L+iR+s32
        zSS2vGGa8l+eOX27mQsl9bnjDH7d7AirmeJ37FZW5hKJjgJOjxl/ds5RU8zL7+myWqAUvyz7
        6td/pyafdueL3mf9/Yi8rvNV4cyZEt4Tf/vc8hPLUP7k/6ee9dL7F8rmvDu3TXlxhSn+es6B
        aeWr/fQe2uw7/V/zyYOk624pKbavjl0V3P4p5+vf+/KnDh/6LPYtNW1reJPHynds70zcjcpN
        cm0W5T7/4G67s1ff+/n/yQzJiYcuKrEUZyQaajEXFScCAGOztAYQAwAA
X-CMS-MailID: 20220306172048epcas5p330a3e9da5ab36716e8b6c316f98ac6b6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220304122516epcas5p16053f1a7266068411806b323a9b836a9
References: <20220304122424.307885-1-krzysztof.kozlowski@canonical.com>
        <CGME20220304122516epcas5p16053f1a7266068411806b323a9b836a9@epcas5p1.samsung.com>
        <20220304122424.307885-5-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Friday, March 4, 2022 5:54 PM
>To: Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner
><tglx@linutronix.de>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>Kozlowski <krzysztof.kozlowski@canonical.com>; Alim Akhtar
><alim.akhtar@samsung.com>; linux-kernel@vger.kernel.org;
>devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>samsung-soc@vger.kernel.org
>Subject: [PATCH v2 4/4] arm64: dts: tesla: add a specific compatible to MCT
on
>FSD
>
>One compatible is used for the Multi-Core Timer on Tesla FSD SoC, which is
>correct but not specific enough.  The MCT blocks have different number of
>interrupts, so add a second specific compatible to Tesla FSD.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


> arch/arm64/boot/dts/tesla/fsd.dtsi | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
>b/arch/arm64/boot/dts/tesla/fsd.dtsi
>index 9a652abcbcac..10c217a57a7d 100644
>--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
>+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
>@@ -727,7 +727,7 @@ spi_2: spi@14160000 {
> 		};
>
> 		timer@10040000 {
>-			compatible = "samsung,exynos4210-mct";
>+			compatible = "tesla,fsd-mct", "samsung,exynos4210-
>mct";
> 			reg = <0x0 0x10040000 0x0 0x800>;
> 			interrupts = <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
> 				<GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
>--
>2.32.0


