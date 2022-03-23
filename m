Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A846F4E57E8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343822AbiCWRzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343816AbiCWRzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:55:41 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E291B7FC;
        Wed, 23 Mar 2022 10:54:11 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id r8so2413539oib.5;
        Wed, 23 Mar 2022 10:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f60LFDjbAJWv9CVysPuREcwz6J+aCagFE8UqkVqcmgk=;
        b=dsZ4zI4k6dtFej10v+TI/KlFX+b3VGHM65HQCco1h+50o6XUcfgvyYoPO4KnwJKhws
         bwl4XnCcF6RPBIhsZF+rkbYmodkL1Ife2gjGJw6ZD+6s79zj5YilZTJ5qzwBjmF9ONYu
         rWtwC8YyaWg/QPL8sl3r7GSVowP0iRh/wQHZQ7HCioA5Vl7Q5POzb2d2ZTaO9S+LpQx6
         yGUsITTkmKbPWn4puoSDoXBxeQUJI0Ln1/xdKzUpAd7YvabpSXzH9J3shkYTXRZLTD1A
         VVcWWnirvi1/AnLmICYxZ2Wbp0nwQRQScw81K2Jps5QeMvpfPjWDUsXD20fbuLqlU5WD
         6LGQ==
X-Gm-Message-State: AOAM530qmdJ2ZuXioLBz0QDgWGEALhApq1gUf06NT/75drUl9MIEfD3x
        W0i/pdJaihrrIE+jvmz8+w==
X-Google-Smtp-Source: ABdhPJzigUdbgXJf2LVDBFHy1cfNLOZrkjkx0JqLhUAV+A4gntNmxSVXno8+yULDhGNE6h3ICcf3Dg==
X-Received: by 2002:a05:6808:171a:b0:2ef:87cf:1916 with SMTP id bc26-20020a056808171a00b002ef87cf1916mr634046oib.299.1648058050920;
        Wed, 23 Mar 2022 10:54:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p4-20020a056870a54400b000da07609a6dsm245974oal.22.2022.03.23.10.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 10:54:10 -0700 (PDT)
Received: (nullmailer pid 160979 invoked by uid 1000);
        Wed, 23 Mar 2022 17:54:09 -0000
Date:   Wed, 23 Mar 2022 12:54:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lars Povlsen <lars.povlsen@microchip.com>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC v1 1/2] dt-bindings: pinctrl: ocelot: add reset
 property
Message-ID: <YjtewWq71NqThh+K@robh.at.kernel.org>
References: <20220313154640.63813-1-michael@walle.cc>
 <20220313154640.63813-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313154640.63813-2-michael@walle.cc>
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

On Sun, 13 Mar 2022 16:46:39 +0100, Michael Walle wrote:
> On the LAN966x SoC the GPIO controller will be resetted together with
> the SGPIO and the switch core. Add a phandle to register the shared
> reset line.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml  | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
