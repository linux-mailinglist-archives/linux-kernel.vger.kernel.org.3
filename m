Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CB646F162
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbhLIRQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:16:50 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:43763 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhLIRQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:16:47 -0500
Received: by mail-oi1-f171.google.com with SMTP id o4so9556175oia.10;
        Thu, 09 Dec 2021 09:13:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dPTS9ZsVhU7ixNgjNcF+ROCU9JsSrkaqb7M5flHUNFg=;
        b=B2RbkLKUE0eEOj/xkQlCKxLzpHU0hCIS08zUgKji3CIOsTaSc6dOjpKVsHjevs62+6
         kgJXWsHzbTacGmtt+Wsusj0LonC6XmlVWKYrTFutpcnWvFykzKHZ5l5xTHq87e9qA5YO
         L3/bo8Fg18/MmUb8eiWkqLMV/itk9ig9TGFhe4GT4z65x86uzVR0m+dvaUr57AZ+IlaP
         KnsyE7/KGBvpvYOOOp7Cxa7kYbb9gL7KsFrSQK+VJ9KeqN/moj4DxVre17ycm2Xe6T2Z
         BEBelNS/I3k0FXS552QsBjuBWq2jdge3EdKCOkuquZozB+ZSqUONCMtT2MIP9zZhV/mQ
         52tQ==
X-Gm-Message-State: AOAM530fUJV1I+MruGHj2FDBaE4cucGcZldwwN31X266bxU0d2XPuJve
        bsTDo96qCSvBBxdlHQmiSw==
X-Google-Smtp-Source: ABdhPJwXCE8zZpMxt4dtVJIdspFWSGIwx37G1WJ1f3m7yhxlm3iJLd6PzhXO5EcW3/HXf/VUAKljUw==
X-Received: by 2002:a05:6808:3097:: with SMTP id bl23mr6934879oib.0.1639069993500;
        Thu, 09 Dec 2021 09:13:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w18sm78187otm.1.2021.12.09.09.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:13:12 -0800 (PST)
Received: (nullmailer pid 3103381 invoked by uid 1000);
        Thu, 09 Dec 2021 17:13:11 -0000
Date:   Thu, 9 Dec 2021 11:13:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH 2/4] dt-bindings: i2c: apple,i2c: Add apple,t6000-i2c
 compatible
Message-ID: <YbI5J8oTKeL1M9Sh@robh.at.kernel.org>
References: <20211209051001.70235-1-marcan@marcan.st>
 <20211209051001.70235-3-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209051001.70235-3-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Dec 2021 14:09:59 +0900, Hector Martin wrote:
> This block is compatible with t8103, so just add the new per-SoC
> compatible under apple,i2c.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  Documentation/devicetree/bindings/i2c/apple,i2c.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
