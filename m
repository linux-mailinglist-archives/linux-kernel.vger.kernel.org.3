Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FE6477572
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbhLPPNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhLPPNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:13:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4E6C061574;
        Thu, 16 Dec 2021 07:13:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 825ABB8247F;
        Thu, 16 Dec 2021 15:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B56AC36AE4;
        Thu, 16 Dec 2021 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639667597;
        bh=REimS41qgBurbspSIkR1kMxD0grK0fDoyp2v8fHLvWU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=la1Nva7CY5Jjwk/Wm8lWv3aYBjlUl57ZAfIlbsOFzuOmJSPuKLopP/GuXByjC/AxG
         d8FYa3Cmbcy/Oncgw2P12FORplfl01xThQnV8jXaFWhGL25GidA2g8k+ManOQFoc6j
         2F+cH8UL49wJ8NB4ZXlyoHdZTi6aEKZgK9+U7WrEXbLuLIlLZdlk2gbt6H/RyH7/CX
         CQ8ZHrKOLJiH/rt4doqQ3JgqXTP2C/ix1yRkUCJNYrJm2Qapx2frWlRH0A5ZcMfOap
         zPq992A0r6cmcuhnAFlsqwmf3nGPeRJCwyKLLDEBzZvGY+fLYhDo6HiTeJwdsq/1FI
         8sMVox38pRHdw==
Received: by mail-ed1-f44.google.com with SMTP id t5so87989858edd.0;
        Thu, 16 Dec 2021 07:13:17 -0800 (PST)
X-Gm-Message-State: AOAM530WkSW5Q9FIvG2B8LoHvgKPTBhsY4NIWj0WWsuSxYTLMRfQvDhk
        dDhTl0rmpTAZMpx7E+0Cnt5WUu6xr+510aAySw==
X-Google-Smtp-Source: ABdhPJzaSjcXBqry8QmxPjHdP9FMmSwW8YKfAtjQEf0G8hozeKwYCJ5n4IhU9jxoGpU1d4mPc88zqtdZC7Q7FuBNpgY=
X-Received: by 2002:a05:6402:4251:: with SMTP id g17mr20936069edb.89.1639667595626;
 Thu, 16 Dec 2021 07:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20211215152712.72502-1-david@ixit.cz>
In-Reply-To: <20211215152712.72502-1-david@ixit.cz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 16 Dec 2021 09:13:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLyMr+apgqn31V7QPfqqxhJ1ro258WsDP=CO37zfyxVNw@mail.gmail.com>
Message-ID: <CAL_JsqLyMr+apgqn31V7QPfqqxhJ1ro258WsDP=CO37zfyxVNw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: bridge: document Toshiba TC358768
 cells and panel node
To:     David Heidelberg <david@ixit.cz>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ~okias/devicetree@lists.sr.ht,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 9:38 AM David Heidelberg <david@ixit.cz> wrote:
>
> Properties #address-cells and #size-cells are valid.
> The bridge node can also contains panel node.
>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/display/bridge/toshiba,tc358768.yaml      | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> index eacfe7165083..3186d9dffd98 100644
> --- a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> @@ -69,6 +69,16 @@ properties:
>        - port@0
>        - port@1
>
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^panel@[0-3]$":
> +    $ref: ../panel/panel-common.yaml

It's possible to attach something that doesn't use panel-common.yaml
and if it did, it would be applied by that schema.

What you need is to just reference dsi-controller.yaml at the top level.

Rob
