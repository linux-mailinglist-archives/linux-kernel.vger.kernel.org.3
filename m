Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6480A4D03F1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244127AbiCGQVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbiCGQVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:21:49 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6FA89CDC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:20:54 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w4so3859277ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 08:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iNi/NuJgb3I9MZadAA/nBbNUy0J51g3KZrUkLORkuTg=;
        b=ncIyprolCtNzbtGaI8ZEmcOjRrndbUssGRkZqhTqAq1mncPCxyr8gFUJT+9I8xw3xp
         1KU0CXG+rNCoX6ko4mNtq8RrozoX0C5ZaIoyvWhz5WuIWD848QK3TinrNTgYk2H0pjay
         odWdVM4oK06IhmLm2ZcpZ0v15xUfdR5ZvVuPOnMWX7n6TXe5xpnAyVs3mM72TW+xblVn
         mMYYTaKxcR1doMK9EUB3YFnFb9X+xNpabSffaQfIwXi11CR5PVbT8n/PxmD8rD54BIKV
         YfQWUEZpZHA4EuNW66caBCVzlVAUu4DnBwAO3IJNM7eqAMTnXHCAWIcjn4NKJ8hHT1yf
         E2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iNi/NuJgb3I9MZadAA/nBbNUy0J51g3KZrUkLORkuTg=;
        b=TZ670JPy3mq/CJc1wUO+F4RYPw8p1Xm9SFKIzUwy+sKP9WNo+eiuAlFYBZ6tcn5+Yo
         ZcWstfwFnoS+Wqe2qAgaYNRbsYaIXJ+aWlohN4QOkZiDyuVVoZr2dg6rgn5r2nwitS+2
         mogMk86N1Pqyo/IOgdUukrcKbXr7Y2qV6vCXWiyEIsIhIVXpEwLFAkpBzqvkhGaAo8DZ
         71QzmjrMp0sITQ3ANrbVlxofWGaUDWPPug1BHocZMynSapDiY9446mYTyYVufBYqS9X9
         9j0ri/PwL0w9tm/Pfi7Ta6kjMpqOy7/CY6XKi9rxETi0Y6AEOWSn/qNw+oCZCjlvTUb2
         bBrw==
X-Gm-Message-State: AOAM532D1po+wMbmKV0xJS37s2w2ZYHr8jCPQY0QigezIhlgDx5ydirB
        2eymRqi3KvVQMMksEBktTCWmPGffCoP3olNx9QZr7g==
X-Google-Smtp-Source: ABdhPJwdaWZHVqYQDvsGi1XSWtL8PLKoWQ/6BDdpDRBxtNhslHD57lm6/C7wkiv2yOrgMygpsnOjzpRX6cHmYGRXWVI=
X-Received: by 2002:a17:902:f155:b0:151:8377:9a8e with SMTP id
 d21-20020a170902f15500b0015183779a8emr12909462plb.21.1646670054330; Mon, 07
 Mar 2022 08:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20220307154558.2505734-1-robert.foss@linaro.org> <20220307154558.2505734-2-robert.foss@linaro.org>
In-Reply-To: <20220307154558.2505734-2-robert.foss@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 7 Mar 2022 17:20:43 +0100
Message-ID: <CAG3jFytBsDVe6z7QsEZCc2KN4HdyBCZKTQxuc01YUO4m-RkMmQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Revert "dt-bindings:drm/bridge:anx7625:add vendor define"
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        matthias.bgg@gmail.com, robert.foss@linaro.org,
        xji@analogixsemi.com, hsinyi@chromium.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2022 at 16:46, Robert Foss <robert.foss@linaro.org> wrote:
