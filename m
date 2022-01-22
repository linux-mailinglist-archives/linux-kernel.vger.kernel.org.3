Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE444968F8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 01:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiAVA5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 19:57:31 -0500
Received: from mail-oo1-f45.google.com ([209.85.161.45]:34583 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiAVA51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 19:57:27 -0500
Received: by mail-oo1-f45.google.com with SMTP id f4-20020a4ac484000000b002e3e221d769so3824650ooq.1;
        Fri, 21 Jan 2022 16:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UCFVPsYIbWn5LSHXfQRNXq3VUxkbUc2dAX7qlE1mnBI=;
        b=YWTDN+pOEjcOEU+T70tzmx3yac/KKiUp076Y17xKmK9xCSw6rHHPSYfDjrKioFgTS5
         VuyDaxEHAjGlcvo9HuD3MK5wE7EgDz3JCWbJ9yHOzp0qYgG5T46j4jDXKWRpZruePuAf
         7OZThk+bK0BYjwLxF/yJyCCyO39I0jNKoDyLv5PJqStQGCzSOquq+N8ADTvKhWCHB4eQ
         oYwfRrDZt7l89lEe3s6QORcVUbP1ZfWuiOLr+l+nylCez/8UJAnWwwW18Gf+HLuf4/e5
         sgUuuOQUBWJFEFT7KiX2caKhqZ4VJQk+Nxgdh3qwVKTUuYVYpDrFxcusZQo4oAya0ve6
         Ynkw==
X-Gm-Message-State: AOAM532hYAld9KzJYzIWnhvt72O69KjXk0pMUYK6Fee6u7FA+Rgouo6v
        dbv2Ej7U3couTRR7wKbUAA==
X-Google-Smtp-Source: ABdhPJyco54px60GtmKl9r/Bro32Hth5e2wl+B7OHmLSFZXoTB8yx2Z2qpiBX2veogSbGhFQF1Kl7Q==
X-Received: by 2002:a4a:94d3:: with SMTP id l19mr4140263ooi.94.1642813046635;
        Fri, 21 Jan 2022 16:57:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g91sm1877484otg.21.2022.01.21.16.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 16:57:26 -0800 (PST)
Received: (nullmailer pid 1956568 invoked by uid 1000);
        Sat, 22 Jan 2022 00:57:25 -0000
Date:   Fri, 21 Jan 2022 18:57:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] dt-bindings: spi: Add compatible for Mediatek
 MT8186
Message-ID: <YetWdZnqEODQtBMU@robh.at.kernel.org>
References: <20220112103609.17421-1-leilk.liu@mediatek.com>
 <20220112103609.17421-4-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112103609.17421-4-leilk.liu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 18:36:09 +0800, Leilk Liu wrote:
> This commit adds dt-binding documentation of spi bus for Mediatek MT8186 SoC
> Platform.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
