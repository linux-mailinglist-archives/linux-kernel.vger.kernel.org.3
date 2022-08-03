Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAF1589418
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 23:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbiHCVkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 17:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiHCVkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:40:06 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BB340BE2;
        Wed,  3 Aug 2022 14:40:05 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id e69so13901457iof.5;
        Wed, 03 Aug 2022 14:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=PoAbO2TJzV0lAh1cQiBoTvQXqo+RgOhm6j9tuBM+bjI=;
        b=O40NjtNtw/dd9gbcbHz9QJsero9lCCmpjjlsgLNi46TQ9klvRBJPk4Qnbj6u0lOTVB
         UYZ6if6R+AyLyTVfYvzhdcHK5zjshLSlUYCql5CE+Zx1fDyRVfuWFQ4Getk7kvgfynYA
         DsSmQTO/Utfm/SyWRgoGlxjGV4BoXwd7GUr/NJsCsEo9zq7ZvqgKZ3xP4g3v8DUm/RWf
         1OV+NGs6jRYlhsNtVJZzow2hd4iTB6DD3mzJfHEHUdtGKnQhkiEDTrVlc9JuBlABH9nU
         OLvNqeXAQNPGV5oh7ozL776xAnZX7P0SKLlficJA3G8wuuR/5rsl0vtUg3H5t+qmZYui
         QH4g==
X-Gm-Message-State: ACgBeo3lMl5AAayu0tXVl9nGrEBbo/LQCP/C65YSjqw9M2sBFOqI257u
        l9EbwfiiTINJXdXPvURcKA==
X-Google-Smtp-Source: AA6agR74TqLpu6rXFlxDzpXKcwaDch4+hV9VRV/8owxn5cc8tUiYTeoIQKDKrn8CMLWJddeDtM0HWg==
X-Received: by 2002:a05:6602:154c:b0:67f:c11a:6d7c with SMTP id h12-20020a056602154c00b0067fc11a6d7cmr2511343iow.176.1659562805005;
        Wed, 03 Aug 2022 14:40:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m7-20020a92c527000000b002dc3df1b345sm7339451ili.88.2022.08.03.14.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:40:04 -0700 (PDT)
Received: (nullmailer pid 2667120 invoked by uid 1000);
        Wed, 03 Aug 2022 21:40:00 -0000
Date:   Wed, 3 Aug 2022 15:40:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
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
        Joachim Eastwood <manabian@gmail.com>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Patrick Vasseur <patrick.vasseur@c-s.fr>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Oskar Andero <oskar.andero@gmail.com>,
        =?UTF-8?Q?M=C3=A5rten_Lindahl?= <martenli@axis.com>,
        Bogdan Pricop <bogdan.pricop@emutex.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Dan Murphy <dmurphy@ti.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Phil Reid <preid@electromag.com.au>,
        Michael Welling <mwelling@ieee.org>,
        Robert Jones <rjones@gateworks.com>,
        Chris Coffey <cmc@babblebit.net>,
        Slawomir Stepien <sst@poczta.fm>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 00/10] dt-bindings: iio: use spi-peripheral-props.yaml
Message-ID: <20220803214000.GB2639296-robh@kernel.org>
References: <20220727164646.387541-1-krzysztof.kozlowski@linaro.org>
 <20220730224643.GB11662@wunner.de>
 <bd829586-f052-03c3-aa68-e5a2be84b6bb@linaro.org>
 <20220801160410.GA6059@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801160410.GA6059@wunner.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 06:04:10PM +0200, Lukas Wunner wrote:
> On Mon, Aug 01, 2022 at 05:45:07PM +0200, Krzysztof Kozlowski wrote:
> > On 31/07/2022 00:46, Lukas Wunner wrote:
> > > On Wed, Jul 27, 2022 at 06:46:36PM +0200, Krzysztof Kozlowski wrote:
> > >>  78 files changed, 324 insertions(+), 249 deletions(-)
> > > 
> > > Pardon me for being dense, but what is the benefit of this series
> > > that justifies inflating the schema definitions by a total of 75 lines?
> > 
> > The commits were explaining rationale, so let me bring it here. The
> > benefits are:
> > This allows using all properties typical for SPI-connected devices, even
> > these which device bindings author did not tried yet.
> 
> How do you know these untested properties work with the devices to which
> you're adding them?

How do we know anything DT works? We don't without testing on h/w. 
That's not what the schemas provide.

The spi-peripheral-props.yaml reference is needed in order to allow 
controller specific timing properties and to prevent random 
other undocumented properties from being present. There is not another 
way to do both of those.

Do I wish we didn't have these controller specific timing parameters, 
yes! But that ship has sailed.

Rob
