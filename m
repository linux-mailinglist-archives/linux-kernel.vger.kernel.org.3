Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46D459CAEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbiHVVhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238145AbiHVVhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:37:13 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC74C52FEB;
        Mon, 22 Aug 2022 14:37:12 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso8609965otv.3;
        Mon, 22 Aug 2022 14:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KEpNtUC9l6wcpMRYvXgPLT6vlWgJnNmmrEjDcmWf5Jw=;
        b=Cb67W4y06KkMNC1JilWsaZIaFCF+y0TrgrWURUX7q3y+NiwRw2E5i/Fh/+mctYsC5d
         sPI5AYTMPmSQF993JHRaNGhxRB9W1qS8TCbUcaWzsmMePE7ymqCtuzK2zZUCsiIsQ7LK
         yMYGdoh1nJDjJ2X3oY2/FneUiRAgPvQ5l6uHbR0/tDh42+0c7lyVBSIdhu7BYThi4IC/
         KDJweMetLeyYeOXKvKPgVnbc2pCs94+nwVoDAtGx+tT3PXAnDI8HXko9LYsanx5q0qT+
         Ts9O0I3S02CaRkbQTAD372On1kCjAh3DS1kojMRxGdLV/nXDCwPBb2X66aWlaMvbTg4o
         9LgA==
X-Gm-Message-State: ACgBeo0WCoooecQ/3xmY6OefZ7LFKipVpZA9Lv/qcakwkFEuLiSaWR7D
        6rrCG5wXFnW1RPADnC3ImA==
X-Google-Smtp-Source: AA6agR5d4kOtbr6Cfx6n95VVMcZobOYTA0XwKtbRhPwEIJABIhfjNrrCrSOrwVeVhadGDzMD8Zzo5A==
X-Received: by 2002:a05:6830:660c:b0:61c:1c4f:3f56 with SMTP id cp12-20020a056830660c00b0061c1c4f3f56mr8340692otb.207.1661204232175;
        Mon, 22 Aug 2022 14:37:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q206-20020aca43d7000000b0033b31480f38sm2843385oia.34.2022.08.22.14.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:37:11 -0700 (PDT)
Received: (nullmailer pid 896426 invoked by uid 1000);
        Mon, 22 Aug 2022 21:37:10 -0000
Date:   Mon, 22 Aug 2022 16:37:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        p.meerwald@bct-electronic.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] dt-bindings: leds: pca963x: Add support for PCA962x
 chips
Message-ID: <20220822213710.GA896391-robh@kernel.org>
References: <20220822061838.8212-1-mike.looijmans@topic.nl>
 <20220822061838.8212-2-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822061838.8212-2-mike.looijmans@topic.nl>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 08:18:38 +0200, Mike Looijmans wrote:
> The PCA962x family shares the same I2C register layout and functionality.
> This adds support for the following chips:
> PCA9623 4-channel
> PCA9624 8-channel
> PCA9622 16-channel
> PCA9626 24-channel
> 
> Tested only the PCA9624. Other devices based on datasheet information.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
>  Documentation/devicetree/bindings/leds/leds-pca9532.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
