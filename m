Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1223D4F79C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbiDGIcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243032AbiDGIcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:32:16 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1E2148652;
        Thu,  7 Apr 2022 01:30:16 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id k2so5495090edj.9;
        Thu, 07 Apr 2022 01:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RyClp8J+UOKKd69LMTLM+mjlqOxwep1G4/PnD2rDX08=;
        b=Mt/4xtHYCRSz9HxImH1r/cSaOGq627NjsJ6BjUXBtW4qhHf9AmlnRZtseRSnsS35Tf
         yKeOvzfVHwmjmOzl2sJ22RDKjomqwsQiFlRjm0MzY9/jAH7DdRQnvlbbqVKBdYdEQGnX
         ITgCeJ14wVD+LzYtM0UUxuO6OegjQIsfada+VKoipegYk4crapKQirukLOv26UNDhPpJ
         yOF4tgukP1D3vX0YTtCDsvAQeSDlpxmO/A14GIyNbOLjYS+f5r5tIbopwyT2HOKbGjr9
         g84Ck1YjB3pnfKynCniuLn85ND8bYiWniHXRNWGmRyNY+3GEncmBYUBXnKtMXMncViYe
         ac6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=RyClp8J+UOKKd69LMTLM+mjlqOxwep1G4/PnD2rDX08=;
        b=fUNtpX6y3E9lpOWHt0hbZo+KccJshIH5+UOCJEBAldZ6H/OuNGNO2relgQ2jAbqhaO
         oi81jXMymq+/WiQ5qbrUIRaR8pkKKOsKLCqWwTM8hHzvElpL1P0+zkAbyOID/E1M2q+q
         uzLnZQVvX8tU0wdsSimCK3C8tUlEe7VJiqkGnQp4f6Q9Y8313Vji2q7Hzu6dGUBuiWis
         dFG8ZiSGj63wLGtcPZtXR4Wi2kLZkFW62gFqNbc6FbT/9swIIePLR/hf84VrdoxmAG66
         w8VcsAM5QyKEFJGiDrF9k18LDP8xD3RhOvDAckgSg0GlnAReZa168vTb+zWSrRT5CVBQ
         MJ/Q==
X-Gm-Message-State: AOAM532yxPuX6QHcl9LQ/wNwXgCBfptCp3bvUFkU5zfH8tXAB4K0QAnt
        r7e8RXQWUyn4DL0gBHMHfeg=
X-Google-Smtp-Source: ABdhPJzlMtj4hzavyjsLVA1gXQU9mMuFyiRtIr2lqVzGRfol4/NLgz5bE5/0RBfla00DnYG3za6u7A==
X-Received: by 2002:a05:6402:548:b0:41c:bf00:307 with SMTP id i8-20020a056402054800b0041cbf000307mr12848490edx.6.1649320215006;
        Thu, 07 Apr 2022 01:30:15 -0700 (PDT)
Received: from giga-mm.localdomain ([195.245.23.54])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906380a00b006a68610908asm7406320ejc.24.2022.04.07.01.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 01:30:14 -0700 (PDT)
Message-ID: <74f4f647b22bc469fdcb535b47d5a808d8372e56.camel@gmail.com>
Subject: Re: [PATCH 03/12] ARM: ep93xx: enable SPARSE_IRQ
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com
Date:   Thu, 07 Apr 2022 10:30:12 +0200
In-Reply-To: <20220405091750.3076973-4-arnd@kernel.org>
References: <20220405091750.3076973-1-arnd@kernel.org>
         <20220405091750.3076973-4-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnd,

On Tue, 2022-04-05 at 11:17 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without CONFIG_SPARSE_IRQ, we rely on mach/irqs.h to define NR_IRQS
> globally. Do the minimal conversion by setting .nr_irqs in each
> machine descriptor.
> 
> Only the vision_ep9307 machine has extra IRQs for GPIOs, so make
> .nr_irqs the original value there, while using the plain NR_EP93XX_IRQS
> everywhere else.
> 
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Hubert Feurstein <hubert.feurstein@contec.at>
> Cc: Lukasz Majewski <lukma@denx.de>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I've successfully tested the whole series on EDB9302, therefore:
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>  arch/arm/Kconfig                               | 2 ++
>  arch/arm/mach-ep93xx/adssphere.c               | 1 +
>  arch/arm/mach-ep93xx/core.c                    | 1 +
>  arch/arm/mach-ep93xx/edb93xx.c                 | 8 ++++++++
>  arch/arm/mach-ep93xx/gesbc9312.c               | 1 +
>  arch/arm/mach-ep93xx/{include/mach => }/irqs.h | 7 -------
>  arch/arm/mach-ep93xx/micro9.c                  | 4 ++++
>  arch/arm/mach-ep93xx/simone.c                  | 1 +
>  arch/arm/mach-ep93xx/snappercl15.c             | 1 +
>  arch/arm/mach-ep93xx/soc.h                     | 1 +
>  arch/arm/mach-ep93xx/ts72xx.c                  | 3 ++-
>  arch/arm/mach-ep93xx/vision_ep9307.c           | 1 +
>  12 files changed, 23 insertions(+), 8 deletions(-)
>  rename arch/arm/mach-ep93xx/{include/mach => }/irqs.h (96%)

-- 
Alexander Sverdlin.

