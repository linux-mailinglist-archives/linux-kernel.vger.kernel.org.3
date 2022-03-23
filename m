Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9004E58A6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343982AbiCWSqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237232AbiCWSqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:46:18 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE68389334;
        Wed, 23 Mar 2022 11:44:48 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id e4so2566681oif.2;
        Wed, 23 Mar 2022 11:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UhAIis1sOQRNVOvuZb/HadToEgbIlD8Ne2xz3MzwvhE=;
        b=NEAKzSX0iEzAPmmNk4ICjJXnTAJb5QmOQVOUST+dFHj2x6+vTaR+8eiu2eQgyVhcVz
         ksAVZC7tdzqZPwSVXBjaLp/BiWYt8KrqQVqrRpwb3mBpr1HU6Zp91wkO9TZe7N90Dpa2
         i3M8Zx5O0DVX6NzEwFtqSOUX6lpdJ5Xx6zUd/mo0M2MMSeeiCTfpz9294mbwTZyDCSI0
         ADiOm1PAwPk0erWW7Zw2wsq3F8G8SSCN+0Pr3ePqm6bazt5T2EA9OKqj1TgZr1FlgmMR
         p/4bnUV96ZV0UlxpnHeebt3+X6s3QesaV5PyVojlVA7eOT5FPiN/VwkoXFD/vYcjbbrE
         sPEw==
X-Gm-Message-State: AOAM532IDdI6BRigy9TyoX5dCNLcHpoxt6Qd8CP/Mw+4CYnFJIImMWAP
        Xwy46Zhn5Y7nfCi1PjyMcg==
X-Google-Smtp-Source: ABdhPJwgXCtwH1bJb5phSOJ/PNftPX3MRNt1PhAGu5iAKeTjH+CgiYzDdRdv3pDRcsD1OLWbbclljw==
X-Received: by 2002:aca:59d5:0:b0:2ef:2125:ec15 with SMTP id n204-20020aca59d5000000b002ef2125ec15mr864310oib.4.1648061088200;
        Wed, 23 Mar 2022 11:44:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r21-20020a05683002f500b005b249ffa43fsm350713ote.22.2022.03.23.11.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:44:47 -0700 (PDT)
Received: (nullmailer pid 237514 invoked by uid 1000);
        Wed, 23 Mar 2022 18:44:46 -0000
Date:   Wed, 23 Mar 2022 13:44:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Adrien Thierry <athierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gaston Gonzalez <gascoar@gmail.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: soc: bcm: bcm2835-vchiq: Add support
 for bcm2711
Message-ID: <YjtqnktIHajn8skP@robh.at.kernel.org>
References: <20220315200929.74952-1-athierry@redhat.com>
 <20220315200929.74952-2-athierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315200929.74952-2-athierry@redhat.com>
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

On Tue, Mar 15, 2022 at 04:09:28PM -0400, Adrien Thierry wrote:
> Add a new compatible string for BCM2711. This is the chip used on the
> Raspberry Pi 4.
> 
> Signed-off-by: Adrien Thierry <athierry@redhat.com>
> ---
>  .../devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml     | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
> index e04439b3355b..599bd283df1b 100644
> --- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
> @@ -27,6 +27,12 @@ properties:
>                - brcm,bcm2836-vchiq
>            - const: brcm,bcm2835-vchiq
>  
> +      - description: BCM2711 based boards
> +        items:
> +          - enum:
> +              - brcm,bcm2711-vchiq
> +          - const: brcm,bcm2711-vchiq

Why do you have the same compatible twice?

> +
>    reg:
>      description: Physical base address and length of the doorbell register pair
>      minItems: 1
> -- 
> 2.35.1
> 
> 
