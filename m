Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA9E57AA55
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 01:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbiGSXQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 19:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiGSXP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 19:15:59 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514B819C1A;
        Tue, 19 Jul 2022 16:15:58 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id l24so13069202ion.13;
        Tue, 19 Jul 2022 16:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x7zrOa5/ktmoB5oxXsEeidEAZIQuHoj85mXI/04gaag=;
        b=zgYeeZolex6Du4B1LS+ZdZeY3WrRT7yz96/K7eKsMu4csYnhCLm8Vb4lVZG4J1Fu0N
         J/AKYrPuLfrwfO8mX7ngiHmZ23M0c1RnHHUn0hpIpAxjqMfKws206EwYE5CaUrr2viKY
         8Y8P/nmgIqr9Kd0BXbUP4n3+FeQ02J2aN3E4c0d+J4SJTo95GW0WgJ297NDIkNdeNS12
         ljD16bRJZKKyY6czzzGxgg+NbqUYTEZ0t286543KBxAiSPNulWDUbEXvSWEWZVvkDybY
         cQkvD657Bz3S2fljInGS2cI/zoBeNFfJEq3tw3rU3BVhec47A335UCqwK0yozRrCbO27
         p2Vg==
X-Gm-Message-State: AJIora+mti50dkd5lEtN66veo/9Vgqz6jp3w+7SsWS0wSyOrxBu3A13T
        XWGonSb/WBmeJbpg1UQ1Lw==
X-Google-Smtp-Source: AGRyM1sKqEUwbdyTaYgehIaHgky8kBPT9go08h2ItbuBmzqTE4pl9HkOYuSs3jgORKoDhSftgu6XZQ==
X-Received: by 2002:a05:6638:25c7:b0:33f:27ae:22f8 with SMTP id u7-20020a05663825c700b0033f27ae22f8mr17940809jat.51.1658272557630;
        Tue, 19 Jul 2022 16:15:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p13-20020a02c80d000000b00339e2f0a9bfsm7164837jao.13.2022.07.19.16.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 16:15:57 -0700 (PDT)
Received: (nullmailer pid 2014837 invoked by uid 1000);
        Tue, 19 Jul 2022 23:15:55 -0000
Date:   Tue, 19 Jul 2022 17:15:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     marijn.suijten@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        sven.schwermer@disruptive-technologies.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz,
        andy.shevchenko@gmail.com, bjorn.andersson@linaro.org,
        johan+linaro@kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: leds: Add binding for a multicolor
 group of LEDs
Message-ID: <20220719231555.GA2005680-robh@kernel.org>
References: <20220719191801.345773-1-jjhiblot@traphandler.com>
 <20220719191801.345773-4-jjhiblot@traphandler.com>
 <1658265913.899205.1852593.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658265913.899205.1852593.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 03:25:13PM -0600, Rob Herring wrote:
> On Tue, 19 Jul 2022 21:18:00 +0200, Jean-Jacques Hiblot wrote:
> > This allows to group multiple monochromatic LEDs into a multicolor
> > LED, e.g. RGB LEDs.
> > 
> > Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> > ---
> >  .../bindings/leds/leds-group-multicolor.yaml  | 61 +++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/leds-group-multicolor.example.dtb: multi-led: Unevaluated properties are not allowed ('color', 'function' were unexpected)
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml

Looks like this is fixed by commit de40c8496ead ("dt-bindings: leds: 
class-multicolor: reference class directly in multi-led node") in next.

Rob
