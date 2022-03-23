Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2194E5856
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245682AbiCWSZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiCWSZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:25:32 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87295F56;
        Wed, 23 Mar 2022 11:24:01 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id o64so2491004oib.7;
        Wed, 23 Mar 2022 11:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oKTwXn3AzG41Z3u41j1rFts/g2rJnWT6gTg6f0FYmHE=;
        b=dFJiAfSZvgq0MCCzBmcBhw/azrMl58UjngAEmtNc66dQl5mHoNLI2NMqty3eT4m65W
         sbdfnQ8O6E6gqacwUJcqQ5ym75UnALf1hE2qsbQmrIo/ghqDLMT0IPHQzTswZmiPtTw9
         qaLI+VYGKqdjfIO7+uPyAh+M30F9mCB3y9kNISfDoPRH5bqBeVHZ0qJPYEgeT3vGaKVL
         zl5EGLO0xPQehhsNA0sirLP6Dz0iGyVXFKwifu9T1FU2i7zF54yuIqx7YAkgbrIOCgAY
         BnnrCaVaBbR7tuhBx21f4NT9HNE8AWpFA34wp218YL4ipgfiB0s0fZxFruywvC015XcF
         OXzg==
X-Gm-Message-State: AOAM533SO4yLwgPC3GjdJpMSxzPnldEBtLT18wy8efLN6B5t4sq+SJQ8
        YSiBEkBrWdBEugv2h4m/ZQ==
X-Google-Smtp-Source: ABdhPJxoaSf2++CCDZaunh3odXbdG5Bl8kpsdCWU366fF1ugEU/8uHcoJEmuYVYlRMVnLUeZ5MX7sQ==
X-Received: by 2002:aca:230e:0:b0:2d9:ec1f:bbae with SMTP id e14-20020aca230e000000b002d9ec1fbbaemr5307335oie.68.1648059841134;
        Wed, 23 Mar 2022 11:24:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i4-20020a4addc4000000b00324bd261e5fsm50138oov.11.2022.03.23.11.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:24:00 -0700 (PDT)
Received: (nullmailer pid 206689 invoked by uid 1000);
        Wed, 23 Mar 2022 18:23:59 -0000
Date:   Wed, 23 Mar 2022 13:23:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     max.krummenacher@toradex.com, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v1 02/14] dt-bindings: arm: fsl: Add carriers for
 toradex,colibri-imx6dl
Message-ID: <Yjtlv9NUQ0dSNESd@robh.at.kernel.org>
References: <20220314162958.40361-1-max.krummenacher@toradex.com>
 <20220314162958.40361-3-max.krummenacher@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314162958.40361-3-max.krummenacher@toradex.com>
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

On Mon, 14 Mar 2022 17:29:46 +0100, Max Krummenacher wrote:
> Add bindings for Aster, Iris and Iris V2 carrier boards our
> Colibri iMX6S/DL may be mated with.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
