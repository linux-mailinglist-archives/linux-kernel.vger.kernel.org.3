Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2059E578C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiGRUvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiGRUvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:51:08 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098BDBE25;
        Mon, 18 Jul 2022 13:51:08 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id y2so10296511ior.12;
        Mon, 18 Jul 2022 13:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qk1NnRPUrvfb6Ao0fhaKH3YbFOLfieQu41upb1j3S8o=;
        b=6Lkff+2CoktY9TSuZzamy+yVPq0woHyQAyVDdmEeweQFQ+Ji4SBOXLgjDmqImiQZPi
         I/uC2vjdz/CcuMjtWTn3ZVgcicZI0nSllYieG9jZtsd3euiZCzcECZHYMw1QEcqceV8D
         a8JrSxDvZGDZe2MbwoHNxJSCq9XMRghHQWyayMf1AiOevR3cbWNYilEMVXJYHwB1nVZ7
         l/8wcpiqLzWszbkxv25Abtnon4cfbVOr0pK4nL7X7yp1F2SAaGROvKvsLHA4DCBDvHRT
         w3GAKC1vwo5aFM99L8CcXDNPnnpTSAdYsD6luarJtvWT1S3xzL4Gyh406pppCPNjqMUo
         tU9A==
X-Gm-Message-State: AJIora+xgR/0jlwhO48NgC70imagWSeFE8tCOGii5GG/D6FKSCEHPfH9
        zIgh800kpJYXYcPcKQRCx7W6NyPomw==
X-Google-Smtp-Source: AGRyM1tYacKHsy1T7UN6k1R/w/vtNpZ05L+jLEjMFKYvHdsUZlkYrEnKHSB8fD7OMnniG/dIq1ZYnw==
X-Received: by 2002:a05:6602:1851:b0:67b:f627:90eb with SMTP id d17-20020a056602185100b0067bf62790ebmr5440375ioi.152.1658177467278;
        Mon, 18 Jul 2022 13:51:07 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p13-20020a02b00d000000b0033f258426c0sm5929775jah.108.2022.07.18.13.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:51:06 -0700 (PDT)
Received: (nullmailer pid 3529896 invoked by uid 1000);
        Mon, 18 Jul 2022 20:51:05 -0000
Date:   Mon, 18 Jul 2022 14:51:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: timer: renesas,cmt: R-Car V3U is R-Car
 Gen4
Message-ID: <20220718205105.GA3529863-robh@kernel.org>
References: <20220713100603.3391-1-wsa+renesas@sang-engineering.com>
 <20220713100603.3391-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713100603.3391-3-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 12:06:02 +0200, Wolfram Sang wrote:
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family. Hence move its compatible value to the R-Car Gen4 section.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/timer/renesas,cmt.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
