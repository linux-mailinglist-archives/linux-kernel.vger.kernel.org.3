Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82D7475E24
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245126AbhLORE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:04:59 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:41651 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245123AbhLORE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:04:56 -0500
Received: by mail-oi1-f169.google.com with SMTP id u74so32504604oie.8;
        Wed, 15 Dec 2021 09:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eG1NB2Sq3vENVmOUtEsqpxLH1lU9wd+52s3qMjDalEI=;
        b=krfrxinAK+qdmo+USRnDt65vQSc075sXtOr7006uj8j/XzxsTxTsZlKPMO8lqoGXE0
         9cjV77o8WwVASVJQoB9LeGlIAkokVmxhdMvEps27Go27JM3hRWH8+wl/3ZlAJdDkVyva
         tawviDm4zeAV9Q7m9mKHqK80eojs6x52B6Rc6DiwJlPLE+ONRzajd6FfaGy4Pob4N0Q1
         XugYQSXb1oNQwWhzZZCj4hq7L8Nrvb1wyuDHGhU+fDL+PIFVXsLxwyzNxULJFIqnIDL4
         Ac6XTH+O/V0PmJEgpbc8z5PpoDLjcW33NWFLflZyVUnU3w9I4hXe/njZ3Esr7cwbw7sL
         dfhQ==
X-Gm-Message-State: AOAM531fqAjKb4byeJf61vj53jn+ry/NyTHO7LstWT8aVXU2yarFYP9g
        in0jqHtiAUhXFQAcFTJupg==
X-Google-Smtp-Source: ABdhPJzcfp8LfKwPOYvP1NBS/j0z+VCxvqDUTm2P2r3TAgngSTMxZ4qsp/FdcmyM3cfjWVtZEg+Ujg==
X-Received: by 2002:aca:5983:: with SMTP id n125mr627716oib.153.1639587895880;
        Wed, 15 Dec 2021 09:04:55 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e4sm446017oiy.12.2021.12.15.09.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 09:04:55 -0800 (PST)
Received: (nullmailer pid 1478848 invoked by uid 1000);
        Wed, 15 Dec 2021 17:04:54 -0000
Date:   Wed, 15 Dec 2021 11:04:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com
Subject: Re: [PATCH 1/2] dt-bindings: spi: atmel,quadspi: Convert to
 json-schema
Message-ID: <YbogNtvbtypd41g5@robh.at.kernel.org>
References: <20211209122939.339810-1-tudor.ambarus@microchip.com>
 <20211209122939.339810-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209122939.339810-2-tudor.ambarus@microchip.com>
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

Reviewed-by: Rob Herring <robh@kernel.org>
