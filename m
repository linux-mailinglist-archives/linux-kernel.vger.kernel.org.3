Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82ACF46F15E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbhLIRQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:16:30 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:39784 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbhLIRQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:16:28 -0500
Received: by mail-ot1-f48.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso6870609ots.6;
        Thu, 09 Dec 2021 09:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Bi3Hs0dz1zLMbmU20z1hBT7554DenEcOj+Mm3ASJ9o=;
        b=2LmhSlTHLx57M6P3Bchg8GVM74wbEmFz9zv9gf6/GCDgnc5f+vEfAoUGCHx/k4IZdg
         7y6MZpxEdPODinZUE4mlQ3YFNw8OkMTF3UuqyEaHk6dNUiGMafa9FZsdgP9LFOF1XiNS
         uuklLem0Ij/U4v2bD1V1ZIMpnIjXaQTEg3JFoi0bKAxcta0zp4+ilx4dkuCCgCOCpuo/
         ak3DYKCnkdQvebVtLfeVXx2BmgFPoz5nLCNuIDQAsNf5kLVoaBOs9N6V4ABzjqRjafv8
         w27wE9uaMrSSkmG7fKMfU4KcHyt1IM3onCNilK/Cma/AdVu7e+02zlV5a39Z+f0wSMcp
         342Q==
X-Gm-Message-State: AOAM5306UFiSzWD0wkodx27ehecs1U9VZG/Kr08/B8v/kAu/WDOkGOHG
        gVibxEV+NLB1lm7fP+cD4A==
X-Google-Smtp-Source: ABdhPJwOWbvOoLjUB66dcX6BdXi20kQtW84xHwSzlBDrIMbpmbcILSEgsrRy5KzEJICOytZ0YWU7Gg==
X-Received: by 2002:a05:6830:310f:: with SMTP id b15mr6391242ots.31.1639069974305;
        Thu, 09 Dec 2021 09:12:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j5sm67192oou.23.2021.12.09.09.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:12:53 -0800 (PST)
Received: (nullmailer pid 3101528 invoked by uid 1000);
        Thu, 09 Dec 2021 17:12:52 -0000
Date:   Thu, 9 Dec 2021 11:12:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH 1/4] dt-bindings: arm: apple: Add t6000/t6001 MacBook Pro
 14/16" compatibles
Message-ID: <YbI5FB3n2HHwTj3A@robh.at.kernel.org>
References: <20211209051001.70235-1-marcan@marcan.st>
 <20211209051001.70235-2-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209051001.70235-2-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Dec 2021 14:09:58 +0900, Hector Martin wrote:
> This adds the initial apple,t6000 platforms:
> 
> - apple,j314s - MacBook Pro (14-inch, M1 Pro, 2021)
> - apple,j316s - MacBook Pro (16-inch, M1 Pro, 2021)
> 
> And the initial apple,t6001 platforms:
> 
> - apple,j314c - MacBook Pro (14-inch, M1 Max, 2021)
> - apple,j316c - MacBook Pro (16-inch, M1 Max, 2021)
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../devicetree/bindings/arm/apple.yaml        | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
