Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E44477E15
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241130AbhLPVEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:04:45 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:40593 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhLPVEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:04:44 -0500
Received: by mail-ot1-f46.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so406441otj.7;
        Thu, 16 Dec 2021 13:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8/HB4TUr3nuRo2TCTqrXve1tRaQ/uHPqILDzAsNvksk=;
        b=PQgewFaULSgRq4Yziq06cxjkrQUGecqbjUUO1MBREYmQX1L0u7HEQv4NVK5qbXKJ5F
         viYSfcNiZFs1yRlyvtrTWuAS/MKJqbQSeWQ8pam9zM3fxFvHC8+6dKqMKFPekgiWYzXV
         XgMjWo0EJJJg4Owo2h1NPejx7zCPvcYg/CaU9M96YjJQfZ2ngebyCRgNV2A5NYCzj+pl
         4Z3sqtMEOOE2VuxogbZ01SIxR23WQcPYguUd7quQRZgT94b8/2pufmH7V8PF9s33MUGW
         0M9Eeaqx+Fyn65IXqTxIUiwsukgQEbNN87+5ihZ53Njgl/aRnwbu7v5gH0GjWp99haRX
         QOPw==
X-Gm-Message-State: AOAM531FrXUXgQ8pIZdYgrnW2HO3rFrHMqGzUPnFRyVyL9lVUKSaPkWM
        bBc9P6broX7mTHwvDuUhTA==
X-Google-Smtp-Source: ABdhPJwaw+XBfHtnkt8e4rQRnSXbJ/pQ1FTRtrA5QLx0viKeJhfPqUxOb6a1KcwopQu6edmYrwZCMw==
X-Received: by 2002:a05:6830:25d4:: with SMTP id d20mr14093835otu.143.1639688684195;
        Thu, 16 Dec 2021 13:04:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l39sm1312887otv.63.2021.12.16.13.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 13:04:43 -0800 (PST)
Received: (nullmailer pid 753209 invoked by uid 1000);
        Thu, 16 Dec 2021 21:04:42 -0000
Date:   Thu, 16 Dec 2021 15:04:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        abel.vesa@nxp.com, linux-media@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        benjamin.gaignard@collabora.com, linux-kernel@vger.kernel.org,
        aford@beaconembedded.com, Philipp Zabel <p.zabel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        hverkuil-cisco@xs4all.nl, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH V2 01/10] dt-bindings: power: imx8mq: add defines for VPU
 blk-ctrl domains
Message-ID: <Ybup6sUyFCCNH9hp@robh.at.kernel.org>
References: <20211216111256.2362683-1-aford173@gmail.com>
 <20211216111256.2362683-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216111256.2362683-2-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 05:12:46 -0600, Adam Ford wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This adds the defines for the power domains provided by the VPU
> blk-ctrl on the i.MX8MQ.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 

Acked-by: Rob Herring <robh@kernel.org>
