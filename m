Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED30557AA59
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 01:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbiGSXQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 19:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiGSXQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 19:16:17 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB26F19C1A;
        Tue, 19 Jul 2022 16:16:16 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id l11so6367883ilf.11;
        Tue, 19 Jul 2022 16:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NZy5Mxd9v6PXdOMNJjgy5Kuyd8cAk8SIxn1n+efLe/4=;
        b=8H8H6efxH02RV4x/6NO/aJxoG77yxZqqXb5Hc/AS8EN/qn/cOHor3rBDm6Ny3X9GEu
         ZqcchMCcz955cZxggD3bdKi08RjGeFOyC+AULTVpfi9ViC2Xp+bhKO60B8nQNHihspPv
         /OOdeJAZSpK/K0tVSadiq/vXAwFhcLU1TMxCpfhNFjIhIwaePxsOAPrl9vBMDkvRs8H9
         zspjKY8VRbRfy9LXbRnxH7Ec4b3rHOL8GLcdCcbA5/pRDFNrcUaHTMm9PDblGYTBjGjQ
         q4aBkt9gwOlwe1C1OYsYYjTkT9HZ13K6/CoCG0Vd48eHrcom3+aQMkhXeHe84YCKoLBq
         xy4A==
X-Gm-Message-State: AJIora9MUHNJmu1ut9CoCLUC29B978lsYU4eWcF62e44ZsXg/svBkQ0L
        mbWZEgXe74R7PW05QeEIZLJ9OV9oXg==
X-Google-Smtp-Source: AGRyM1uLImnyCPhYRn7TN9cUraWzTLvOPvuq84/Wdo0MjUfhSySSc6AsMGoql3glP9UDrSSNzH59mg==
X-Received: by 2002:a05:6e02:8b0:b0:2dc:3e:5395 with SMTP id a16-20020a056e0208b000b002dc003e5395mr17801682ilt.11.1658272575938;
        Tue, 19 Jul 2022 16:16:15 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z61-20020a0293c3000000b0033f11276715sm7225248jah.132.2022.07.19.16.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 16:16:15 -0700 (PDT)
Received: (nullmailer pid 2015268 invoked by uid 1000);
        Tue, 19 Jul 2022 23:16:14 -0000
Date:   Tue, 19 Jul 2022 17:16:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     bjorn.andersson@linaro.org, marijn.suijten@somainline.org,
        robh+dt@kernel.org, pavel@ucw.cz,
        sven.schwermer@disruptive-technologies.com,
        johan+linaro@kernel.org, linux-leds@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: leds: Add binding for a multicolor
 group of LEDs
Message-ID: <20220719231614.GA2015215-robh@kernel.org>
References: <20220719191801.345773-1-jjhiblot@traphandler.com>
 <20220719191801.345773-4-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719191801.345773-4-jjhiblot@traphandler.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 21:18:00 +0200, Jean-Jacques Hiblot wrote:
> This allows to group multiple monochromatic LEDs into a multicolor
> LED, e.g. RGB LEDs.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  .../bindings/leds/leds-group-multicolor.yaml  | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
