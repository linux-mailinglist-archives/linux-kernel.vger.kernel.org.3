Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BEB55C3CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242298AbiF0WEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242899AbiF0WDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:03:31 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67694274;
        Mon, 27 Jun 2022 15:02:56 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id l24so11034099ion.13;
        Mon, 27 Jun 2022 15:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jdv65aYoH3wngx7Fdw7tsT2p4p1oistmuOoKV/y1rZU=;
        b=quXFNqQuw6O5NGHUgtByqF0r7wBU69Wq8LXLTGrX4a93cWBfloFq78gjVs6LhiZyt6
         eXULEi22mnb8SpFXFYaZcfvl4LuwNIQAZwBgypCrSqFC7BZSxK55PXBNTlNCjBnoUML0
         dDwqQd65iSp7dIdwxCq0pMtp1dgQynqlmSTJodLVz/PZQhidh2X3e56moJuQ/kspI6eg
         MzQ4sU64cundYlHTwFQ16TBZj2SmsxRkD9uerzsLkGYvgX3rpo6fppw+DC/mp21pDu3U
         LD73hMZYvlA/GkpjN/kXiNhCRnIWphiM9LAC71TR+5qYDnfK+EcbsHwFHsP4sWjkWzBe
         AgjA==
X-Gm-Message-State: AJIora8hB+vmZVzxwg25ruMPhVaRXaTBjx1GZgC2cqNYvuFD0ioydQOf
        NPkBhN8vlmv2Z/HsvoMrYw==
X-Google-Smtp-Source: AGRyM1sSDQYqJH4dsXWvmX5/Ry1DdbydVr5ZtoGq5S6BuADCTCcLi5R+m9kGUrb7nupJ9XoLcmy2kQ==
X-Received: by 2002:a05:6638:2110:b0:33b:b100:551e with SMTP id n16-20020a056638211000b0033bb100551emr9607569jaj.116.1656367375677;
        Mon, 27 Jun 2022 15:02:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z22-20020a027a56000000b00339ead526e5sm5290440jad.19.2022.06.27.15.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:02:55 -0700 (PDT)
Received: (nullmailer pid 3044113 invoked by uid 1000);
        Mon, 27 Jun 2022 22:02:53 -0000
Date:   Mon, 27 Jun 2022 16:02:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suniel Mahesh <sunil@amarulasolutions.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-amarula@amarulasolutions.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Christopher Vollo <chris@renewoutreach.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: sunxi: Add binding for
 RenewWorldOutReach R16-Vista-E board
Message-ID: <20220627220253.GA3044042-robh@kernel.org>
References: <20220615093900.344726-1-sunil@amarulasolutions.com>
 <20220615093900.344726-2-sunil@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615093900.344726-2-sunil@amarulasolutions.com>
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

On Wed, 15 Jun 2022 15:08:59 +0530, Suniel Mahesh wrote:
> Add a binding for the RenewWorldOutReach R16-Vista-E board based on
> allwinner R16.
> 
> Signed-off-by: Christopher Vollo <chris@renewoutreach.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>
> ---
> Changes for v2:
> - Add missing compatible string
> - insert missing signatures of contributors
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
