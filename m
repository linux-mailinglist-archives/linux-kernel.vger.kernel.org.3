Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361B6586E03
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiHAPpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbiHAPpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:45:17 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE49455BD
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:45:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id v7so5110432ljh.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0zyZ2hFRDCL/PAB+77dCIxgz+ZJjPhAukCUQAK9K37I=;
        b=NmBGuOwDmFWyAOTwqfb7d0MouyyUkpKz34kkXOGcVYw0WRLvLsRd4fzADyU365P/wJ
         4/kuB9jG8oBgZrBtB86EZlee2Yt8ZPCxja9c1dHOFQz2eCXJfGsfdSxHPW9jdazR1A99
         25LR9NouXBhS9+9ZbzDYMr7QxJlW/U+E96aX0ihqOp32X0ZnbLjk5f8MoUrW/RhkyuqC
         HF+M5aB7NuAUv2biIB0egFdMSiT5o6au74UTgfRpQ02KgJmUlHYvIp+arg/VNkCjd/Oi
         5woCRF4s/3oLhjdAdqLnJ+IRKxk1C2YZu1MVihCyHcCbBUIRxgiqNK5hZe+Bxt870hmG
         dhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0zyZ2hFRDCL/PAB+77dCIxgz+ZJjPhAukCUQAK9K37I=;
        b=VVvkyOoneZyQxVIKJjPeMeAC/xxAnoUUgHin7zwT5pPtP4D//qQvaHbU9Cd3xPmbJR
         gSmf+tGEba3A45nHVSdCAFmJiFVpzDwgA9d/ydCBDTUxmybkLgUS9+n8xe6iA3cbBBHk
         HZLsBKbdDwsr6GvahmmTgO9JmXk/SMY+MckW+u4NvrbDNFQDhhJEhesr+mI0MyVmRmaG
         sD5rj+ZxBEPZxch768zYm6DL3mq/ZEb9cZp3sOg6yWpvS+1JlveQQQeTB92karBBjQ2C
         3tzd5pE58UraF7F2zspZkhtFI9pu10TQMENof+faZyiGJ+sPdkuBK/bfz2s+QvlS/WE3
         Esaw==
X-Gm-Message-State: AJIora9bEe31adxX8QT4XU+6NhKYEBvjmowW1hxXxWuInaVGp9HCFe9i
        9maRDtMmwV+pgZW9ezhkzCNuAA==
X-Google-Smtp-Source: AGRyM1tioJLRexsAbEzPR5s9tl1SAoqjdAsmrvPwSvCHuyovgYJvBqfWj3511GuPNaK88Y3DupzQPQ==
X-Received: by 2002:a2e:8247:0:b0:25d:b515:92e with SMTP id j7-20020a2e8247000000b0025db515092emr5248224ljh.527.1659368713339;
        Mon, 01 Aug 2022 08:45:13 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id g7-20020a056512118700b0047dace7c7e5sm1769765lfr.212.2022.08.01.08.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 08:45:12 -0700 (PDT)
Message-ID: <bd829586-f052-03c3-aa68-e5a2be84b6bb@linaro.org>
Date:   Mon, 1 Aug 2022 17:45:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 00/10] dt-bindings: iio: use spi-peripheral-props.yaml
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>,
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
References: <20220727164646.387541-1-krzysztof.kozlowski@linaro.org>
 <20220730224643.GB11662@wunner.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220730224643.GB11662@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2022 00:46, Lukas Wunner wrote:
> On Wed, Jul 27, 2022 at 06:46:36PM +0200, Krzysztof Kozlowski wrote:
>>  78 files changed, 324 insertions(+), 249 deletions(-)
> 
> Pardon me for being dense, but what is the benefit of this series
> that justifies inflating the schema definitions by a total of 75 lines?

The commits were explaining rationale, so let me bring it here. The
benefits are:
This allows using all properties typical for SPI-connected devices, even
these which device bindings author did not tried yet.

Also, what I did not mention in commit msg, this makes sure, that
spi-xxx properties have a type, which is validated by
spi-peripheral-props.yaml. Otherwise, when someone puts bogus data as
spi-max-frequency (e.g. phandle) and checks only with that device
schema, no errors are reported.

Best regards,
Krzysztof
