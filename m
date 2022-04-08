Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6CC4F9E7D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbiDHVBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiDHVBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:01:46 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74152C38;
        Fri,  8 Apr 2022 13:59:41 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-d6ca46da48so10958249fac.12;
        Fri, 08 Apr 2022 13:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mgIV08Nzu1AulSexKN4gF1Bv7Djf0q021L8PdHI29+k=;
        b=0KDYXMJLORdgfiJ2GSIMXR3iq+8/3pEDfPegG5VGgNXMEQtLBpwkQ4gyrW9hRDxZtf
         BSzMK+ZFzex3faRoyjxnXO2/EgdtwSa0ujcZZDYz34ZpZ2IiNYrbTjQxk1xDUouoemMO
         FoxmISOqpid4ktfaR2xKOI1Yalm+2Ye4xaRyIwY3y/i6rhKO5Ok9cbQcU1IbsAgZ/K34
         E446v+D343LArxGbfV5KnHbubwsiLGJexAUo/+ZCIqZ2r2ImOImLOmh+VMsCGzT5zARK
         KWNtXjdp5/2ZAx8/6aPiaT4d/GSF9M9p5anOCiOsHI51lqY4cE81kGWLgEYzJI7cEv2t
         9G/Q==
X-Gm-Message-State: AOAM530+YgFTXTl33d8CAwKCaBOO/XyB7I1PjuEXM4NJvzWuFVXLXl/W
        E8waMYiKjoFKx7JZ5JKdHELruaPYMw==
X-Google-Smtp-Source: ABdhPJxHqBYnOljjlPwoSREFiVsVGDcfYviUYhyu+neONh6XlOy5IYfgmJpr6obbximEBUAHpbNLjw==
X-Received: by 2002:a05:6870:a1a8:b0:e2:182d:6375 with SMTP id a40-20020a056870a1a800b000e2182d6375mr9625671oaf.247.1649451580743;
        Fri, 08 Apr 2022 13:59:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x18-20020a056830245200b005ce01c28c77sm9417283otr.1.2022.04.08.13.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 13:59:40 -0700 (PDT)
Received: (nullmailer pid 4052959 invoked by uid 1000);
        Fri, 08 Apr 2022 20:59:39 -0000
Date:   Fri, 8 Apr 2022 15:59:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        phone-devel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Pavel Machek <pavel@ucw.cz>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: leds: convert ktd2692 bindings to
 yaml
Message-ID: <YlCiO3hfTtzJwq5H@robh.at.kernel.org>
References: <20220408184104.13665-1-markuss.broks@gmail.com>
 <20220408184104.13665-2-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408184104.13665-2-markuss.broks@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Apr 2022 21:40:54 +0300, Markuss Broks wrote:
> This patch converts the leds-ktd2692.txt bindings to modern yaml
> style device-tree bindings.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../bindings/leds/kinetic,ktd2692.yaml        | 87 +++++++++++++++++++
>  .../devicetree/bindings/leds/leds-ktd2692.txt | 50 -----------
>  2 files changed, 87 insertions(+), 50 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/kinetic,ktd2692.yaml
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-ktd2692.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
