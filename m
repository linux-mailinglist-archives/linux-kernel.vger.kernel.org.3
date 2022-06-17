Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AD854F8B5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382623AbiFQN6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382604AbiFQN6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:58:38 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCD236E06;
        Fri, 17 Jun 2022 06:58:37 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id d123so4587258iof.10;
        Fri, 17 Jun 2022 06:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=vuzioXxWsL/LcXE/Jqc7Srz2yPLtSw7sPrasQK3imCE=;
        b=UrbAbQQqewa3ugHyygGUF81t1gS0So1VJ+L2kxtco84NxolnV0pk1OSyCaB3cap0bU
         N2ji5zf1DgsCAMAvuK9IzyVh6Zu2HoK/gJij88xPrdt6yMKPqtXoNxLMdv+UTcaAxT3J
         YDo6Kq050Cbs1eiCA8Mi9fslFjDlaqPOR2IzaG/h6MdOkyxMhAHbdNu/2rlaCG4eqAtp
         paAyLc31jHrq4gLI1tl6GSLmggqXVe2uHZqIZ3IUi2Y77n9r9JdQ+9fZMHpWonDUnaIh
         BAVPy1bY/AmHNQJJJ9ZshOkBFWMvUYTQ4NBjMDMX2MfmRxvWJfpD8HryP9kHceiD2bFi
         LN/w==
X-Gm-Message-State: AJIora+wi1EaIm2dIMXvs0kiONBut9aLXe8pcrNzoUfoflt0jC1mD3Cg
        AvoVuGQYhL+bODsbIDrvGw==
X-Google-Smtp-Source: AGRyM1vYq1BYKmRuq3VRfAghK7cb6KqmC2erUpwmgKbKRaDaFDu43hXLoJnn3kmyeL2LSr8JhE19lw==
X-Received: by 2002:a05:6638:5b0:b0:331:61eb:618a with SMTP id b16-20020a05663805b000b0033161eb618amr5695136jar.164.1655474316816;
        Fri, 17 Jun 2022 06:58:36 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id a12-20020a029f8c000000b00337de103c08sm356429jam.27.2022.06.17.06.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 06:58:36 -0700 (PDT)
Received: (nullmailer pid 1508990 invoked by uid 1000);
        Fri, 17 Jun 2022 13:58:32 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     Nicolas.Ferre@microchip.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Claudiu.Beznea@microchip.com, krzysztof.kozlowski@linaro.org,
        UNGLinuxDriver@microchip.com
In-Reply-To: <20220617130729.12072-2-kavyasree.kotagiri@microchip.com>
References: <20220617130729.12072-1-kavyasree.kotagiri@microchip.com> <20220617130729.12072-2-kavyasree.kotagiri@microchip.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: mfd: atmel,flexcom: Convert to json-schema
Date:   Fri, 17 Jun 2022 07:58:32 -0600
Message-Id: <1655474312.882258.1508989.nullmailer@robh.at.kernel.org>
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

On Fri, 17 Jun 2022 18:37:27 +0530, Kavyasree Kotagiri wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v3 -> v4:
>  - Corrected format of enum used for compatible string.
> 
> v2 -> v3:
>  - used enum for compatible string.
>  - changed irq flag to IRQ_TYPE_LEVEL_HIGH in example.
>  - fixed dtschema errors.
> 
> v1 -> v2:
>  - Fix title.
> 
>  .../bindings/mfd/atmel,flexcom.yaml           | 104 ++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 -----------
>  2 files changed, 104 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


flexcom@f0000000: spi@400:compatible:0: 'atmel,at91rm9200-spi' was expected
	arch/arm/boot/dts/at91-sam9x60ek.dtb

flexcom@f0000000: spi@400:compatible: ['microchip,sam9x60-spi', 'atmel,at91rm9200-spi'] is too long
	arch/arm/boot/dts/at91-sam9x60ek.dtb

