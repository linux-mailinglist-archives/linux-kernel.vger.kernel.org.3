Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFFF4F6A4E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiDFTtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiDFTso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:48:44 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B354330DF6;
        Wed,  6 Apr 2022 11:34:18 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-e2442907a1so3500733fac.8;
        Wed, 06 Apr 2022 11:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MwdIaQzbBkp+/5EU9BR9ve1JKS4NpPyKI/2bRfhgI3A=;
        b=BA8m8LakTUEyA/n2t/pwSuNOe50fI9ZHlTFc/+MQG6tPWAUtsodlSatWMIZ0/k/466
         zMkrXiNHyyOvhddBDyJoh7P4HdNe95zqZum/4mVdJHJQIXUSKDCf/hQgGSnC6b1fWxFk
         omCzl97nvWVgUTO3fLS6zyO4gTZxncwFKXgWWTuEAE+jbWlL3f2qOfA5t1jK04Hic8n2
         jrHJkvN002zIjK0OR4PykCuUaqlz8aJdfyUkkNCtXM4xAzTEBI73jev1S9+Nf8jG2IpN
         NuXFcdJKWPXPRNBqYNHQIa8pKdNpNi3GVSc9i9Ij0sORmsdpwWZHMhNzYJjozqGQQ1rV
         +QTQ==
X-Gm-Message-State: AOAM533IT4TRHPqkIrKN6dNm00B/Z+Lgc0FuFqC4W9gWk5Z5dvEBgVyq
        NBk0JXXIA03wrHKd2sGyqA==
X-Google-Smtp-Source: ABdhPJz091hVtxjPl1dTv65qEKLx42amDqNg+LIkiEhUs1vZjalw5jmdtXldZ84sUL4miSebhuT5bQ==
X-Received: by 2002:a05:6870:f144:b0:da:b3f:2b88 with SMTP id l4-20020a056870f14400b000da0b3f2b88mr4542392oac.295.1649270057566;
        Wed, 06 Apr 2022 11:34:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w1-20020a056808090100b002da82caced5sm6643535oih.3.2022.04.06.11.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:34:17 -0700 (PDT)
Received: (nullmailer pid 2552073 invoked by uid 1000);
        Wed, 06 Apr 2022 18:34:16 -0000
Date:   Wed, 6 Apr 2022 13:34:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, sre@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 3/8] dt-bindings: reset: atmel,at91sam9260-reset: add
 sama7g5 bindings
Message-ID: <Yk3dKExnPUglpiwb@robh.at.kernel.org>
References: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
 <20220405112724.2760905-4-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405112724.2760905-4-claudiu.beznea@microchip.com>
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

On Tue, 05 Apr 2022 14:27:19 +0300, Claudiu Beznea wrote:
> Add documentation for SAMA7G5 reset controller. Compared with previous
> versions of reset controllers this one contains support for resetting
> in SoC devices (e.g. USB PHYs).
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../reset/atmel,at91sam9260-reset.yaml        | 23 +++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
