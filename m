Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA73E59C848
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiHVTOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbiHVTNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:13:52 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB89463BE;
        Mon, 22 Aug 2022 12:13:51 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id u14so13375325oie.2;
        Mon, 22 Aug 2022 12:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=6JC0KO+m4DF5inifgly9A1gU2VAGJqBkCuiXunbHrP4=;
        b=xeARKiMwyYeEoB2fhIx1/vxry6PGIepzMuOO9YZ5Ynx4EpGKLxK1mMI1i/3e9bBdRd
         xVh3DlRTf4ieMSRlz8eaO9NvGL7yZI1a1nhqABTc92u1djHyW8Q4bVFsy1VeNWfIzcCi
         K0M8XLPfYo8eP7svxNRqP9iKHv+uwQlxPpnQcVy17f+6WYNRTRytcoHVREGh8BsLKGZG
         DUbnCC8NUCkuFih0i57pQBcrk9wXg/AJiHZYdM9ViMxAecFeI7uJxUDL+sSdtyy0q/48
         wmXEUwFbSsH6wHcvfnG04qO9Bn1vVm7Mz/IEJyobISahcANdZCgGM2VlFTbhGOVTMCCM
         tlYg==
X-Gm-Message-State: ACgBeo0XNvhkHelvXtfM/R0IE9ZUvPtXUEonYolC2djNllSuir2qHdu0
        ZKSTiXHxzcZisOPU1NkLoo3yKp81wQ==
X-Google-Smtp-Source: AA6agR4qKXupE/NYJSVAwoDdU9IOq7ThRHgQhkJLOoZ2PaV3qZe75eztGrD6oy7iPZMj9AHW3NOM+g==
X-Received: by 2002:a05:6808:152b:b0:343:ef9d:4729 with SMTP id u43-20020a056808152b00b00343ef9d4729mr11676577oiw.286.1661195631041;
        Mon, 22 Aug 2022 12:13:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i15-20020a54408f000000b00344851ea0ddsm2712089oii.56.2022.08.22.12.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:13:49 -0700 (PDT)
Received: (nullmailer pid 241296 invoked by uid 1000);
        Mon, 22 Aug 2022 19:13:48 -0000
Date:   Mon, 22 Aug 2022 14:13:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, Hari Nagalla <hnagalla@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: pinctrl: k3: Introduce pinmux
 definitions for J784s4
Message-ID: <20220822191348.GA241215-robh@kernel.org>
References: <20220819190054.31348-1-a-nandan@ti.com>
 <20220819190054.31348-3-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819190054.31348-3-a-nandan@ti.com>
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

On Sat, 20 Aug 2022 00:30:52 +0530, Apurva Nandan wrote:
> Add pinctrl macros for J784s4 SoC. These macro definitions are
> similar to that of J721s2, but adding new definitions to avoid
> any naming confusions in the soc dts files.
> 
> checkpatch insists the following error exists:
> ERROR: Macros with complex values should be enclosed in parentheses
> 
> However, we do not need parentheses enclosing the values for this
> macro as we do intend it to generate two separate values as has been
> done for other similar platforms.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  include/dt-bindings/pinctrl/k3.h | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
