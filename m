Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A294A4CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380824AbiAaRSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:18:40 -0500
Received: from gloria.sntech.de ([185.11.138.130]:60686 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241643AbiAaRSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:18:39 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nEaJx-0007vn-BQ; Mon, 31 Jan 2022 18:18:29 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     quentin.schulz@theobroma-systems.com
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>
Subject: Re: [PATCH] dt-bindings: ltk050h3146w: replace Heiko Stuebner by myself as maintainer
Date:   Mon, 31 Jan 2022 18:18:28 +0100
Message-ID: <4194940.gPueJrmO9C@diego>
In-Reply-To: <20220131165439.717713-1-quentin.schulz@theobroma-systems.com>
References: <20220131165439.717713-1-quentin.schulz@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 31. Januar 2022, 17:54:39 CET schrieb quentin.schulz@theobroma-systems.com:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> Heiko does not work at Theobroma Systems anymore and the boards using
> those panels are downstream, maintained internally by the company, so
> let's relieve Heiko of maintainership duties.
> 
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Quentin Schulz <foss+kernel@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  .../devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml
> index 63d2a00348e9..a40ab887ada7 100644
> --- a/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Leadtek LTK050H3146W 5.0in 720x1280 DSI panel
>  
>  maintainers:
> -  - Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> +  - Quentin Schulz <quentin.schulz@theobroma-systems.com>
>  
>  allOf:
>    - $ref: panel-common.yaml#
> 




