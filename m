Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129E353EE3D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiFFS7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiFFS71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:59:27 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE31AAFB3C;
        Mon,  6 Jun 2022 11:59:25 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id n144so134683iod.4;
        Mon, 06 Jun 2022 11:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LBCu0rHUuV6/ftfk4QrcN/2mnb7WuKbppJnFTxyjW94=;
        b=nwnRN47R8roUVlUIUAOh/EgLE6E9Lvtk84fNSNA10m+0NHYtJTrTwMjvhstpmz/Tax
         56cX7I886Q8yhdZLBxWWGteKFB5PESsldSdY2C5+NZGDtkIEE6CgPlVY/do9HccR7xVY
         dc1hCzuyY4mGqdZ5X9jPtXx28nClimi3wQ1fmryamAnAREAaebtUlA9TkSRE2dqm0mVl
         6700YmXg5v38XHZMLIJkCwgxslhU+Zb/3/VM/IlReIUJfJRBBKa1KhuajwS7AvzSH463
         dQSeZX9Bt/MfDxWGtnKdaOZj+qTFXVIz+9Df4i/IgMgJpegV+PEVLKLwpz+bwJtN7gbI
         wqOA==
X-Gm-Message-State: AOAM532mgY9EYbCJxjyiri7okz+rFPKR20gP2HV4ImwUebjmJnQQ+WIg
        RZ65B2Cir/poAju1vBedtg==
X-Google-Smtp-Source: ABdhPJweHrdLUcsa2RnGGF2haYRcX1atBS2HmAwJzesZ7+Tb0tRZgHJ+InjfDtx4dsAxjBZfbip76A==
X-Received: by 2002:a05:6638:3787:b0:331:aaf5:950c with SMTP id w7-20020a056638378700b00331aaf5950cmr4180577jal.118.1654541965156;
        Mon, 06 Jun 2022 11:59:25 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id n5-20020a056e02100500b002d5366820acsm1585158ilj.18.2022.06.06.11.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 11:59:24 -0700 (PDT)
Received: (nullmailer pid 1080359 invoked by uid 1000);
        Mon, 06 Jun 2022 18:59:23 -0000
Date:   Mon, 6 Jun 2022 13:59:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 0/8] pinctrl/arm: dt-bindings: deprecate header with
 register constants
Message-ID: <20220606185923.GA900292-robh@kernel.org>
References: <20220605160508.134075-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605160508.134075-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 06:05:00PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Merging
> =======
> 1. I plan to take the DTS changes (patches 1-6) via Samsung SoC tree.
> 2. The driver change (patch 7) can go independently via pinctrl tree or via my
>    Samsung pinctrl tree.
> 3. The final bindings patch 8 will wait for next release, to avoid any cross
>    tree merges or warnings.
> 
> Changes since v2
> ================
> 1. Split last bindings patch per driver changes and bindings.
> 2. Add tags.
> 
> Changes since v1
> ================
> 1. Correct title (in the comment) of each header (Chanho).
> 2. Patch #7: Adjust warning message.
> 3. Add tags.
> 
> Description
> ===========
> The Samsung pin controller drivers were always expecting DTS to use raw
> register values for pin configuration (e.g. pull up/down, drive strength).  DTS
> had these values hard-coded all over, so at some point we decided for
> convenience to move them to dt-bindings header.  Less code duplication, some
> meaning added to raw number, etc.
> 
> However these constants do not fit the purpose of bindings.  They do not
> provide any abstraction, any hardware and driver independent ID.  With minor
> exceptions, the Linux drivers actually do not use the bindings header at
> all.  Because of this "dt-bindings ID" approach, these constants were re-used
> between chips, e.g. Exynos ones in S5PV210.  These does not make much sense
> because the values between Exynos and S5PV210 (or S3C24xx) are not related.  If
> it was an abstraction ID, this would be fine. But it's not.
> 
> Clean this up by:
> 1. Moving the constants to DTS-local headers.
> 2. Deprecating the bindings header.
> 
> Tested by comparing DTBs (dtx_diff, fdtdump).
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (8):
>   ARM: dts: s3c2410: use local header for pinctrl register values
>   ARM: dts: s3c64xx: use local header for pinctrl register values
>   ARM: dts: s5pv210: use local header for pinctrl register values
>   ARM: dts: exynos: use local header for pinctrl register values
>   arm64: dts: exynos: use local header for pinctrl register values
>   arm64: dts: fsd: use local header for pinctrl register values
>   pinctrl: samsung: do not use bindings header with constants
>   dt-bindings: pinctrl: samsung: deprecate header with register
>     constants

For the series:

Acked-by: Rob Herring <robh@kernel.org>

