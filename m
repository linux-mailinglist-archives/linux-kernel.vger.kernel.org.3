Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1EF50EDE9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbiDZBDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbiDZBC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:02:59 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A2AD3AFE;
        Mon, 25 Apr 2022 17:59:52 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id e7-20020a4aaac7000000b00330e3ddfd4bso3109894oon.8;
        Mon, 25 Apr 2022 17:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BH7vmV60pq07t1GAA5YZvFkzgwzKmGX6FaF8nF3TCVY=;
        b=m5/o6J5bGRW/+SkrXKsB0dn0UnqKyMIjOfNQxqDP/AuSk6fAnsLd0KFspY1Lx/rtPU
         BCwa99OFzR5yCsTp3fyv/+S0kn879eFblyAhvJEJ1OGbWaJVS0hWggKQElSyCYeGIN2s
         XI8M1qEL+JNYQkmobl+N/oHcYhQVwpa1l1PFjbxP8gKy1QrVs0RvXQI/X/SzdlHZYg4Z
         4TeM4uFr1Y2LXTCrTK1ZxMI1PrmsHmKrVLDkoqLXFpVvIC4wfI9Mk4gQunjrBaNIcOV7
         Nk+O3BZxTlLqOw8crW/3QIqkY+EYT4OV5jmlAnVNVTGqLS1SxEsNpM3y0AHzX8CNQnJD
         ZrbA==
X-Gm-Message-State: AOAM533I52NLeNjC0bFs9P7PVtrYR//PSYzNbueTjjcdOQNNIbijShJ+
        eZOIpGSPCk6+YUfpIv66KA==
X-Google-Smtp-Source: ABdhPJzWGYxJLnYY0ELBcT5LlXMJyLGiZQ9E8DZQVDqDcgdXUUm8igxTVXHcPgf2xbRJaVFiyccqpg==
X-Received: by 2002:a4a:c294:0:b0:329:2fed:ad3f with SMTP id b20-20020a4ac294000000b003292fedad3fmr7311432ooq.4.1650934791766;
        Mon, 25 Apr 2022 17:59:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 30-20020a9d0ba1000000b005e95b29b95dsm4323883oth.5.2022.04.25.17.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 17:59:51 -0700 (PDT)
Received: (nullmailer pid 665368 invoked by uid 1000);
        Tue, 26 Apr 2022 00:59:50 -0000
Date:   Mon, 25 Apr 2022 19:59:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Sagi Grimberg <sagi@grimberg.me>, devicetree@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Jens Axboe <axboe@fb.com>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-nvme@lists.infradead.org, Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 2/6] dt-bindings: nvme: Add Apple ANS NVMe
Message-ID: <YmdEBvMtO0PIfxCo@robh.at.kernel.org>
References: <20220415142055.30873-1-sven@svenpeter.dev>
 <20220415142055.30873-3-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415142055.30873-3-sven@svenpeter.dev>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 16:20:51 +0200, Sven Peter wrote:
> Apple SoCs such as the M1 come with an embedded NVMe coprocessor called
> ANS2.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
> v1 -> v2:
>   - Moved to bindings/nvme (Krzysztof Kozlowski)
>   - Added power-domains and power-domain-names min/maxItems
>     (Krzysztof Kozlowski)
> 
>  .../bindings/nvme/apple,nvme-ans.yaml         | 111 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
