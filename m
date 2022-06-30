Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D980561F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiF3P2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbiF3P2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:28:11 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785C36582;
        Thu, 30 Jun 2022 08:28:08 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id h85so19486183iof.4;
        Thu, 30 Jun 2022 08:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v3fCsU8QvmYK6uO1hQCv7+cOLqDCcdfggA8x53nv70M=;
        b=YeLYKjR6/9iZPpfsC5/1Qt/mazEHARmW/zpJjGywZDW8tVictELn6C3Q8jUUxyVlPG
         pa30e18Leyp7Lys1yJVZFcMCR3tQIcwkAQaq7SIcSuCxMuKqf1qDjdxdumiBw3AUcP/u
         BvWR/0CoWN6jhNxdVc8NhbDO4X+UuwE+rBTZSFTDqsu2Wdg3/IVxdnXnglJzt53va1LZ
         FJCF2uQWWO12ALadajMSWAqcoAaaBRUVJdT5hm+H1PdPh3HLHAtC0s3Hz+9lQWNBiQtd
         iZBv9dctU9WeAwfxy2Eir9+7JsBf3RRxI3fkrxFg6VAHQ2GNDLWKSaqZO9oXz0OLOGix
         gKDw==
X-Gm-Message-State: AJIora8hZPBJGWqd/v1s/vahyvX2kgHAI4lyehJdC7OESQKphDNYVIcm
        DOZKxd98wW5nZub25di0Xw==
X-Google-Smtp-Source: AGRyM1uiMa8Lbawmqk7m9RBiNYGmneqDL6HHs6q1fDNwTcu2C1YoflyIvtE/Nt4vca8Xd91yTDwTiw==
X-Received: by 2002:a6b:cd43:0:b0:675:b0bf:d999 with SMTP id d64-20020a6bcd43000000b00675b0bfd999mr1189535iog.193.1656602887765;
        Thu, 30 Jun 2022 08:28:07 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a13-20020a927f0d000000b002d8f50441absm8082320ild.10.2022.06.30.08.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 08:28:07 -0700 (PDT)
Received: (nullmailer pid 2744540 invoked by uid 1000);
        Thu, 30 Jun 2022 15:28:06 -0000
Date:   Thu, 30 Jun 2022 09:28:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Subject: Re: [PATCH v1 RESEND 1/7] dt-bindings: leds: Convert is31fl319x to
 dtschema
Message-ID: <20220630152806.GA2732671-robh@kernel.org>
References: <20220628182147.2837180-1-vincent.knecht@mailoo.org>
 <20220628182147.2837180-2-vincent.knecht@mailoo.org>
 <1656468579.884791.1403671.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656468579.884791.1403671.nullmailer@robh.at.kernel.org>
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

On Tue, Jun 28, 2022 at 08:09:39PM -0600, Rob Herring wrote:
> On Tue, 28 Jun 2022 20:21:39 +0200, Vincent Knecht wrote:
> > Convert leds-is31fl319x.txt to dtschema.
> > Set license to the one recommended by DT project.

Do you have permission to do so? The original .txt file is default GPL2 
and owned by H. Nikolaus Schaller. 

> > 
> > Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> > ---
> >  .../bindings/leds/issi,is31fl319x.yaml        | 113 ++++++++++++++++++
> >  .../bindings/leds/leds-is31fl319x.txt         |  61 ----------
> >  2 files changed, 113 insertions(+), 61 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/leds/leds-is31fl319x.txt
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml: patternProperties:^thermistor@:properties:adi,excitation-current-nanoamp: '$ref' should not be valid under {'const': '$ref'}
> 	hint: Standard unit suffix properties don't need a type $ref
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml: ignoring, error in schema: patternProperties: ^thermistor@: properties: adi,excitation-current-nanoamp
> Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.example.dtb:0:0: /example-0/spi/ltc2983@0: failed to match any schema with compatible: ['adi,ltc2983']

You can ignore this. The bot went amuck.

Rob
