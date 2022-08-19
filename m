Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB63459A563
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349865AbiHSSb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 14:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349745AbiHSSb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:31:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6336C88AD;
        Fri, 19 Aug 2022 11:31:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 613F760ED3;
        Fri, 19 Aug 2022 18:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ABDC433C1;
        Fri, 19 Aug 2022 18:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660933883;
        bh=QuVIEsO5UmTSs0WAutUfIo3fcQXR0O4vobQR36XYVSg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cSjeOqirADj4Mc3kI1ZuL8qZNGqPPgBJn9hY2YHPn3SQ1tTyxfIJNOdnsJsL/o5k/
         Ua/O/sYZA5BSSACK4VYQnbdsrlVlJJvxXxZ8XSlTHSMNdSxueO5WoPN174PHR//gta
         w3h1uVu45NCg0OMgIGLRaQcfI3XNRABlXxFaH1xehc/X7R9oj5b+n5q9HmX6ogPDgi
         3zP60Z9aFLZICznzQrSfjkRd++M7wE8qhYd0RVvLPUkycIXDOB4vGU9vHYX1MpqJ87
         Y/eUIERAJrU09SDuUX2pkBL4pa5ClmKufZeiVTDs1LSKzPMIgWeOmu2ML+0zYmHOqJ
         9eiva/pJe+7sA==
Date:   Fri, 19 Aug 2022 19:41:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Patrick Vasseur <patrick.vasseur@c-s.fr>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Oskar Andero <oskar.andero@gmail.com>,
        =?UTF-8?B?TcOlcnRlbg==?= Lindahl <martenli@axis.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Andrew Davis <afd@ti.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Phil Reid <preid@electromag.com.au>,
        Michael Welling <mwelling@ieee.org>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Coffey <cmc@babblebit.net>,
        Slawomir Stepien <sst@poczta.fm>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 00/10] dt-bindings: iio: use
 spi-peripheral-props.yaml
Message-ID: <20220819194150.23f47751@jic23-huawei>
In-Reply-To: <20220818145248.GD1829017-robh@kernel.org>
References: <20220816124321.67817-1-krzysztof.kozlowski@linaro.org>
        <20220818145248.GD1829017-robh@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 08:52:48 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, Aug 16, 2022 at 03:43:11PM +0300, Krzysztof Kozlowski wrote:
> > Hi,
> > 
> > The patchset is independent of my other recent changes around SPI, so feel free
> > to apply it for next release.
> > 
> > Changes since v2
> > ================
> > 1. Keep spi-3wire also in device bindings (not in spi-peripheral-props.yaml).
> > 2. Add Rb tag.
> > 
> > Changes since v1
> > ================
> > 1. Continue the rework for entire IIO.
> > v1: https://lore.kernel.org/all/20220715095302.214276-1-krzysztof.kozlowski@linaro.org/
> > 
> > Best regards,
> > Krzysztof
> > 
> > Krzysztof Kozlowski (10):
> >   dt-bindings: iio: adc: use spi-peripheral-props.yaml
> >   dt-bindings: iio: accel: use spi-peripheral-props.yaml
> >   dt-bindings: iio: amplifiers: adi,ada4250: use
> >     spi-peripheral-props.yaml
> >   dt-bindings: iio: dac: use spi-peripheral-props.yaml
> >   dt-bindings: iio: frequency: adf4371: use spi-peripheral-props.yaml
> >   dt-bindings: iio: health: ti,afe4403: use spi-peripheral-props.yaml
> >   dt-bindings: iio: imu: use spi-peripheral-props.yaml
> >   dt-bindings: iio: potentiometer: use spi-peripheral-props.yaml
> >   dt-bindings: iio: samsung,sensorhub-rinato: use
> >     spi-peripheral-props.yaml
> >   dt-bindings: iio: temperature: use spi-peripheral-props.yaml  
> 
> For the series,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Series applied to the togreg branch of iio.git and pushed out as testing

Thanks,

Jonathan

