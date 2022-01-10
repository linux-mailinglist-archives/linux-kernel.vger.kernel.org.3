Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E12489FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243366AbiAJTL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:11:59 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:39446 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbiAJTL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:11:58 -0500
Received: by mail-oi1-f171.google.com with SMTP id r62so13293942oie.6;
        Mon, 10 Jan 2022 11:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J0663NZkiKExBbXCVIPgWUhUN1N5hsII2EZmAwz75K8=;
        b=7L2nxcqG1HjEcez9ZzM35ZZl79Nd6mDI6RUXSSnEEhqafnR30Iry2h/AByb7Ny0GyO
         4RWoJlQvnbeY3bLUoieHxAzuZh8pLuw96jlW0G96oiE9q4dkCBm0Ht9vAdz0YWVJ9GE7
         q6vottXLWBSeemNANfUh+rNKuv5MVtC/sLSVBJNsFvK+3uNbI+E40pRnTYTUKr1kvaY7
         Keh0qRdg9WKwN6NmWJnOjSjyVenyS9uJ3S2zHOlZflaGnxre9mlxGYbOGcHgJFcU95Nj
         rSGhqGYKNuPrcknH9oJEkm/zL0BGYzH9n583y+NNKVOLz5nCM8hQU2oo+kU8wy4iXgRP
         vnBg==
X-Gm-Message-State: AOAM530bskcFGWo+xWb1IUHLXH7WXbDo5OdVuG3WOuXYPkvwDOxhSisy
        83OzfAmuVp/iXk3mcqtFgw==
X-Google-Smtp-Source: ABdhPJwFc8E5C8vx355pUBAwpRHNYnOAMOm14jdxUfd57Z/9xdMFrM6eW/gZ9BJLiiYtVV9gjq6fqw==
X-Received: by 2002:a05:6808:124d:: with SMTP id o13mr664513oiv.91.1641841917809;
        Mon, 10 Jan 2022 11:11:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t127sm1475472oot.3.2022.01.10.11.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 11:11:57 -0800 (PST)
Received: (nullmailer pid 1311476 invoked by uid 1000);
        Mon, 10 Jan 2022 19:11:56 -0000
Date:   Mon, 10 Jan 2022 13:11:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xiantao Hu <xt.hu@cqplus1.com>
Cc:     devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        qinjian@cqplus1.com, wim@linux-watchdog.org, wells.lu@sunplus.com,
        p.zabel@pengutronix.de, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v4 1/2] watchdog: Add Sunplus SP7021 WDT devicetree
 bindings documentation
Message-ID: <YdyE/ODxPwjg9UnR@robh.at.kernel.org>
References: <20211229054308.63168-1-xt.hu@cqplus1.com>
 <20211229054308.63168-2-xt.hu@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229054308.63168-2-xt.hu@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2021 13:43:07 +0800, Xiantao Hu wrote:
> This adds the documentation for the devicetree bindings of the Sunplus
> SP7021 watchdog driver, found from SP7021 SoCs and newer.
> 
> Signed-off-by: Xiantao Hu <xt.hu@cqplus1.com>
> ---
> Changes in v4
>  - Fix comments from Mr. Rob Herring
> 
>  .../bindings/watchdog/sunplus,sp7021-wdt.yaml | 47 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/sunplus,sp7021-wdt.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
