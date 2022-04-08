Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CBE4F9EE2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbiDHVJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239645AbiDHVJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:09:30 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E85165ABE;
        Fri,  8 Apr 2022 14:07:25 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id e189so10073424oia.8;
        Fri, 08 Apr 2022 14:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pYrMZV8IjCW8iYNoKDQBPlJEM2DsRfccLQtP6lTmZ+E=;
        b=RnNWOTvYDB6rKNZLc32W2dkm6O4YJt4caUr8tMNR1k1uANhCLuRpERkysK16grNfBE
         KqBnPjR0uBrfasFkRFsv9WyGzIKwCyVnXKRqe/E1VWaIdOG8IhO5kiQgNiGnJZc2Kdxd
         Anh6VocnlSULdHu5CGlXzcxggmF7uFs2daNNV+uTiXViT1IMoQrx/62WzPlgutr46xc6
         oaL8lAcB2kE3I15cufSbc7L6fR1RQgVWMLCRF+EzAhI4IcKz4PG6ELUY+dMtgg7bqZdb
         cATaZvqDZJ+WEAq55mYrtWmPY8OICNU9gWUrYXDvqLgfsf5FvV64FBrteWPTexRuUiPh
         o1fg==
X-Gm-Message-State: AOAM530vcIByHmFwhk8Yj/FoHxoK7mb3wsp+FxwqBbKExKSY27WQhFGx
        OrMyV75k+gsKWExiHOI5KQ==
X-Google-Smtp-Source: ABdhPJwWTpgR9nwArxEDDPxXD6GGCtIyRk9dQCxH/2JfmFaUUrC5PDmCLr6vKJ/kDuhQQXT9PXQRLw==
X-Received: by 2002:a05:6808:2189:b0:2da:b59:3acb with SMTP id be9-20020a056808218900b002da0b593acbmr824624oib.112.1649452044989;
        Fri, 08 Apr 2022 14:07:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 17-20020a056870121100b000e296227c9bsm793744oan.9.2022.04.08.14.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:07:24 -0700 (PDT)
Received: (nullmailer pid 4067486 invoked by uid 1000);
        Fri, 08 Apr 2022 21:07:24 -0000
Date:   Fri, 8 Apr 2022 16:07:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 05/14] dt-bindings: reset: lantiq,reset: Convert to yaml
Message-ID: <YlCkDJAUJx/w65HJ@robh.at.kernel.org>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
 <20220407154338.4190674-5-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407154338.4190674-5-p.zabel@pengutronix.de>
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

On Thu, 07 Apr 2022 17:43:29 +0200, Philipp Zabel wrote:
> Convert the device tree bindings for the Lantiq XWAY SoC RCU reset
> controller to YAML schema to allow participating in DT validation.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/reset/lantiq,reset.txt           | 30 ------------
>  .../bindings/reset/lantiq,reset.yaml          | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/lantiq,reset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/lantiq,reset.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
