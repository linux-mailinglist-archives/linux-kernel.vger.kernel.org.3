Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1933848BC64
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347699AbiALBYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:24:47 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:45613 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347700AbiALBYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:24:43 -0500
Received: by mail-ot1-f43.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso817826otf.12;
        Tue, 11 Jan 2022 17:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YJBsoGYj3kekFxTCKOq3P6jhOkyAT3RUfdBvwOQm/NM=;
        b=nzO5qRV83aTi3DlQL8NsZqjsMJtqeeYbWxDoiv3O9WwZZX45dk3NJRYnmyzP4Q808J
         dAw/MlsSWAZYlUNKuLjq1NP9T0QTmZ3JElBm2QwXSHtnzGrk2MyO/Vnmt2fMNZD1ES8O
         5mwhr6Uf5jH4jG7pMu+ZB8HSb/Ct3wOsrbPYgVa14SskX3muD9XzojrUg1eQCCyH/x+t
         cyaSwX10jfN7PNSAWoK5C8W1fvgqDBm5SmEV4xtgW/NGbx5ZRsWaiynmrKDPHUSvzxbO
         kAUMv/DB8co4aEZtyqo/EVGQnjZJ61AtbKzd8mrnAgFv1UovU9pmkhhYDfjYw5DkLDjB
         pxqw==
X-Gm-Message-State: AOAM5328+Gbfud119IbqGHJK2wn5poHG/hvn4b7sGzqFVikjTYyhf1IB
        MIxZ8boYdAge/hHWIddPag==
X-Google-Smtp-Source: ABdhPJywMDEaxecS3gMm1X07ghI/3wahJu50yHq+CDYbCQi7QYFQlXVxsPImThd2me+NvMTGBsVHsA==
X-Received: by 2002:a05:6830:3489:: with SMTP id c9mr5404979otu.206.1641950677839;
        Tue, 11 Jan 2022 17:24:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 188sm46550oop.25.2022.01.11.17.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:24:37 -0800 (PST)
Received: (nullmailer pid 3860698 invoked by uid 1000);
        Wed, 12 Jan 2022 01:24:36 -0000
Date:   Tue, 11 Jan 2022 19:24:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     conleylee@foxmail.com
Cc:     mripard@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sunxi.yaml: add HAOYU Electronics Marsboard A20
Message-ID: <Yd4t1NTa/ZEDsUyz@robh.at.kernel.org>
References: <YdS1GVkRopRSoD5S@robh.at.kernel.org>
 <20220105024551.807713-1-conleylee@foxmail.com>
 <tencent_9A79E4BC3715D4948E6D69363916D4B26D0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_9A79E4BC3715D4948E6D69363916D4B26D0A@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 10:45:51AM +0800, conleylee@foxmail.com wrote:
> From: conley <conleylee@foxmail.com>

Need a full name here and a commit message.

> 
> Signed-off-by: conley <conleylee@foxmail.com>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
> index 889128acf49a..4bd93ae26bd1 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -444,6 +444,11 @@ properties:
>            - const: haoyu,a10-marsboard
>            - const: allwinner,sun4i-a10
>  
> +      - description: HAOYU Electronics Marsboard A20
> +        items:
> +          - const: haoyu,a20-marsboard
> +          - const: allwinner,sun7i-a20
> +
>        - description: MapleBoard MP130
>          items:
>            - const: mapleboard,mp130
> -- 
> 2.31.1
> 
> 
