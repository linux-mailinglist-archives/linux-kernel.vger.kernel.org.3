Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDE5587898
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbiHBIBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236154AbiHBIA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:00:56 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09631DEE7
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:00:55 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id m9so14764796ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 01:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qp/fom4yzLGREQ6eeR8li3mYbaq2TiER/tBpXxkXygo=;
        b=TFKlaysWDIVNTrpIejCvdZ3ShsEZpGjK197WnOqTVDguDiHpHDaSiYtLkMZnv5nWVL
         Y4HNIrLz/rrChsreSuiWgemQ3g80PyFtDxrfZiE1E8sapn0v7ZIR5BzlDcJLmpMqqwT1
         wX++pYFLpakjvWeQhddWl3cAY9KW1symUlX6F6umXqO+4JZ3J8WmsgFz1JnpbIySrFgC
         DYlNBb8kW3xD+a/p7M+eAjUxNgc6Jhs/CzaA30VuYoKvl3k8wpnknxRdQjaIxDqRSMB2
         pAdELhDbrTvIN9g0syFGrU4L5TFeE8HeXYDIatMLL9ahGlsDrC5IHf6wi4UgNJP54G6P
         C2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qp/fom4yzLGREQ6eeR8li3mYbaq2TiER/tBpXxkXygo=;
        b=uEteHimkaA7qJcgNauquSkPiNlneItnWijHW7wZXTgy1togesroGjY0dvkx1gThAcc
         y4Lkkzsu0row3jMJdeetrY6x9Zzp5YFr+XDogJEAmRZCglnOdbAVNL2JOxIksfM/doct
         wuizqNE7Rf49v+NrWOZOpUZTJ+NtnEJH0WqmUSF1D0w2+HSDENXocqz9rbTZygLOuktq
         qX2FQ1xVf+m5Qch+AR+ASvxrAPq51iC+5oUEEG8KJreab4bmlDrAVQ1o4oRUH1Zj9Uf0
         vy3m8quipxTnotKDhM32FtqYNeqYQGYqBV5xA9jCM+IwpErH0ytpYwBTGt+jOlgWC/g7
         58Rw==
X-Gm-Message-State: AJIora/qJH5+iHo2HZ+zgd1OOVmv1SxBnfdC4UgMcFOY1MyCGiniWavz
        bvnLdVD2zxDpgPvW6LYdx7B6lQ==
X-Google-Smtp-Source: AGRyM1tLMTHtWy8rLH1qccJY+573kjD3/apdLT7hUWRIsx3cmqkIWPYfI8rcWCVwsyah4kPGJxNplg==
X-Received: by 2002:a2e:a812:0:b0:25d:d922:d with SMTP id l18-20020a2ea812000000b0025dd922000dmr5895793ljq.181.1659427253194;
        Tue, 02 Aug 2022 01:00:53 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id v2-20020a2e2f02000000b0025deba4d9f1sm1818669ljv.86.2022.08.02.01.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 01:00:52 -0700 (PDT)
Message-ID: <426b98b9-95a0-eb5e-7f68-fbe1e45b4740@linaro.org>
Date:   Tue, 2 Aug 2022 10:00:48 +0200
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
 <bd829586-f052-03c3-aa68-e5a2be84b6bb@linaro.org>
 <20220801160410.GA6059@wunner.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220801160410.GA6059@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2022 18:04, Lukas Wunner wrote:
> On Mon, Aug 01, 2022 at 05:45:07PM +0200, Krzysztof Kozlowski wrote:
>> On 31/07/2022 00:46, Lukas Wunner wrote:
>>> On Wed, Jul 27, 2022 at 06:46:36PM +0200, Krzysztof Kozlowski wrote:
>>>>  78 files changed, 324 insertions(+), 249 deletions(-)
>>>
>>> Pardon me for being dense, but what is the benefit of this series
>>> that justifies inflating the schema definitions by a total of 75 lines?
>>
>> The commits were explaining rationale, so let me bring it here. The
>> benefits are:
>> This allows using all properties typical for SPI-connected devices, even
>> these which device bindings author did not tried yet.
> 
> How do you know these untested properties work with the devices to which
> you're adding them?

These properties should be device independent and instead
controller-dependent. At least some of them (that's why CPHA/CPOL was
moved away and maybe the same we need to do with spi-3wire, spi-cs-high,
spi-lsb-first).

My approach here is no different than other subsystems. Take a look at
regulator - we allow all regulator.yaml properties, even though several
are not applicable (e.g. current for voltage regulators) and for sure no
tested.

Best regards,
Krzysztof
