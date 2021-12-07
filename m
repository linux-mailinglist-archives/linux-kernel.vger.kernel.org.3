Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDF746C6A0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241789AbhLGVZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:25:19 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:35647 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhLGVZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:25:19 -0500
Received: by mail-oi1-f178.google.com with SMTP id m6so1069306oim.2;
        Tue, 07 Dec 2021 13:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YHFDCx8cz0OBlLogJ/xFHdL4cUOdiVDHhIchnRBaE9Q=;
        b=1dXjWW1AKqCe8DQsYUvw6oN8hdcwVhDeLKC2+Vt0aJScYAgHjenhn3lZC6MeVkKHZ1
         iyHcoAMPOh1wAgpwlvHaIrAL3SfPJQu77jlOInQwi4qpYaH3dWXFSv/AJzPjGbjd6nvw
         WmDbuMmCuCeLDHGOwqBYtmfy1ouojhXeF3irAaDMLID1YMBDqwoH8NAjqo/z5bHM5YCd
         UQO8NUZyOPqsDZ/pJiplcV6VTcQLqRYt8ZxuaaB6KkTXqE7jvq611kHSK3lv74UEMakq
         S4C9o2ATh0LHH1JAjMqJtIiy90IVHys81DJcGBeUHKpDCYT/rkkOqPrPklciqE9PmpPr
         6uUw==
X-Gm-Message-State: AOAM532G4q/vOsmQgBeY8OFtOm0p3vagIIko6gfmqR/NG9byMDMjYaQu
        37NCqFYQcDIVzIzU1Y60pQ==
X-Google-Smtp-Source: ABdhPJzA4YcDlmXoSGBF16wJC5CXRfHtRRFgKj56o15+uWhHftO8cS/FG3AQ4zcnAI4JBgHR1AfAXA==
X-Received: by 2002:aca:1115:: with SMTP id 21mr7495706oir.137.1638912108077;
        Tue, 07 Dec 2021 13:21:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w24sm133958ots.10.2021.12.07.13.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:21:47 -0800 (PST)
Received: (nullmailer pid 853594 invoked by uid 1000);
        Tue, 07 Dec 2021 21:21:46 -0000
Date:   Tue, 7 Dec 2021 15:21:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benoit Masson <yahoo@perenite.com>
Subject: Re: [RFC PATCH 2/9] dt-bindings: arm: amlogic: add X96-AIR bindings
Message-ID: <Ya/Qask7Fpb6mTxb@robh.at.kernel.org>
References: <20211130060523.19161-1-christianshewitt@gmail.com>
 <20211130060523.19161-3-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130060523.19161-3-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 06:05:16AM +0000, Christian Hewitt wrote:
> Add board bindings for the Amediatech X96-AIR STB which ships with
> model variants distiguished by Ethernet configuration: models using
> internal 10/100 PHY have a -100 suffix, while models using external
> Gigabit PHY have a -1000 suffix.

Isn't the phy described in DT? Why do you need to describe this 1 
difference at the top level?

> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
> index 36081734f720..e9ab0ffe8be7 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
> @@ -170,6 +170,8 @@ properties:
>        - description: Boards with the Amlogic Meson SM1 S905X3/D3/Y3 SoC
>          items:
>            - enum:
> +              - amediatech,x96-air-100
> +              - amediatech,x96-air-1000
>                - bananapi,bpi-m5
>                - hardkernel,odroid-c4
>                - hardkernel,odroid-hc4
> -- 
> 2.17.1
> 
> 
