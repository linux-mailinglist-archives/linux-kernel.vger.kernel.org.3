Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DB24903CE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbiAQI2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238144AbiAQI2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:28:13 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726ECC06161C;
        Mon, 17 Jan 2022 00:28:12 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id BCAEAE0014;
        Mon, 17 Jan 2022 08:28:05 +0000 (UTC)
Date:   Mon, 17 Jan 2022 09:29:07 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Scally <djrscally@gmail.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH 1/2] dt-bindings: media: video-interfaces: add support
 for dual edge sampling
Message-ID: <20220117082907.hxauz4bfbwwevmge@uno.localdomain>
References: <20220114105755.730200-1-michael.riesch@wolfvision.net>
 <20220114105755.730200-2-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220114105755.730200-2-michael.riesch@wolfvision.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Fri, Jan 14, 2022 at 11:57:54AM +0100, Michael Riesch wrote:
> Some devices support sampling of the parallel data at both edges of the
> interface pixel clock in order to reduce the pixel clock by two.
> Use the pclk-sample property to reflect this feature in the device tree.
>
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>

Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
  j

> ---
>  .../devicetree/bindings/media/video-interfaces.yaml          | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/media/video-interfaces.yaml b/Documentation/devicetree/bindings/media/video-interfaces.yaml
> index 4391dce2caee..b7f77a255778 100644
> --- a/Documentation/devicetree/bindings/media/video-interfaces.yaml
> +++ b/Documentation/devicetree/bindings/media/video-interfaces.yaml
> @@ -144,9 +144,10 @@ properties:
>
>    pclk-sample:
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    enum: [ 0, 1 ]
> +    enum: [ 0, 1, 2 ]
>      description:
> -      Sample data on rising (1) or falling (0) edge of the pixel clock signal.
> +      Sample data on falling (0), rising (1) or both (2) edges of the pixel
> +      clock signal.
>
>    sync-on-green-active:
>      $ref: /schemas/types.yaml#/definitions/uint32
> --
> 2.30.2
>
