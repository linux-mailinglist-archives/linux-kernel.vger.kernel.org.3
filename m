Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D7F48AF21
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbiAKOHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:07:17 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:52410 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238129AbiAKOHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:07:16 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E9847340;
        Tue, 11 Jan 2022 15:07:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1641910035;
        bh=g0YLAV52b9NcNAxgXdu6ezu7y1czJ/KZAXOlP8Y7GVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sMjgJkR0Q85Xdph+L8A8oylQqk2SmpdtVU412Z+fcLTclsnw8AdmBcyAhxh1VfQLS
         oLwdtg9Ie5xUBVxI7/Iz6RrlrgjNgqDFIwaW7pCccrsF4lJ0GJ5aFzESsB42j8+Vxj
         6dJvpLip5cGdhsLaw0zA+G537Av0srlaVrep4mog=
Date:   Tue, 11 Jan 2022 16:07:04 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     mchehab@kernel.org, robh@kernel.org, sakari.ailus@linux.intel.com,
        geert@linux-m68k.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-binding: media: hynix,hi846: use
 $defs/port-base port description
Message-ID: <Yd2PCHehf0O8WMVP@pendragon.ideasonboard.com>
References: <20220111133937.1099917-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220111133937.1099917-1-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thank you for the patch.

On Tue, Jan 11, 2022 at 02:39:36PM +0100, Martin Kepplinger wrote:
> This is supposed to fix "make dt_binding_check":

Maybe s/is supposed to fix/fixes/ ? :-) No need to post a new version
just for that, I think it can be changed when applying the patch. Sakari
?

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>     Documentation/devicetree/bindings/media/i2c/hynix,hi846.example.dt.yaml:
> camera@20: port:endpoint: Unevaluated properties are not allowed
> ('link-frequencies', 'data-lanes' were unexpected)
>     From schema: Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> 
> Fixes: f3ce7200ca18 ("media: dt-bindings: media: document SK Hynix Hi-846 MIPI CSI-2 8M pixel sensor")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
> 
> 
> revision history
> ----------------
> v2: thank you, Laurent
>  * add unevaluatedProperties: false
> v1:
> https://lore.kernel.org/linux-media/20220110123804.377944-1-martin.kepplinger@puri.sm/
> 
> 
>  Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> index 85a8877c2f38..5d0fc18a2ea2 100644
> --- a/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
> @@ -49,7 +49,8 @@ properties:
>      description: Definition of the regulator used for the VDDD power supply.
>  
>    port:
> -    $ref: /schemas/graph.yaml#/properties/port
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    unevaluatedProperties: false
>  
>      properties:
>        endpoint:

-- 
Regards,

Laurent Pinchart
