Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38A453B939
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbiFBM6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiFBM6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:58:51 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF666267CD9;
        Thu,  2 Jun 2022 05:58:48 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id k11so6369216oia.12;
        Thu, 02 Jun 2022 05:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Sl40eTqdPmzEKppcJA4FQwmfcLIIy0ie+JY3OH9t8Y=;
        b=1Kgs5Vr4Qhz/YHIeBZiOW5mBeQ9cwjp8wd+G5DpNxr7cZJMM8JQvM47O2KqnpL/OHX
         rl6oAp4RQYr73PQPBHs8PVcQDG5FAi9bqn8uuaeO8Cxky1DxrEgYEddRuvnualyHlpcw
         yhyM/z9hskI2QkgA+O0fMfRO3ZyRQeTYcff+m47UR+iYmbp4oEPTh+fQHwzopqM7JIbh
         dH00bfST1NCQTitMfNRrPX4ce2rd+rgJpc5SdaqIJilzao15Uluf+B8liJJst27QzJEg
         MHY+YV911KNZn/vSAUwzBOwPBNUVll1WL8I6sgmVDRdWYpK+bzlVloxw0WG0SKnXRifm
         Zp4Q==
X-Gm-Message-State: AOAM532gc15+1k/IMn8TX9rpwNaZ3Dmxo1vnhgc0COzuK9ZNfcegYF+0
        buAYYNirpuWP2UJVkOFgM00b9QD10w==
X-Google-Smtp-Source: ABdhPJwH6fy65rUHt6Lx51K//7iArjhtsHzTFqg2VRAtu11CoBlEcwO2/HjeRWn2atnzqNt3dkCjhg==
X-Received: by 2002:a05:6808:1584:b0:32b:314a:54ef with SMTP id t4-20020a056808158400b0032b314a54efmr17995256oiw.41.1654174727364;
        Thu, 02 Jun 2022 05:58:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 63-20020aca0542000000b00325643bce40sm2314868oif.0.2022.06.02.05.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 05:58:46 -0700 (PDT)
Received: (nullmailer pid 2095464 invoked by uid 1000);
        Thu, 02 Jun 2022 12:58:45 -0000
Date:   Thu, 2 Jun 2022 07:58:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        sboyd@kernel.org, olof@lixom.net, venture@google.com,
        vkoul@kernel.org, jirislaby@kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, arnd@arndb.de,
        daniel.lezcano@linaro.org, joel@jms.id.au, soc@kernel.org,
        devicetree@vger.kernel.org, tali.perry1@gmail.com, will@kernel.org,
        catalin.marinas@arm.com, linux@roeck-us.net,
        linux-serial@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        wim@linux-watchdog.org, krzysztof.kozlowski+dt@linaro.org,
        benjaminfair@google.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, linux-clk@vger.kernel.org,
        avifishman70@gmail.com, geert+renesas@glider.be, yuenn@google.com,
        tglx@linutronix.de, robh+dt@kernel.org,
        marcel.ziswiler@toradex.com, biju.das.jz@bp.renesas.com,
        robert.hancock@calian.com, lkundrak@v3.sk
Subject: Re: [PATCH v1 13/19] dt-bindings: arm: npcm: Add maintainer
Message-ID: <20220602125845.GA2095431-robh@kernel.org>
References: <20220522155046.260146-1-tmaimon77@gmail.com>
 <20220522155046.260146-14-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220522155046.260146-14-tmaimon77@gmail.com>
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

On Sun, 22 May 2022 18:50:40 +0300, Tomer Maimon wrote:
> Add Tomer Maimon to the maintainers list.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/npcm/npcm.yaml        | 1 +
>  Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml | 1 +
>  2 files changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
