Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5905624E6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbiF3VMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbiF3VMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:12:40 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229212127A;
        Thu, 30 Jun 2022 14:12:40 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id v185so394515ioe.11;
        Thu, 30 Jun 2022 14:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NU/AvFQx41MnlN2INgX2d2mKGjQ/GchZyPYaF7yuRhA=;
        b=mT6zq8QTXaOUOB9wBE3BngsvV82jSG+FW7dU90bH0EZUqGu0CoymiSuVbPTrIEVUad
         t/17L76RmRUBCx7V5FIX5NHkQFuvQ5UihF3Ej9XWE4CcLSc/zxpt6VVDrW0m2kDOhswZ
         MueFyJsH8GaVIXRKVkD5A+8+tJR3nPnYk3fRnmp/sHCpUthjJdbzQHAWCPGgBAKH9grn
         jehBspUoImHsntqO1W/7qXgLw5+6lmlLF7Q0EzHZT8UtysbqrLrMHSbLtzBVaPqyv9+j
         bE6svwh0pjWoQN9h/o8dR/3cmr1PXBAz71zQAst38ozycSZFU63liom/EMB2VxuEFhcl
         0+Fw==
X-Gm-Message-State: AJIora83wACW5k15YYM52MxeDubj64c9asj5/oujfd01vOSE5cY1bcCw
        +otW6/sokKSUNg6a6YnHJA==
X-Google-Smtp-Source: AGRyM1vUHpxJtmnIdMF6WAmLIKQFfm7Jk2VLKtR0y9ZsnjCfaDTN83tgI2HN2T4Q9CJZujIfMhz7Gw==
X-Received: by 2002:a05:6638:3802:b0:32e:3d9a:9817 with SMTP id i2-20020a056638380200b0032e3d9a9817mr6879427jav.206.1656623559373;
        Thu, 30 Jun 2022 14:12:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p26-20020a02b39a000000b0033c8ae0cc59sm6515478jan.143.2022.06.30.14.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:12:38 -0700 (PDT)
Received: (nullmailer pid 3307283 invoked by uid 1000);
        Thu, 30 Jun 2022 21:12:36 -0000
Date:   Thu, 30 Jun 2022 15:12:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     Sergiu.Moga@microchip.com, Claudiu.Beznea@microchip.com,
        linux-arm-kernel@lists.infradead.org, UNGLinuxDriver@microchip.com,
        linux-spi@vger.kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Nicolas.Ferre@microchip.com, Kavyasree.Kotagiri@microchip.com,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: convert spi_atmel to json-schema
Message-ID: <20220630211236.GA3303869-robh@kernel.org>
References: <20220629125804.137099-1-sergiu.moga@microchip.com>
 <1656542219.625404.1042476.nullmailer@robh.at.kernel.org>
 <8191d9e3-88e9-c8fb-2544-d25d3a93d0a8@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8191d9e3-88e9-c8fb-2544-d25d3a93d0a8@microchip.com>
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

On Wed, Jun 29, 2022 at 10:45:20PM +0000, Conor.Dooley@microchip.com wrote:
> On 29/06/2022 23:36, Rob Herring wrote:
> > On Wed, 29 Jun 2022 15:58:04 +0300, Sergiu Moga wrote:
> >> Convert SPI binding for Atmel/Microchip SoCs to Device Tree Schema
> >> format.
> >>
> >> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> >> ---
> >>  .../devicetree/bindings/spi/atmel,spi.yaml    | 82 +++++++++++++++++++
> >>  .../devicetree/bindings/spi/spi_atmel.txt     | 36 --------
> >>  2 files changed, 82 insertions(+), 36 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/spi/atmel,spi.yaml
> >>  delete mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt
> >>
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/spi/atmel,spi.example.dtb:0:0: /example-0/spi@fffcc000/mmc@0: failed to match any schema with compatible: ['mmc-spi-slot']
> 
> My conversion of this should be in -next right?

I don't know, you tell me.

> Is this just an incorrect base for the bot, or am I missing
> something?

The bot runs on rc1.

Rob
