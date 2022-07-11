Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925FA570DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 01:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiGKXGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 19:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiGKXGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:06:22 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC4A87354;
        Mon, 11 Jul 2022 16:06:15 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id z81so6401599iof.0;
        Mon, 11 Jul 2022 16:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lA3VV/WpusZOkVyB8IDWGHdkdcsPsUKR/xBEoxl1NBs=;
        b=q4Ly2YIxJeQQlxP/4RvkE4syzfxxuQK5+90+fZ2YMAQmlI1y7I3AXrhpMJvgYCESnD
         N3MJXJvB6dFBlnwjvYTTCCMCgUSjZBkBYsJcj0449HPOPEZhxQLMkFrTZ+dPwf+om9fp
         JHmkTHe9rEH1nMRvKhlO8whFqDq4C31a/bEOdNXlkn9XpASlEPFlHxX9kBTR3VMP3Uxg
         DHJj/Lexbu3k9bQpOBuZbdkZQCerL1VYXA4R6t4w3I/W8FeNntnH9CjclM1QlXZW8K++
         /TRX3D2YWrgMYFWmcdmX7yxEQdOOKUaXXLJz764cY9NUPwmvBwjWnKNUGO1QmUMgENfv
         iIXg==
X-Gm-Message-State: AJIora+bZOanF8i/X+k50/IWRqQ6vlbiCJ+8FTbMjkDcvkIVyytmg/Q9
        YOfT7oXegfHw9yBLvIZCYg==
X-Google-Smtp-Source: AGRyM1sQM927nejfjbcjCQ76dhLSfN/pXwwnLN6hKB6L8AasvHEbhuqFwPESIkqTQ+4MAHoDnQ9s0g==
X-Received: by 2002:a05:6638:349f:b0:33f:68a2:5eb5 with SMTP id t31-20020a056638349f00b0033f68a25eb5mr2019006jal.167.1657580774868;
        Mon, 11 Jul 2022 16:06:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a25-20020a027359000000b0033f3fcba96bsm3447203jae.100.2022.07.11.16.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 16:06:14 -0700 (PDT)
Received: (nullmailer pid 437817 invoked by uid 1000);
        Mon, 11 Jul 2022 23:06:13 -0000
Date:   Mon, 11 Jul 2022 17:06:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     robh+dt@kernel.org, Kavyasree.Kotagiri@microchip.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, UNGLinuxDriver@microchip.com,
        nicolas.ferre@microchip.com, devicetree@vger.kernel.org,
        claudiu.beznea@microchip.com
Subject: Re: [PATCH v8 2/3] dt-bindings: mfd: atmel,sama5d2-flexcom: Add new
 compatible string for lan966x
Message-ID: <20220711230613.GA437776-robh@kernel.org>
References: <20220708115619.254073-1-kavyasree.kotagiri@microchip.com>
 <20220708115619.254073-3-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708115619.254073-3-kavyasree.kotagiri@microchip.com>
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

On Fri, 08 Jul 2022 09:56:18 -0200, Kavyasree Kotagiri wrote:
> LAN966x SoC flexcoms has two optional I/O lines. Namely, CS0 and CS1
> in flexcom SPI mode. CTS and RTS in flexcom USART mode. These pins
> can be mapped to lan966x FLEXCOM_SHARED[0-20] pins and usage depends on
> functions being configured.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v7 -> v8:
>  - Changed compatible string to microchip,lan9668-flexcom.
> 
> v6 -> v7:
>  - Add #address-cells, #size-cells to flx3 example.
> 
> v5 -> v6:
>  - Removed spi node from flx3 example.
> 
> v4 -> v5:
>  - Fixed indentations and dt-schema errors.
>  - No errors seen with 'make dt_binding_check'.
> 
> v3 -> v4:
>  - Added else condition to allOf:if:then.
> 
> v2 -> v3:
>  - Add reg property of lan966x missed in v2.
> 
> v1 -> v2:
>  - Use allOf:if:then for lan966x dt properties
> 
>  .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 65 ++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
