Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9396946F146
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239321AbhLIRO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:14:28 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:38767 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242650AbhLIROU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:14:20 -0500
Received: by mail-oi1-f179.google.com with SMTP id r26so9568547oiw.5;
        Thu, 09 Dec 2021 09:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=vDpBlTT4D85f/awNnonitBOckiP0o6Fp6s+m19mtbZM=;
        b=jWdXzn4yM0gdTsrRXWFitdcUYPMtoVUMY6OsRtfujqxKs5e7ZKenimlQqVMZx/rmnP
         weBzyAdah/IFlm04JLGuHAUq8c9a/VDxQkFZbtcarm3hvx2QkBD6kphbEuwI8V8WIA4U
         ahItLwuMSaONmSlKIeqR+y2yidqopohORu81hsrbX74VEgd2CYLFqlg0eBScTTIIUBxU
         YrCjyHtqtvpnTOZYazFtBTrHfJvO4+cMZEK6993/Il1iePR8HlLA4VS9P0x8I6W5axxF
         86ZpYXsu0Wzs20UB96LG7tyXEsk2ub+QFCmlP0xe1DOMpC237JFSrWdP+e8QN6HdEf+a
         s1/Q==
X-Gm-Message-State: AOAM532FtyHDU/HWeH0OD0c5XTwtml/CeQ+vV9bo9wxfdlUF3NLeoGCn
        sH0a61pCKH2Y1g/IjJrTxw==
X-Google-Smtp-Source: ABdhPJw7ide+1YV2hij0cO0+JZY6WR7BBWYDbRGOdQFR+sfaZc/JLYJtsJrI1bORVDf1mb1yDZMe0g==
X-Received: by 2002:aca:603:: with SMTP id 3mr6899169oig.98.1639069845995;
        Thu, 09 Dec 2021 09:10:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y12sm105829oiv.49.2021.12.09.09.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:10:45 -0800 (PST)
Received: (nullmailer pid 3089524 invoked by uid 1000);
        Thu, 09 Dec 2021 17:10:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, nicolas.ferre@microchip.com,
        broonie@kernel.org, ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        alexandre.belloni@bootlin.com
In-Reply-To: <20211209122939.339810-2-tudor.ambarus@microchip.com>
References: <20211209122939.339810-1-tudor.ambarus@microchip.com> <20211209122939.339810-2-tudor.ambarus@microchip.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: atmel,quadspi: Convert to json-schema
Date:   Thu, 09 Dec 2021 11:10:42 -0600
Message-Id: <1639069842.758236.3089523.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Dec 2021 14:29:38 +0200, Tudor Ambarus wrote:
> Convert the Atmel QuadSPI controller Device Tree binding documentation
> to json-schema.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  .../bindings/spi/atmel,quadspi.yaml           | 87 +++++++++++++++++++
>  .../devicetree/bindings/spi/atmel-quadspi.txt | 37 --------
>  2 files changed, 87 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/atmel-quadspi.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1565734


spi@f0024000: 'clock-names' is a required property
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dt.yaml
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dt.yaml

