Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B446048994E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiAJNKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiAJNKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:10:35 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121D9C06173F;
        Mon, 10 Jan 2022 05:10:35 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 83F15A50;
        Mon, 10 Jan 2022 14:10:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1641820233;
        bh=bbN0HHwtV7n8wJWLf+LzZvANW6C6Q4kQcvHiYiRl2UA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qh4gowx+DfZAVH8U+27K2rwObgfsZ/UdeqlNbn9DCO26cZ1s4dea9rksUKUDEmCEj
         fVke0nGZwt/Hf/o3rfmfoHaw5u9UKAWSC9mK/s8tNWq/OKR1U7dkItZIKdIK8ZVCS7
         Zln3WUybIW0FeKzC6rwNdtw8D5fQNQPMjJxD5WDY=
Date:   Mon, 10 Jan 2022 15:10:25 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     mchehab@kernel.org, robh@kernel.org, sakari.ailus@linux.intel.com,
        geert@linux-m68k.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: media: hynix,hi846: add
 link-frequencies description
Message-ID: <YdwwQSpKJuGraKmg@pendragon.ideasonboard.com>
References: <20220110123804.377944-1-martin.kepplinger@puri.sm>
 <20220110123804.377944-2-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220110123804.377944-2-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thank you for the patch.

On Mon, Jan 10, 2022 at 01:38:04PM +0100, Martin Kepplinger wrote:
> link-frequencies is required but only mentioned in the example. Add
> it to the description.
> 
> Fixes: f3ce7200ca18 ("media: dt-bindings: media: document SK Hynix Hi-846 MIPI CSI-2 8M pixel sensor")
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> index e61255cf3fb9..6b917337ceac 100644
> --- a/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> @@ -68,8 +68,11 @@ properties:
>                    - const: 1
>                    - const: 2
>  
> +          link-frequencies: true
> +
>          required:
>            - data-lanes
> +          - link-frequencies
>  
>  required:
>    - compatible

-- 
Regards,

Laurent Pinchart
