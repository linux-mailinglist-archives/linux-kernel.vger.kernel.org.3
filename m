Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52994C03F9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiBVVkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbiBVVkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:40:12 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677DB139106;
        Tue, 22 Feb 2022 13:39:46 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id q5so16107767oij.6;
        Tue, 22 Feb 2022 13:39:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e2psfHnwZs5xWnyvc67xSSoWa8E4e5UoRm7fPOvRG2k=;
        b=J5LoT6ypVfOemIi4NpchuGpJjYJB1piKyMQZsit8PbdadJFbRNMLVdgn5JaBZRKhNJ
         yL+32IwQD9iNaa6ta3hxZoBm90J227tNBrB/4lOh+Kl2Gh5g7FjzYDjEdFhk3a1xe2SR
         Ijn+QHCDbZoFTfeD6tCF/b/u0swpNWONMKWCt6LaWCgk4dPZ2RW9TdTdkon3v592aqnY
         JOV7ty/KlMPFE21iuQNtCeTLTlXeEcT1TPGNS5qjwBPEB9CnruQiPKZaCCrz8bZsBHG7
         8DqjLoiU0WRMWOgLhRBjT7itpkX1bXchaJ8yE3oJ3E37E7L0L4UEDvU6h/Xd85/pCu8z
         QkRg==
X-Gm-Message-State: AOAM533qpZ8qsq0loBdYlIE5PjofVC9f9weUFKJAVjF5MVyRRiYUFraH
        gsHTNdcZcN8Hl49cNJHaoQ==
X-Google-Smtp-Source: ABdhPJzrwJuwkbQEPG+nVIKFTN4wDkORO0vQxGqMkcJcmKTnAAfMQGUYwq+TDGVA6kTamSiXcfTrIw==
X-Received: by 2002:a05:6808:202a:b0:2d4:df36:68a4 with SMTP id q42-20020a056808202a00b002d4df3668a4mr2997913oiw.16.1645565985765;
        Tue, 22 Feb 2022 13:39:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r36sm9663847oiw.40.2022.02.22.13.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 13:39:44 -0800 (PST)
Received: (nullmailer pid 3634892 invoked by uid 1000);
        Tue, 22 Feb 2022 21:39:43 -0000
Date:   Tue, 22 Feb 2022 15:39:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     conor.dooley@microchip.com
Cc:     linux-gpio@vger.kernel.org, atishp@rivosinc.com,
        a.zummo@towertech.it, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.walmsley@sifive.com, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        ivan.griffin@microchip.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, daire.mcnamara@microchip.com,
        jassisinghbrar@gmail.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        palmer@dabbelt.com, geert@linux-m68k.org,
        lewis.hanly@microchip.com, thierry.reding@gmail.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH v7 02/11] dt-bindings: soc/microchip: add info about
 services to mpfs sysctrl
Message-ID: <YhVYH6vf+b9jKeB3@robh.at.kernel.org>
References: <20220214135840.168236-1-conor.dooley@microchip.com>
 <20220214135840.168236-3-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214135840.168236-3-conor.dooley@microchip.com>
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

On Mon, 14 Feb 2022 13:58:32 +0000, conor.dooley@microchip.com wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The services actually provided by the system controller are not
> documented so add some words about what the system controller can
> actually do. Add a link to the oneline documentation with the specific
> details of each individual service.
> Also, drop the unneeded label from the example.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../soc/microchip/microchip,mpfs-sys-controller.yaml  | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
