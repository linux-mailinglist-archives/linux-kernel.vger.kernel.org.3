Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9C5475E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245134AbhLORFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:05:45 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:40777 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245123AbhLORFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:05:44 -0500
Received: by mail-oi1-f179.google.com with SMTP id bk14so32555716oib.7;
        Wed, 15 Dec 2021 09:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nR0LhYCnvyI1jknf4KALchGxggcg5wDp4IaSeS8jbR8=;
        b=a3F/oYel6VV9lmWecI3CCWuiQSmvQQj6uyMnOEAqt+T0+YtxrLTH+KnZ4GUp/Zyduy
         DskTzA3Sxdv2x2c2atWul2t2/GQ2MtSDVloOFQc2bpQ4Ley271xUJiw34a2vh8gnrl1P
         BJNEXSRQnfH6TrQLBpF9irMG0eGyYfXRqvclG56jlYp4am89oS+UnkXYMD0mcyQKzth1
         +DbkVJLjoG7CD/rPuAkziz6boAg9m/yQtViwv2IaEqKpcbnXLb9K/M/u68xeGwpf8oFS
         DX0uRuPrpJIjFCjcjYO5UOBtFES6WuvBD6ez/XQ+Bc2IEOWlaiombLK5Pxfenkaw8P89
         7keg==
X-Gm-Message-State: AOAM533xn7WYkORLLPh/NuXmneeolHl+HrjKQxb83oXlL1Loxsz2uNw+
        8D/0Z36Rs4FwR5XZ982+TBG4Tvht7w==
X-Google-Smtp-Source: ABdhPJxQU7ez4jkeUaQaHB9ebI4gsQglf+pR/GDhnL7RW0n9Tdoq4c1LqRxCkmcVDHsGiSC/bM6hHA==
X-Received: by 2002:a05:6808:1a02:: with SMTP id bk2mr694199oib.52.1639587944309;
        Wed, 15 Dec 2021 09:05:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n23sm452955oig.4.2021.12.15.09.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 09:05:43 -0800 (PST)
Received: (nullmailer pid 1480018 invoked by uid 1000);
        Wed, 15 Dec 2021 17:05:42 -0000
Date:   Wed, 15 Dec 2021 11:05:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     alexandre.belloni@bootlin.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: spi: atmel,quadspi: Define sama7g5 QSPI
Message-ID: <YbogZqBsR0Tfz33P@robh.at.kernel.org>
References: <20211209122939.339810-1-tudor.ambarus@microchip.com>
 <20211209122939.339810-3-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209122939.339810-3-tudor.ambarus@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Dec 2021 14:29:39 +0200, Tudor Ambarus wrote:
> sama7g5 embedds 2 instances of the QSPI controller:
> 1/ One Octal Serial Peripheral Interface (QSPI0) Supporting up to
>    200 MHz DDR. Octal, TwinQuad, HyperFlash and OctaFlash Protocols
>    Supported
> 2/ One Quad Serial Peripheral Interface (QSPI1) Supporting Up to
>    90 MHz DDR/133 MHz SDR
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  .../devicetree/bindings/spi/atmel,quadspi.yaml   | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
