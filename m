Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DEC56786A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiGEUaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiGEUaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:30:12 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BC51B78C;
        Tue,  5 Jul 2022 13:30:12 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id h5so8005667ili.3;
        Tue, 05 Jul 2022 13:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mtbdmlSxv4Cd125/TbfgcIJrtF3An7hCFaLz0pLZoWs=;
        b=OBEQGFP0r2HiEiR05+0zxGNBNC5yC+oh3zsyRoYkpYA6EMyVPc499lz+ahW16bKdF/
         H8UaAT5Ehnzu4LN6e8XIkC/n8m6BHD7XxAtQBjFbkUJSEDZxAojWzWzx2vch5wY+6VwW
         IkO0e7yojZkMp0zM0X4bEYkucx9N78h9nx9ExvvuHpDqfRgSlee46jqu9DX4VqjlETqx
         Moaf0ijpVrs7ljC1JU43QGm2PnbL2XxCmJhUsRMn3akgvIQ9i6rXVg6OhV87GLpOtkaH
         1gqVb1eu+vKJxp8nBX5BbN8Pk6jnheoAa8ETVOyZKkVQ3VrlFSZAd6x1bv9MOILx4dsV
         uwWw==
X-Gm-Message-State: AJIora8ZOQghdWFqETp9M5Osm912fcXMhQvlzEEPYXi1gfrUbREtJ8Se
        z8BA5DqnRmZ0rtHCpgRdPQ==
X-Google-Smtp-Source: AGRyM1vSWK3svILYFkwe79VCaH7I7KebPNrKoSiZdUGdvJ6Egzq/600Yzb17y2wogLo9jufFUm0cHg==
X-Received: by 2002:a92:6f0a:0:b0:2d9:24b5:9401 with SMTP id k10-20020a926f0a000000b002d924b59401mr20676113ilc.89.1657053011532;
        Tue, 05 Jul 2022 13:30:11 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y25-20020a027319000000b00339e42c3e2fsm15225003jab.80.2022.07.05.13.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:30:11 -0700 (PDT)
Received: (nullmailer pid 2572306 invoked by uid 1000);
        Tue, 05 Jul 2022 20:30:09 -0000
Date:   Tue, 5 Jul 2022 14:30:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-usb@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-sunxi@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] dt-bindings: usb: sunxi-musb: Add Allwinner D1
 compatible
Message-ID: <20220705203009.GA2572274-robh@kernel.org>
References: <20220702195249.54160-1-samuel@sholland.org>
 <20220702195249.54160-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702195249.54160-2-samuel@sholland.org>
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

On Sat, 02 Jul 2022 14:52:47 -0500, Samuel Holland wrote:
> The MUSB controller in the Allwinner D1 has 10 endpoints, making it
> compatible with the A33 variant of the hardware.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
