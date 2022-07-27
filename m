Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B79F582A23
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiG0QAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiG0QAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:00:49 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEA74A82A;
        Wed, 27 Jul 2022 09:00:48 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id 125so13866676iou.6;
        Wed, 27 Jul 2022 09:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uBsgoWPScdkjNHTUG+UX4gTQ/1ojeJRsC75QZ5pUW2M=;
        b=dQeSjiXtNJ+TC/1F2dxC/wG8brQRm6WmZvQT04giY1+WkVUf/C/59pCacRKwT/1f7v
         JHiessbZqaIJi3QdmLLqG9EkEhpp3GBAEobpP+/nMERRLuzq+DQxjLaM22jcLzR25MVV
         KGhbEfFRG9zZf4IdYg8r83BbnzFGZwsPQHhJbZPq4dyn2cqvTq+xuaU8dtcPSZvMa3ww
         MCw22f7LIj6rSVmFDCP7DZTM988xD6uSNWpYt7QOthGirG/soehOANYgWYUdFMNYnXrc
         NR6Q2qe3or6ZDLwHOXQlHE85EzPGnLAGzsYoz9woVjzkbSiZhlwkNmJt8WTVBszUKPoj
         ET8A==
X-Gm-Message-State: AJIora92tmzTquy25lYW8/+gLerxu/llAIAk2ToMrXCySAWwZlfFJDdl
        bwgGRxRDGrvsLF1uHzkGew==
X-Google-Smtp-Source: AGRyM1sD8B2rbELo9ocOtlLalIh62gFYeLVGS+WKt5OHRvdHFMThwl6MxVNUoXL9QBmLT7sf0+wjNw==
X-Received: by 2002:a6b:771a:0:b0:67b:d23e:277b with SMTP id n26-20020a6b771a000000b0067bd23e277bmr7818827iom.203.1658937647850;
        Wed, 27 Jul 2022 09:00:47 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b125-20020a021983000000b0033f027c2dbcsm7953186jab.156.2022.07.27.09.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:00:47 -0700 (PDT)
Received: (nullmailer pid 2754701 invoked by uid 1000);
        Wed, 27 Jul 2022 16:00:46 -0000
Date:   Wed, 27 Jul 2022 10:00:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] dt-bindings: timer: renesas,tmu: Add r8a779f0 support
Message-ID: <20220727160046.GA2754636-robh@kernel.org>
References: <20220726205858.1199-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726205858.1199-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 22:58:57 +0200, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/timer/renesas,tmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
