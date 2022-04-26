Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872BF50EDE4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbiDZA7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiDZA7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:59:33 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BFF2A27E;
        Mon, 25 Apr 2022 17:56:27 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-e67799d278so14095016fac.11;
        Mon, 25 Apr 2022 17:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U/mTnYUQ6pZqCz9Eu3IYpCeJl6Jh6nhN/yx/cgzIAyc=;
        b=MANmK4hVLj0CnFuVC+B/8diz6ZvufpLozHdHuXKi4zshBMOlgImoF556yce28hNj4J
         x1Gwf87tT9U8xHkG8g9GY+eQAUSW79VNFAJBP/kNnBhdfpejYD3adL6qGM0mJ+UT/wEW
         6hoz5Ej/lu6Vscvo531/42/Z9dDcWi5CsgDZnX870heWiwu7C5aA0KAaUxBVHyFsuO9c
         /h5c5S0eiov8JzhljY/pvEwkYZMCYWTjj/nHXX7ghbHCsiQdDYiGs/HyBozctEliCLv2
         dJ60rUTDYeSrCWwzQj3KZUXp+hwdKvTdCZ45LADjpo74Ci3CIZAq4B4T8K4UeTYXZcgQ
         27HA==
X-Gm-Message-State: AOAM530oMDk25lwzpetdwZJuVV6Mgoy0eX/3NAsJ3FTeaog3Eg4rCbK1
        2bU3FeXxwZMrot9nCtAUQA==
X-Google-Smtp-Source: ABdhPJxyx3J68XofDMvRr2IMaFZEVqAi9bkYtA1l1FETzILj3JsvgXUd1OQnFJY5HJlTknU0eJHU+w==
X-Received: by 2002:a05:6870:15cf:b0:e2:6c7a:69fe with SMTP id k15-20020a05687015cf00b000e26c7a69femr8088818oad.257.1650934586697;
        Mon, 25 Apr 2022 17:56:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g8-20020a056830160800b0060548e5f69csm4344925otr.2.2022.04.25.17.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 17:56:26 -0700 (PDT)
Received: (nullmailer pid 659909 invoked by uid 1000);
        Tue, 26 Apr 2022 00:56:25 -0000
Date:   Mon, 25 Apr 2022 19:56:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/6] dt-bindings: iommu: Add Apple SART DMA address
 filter
Message-ID: <YmdDOeD31VZkMvv4@robh.at.kernel.org>
References: <20220415142055.30873-1-sven@svenpeter.dev>
 <20220415142055.30873-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415142055.30873-2-sven@svenpeter.dev>
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

On Fri, 15 Apr 2022 16:20:50 +0200, Sven Peter wrote:
> Apple SoCs such as the M1 come with a simple DMA address filter called
> SART. Unlike a real IOMMU no pagetables can be configured but instead
> DMA transactions can be allowed for up to 16 paddr regions. The consumer
> also needs special support since not all DMA allocations have to be
> added to this filter.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
> v1 -> v2:
>   - Moved to bindings/iommu since it is "Close enough to an IOMMU in
>     terms of its purpose" (Rob Herring)
> 
>  .../devicetree/bindings/iommu/apple,sart.yaml | 52 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/apple,sart.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
