Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F55B4F99BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbiDHPpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiDHPpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:45:30 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093D4939BD;
        Fri,  8 Apr 2022 08:43:27 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 12so9178024oix.12;
        Fri, 08 Apr 2022 08:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=IuCdWneO/2MVEgPWK3W9Br9orThPe68KZF9Rp7MYybo=;
        b=FetcGKvWrSjumtvzQr+KCSL8Bf5+5Tv2HBVJ1h2MKu4xw1FZBhQOFq6lEqioGum66i
         fRX8UGVhmMhtaYo6Mwqw4QhEfoQbXRNGtrWZkmIFxxSNJrYsG6fRA+iSvcQvyeI1OMQh
         cgIDK2qVu7+UwxqcgofBqhu9oNauA0nA04a3IP7xg4Dr917h9wdfYBab0hFRnntVrBxf
         NJWanKWt0xRT/IZ+owECZmWq6i5OHHZ6NaqrUwKn/V5Fh95hJXgPYzy7nvAO4FIWdolX
         ScI226Ql1wBoOZbfJ7DE4eJSvQrgySAaYhMGDb3xniQsYxIuXFIyYcvYBBt/PKSqc5pc
         hhsw==
X-Gm-Message-State: AOAM533rF0nCTXhnb1jY4XPhFgoSCoJqbnw/NHW/yxie8Y5atOvVFQcQ
        kO1An8pOgBCYx5taGkmOfA==
X-Google-Smtp-Source: ABdhPJzodqVef1yNcHldkh/KMqy7DXZg8yUbAPn4QcdjEFlMZE7nR7fKFCFOl/oFjoKqPwLdlQy+fg==
X-Received: by 2002:a05:6808:1592:b0:2f7:3095:b7fd with SMTP id t18-20020a056808159200b002f73095b7fdmr129321oiw.190.1649432606348;
        Fri, 08 Apr 2022 08:43:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x18-20020a056830245200b005ce01c28c77sm9125548otr.1.2022.04.08.08.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 08:43:26 -0700 (PDT)
Received: (nullmailer pid 3538557 invoked by uid 1000);
        Fri, 08 Apr 2022 15:43:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20220407154338.4190674-7-p.zabel@pengutronix.de>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de> <20220407154338.4190674-7-p.zabel@pengutronix.de>
Subject: Re: [PATCH 07/14] dt-bindings: reset: oxsemi,oxnas-reset: Convert to yaml
Date:   Fri, 08 Apr 2022 10:43:25 -0500
Message-Id: <1649432605.552479.3538556.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Apr 2022 17:43:31 +0200, Philipp Zabel wrote:
> Convert the device tree bindings for the Oxford Semiconductor OXNAS
> reset controllers to YAML schema to allow participating in DT
> validation.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/reset/oxnas,reset.txt | 32 -------------
>  .../bindings/reset/oxsemi,oxnas-reset.yaml    | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/oxnas,reset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/oxsemi,oxnas-reset.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/reset/oxsemi,oxnas-reset.example.dts:23.30-31.11: Warning (unit_address_format): /example-0/sys-ctrl@000000: unit name should not have leading 0s
Documentation/devicetree/bindings/reset/oxsemi,oxnas-reset.example.dtb:0:0: /example-0/sys-ctrl@000000: failed to match any schema with compatible: ['oxsemi,ox810se-sys-ctrl', 'syscon', 'simple-mfd']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

