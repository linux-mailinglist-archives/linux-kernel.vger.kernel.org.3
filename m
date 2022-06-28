Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6254055F03F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiF1VRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiF1VQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:16:42 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560B131DC9;
        Tue, 28 Jun 2022 14:16:41 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id u20so14148917iob.8;
        Tue, 28 Jun 2022 14:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6HD4W3yTR1trUTVfpbXVBov8MqgZQbqZwaTmCO/6Gyw=;
        b=wLQHGsJXtlXwccwRQI1SR8mxxNazVK4as61a4owhedlUn+LJ6pMsR5Mg0Lp2NlTd+w
         sVuqSjJZu18ErllNqcWLDxW6cFztPEynCnZ1j4zprmObGjWTUXS1nuKYAohvobfVtoXw
         RgNptIy35N8lPjhN12Bbqyc3utB1npe38gczc0flvEVD50m2DD/GxGdmrZthk7VmvfOe
         lQsq4vlD7b/t/Sjtx07RMf4VyOsIFwd9vX4CcXHuVW+ArUimiRFM9jmUn5CuRQVT9tT/
         zR0ZnzJ6XT/LR9aLpTwY/Bkn1tVTcw0WlDyvlzDbg1IpAF4dft0TNSzyt4yYjCZ+Tfeb
         Um5w==
X-Gm-Message-State: AJIora8V2EZiQO0zaNzCvLR81l8XTYRo8Y+14SK1x1C8VraGas8T+rVC
        WtbRTYDEsG/1l50ax6eLmA==
X-Google-Smtp-Source: AGRyM1tAN+UKhd4ZNCy6ruF8nKrB14lOgEXw1PfT0QscrNfgDtA9XVc6TRWrOdw7ywOiRCTazGW4fA==
X-Received: by 2002:a05:6638:218f:b0:33c:caf0:a61c with SMTP id s15-20020a056638218f00b0033ccaf0a61cmr67781jaj.198.1656451000493;
        Tue, 28 Jun 2022 14:16:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q4-20020a056e020c2400b002d95c4d56d3sm6141440ilg.76.2022.06.28.14.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 14:16:40 -0700 (PDT)
Received: (nullmailer pid 990409 invoked by uid 1000);
        Tue, 28 Jun 2022 21:16:38 -0000
Date:   Tue, 28 Jun 2022 15:16:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kavyasree.Kotagiri@microchip.com
Cc:     Nicolas.Ferre@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Claudiu.Beznea@microchip.com,
        krzysztof.kozlowski@linaro.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v4 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Message-ID: <20220628211638.GC963202-robh@kernel.org>
References: <20220617130729.12072-1-kavyasree.kotagiri@microchip.com>
 <20220617130729.12072-2-kavyasree.kotagiri@microchip.com>
 <1655474312.882258.1508989.nullmailer@robh.at.kernel.org>
 <CO1PR11MB48653378BAECD414F497D59592B09@CO1PR11MB4865.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB48653378BAECD414F497D59592B09@CO1PR11MB4865.namprd11.prod.outlook.com>
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

On Mon, Jun 20, 2022 at 11:45:31AM +0000, Kavyasree.Kotagiri@microchip.com wrote:
> > > Convert the Atmel flexcom device tree bindings to json schema.
> > >
> > > Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> > > ---
> > > v3 -> v4:
> > >  - Corrected format of enum used for compatible string.
> > >
> > > v2 -> v3:
> > >  - used enum for compatible string.
> > >  - changed irq flag to IRQ_TYPE_LEVEL_HIGH in example.
> > >  - fixed dtschema errors.
> > >
> > > v1 -> v2:
> > >  - Fix title.
> > >
> > >  .../bindings/mfd/atmel,flexcom.yaml           | 104 ++++++++++++++++++
> > >  .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 -----------
> > >  2 files changed, 104 insertions(+), 63 deletions(-)
> > >  create mode 100644
> > Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-
> > flexcom.txt
> > >
> > 
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> > 
> > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > This will change in the future.
> > 
> > Full log is available here: https://patchwork.ozlabs.org/patch/
> > 
> > 
> > flexcom@f0000000: spi@400:compatible:0: 'atmel,at91rm9200-spi' was
> > expected
> >         arch/arm/boot/dts/at91-sam9x60ek.dtb
> > 
> > flexcom@f0000000: spi@400:compatible: ['microchip,sam9x60-spi',
> > 'atmel,at91rm9200-spi'] is too long
> >         arch/arm/boot/dts/at91-sam9x60ek.dtb
> 
> These errors are expected because "microchip,sam9x60-spi" and "atmel,at91rm9200-spi"
> are documented in Documentation/devicetree/bindings/spi/spi_atmel.txt.
> which I added in description as
> " description: See ../spi/spi_atmel.txt for details of SPI bindings."

If that was still true, there would not be a warning because .txt files 
don't cause warnings. You've defined the SPI compatible here and that 
doesn't agree with the dts files. One of them is wrong.

Normally, child nodes either just reference another schema or document 
everything locally. You've done a mixture which is not right. Presumably 
that was to avoid 'undocumented compatible' warnings. To fix that you 
either need to convert the SPI binding or don't use it in the example.

Rob
