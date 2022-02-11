Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707A64B2621
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350253AbiBKMpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:45:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345089AbiBKMpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:45:19 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C0CF6E;
        Fri, 11 Feb 2022 04:45:18 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso10139484oon.5;
        Fri, 11 Feb 2022 04:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1ZmE/JWwkWWP/1u0tD/CxpUFw+p6UWTWhaQ4GN/9I4g=;
        b=f/SlicSjSG8wt2ieEbC6gsaDqQEpAxrCopetb/afHefyuSBcRVvfNipjH3G/vWJOj/
         anPB3T0cf5KtOVIlNTUUrgwnXLdlY5ouCWTH7QTaMMH9JVI9Z2kNtTJGESDz7cuJOqsS
         WoccEgYNiWy08r8foeVNhoiebrwWlnN5vOlOX5WK6zXqvnEVqn4UIOpseKWVaIB4kacz
         H/OecSTZi4kkWjsudoTyr/LveeaubXD/vU4jyzoDXAb+c9Vq9EM+gz6x3JIVMNxVZ3/S
         8q33whMgAwNnOihgnIWrs4Qz06HYtt6xmeO0vPvitnYgjPgWjOfJ8S86+/juXB33Y4yn
         W0xA==
X-Gm-Message-State: AOAM533Wi3Tp4ZOwFtGlAW2+4+PIqjEKPuBpIHLKjweZMiI4AZjJVORp
        aD6oexd3v/onOrq55CqjsQ==
X-Google-Smtp-Source: ABdhPJxLLzBy4UD9XD8/7SJRsKiYhGphIJQmrnQkOk0M0IRZ8p8MucQvJeMkW5n7bTSiceZG6ayJ3g==
X-Received: by 2002:a05:6870:a701:: with SMTP id g1mr59208oam.96.1644583518219;
        Fri, 11 Feb 2022 04:45:18 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d4:10b7:69a2:33cd:1782:fb47])
        by smtp.gmail.com with ESMTPSA id t4sm9461269oie.14.2022.02.11.04.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 04:45:17 -0800 (PST)
Received: (nullmailer pid 192847 invoked by uid 1000);
        Fri, 11 Feb 2022 12:45:13 -0000
Date:   Fri, 11 Feb 2022 06:45:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/3] dt-bindings: nvmem: brcm,nvram: add NVMEM cell to
 example
Message-ID: <YgZaWfntxZ1gmYGf@robh.at.kernel.org>
References: <20220124160300.25131-1-zajec5@gmail.com>
 <20220124160300.25131-3-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220124160300.25131-3-zajec5@gmail.com>
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

On Mon, Jan 24, 2022 at 05:02:59PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> NVRAM doesn't have cells at hardcoded addresses. They are stored in
> internal struct (custom & dynamic format) . It's still important to
> define relevant cells in DT so NVMEM consumers can reference them.
> 
> One of cells set in almost every device is "et0macaddr" containing MAC
> address. Add it to example to show how it can be referenced.

"et0macaddr" is defined in the internal struct? Can you make this 
explicit in the the schema that's where the child node names come from. 
Perhaps go as far as documenting what some of the names are if they are 
common and not documented elsewhere.

> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> index 8c3f0cd22821..ab14e3ae45c8 100644
> --- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> @@ -32,6 +32,9 @@ unevaluatedProperties: false
>  examples:
>    - |
>      nvram@1eff0000 {
> -            compatible = "brcm,nvram";
> -            reg = <0x1eff0000 0x10000>;
> +        compatible = "brcm,nvram";
> +        reg = <0x1eff0000 0x10000>;
> +
> +        mac: et0macaddr {
> +        };
>      };
> -- 
> 2.31.1
> 
> 
