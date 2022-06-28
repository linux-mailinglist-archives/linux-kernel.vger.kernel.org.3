Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280D255EB58
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiF1RxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbiF1Rwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:52:45 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B592C134;
        Tue, 28 Jun 2022 10:51:40 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id p9so8378622ilj.7;
        Tue, 28 Jun 2022 10:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ukrpBoDPJ0oBIr06UEzmL8XIg3gYmULI7qvWNNzOPnk=;
        b=EKDpxpgMHWch7FgLhFkWQP2iUmSmBFhDBPZAYoPii4dsmkxu2IMutwE+aKG3gpqguM
         U8rsJ3PfkHTpBwpheKRGtd4wg4oAmI3rkQ5kBd4nvuvJ5VdqcV1xWR20r32/vgQhIOUt
         yX2IHF431Elal7083OvS0bWZlal6gNesGSNM/Rblh6fRgn6CaR9fwkqGeENisODcX3Aq
         2LmNK5+pm+XOM8dEMKb97hwiKbSPSY66GG2JQlEt6Tc5bs+uw5u+Zt+O778nNjzgbuFe
         BLheTC8H3QSvMTJ5yguScz/3Jme+wo5YJJ+zJHV6WUcMdxOyWNk5ra1OxtEgDDs9xnpk
         ygnA==
X-Gm-Message-State: AJIora8nwrzzxyEz1g+JcbBHaQzof9lCLgDZvpEFxGBIeusqNIs2HB+H
        l7EM4wCgDFCrSgxXjIZyRA==
X-Google-Smtp-Source: AGRyM1tZyPkRlhyS8RYwY4Xr/Wna4dV3W/rM1yEkibM9hWTSlUAKQxF5YD4hAYuStPD6le5KFrwRdA==
X-Received: by 2002:a05:6e02:1b86:b0:2da:bf51:1d47 with SMTP id h6-20020a056e021b8600b002dabf511d47mr161243ili.218.1656438699121;
        Tue, 28 Jun 2022 10:51:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h76-20020a6bb74f000000b00665754e45c2sm6919005iof.24.2022.06.28.10.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 10:51:38 -0700 (PDT)
Received: (nullmailer pid 695599 invoked by uid 1000);
        Tue, 28 Jun 2022 17:51:37 -0000
Date:   Tue, 28 Jun 2022 11:51:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Artur Rojek <contact@artur-rojek.eu>,
        Maxime Ripard <mripard@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] dt-bindings: input: Common property clean-ups and
 adc-keys conversion
Message-ID: <20220628175137.GA694214-robh@kernel.org>
References: <20220608211207.2058487-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608211207.2058487-1-robh@kernel.org>
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

On Wed, Jun 08, 2022 at 03:12:02PM -0600, Rob Herring wrote:
> This series refactors the common 'linux,code', 'linux,keycodes', and
> 'linux,input-type' properties defined in various binding schemas. As the
> properties are common, they should only have a single common schema type
> definition. Note that 'linux,input-value' was not included here as it is
> only used in 1 binding (gpio-keys).
> 
> The clean-ups are are result of the discussion on v1 of the adc-keys
> binding conversion[1].
> 
> Rob
> 
> [1] https://lore.kernel.org/all/20220606184243.1057145-1-robh@kernel.org/
> 
> 
> Rob Herring (5):
>   dt-bindings: input: Increase maximum keycode value to 0x2ff
>   dt-bindings: input: Centralize 'linux,code' definition
>   dt-bindings: input: Use common 'linux,keycodes' definition
>   dt-bindings: input: Centralize 'linux,input-type' definition
>   dt-bindings: input: Convert adc-keys to DT schema

Dmitry, Any comments on this?

Rob
