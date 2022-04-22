Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1CE50B96F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448302AbiDVOG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351486AbiDVOG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:06:26 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AA65A162
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:03:33 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q12so7389338pgj.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIxJ0wDa8EMSjPBeJ0MH0ee5bXLTHtfgfaqE1L8G+40=;
        b=lJxrPZlkatu783HAwlcGCkHOGo7DXQhGtEQqtJXdK1/LRl+CFmh8ejREqMzuQsb/EO
         mSWo3xSE3IyrXmkejiW/vWdGNWXHJq3XuWPVwHfOrNTHe22aLtJOSFoF9VbWxGShMkLI
         9Q+PuNjFAIycQZ3Wxp1Hlw+8+12yQNRH0GG+fNhLoV/3xJ4+LhbnZOUxx6MZEP9nSodA
         yqgCHWgXniNWxjtrX3H3On6nZ4yPcA3da8QSX9nhLRZ5IjY5tb6uARk2tJLXfFalCk4P
         xGPGUKbc8fkI0Vi0kDpxm6o08sdvcBkKHkthDdk164bksR8xqFiWBvr+aIqy948MIjR+
         97aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIxJ0wDa8EMSjPBeJ0MH0ee5bXLTHtfgfaqE1L8G+40=;
        b=SZkBCsjCDuEITFbDQdBlaHBoWRvQ23IJYNfP+2sG3YcMolmGsegOQHTZduJcJGcO8D
         6DDUmBfiZiTw32y6fZSCprU3y95AFik4xvU+/g4nzmqHF3pnppDwr1xDdvHFxaHt6wRq
         b5CzBwh6g8DpoPGw8keUJb1UMg/XBB0GYrADMsgXw04oqTB8y47w0p3ykTxRWrJqy7fS
         fAtERF1+3eBD+IcYM9FQBLM0LrxcGecFx1C4ezocZlZ3bCJGlwj12PBXTIXKwnXddmrI
         11jW3lrh8PI0/8aVE0/365bX8EPrRNqlwblzxuQKQDDs7L/wBfpn5rOy9xZKcMs9Ke/N
         S4cQ==
X-Gm-Message-State: AOAM5303J+oSNPzyUO6MA0jDSSc1QZrxI+1dEh0tk5wRUjDYcCtpf0v3
        ohnclf+9GGWzVssZh5TXB65pu5caqprzt97BLJ4ZCQ==
X-Google-Smtp-Source: ABdhPJxRtgE3RbFTfbHXqawhd/4ATwWIhmdUbK2D/ER+hiax8GwWWsOHlmE4gELgS/jXpG50IMB4XeGk31Iq3HBZuEs=
X-Received: by 2002:a05:6a00:1747:b0:505:d75c:e0b2 with SMTP id
 j7-20020a056a00174700b00505d75ce0b2mr5271101pfc.0.1650636212574; Fri, 22 Apr
 2022 07:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220422084720.959271-1-xji@analogixsemi.com> <20220422084720.959271-3-xji@analogixsemi.com>
In-Reply-To: <20220422084720.959271-3-xji@analogixsemi.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 22 Apr 2022 16:03:21 +0200
Message-ID: <CAG3jFysyj7sO0qh3FAAeuOQYUSz6nkZ8svX7f4xdfSY980OkCg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings:drm/bridge:anx7625: add port@0 property
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 at 10:48, Xin Ji <xji@analogixsemi.com> wrote:
>
> Add 'bus-type' and 'data-lanes' define, bus-type 7 for MIPI DPI
> input, others for DSI input.
>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
>
> ---
> V1 -> V2: rebase on the latest code.
> ---
>  .../display/bridge/analogix,anx7625.yaml      | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> index 35a48515836e..4590186c4a0b 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> @@ -94,7 +94,22 @@ properties:
>          $ref: /schemas/graph.yaml#/$defs/port-base
>          unevaluatedProperties: false
>          description:
> -          Video port for MIPI DSI input.
> +          MIPI DSI/DPI input.
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            type: object
> +            additionalProperties: false
> +
> +            properties:
> +              remote-endpoint: true
> +
> +              bus-type:
> +                enum: [7]
> +                default: 1
> +
> +              data-lanes: true
>
>        port@1:
>          $ref: /schemas/graph.yaml#/properties/port
> @@ -143,6 +158,8 @@ examples:
>                      reg = <0>;
>                      anx7625_in: endpoint {
>                          remote-endpoint = <&mipi_dsi>;
> +                        bus-type = <7>;
> +                        data-lanes = <0 1 2 3>;
>                      };
>                  };
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
