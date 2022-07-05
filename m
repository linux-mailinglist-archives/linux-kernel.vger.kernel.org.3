Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B5156786B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiGEUac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiGEUa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:30:28 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090BD1BEB5;
        Tue,  5 Jul 2022 13:30:28 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id n7so1678627ioo.7;
        Tue, 05 Jul 2022 13:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zWSAd7tRcv1q855NvXcXI64psDNg7skOpykCH1OmutE=;
        b=gyRSAEsq4zheY6brEabD7fs6zco2S2lqfjtTq0aaSiMwK3GQ6Ud4KV3L8fOOGC4z9H
         DA3Aup67owenvKze1VsY3G8k7kLyhhp/GGHv2wPxAr8U4krcVHu9t4HazacD50sR+q/c
         v0thCTK+BqDHbitfOzrilRK6w6+ipN9rp5N1apAu1YW25O8zJ7Kjy17/fP82hbTO5n/6
         zfsHTbBTJPbibDBkJBKqxFV/VIwRmFYxIzLUci9TZZnRHMv6FTerDtTYTdUSEnNskNMh
         i5r+UeQl1lY1wbYym/Xx7QJikaY7AsbpUDK0+DURuLD4pcMB1NMoprFNEfNwCtO+k2rA
         +vWw==
X-Gm-Message-State: AJIora/cL3c+0qd2UczidXv4RSBk5xuR4J9QnsfsHV83+xmfjL+QLYV4
        fKWI8Oqv+NiLBApCjuaZRLxxkIiRQg==
X-Google-Smtp-Source: AGRyM1svAuFAs6kMqiFi4DVAQ7UeGo4jlZ7/zUYgepb7MgPG+1/C+U9DNErJhhImMe3FgpJV+Rs2CA==
X-Received: by 2002:a05:6602:27c6:b0:657:7e7a:11f3 with SMTP id l6-20020a05660227c600b006577e7a11f3mr19807333ios.40.1657053027141;
        Tue, 05 Jul 2022 13:30:27 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c14-20020a056e020cce00b002dc2b20e9cfsm621858ilj.1.2022.07.05.13.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:30:26 -0700 (PDT)
Received: (nullmailer pid 2572821 invoked by uid 1000);
        Tue, 05 Jul 2022 20:30:25 -0000
Date:   Tue, 5 Jul 2022 14:30:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: usb: generic-ehci: Add Allwinner D1
 compatible
Message-ID: <20220705203025.GA2572770-robh@kernel.org>
References: <20220702195249.54160-1-samuel@sholland.org>
 <20220702195249.54160-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702195249.54160-3-samuel@sholland.org>
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

On Sat, 02 Jul 2022 14:52:48 -0500, Samuel Holland wrote:
> The Allwinner D1 contains USB controllers which claim to be compatible
> with the EHCI specification version 1.0.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
