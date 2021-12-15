Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D1A475DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245022AbhLOQxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:53:24 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:43862 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbhLOQxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:53:21 -0500
Received: by mail-ot1-f45.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so25654565otu.10;
        Wed, 15 Dec 2021 08:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xm9gpKkVx8JRZ7dzKc9hCU1OHkufwqdeq6wW80KqSwA=;
        b=nRNeAHnfXIEYkbzwFzR81kx9AkhXBHask9ZC3kbivFiQ/IO4JPTVCgIsySvb5Sc9AR
         BuhZQxMjJHL+0MaEHN5I9//dH4m/IVjQjIpdOHRkO6akRKijyZZok7MNX+YHfuHOXsWY
         T//o5+NASaNkCihW2UreG7yCE5j2B+cCH3eRplKGUbMo7LvQVvLNIW5FaLqNTJyrAtk6
         PlvZN+7CSIMk2P5Mfk+wjkwu7C4cDhe4EjNgmYtCsZkJzrLLC7SzudZh7uMCWtnvUm0K
         H0a4u6yxnGx1WZ8UkU5Yu+/PmBHevNIzg8KKwpQzrZ4bgz0fQz695GW5dyP1J078oeS8
         uwBA==
X-Gm-Message-State: AOAM533MTOZRQIHyXjMHFwhdgyTHpCEwJd77GlXNLh/8u94UUDKQtKuq
        ww6IAlBNFmz48Y1SEkJMSQ==
X-Google-Smtp-Source: ABdhPJyKtoicFALG4i4urGSzoDXuoc7COnK+VLsgjbQi7WLCicmQaJorWgLOrIAOsd0okSfXK3zfnw==
X-Received: by 2002:a05:6830:4d6:: with SMTP id s22mr9720535otd.270.1639587201035;
        Wed, 15 Dec 2021 08:53:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bc7sm578949oob.35.2021.12.15.08.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:53:20 -0800 (PST)
Received: (nullmailer pid 1462226 invoked by uid 1000);
        Wed, 15 Dec 2021 16:53:18 -0000
Date:   Wed, 15 Dec 2021 10:53:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-media@vger.kernel.org, benjamin.gaignard@collabora.com,
        cphealy@gmail.com, aford@beaconembedded.com, nicolas@ndufresne.ca,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 08/10] dt-bindings: media: nxp,imx8mq-vpu: Enable support
 for i.MX8M Mini
Message-ID: <Ybodfln1RtezsARN@robh.at.kernel.org>
References: <20211208225030.2018923-1-aford173@gmail.com>
 <20211208225030.2018923-9-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208225030.2018923-9-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:50:27PM -0600, Adam Ford wrote:
> The i.MX8M mini appears to have a similar G1 and G2 decoder but the
> post-procesing isn't present.  Add compatible flags to support
> G1 and G2 without post-processing.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> index eeb7bd6281f9..fb6c2ab1b2dc 100644
> --- a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> +++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> @@ -20,6 +20,8 @@ properties:
>          deprecated: true
>        - const: nxp,imx8mq-vpu-g1
>        - const: nxp,imx8mq-vpu-g2
> +      - const: nxp, imx8mm-vpu-g1
> +      - const: nxp, imx8mm-vpu-g2

space                 ^

>  
>    reg:
>      minItems: 1
> -- 
> 2.32.0
> 
> 
