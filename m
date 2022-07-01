Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541705636F6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiGAPc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiGAPc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:32:28 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852AD3336E;
        Fri,  1 Jul 2022 08:32:27 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id p13so1663764ilq.0;
        Fri, 01 Jul 2022 08:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qcaQLVSAjs08L4iBTq66quSSrYfZtmetVnMPwSREdjs=;
        b=vJPnD1pIPYJ/3oFkz1YqxNpE2xbO3yrvTwoB2rLMU5DMCZmV3mF6BYS7RB4vHTuXFQ
         dneT/g18DWHHZUeXzwRtFVz/2mGjppsUtORtj2d0JCtLyTfqjpu5SH+ts5Q99tIjsLKI
         219DoNCMRbCtfL1o5+1MatXsNOtjw6LlJgQQOyOI86DwefGu91G7W95HBVcVIWVYyA7d
         UMeTaCzUirOQxTG3e1QCNHH23ahQYt4SMn0FxKFzMOeMb99rhx9FUXsIajh/6/UzbjHr
         Ua6io8YHL4Nw/rvpMRKF0xu752qFO2jASmMMOdz7xi+fp6gyUndaeS6PZqlSCdKSSUfx
         8luQ==
X-Gm-Message-State: AJIora8nXRZv8UB9S/tqjJgDOZZSl0E6Z7E+DbotTzszWY9yZjac1vU3
        ZvFwlFC32KZ0GyP/XE24CA==
X-Google-Smtp-Source: AGRyM1vLH7YULELjPbz07BEHH0lCB3QbkZccfzpFmFvHBn/Rf1cIyRKwM5psyF45vUu8tcchBneotA==
X-Received: by 2002:a05:6e02:1c89:b0:2da:9746:c0f3 with SMTP id w9-20020a056e021c8900b002da9746c0f3mr8701760ill.298.1656689546793;
        Fri, 01 Jul 2022 08:32:26 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o9-20020a056e02102900b002d40b591700sm9243107ilj.7.2022.07.01.08.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 08:32:26 -0700 (PDT)
Received: (nullmailer pid 986633 invoked by uid 1000);
        Fri, 01 Jul 2022 15:32:25 -0000
Date:   Fri, 1 Jul 2022 09:32:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, pavel@ucw.cz,
        krzk+dt@kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: leds: Add bindings for the TLC5925
 controller
Message-ID: <20220701153225.GA986576-robh@kernel.org>
References: <20220627083835.106676-1-jjhiblot@traphandler.com>
 <20220627083835.106676-2-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627083835.106676-2-jjhiblot@traphandler.com>
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

On Mon, 27 Jun 2022 10:38:33 +0200, Jean-Jacques Hiblot wrote:
> Add bindings documentation for the TLC5925 LED controller.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  .../devicetree/bindings/leds/ti,tlc5925.yaml  | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/ti,tlc5925.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
