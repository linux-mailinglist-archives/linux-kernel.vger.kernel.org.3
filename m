Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF1A47C4E3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbhLURVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:21:30 -0500
Received: from mail-qv1-f43.google.com ([209.85.219.43]:39451 "EHLO
        mail-qv1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240338AbhLURV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:21:28 -0500
Received: by mail-qv1-f43.google.com with SMTP id g15so11739764qvi.6;
        Tue, 21 Dec 2021 09:21:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X+CVb/g6dnkbXp9dG9nViDZF9etnV+5k0QPN7oufv/0=;
        b=XK9d6MuRJnGT/rQ+hPpRFqD25quRHsiC9YP5xh5Rglet1/pLHGfj8uIFMBm3V9qX1E
         wBo6dNq/d91QEpDKPPuusOFWYieyrt79ODBZfy8XeUjM3SgohzET/RfSx+Z2UbSjj19V
         OB6oAzW5wdAH3VQhI6NlQI9plNiSTsyCWw5kJAqJtdA5V+P9KtgwPDUbdyCt/tolz/S8
         xv6Zg8jHpsvFk1U9DngzWPVScPCxmTS7gj3+ffZVIKGFN3qPyjApAP/0Cp+ggKCqP5oo
         IWTzgayeI7AymTlmzchu6jU6Cppn2uT55US4a8aGb1LHZi26HM1rQx7Rh1tiLCQQ2ttt
         vQAw==
X-Gm-Message-State: AOAM533QvilOIYYOLpav7Wss/qB9W/zoMcfiVO8E7HOUenSNuY6v88Xa
        Ph0Pote5WnRJwbWsoWY3Yg==
X-Google-Smtp-Source: ABdhPJyUZqgy8z6h1itTc00ig548tDmWDMm+yG6tEOlBa0l55dZI6W1MWmhrwR6z45DhGzx1FIF2iA==
X-Received: by 2002:a05:6214:27c6:: with SMTP id ge6mr2077176qvb.83.1640107287804;
        Tue, 21 Dec 2021 09:21:27 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id k8sm16700695qtx.35.2021.12.21.09.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 09:21:27 -0800 (PST)
Received: (nullmailer pid 1478362 invoked by uid 1000);
        Tue, 21 Dec 2021 17:21:24 -0000
Date:   Tue, 21 Dec 2021 13:21:24 -0400
From:   Rob Herring <robh@kernel.org>
To:     Zelong Dong <zelong.dong@amlogic.com>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        narmstrong@baylibre.com, robh+dt@kernel.org,
        linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: reset: add bindings for the Meson-S4 SoC
 Reset Controller
Message-ID: <YcINFJ2vaB5WRqzm@robh.at.kernel.org>
References: <20211217073521.35820-1-zelong.dong@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217073521.35820-1-zelong.dong@amlogic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 15:35:21 +0800, Zelong Dong wrote:
> Add DT bindings for the Meson-S4 SoC Reset Controller include file.
> 
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> ---
>  .../reset/amlogic,meson-s4-reset.h            | 125 ++++++++++++++++++
>  1 file changed, 125 insertions(+)
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-s4-reset.h
> 

Acked-by: Rob Herring <robh@kernel.org>
