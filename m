Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DA64762F8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbhLOUQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:16:22 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:33774 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbhLOUQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:16:21 -0500
Received: by mail-oi1-f176.google.com with SMTP id q25so33376674oiw.0;
        Wed, 15 Dec 2021 12:16:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3jPKLGacEy7jKGMNJeI39f+qAjplz95Y70F3K1TSbv8=;
        b=tmg4W9OqWWrhJpnzULm+IP14yseKGUi25UQ7peXahsbcEsHrXyhtdPU76wCROwpMCw
         3ox64twDFh2wBpWHjhgYGZIdlg8t0kJ+I1sAI7WPNkrMdf+TltDFhrfG2pifdycRKe8j
         eT0bkwSUDn+8tiKzcblrhhWCQgwpRy65fLEkOM7fXRkjYB0XgJtqt9VRo97b62+JvK7V
         0MS26t9OV0whZARc1WISKk6RLDOAXgxK78zPr/kHFumElDS04ckNDbaU0Um/b7hEtWJr
         6iLmlx4ZFQgqhaWTRvFm3g+uRBG2ZwDfFlaNrxZYDDpv24z84k5EyjasmCo7+D5KWC42
         uJAw==
X-Gm-Message-State: AOAM53363OuG9HHAqEnxLC0acZNn9v46Vx+wElDUlIfSu2aWx906cbk/
        8v/hiRyDbVAKvCKT6Pj86PFwG2Zp9g==
X-Google-Smtp-Source: ABdhPJw4B42RMakPPZU34eCLe4JldR2y6R4gqOoaGD90DmZFUhLEm1jp7Je7BL0Z0JInmTqbMEMIEQ==
X-Received: by 2002:a05:6808:20e:: with SMTP id l14mr1363853oie.119.1639599380344;
        Wed, 15 Dec 2021 12:16:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n26sm608565ooq.36.2021.12.15.12.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:16:19 -0800 (PST)
Received: (nullmailer pid 1764259 invoked by uid 1000);
        Wed, 15 Dec 2021 20:16:18 -0000
Date:   Wed, 15 Dec 2021 14:16:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     jacopo@jmondi.org, laurent.pinchart@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        sakari.ailus@iki.fi, devicetree@vger.kernel.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 02/23] dt-bindings: media: atmel: csi2dc: add bindings
 for microchip csi2dc
Message-ID: <YbpNEqbOFgwq96SI@robh.at.kernel.org>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
 <20211213134940.324266-3-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213134940.324266-3-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 15:49:19 +0200, Eugen Hristev wrote:
> Add bindings documentation for Microchip CSI2 Demultiplexer controller.
> 
> CSI2DC is a demultiplexer from Synopsys IDI interface specification to
> parallel interface connection or direct memory access.
> CSI2DC can also act as a parallel bypass from a parallel sensor to the
> image sensor controller/interface.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v3:
> - Changed to port base as suggested by Rob
> - Added properties from video-interfaces which are being used by the csi2dc
> - added mention to the parallel port type as input
> - did some rephrasing and rewording
> 
> Changes in v2:
> - changed the endpoint/port references as suggested by Rob
> 
> Changes in this version :
> - fixed 'sink' name to be actually source.
> - added dma properties and example with dma
> 
> Previous change log:
> Changes in v5:
> - modified bindings as per Rob Herring review
> 
> Changes in v4:
> - Removed property for inter-line-delay and for clock continuous/non-continuous
> - Removed virtual channel by reg for second endpoint
> 
> Changes in v3:
> - Removed some text from description, as it was explained in the schema
> - fixed other things as per Rob's review
> - moved some text inside the schema, like the clock description
> 
> Changes in v2:
> - fixed warnings reported by dt_binding_check
> 
> 
>  .../bindings/media/microchip,csi2dc.yaml      | 197 ++++++++++++++++++
>  1 file changed, 197 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
