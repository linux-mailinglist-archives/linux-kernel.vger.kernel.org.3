Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC52462696
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhK2Wyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:54:46 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:44975 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbhK2Wxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:53:52 -0500
Received: by mail-ot1-f52.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso27599839otj.11;
        Mon, 29 Nov 2021 14:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qWL8hJC/A0AV1km5eJc7hYhQ5lsLfhkwDnG1R3lL5ts=;
        b=MAmAZojxJ0pcaQrhNionHW7A2jNefq6jhr5kFGz8YqGjp8vJuQXAhwopoNHwkMFvIq
         xPHyTAVM/YVzFZUmTj1uAvVQHtn/MIuyY+sX43Y1xS2lySagnLPZZ/q2VyidPaICWFF/
         VJNdyeivdpTnCRjhJuzYe2+RjKWdAb1AHL9dv5qTD7+uDPB3PZhoKSlLkmQu66GyvzyU
         Y/spQeVD2Wlc0nbEAas5EjVLDemdtiEdvzljmgKb4TCJE/6rjJ2LywB899yqoV+pkMQ7
         wzlKzhLMX5g/I1JnEvRBcQqJ8gqMjvyiryTSgVAPrFekwGJFomsemQXU9/uhmpNCmvZo
         j/Mw==
X-Gm-Message-State: AOAM530UOdQFEpMKOMibiwZBdXH3kChKFUNSh4q7UxtZfFMkAgHHity2
        Ih99SSqR1cFpc4iITeYZXWaZPJMQ+w==
X-Google-Smtp-Source: ABdhPJxzqxONDfPdEwnHa6GDEi1xkdkjaDaXuvyWIphExGSHtIKZoPxZeNKfoBdPp+P+6gnsXeEcnw==
X-Received: by 2002:a9d:6358:: with SMTP id y24mr48961705otk.369.1638226233869;
        Mon, 29 Nov 2021 14:50:33 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r26sm2865774otn.15.2021.11.29.14.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:50:33 -0800 (PST)
Received: (nullmailer pid 756915 invoked by uid 1000);
        Mon, 29 Nov 2021 22:50:32 -0000
Date:   Mon, 29 Nov 2021 16:50:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        iommu@lists.linux-foundation.org, Janne Grunau <j@jannau.net>
Subject: Re: [PATCH 1/4] dt-bindings: iommu: dart: add t6000 compatible
Message-ID: <YaVZOOUNuglM5TYy@robh.at.kernel.org>
References: <20211117211509.28066-1-sven@svenpeter.dev>
 <20211117211509.28066-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117211509.28066-2-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 22:15:06 +0100, Sven Peter wrote:
> The M1 Max/Pro SoCs come with a new DART variant that is incompatible with
> the previous one. Add a new compatible for those.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  Documentation/devicetree/bindings/iommu/apple,dart.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
