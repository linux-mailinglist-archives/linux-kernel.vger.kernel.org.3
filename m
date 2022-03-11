Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743CD4D58BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345962AbiCKDPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345942AbiCKDPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:15:50 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67BA1A2755
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:14:47 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id fs4-20020a17090af28400b001bf5624c0aaso7052359pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=2FqWSjkXuo5S9mesJxoz3NDkdM5WB3sWHU6io9eY7fk=;
        b=JQ83gMdtJ8abAR5h7+idsAWzxiZol4eLzOdZjVDWrebCaG/Vbex5HMwHcvgDRvL1lk
         d87AF/jaKWvGGVRtKm/QeQQJSiQaR+zx/ykXsPAhYGD0wYvTwkcGOjLTLX8IIgcACB3E
         glTddo1PAPLJZG29IEdnATCiBAGXdCsO8RwWmjBNridFgRXsguSxBGUM5fhuysu6qCcN
         NuHVBGL3a5XX+io/Gp1e3KpizUVYVAWMYFxxRHw5qQXGeirIJCMJLCCaQt4uQpI0rcCI
         Cs1rm8fGOW3lqkvPIVoWmeWhSsOAAzfMdnYbVqoaqM0+XwdnBqOj73G4my/kVvFuZ+p2
         wnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=2FqWSjkXuo5S9mesJxoz3NDkdM5WB3sWHU6io9eY7fk=;
        b=IGjyA1c9/KZs1KUvycqGPO6u+D2B6z9/t8i2PKm+EmaiXJCCKjnyTScNlYJ34H0PCe
         5C6xqAVejDdERGkOv0PTS1G7vCWsDfZFLQLwY/r4Ufar/cQUfTvYJce4LZyLeqMNiOrW
         Qy5FuY8JQdKCTlKCzFSuZ98VuWVP53XXQFIbV5BbAY33gGDfMVHjcuuuKmMeUUsR9rsB
         u0zIeHkpODzUq446VgV2Qc5Vd+A59OAWHgu5jnU+PApzHHXNPBEpKO6eBltS1wLvsfN+
         OBKhOiesiRO9sVDGyUDw7Nf47qOs7qgVVNo6l0AA7+eghQ2KGXZloCvUY0YOVlK4452h
         rrZw==
X-Gm-Message-State: AOAM530iDUddrvAx/VQLVqsYhdxR342mMVb88Lsl9ldx6lU1349d+RLp
        FTNGDaGPtnZhoeoqdwYwmRcH2g==
X-Google-Smtp-Source: ABdhPJxDNSPztcFWbjAxP2vLau7vxHCY/ogScAPVFQ6aIwReOrOag3ZvU3eB4x2JYdPBlmhtuOZCSQ==
X-Received: by 2002:a17:902:b189:b0:14d:6f87:7c25 with SMTP id s9-20020a170902b18900b0014d6f877c25mr8505020plr.31.1646968487048;
        Thu, 10 Mar 2022 19:14:47 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id l9-20020a655609000000b0037589f4337dsm6865189pgs.78.2022.03.10.19.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 19:14:46 -0800 (PST)
Date:   Thu, 10 Mar 2022 19:14:46 -0800 (PST)
X-Google-Original-Date: Thu, 10 Mar 2022 15:54:41 PST (-0800)
Subject:     Re: [PATCH] MAINTAINERS: sifive: drop Yash Shah
In-Reply-To: <20220214082349.162973-1-krzysztof.kozlowski@canonical.com>
CC:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, aou@eecs.berkeley.edu,
        p.zabel@pengutronix.de, sagar.kadam@sifive.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     krzysztof.kozlowski@canonical.com
Message-ID: <mhng-b01b9acc-de77-4d1d-9cdc-f3830a6c569a@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 00:23:49 PST (-0800), krzysztof.kozlowski@canonical.com wrote:
> Emails to Yash Shah bounce with "The email account that you tried to
> reach does not exist.", so drop him from all maintainer entries.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/gpio/sifive,gpio.yaml     | 1 -
>  Documentation/devicetree/bindings/pwm/pwm-sifive.yaml       | 1 -
>  .../devicetree/bindings/riscv/sifive-l2-cache.yaml          | 1 -
>  MAINTAINERS                                                 | 6 ------
>  4 files changed, 9 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
> index e04349567eeb..427c5873f96a 100644
> --- a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
> @@ -7,7 +7,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: SiFive GPIO controller
>
>  maintainers:
> -  - Yash Shah <yash.shah@sifive.com>
>    - Paul Walmsley <paul.walmsley@sifive.com>
>
>  properties:
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
> index 676b2160bada..605c1766dba8 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
> @@ -8,7 +8,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: SiFive PWM controller
>
>  maintainers:
> -  - Yash Shah <yash.shah@sifive.com>
>    - Sagar Kadam <sagar.kadam@sifive.com>
>    - Paul Walmsley <paul.walmsley@sifive.com>
>
> diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> index 2b1f91603897..e2d330bd4608 100644
> --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> @@ -9,7 +9,6 @@ title: SiFive L2 Cache Controller
>
>  maintainers:
>    - Sagar Kadam <sagar.kadam@sifive.com>
> -  - Yash Shah <yash.shah@sifive.com>
>    - Paul Walmsley  <paul.walmsley@sifive.com>
>
>  description:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ebf7a75a6bec..87eeac970ca2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7090,12 +7090,6 @@ L:	linux-edac@vger.kernel.org
>  S:	Maintained
>  F:	drivers/edac/sb_edac.c
>
> -EDAC-SIFIVE
> -M:	Yash Shah <yash.shah@sifive.com>
> -L:	linux-edac@vger.kernel.org
> -S:	Supported
> -F:	drivers/edac/sifive_edac.c

Looks like that leaves this unmaintained?  I'm happy to volunteer, I've 
got the boards lying around somewhere and sort of feel on the hook to 
keep this stuff alive given that whatever's in there is partially my 
fault.  That said, I'm happy to stay out of it so if it's OK to have 
otherwise unmaintained EDAC drivers that works for me so

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks!

> -
>  EDAC-SKYLAKE
>  M:	Tony Luck <tony.luck@intel.com>
>  L:	linux-edac@vger.kernel.org
