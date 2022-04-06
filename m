Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0CC4F6B42
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiDFUWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiDFUVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:21:18 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED535329CAC;
        Wed,  6 Apr 2022 11:33:47 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id t21so3275940oie.11;
        Wed, 06 Apr 2022 11:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sIlgTwiNbfwFFAy/yXeyQZoSzXEnPFRyql/iL5iCCtE=;
        b=EavmNT81m2zPk7pJS6EZPpHNfJlHPQ0kUzliAamOJ/6oVjU2AT9jnyz2im4jfY5447
         B6kp6qB/sWmRE42U/V0UTTWmYcqG2OueC+vYYLYvK/qYJpFjl4rd+dXemTjBuBVXpdIC
         N+3uMpQOxtjnYnkz68BEc5IOLUIn+4gnzxj1UVZ1zUk8Ii8OCQsMe9Ix3AMLXYxphlcu
         KeY5Izmx9OsaV/n19OSxUuuNIIgAFqwrLVo3vT5oSb/Sgb1qk1vQ9t9PmTDxwVV7E+VL
         8TjNtPJ6mO3NFaIMb8p9ZWm927juWoorK0XDxJL8hV/HQMrOzd3Hq9ES0AdY7iQlg6G3
         2qQA==
X-Gm-Message-State: AOAM533sAKnXSCTUPR/QEFMzR2HSMfdze9JPyCqVCY72nYDFHsDsvSTY
        Bn8/arOIhQ7NU80QentuGw==
X-Google-Smtp-Source: ABdhPJzoDiAm1Di4r6ZLELhVjZd9pldCOh/h5QYfD8dFKDaipx5siYm49mB3Emx2ZZfS+3iBhWYjsA==
X-Received: by 2002:aca:36c1:0:b0:2ec:cf67:b8ef with SMTP id d184-20020aca36c1000000b002eccf67b8efmr4103516oia.115.1649270027272;
        Wed, 06 Apr 2022 11:33:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b21-20020a9d7555000000b005b24c85da2csm6980665otl.51.2022.04.06.11.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:33:46 -0700 (PDT)
Received: (nullmailer pid 2551211 invoked by uid 1000);
        Wed, 06 Apr 2022 18:33:46 -0000
Date:   Wed, 6 Apr 2022 13:33:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        sre@kernel.org, p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com
Subject: Re: [PATCH 2/8] dt-bindings: reset: convert Atmel/Microchip reset
 controller to YAML
Message-ID: <Yk3dCu8ef9Scbklp@robh.at.kernel.org>
References: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
 <20220405112724.2760905-3-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405112724.2760905-3-claudiu.beznea@microchip.com>
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

On Tue, 05 Apr 2022 14:27:18 +0300, Claudiu Beznea wrote:
> Convert Atmel/Microchip reset controller to YAML.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../devicetree/bindings/arm/atmel-sysregs.txt | 15 ------
>  .../reset/atmel,at91sam9260-reset.yaml        | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
