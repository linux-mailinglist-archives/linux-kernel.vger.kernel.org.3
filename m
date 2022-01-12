Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F0148BCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348066AbiALB6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:58:45 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:36757 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346397AbiALB6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:58:44 -0500
Received: by mail-oi1-f181.google.com with SMTP id r138so1564850oie.3;
        Tue, 11 Jan 2022 17:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QiBvIiOGnQbPLLO74MUCf7VtqI9zuABcfRwv5FnEOog=;
        b=X1arPjKivDias7qz9ViGbVuiO3BzYv0/Ux/B+Eas+MHdWJJkGqW1H793Lkputdj4Wi
         Ppkuiwgh6wveaoK3Yfqj9MBEKIpxuqLRY+GEvQzod3/uMjOVghVdizOY52pkgeNqNMy6
         Rsk0SfPG3oEe177otHfuvk33WUrHj2sNUCN9+CBXV4pt7ILcJBwuRC/65ywFWZO3yQry
         T7XLNnUzYx+sCOu2SnnolC0n+Lvs6UdpywGnLAezcwir26Qld/mN4jA0BReuKk8PqCrO
         ZQmhOsXfALkcrjGMhQBlB5WSE1HVlUqjlT1VSo5L2GIqEAgii56Bm3GCmGF3gna6D7WC
         jc1A==
X-Gm-Message-State: AOAM530vliFHZJFekHRo6WeYZTt8D8JIsPXguxTivqofOH4RT679kx3c
        zLNiKXNGsMrsOaeVuxIUeA==
X-Google-Smtp-Source: ABdhPJyR5jHQ9khvDQSLdyXjDuxF95nxq+SC47jVCaQyQQP7mxU834P9q8u0DA0BfrR2IPkwzJR7og==
X-Received: by 2002:a05:6808:8d:: with SMTP id s13mr3800219oic.178.1641952724038;
        Tue, 11 Jan 2022 17:58:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a6sm2010540oil.6.2022.01.11.17.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:58:43 -0800 (PST)
Received: (nullmailer pid 3911029 invoked by uid 1000);
        Wed, 12 Jan 2022 01:58:42 -0000
Date:   Tue, 11 Jan 2022 19:58:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Lucas Stach <dev@lynxeye.de>
Subject: Re: [PATCH v1 13/14] dt-bindings: arm: fsl: add
 toradex,verdin-imx8mm et al.
Message-ID: <Yd410mxlPDradVc2@robh.at.kernel.org>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
 <20220107180314.1816515-14-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107180314.1816515-14-marcel@ziswiler.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 19:03:13 +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Add toradex,verdin-imx8mm for our new Verdin iMX8M Mini modules, its
> nonwifi and wifi variants and the carrier boards (both Dahlia and the
> Verdin Development Board) they may be mated in.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> 
>  .../devicetree/bindings/arm/fsl.yaml          | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