>
> This reverts commit a43661e7e819b100e1f833a35018560a1d9abb39.
> ---
>  .../display/bridge/analogix,anx7625.yaml      | 65 +------------------
>  1 file changed, 2 insertions(+), 63 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> index 1d3e88daca041..ab48ab2f4240d 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> @@ -43,70 +43,14 @@ properties:
>    vdd33-supply:
>      description: Regulator that provides the supply 3.3V power.
>
> -  analogix,lane0-swing:
> -    $ref: /schemas/types.yaml#/definitions/uint8-array
> -    minItems: 1
> -    maxItems: 20
> -    description:
> -      an array of swing register setting for DP tx lane0 PHY.
> -      Registers 0~9 are Swing0_Pre0, Swing1_Pre0, Swing2_Pre0,
> -      Swing3_Pre0, Swing0_Pre1, Swing1_Pre1, Swing2_Pre1, Swing0_Pre2,
> -      Swing1_Pre2, Swing0_Pre3, they are for [Boost control] and
> -      [Swing control] setting.
> -      Registers 0~9, bit 3:0 is [Boost control], these bits control
> -      post cursor manual, increase the [Boost control] to increase
> -      Pre-emphasis value.
> -      Registers 0~9, bit 6:4 is [Swing control], these bits control
> -      swing manual, increase [Swing control] setting to add Vp-p value
> -      for each Swing, Pre.
> -      Registers 10~19 are Swing0_Pre0, Swing1_Pre0, Swing2_Pre0,
> -      Swing3_Pre0, Swing0_Pre1, Swing1_Pre1, Swing2_Pre1, Swing0_Pre2,
> -      Swing1_Pre2, Swing0_Pre3, they are for [R select control] and
> -      [R Termination control] setting.
> -      Registers 10~19, bit 4:0 is [R select control], these bits are
> -      compensation manual, increase it can enhance IO driven strength
> -      and Vp-p.
> -      Registers 10~19, bit 5:6 is [R termination control], these bits
> -      adjust 50ohm impedance of DP tx termination. 00:55 ohm,
> -      01:50 ohm(default), 10:45 ohm, 11:40 ohm.
> -
> -  analogix,lane1-swing:
> -    $ref: /schemas/types.yaml#/definitions/uint8-array
> -    minItems: 1
> -    maxItems: 20
> -    description:
> -      an array of swing register setting for DP tx lane1 PHY.
> -      DP TX lane1 swing register setting same with lane0
> -      swing, please refer lane0-swing property description.
> -
> -  analogix,audio-enable:
> -    type: boolean
> -    description: let the driver enable audio HDMI codec function or not.
> -
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>
>      properties:
>        port@0:
> -        $ref: /schemas/graph.yaml#/$defs/port-base
> -        unevaluatedProperties: false
> +        $ref: /schemas/graph.yaml#/properties/port
>          description:
> -          MIPI DSI/DPI input.
> -
> -        properties:
> -          endpoint:
> -            $ref: /schemas/media/video-interfaces.yaml#
> -            type: object
> -            additionalProperties: false
> -
> -            properties:
> -              remote-endpoint: true
> -
> -              bus-type:
> -                enum: [1, 5]
> -                default: 1
> -
> -              data-lanes: true
> +          Video port for MIPI DSI input.
>
>        port@1:
>          $ref: /schemas/graph.yaml#/properties/port
> @@ -143,9 +87,6 @@ examples:
>              vdd10-supply = <&pp1000_mipibrdg>;
>              vdd18-supply = <&pp1800_mipibrdg>;
>              vdd33-supply = <&pp3300_mipibrdg>;
> -            analogix,audio-enable;
> -            analogix,lane0-swing = /bits/ 8 <0x14 0x54 0x64 0x74>;
> -            analogix,lane1-swing = /bits/ 8 <0x14 0x54 0x64 0x74>;
>
>              ports {
>                  #address-cells = <1>;
> @@ -155,8 +96,6 @@ examples:
>                      reg = <0>;
>                      anx7625_in: endpoint {
>                          remote-endpoint = <&mipi_dsi>;
> -                        bus-type = <5>;
> -                        data-lanes = <0 1 2 3>;
>                      };
>                  };
>
> --
> 2.32.0
>

Signed-off-by: Robert Foss <robert.foss@linaro.org>
