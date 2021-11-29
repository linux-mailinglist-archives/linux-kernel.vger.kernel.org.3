Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB29446233E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhK2V3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:29:39 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:35385 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhK2V1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:27:38 -0500
Received: by mail-oi1-f178.google.com with SMTP id m6so37164568oim.2;
        Mon, 29 Nov 2021 13:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8P42aAKBV8S4LvUKHyVzOqAuami2IMb7sD0ZrRnSWyo=;
        b=plnLtuD+N64VN5RlOuMIbDFvnWIZsum9L/nxhNCQJcfqKpiv91d30X3kx2uYoL6Gp9
         7Dxf8E4zbGNlFFvJQ8IIGocv/hhRdIB4JXymZPH08ZcDTd7uwdjpfi7wz9dSRuewGUfU
         Ud8w0bcVM9/JbrrDdyiJNEImwg/Zatq0xsmo4AmfZjS0KDoRBIxe/6KzSdF3jXpFBc7D
         m4u4dTSbPtuEANIiB5MadML9sKaC8XxPWQWN7J6gixMuRHnBkQwousYGq5nsgnF4iiH8
         EQp6gig/ug+JUj++4oEfYKu0916HG2QLQMAK+rzZfOoukhzjn1lkcZbZ5vIsH1xunO/b
         g03A==
X-Gm-Message-State: AOAM532nYmYVg85+/A5JlNvICGYUDV0TnAe6ci3dtsPbSB6RJWF2tQ8Q
        9Ae3bf6XVvEibfyZPkBR6Q==
X-Google-Smtp-Source: ABdhPJx0EJBI7GuYe1BD0nnxLGzq9XPUrMt4flTh1Z8UeMoK+aVbKJ1f47RPGw+VYxaBRSOgS+QNMg==
X-Received: by 2002:a05:6808:1a83:: with SMTP id bm3mr516246oib.173.1638221060008;
        Mon, 29 Nov 2021 13:24:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l6sm2822483otu.12.2021.11.29.13.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 13:24:19 -0800 (PST)
Received: (nullmailer pid 634858 invoked by uid 1000);
        Mon, 29 Nov 2021 21:24:18 -0000
Date:   Mon, 29 Nov 2021 15:24:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Hector Martin <marcan@marcan.st>,
        Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: Add Apple Watchdog
Message-ID: <YaVFApM9K0lAzUze@robh.at.kernel.org>
References: <20211113094732.73889-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211113094732.73889-1-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Nov 2021 10:47:31 +0100, Sven Peter wrote:
> Apple SoCs come with a simple embedded watchdog. This watchdog is also
> required in order to reset the SoC.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  .../bindings/watchdog/apple,wdt.yaml          | 52 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
