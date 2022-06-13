Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9277A54A127
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352222AbiFMVRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352217AbiFMVQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:16:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79134D10D;
        Mon, 13 Jun 2022 13:58:49 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1E55D6601671;
        Mon, 13 Jun 2022 21:58:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655153927;
        bh=TmikzqWBrB46qOMNrEdA0IqJB77LnzkhuMwjJ/1ZJBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iKZzCOUbY+UJhBB9Z3ZyUUmdIykmqpdNuQBWJpxbwBC0Wp+rz0VBIMnI6o7bt9BFW
         MgxULPUIwA82jhxgDNAUxqr8shbAVRhSkT2inQeb3BUQVZRJsZWWktIEw/NqBh24gF
         eMHrYrHdQ7WBJa4kltnWaNYpYTPRRoG3o9MbN8dnMsEXHM9bVoD6gO2sSVzlIKtoGC
         WmqmMXdSvwN+OiDvRYLb+xn266m0rnLiF/lfsoHXCalt2QsA4hiUOAW6Aa8Yp5P1D7
         t2zcgUao/fkmxW8wsrAwbyxmaNoVena1oizM/3KP4Gy2U0SGHkHr+kKpwBQwmu3y0a
         ThbGcSpSGXbww==
Date:   Mon, 13 Jun 2022 16:58:40 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>
Subject: Re: [PATCH v2 0/7] usb: typec: Introduce typec-switch binding
Message-ID: <20220613205840.x7bgrj567prroede@notapiano>
References: <20220609181106.3695103-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609181106.3695103-1-pmalani@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 06:09:39PM +0000, Prashant Malani wrote:
> This series introduces a binding for Type-C data lane switches. These
> control the routing and operating modes of USB Type-C data lanes based
> on the PD messaging from the Type-C port driver regarding connected
> peripherals.
> 
> The first patch introduces a change to the Type-C mux class mode-switch
> matching code, while the second adds a config guard to a Type-C header.
> The next couple of patches introduce the new "typec-switch" binding as
> well as one user of it (the ANX7625 drm bridge).
> 
> The remaining patches add functionality to the anx7625 driver to
> register the mode-switches, as well as program its crosspoint
> switch depending on which Type-C port has a DisplayPort (DP) peripheral
> connected to it.
> 
> v1: https://lore.kernel.org/linux-usb/20220607190131.1647511-1-pmalani@chromium.org/
> 
> Changes since v1:
> - Fixed function signature error in "else case" of typec_mux.h
> - typec-switch.yaml: Fixed indentation, compatible, and node names in examples.
> - anx7625.yaml:
>     + Introduced patternProperties for "switch" children (suggested by Krzysztof Kozlowski).
>     + Added unevaluatedProperties descriptor (suggested by Krzysztof Kozlowski).
>     + Added "address-cells" and "size-cells" properties to "switches".
> 
> Pin-Yen Lin (1):
>   drm/bridge: anx7625: Add typec_mux_set callback function
> 
> Prashant Malani (6):
>   usb: typec: mux: Allow muxes to specify mode-switch
>   usb: typec: mux: Add CONFIG guards for functions
>   dt-bindings: usb: Add Type-C switch binding
>   dt-bindings: drm/bridge: anx7625: Add mode-switch support
>   drm/bridge: anx7625: Register number of Type C switches
>   drm/bridge: anx7625: Register Type-C mode switches

For the whole series,

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Tested that external display works on both ports of mt8192-asurada-spherion.

Thanks,
Nícolas

> 
>  .../display/bridge/analogix,anx7625.yaml      |  63 ++++++++
>  .../devicetree/bindings/usb/typec-switch.yaml |  74 +++++++++
>  drivers/gpu/drm/bridge/analogix/anx7625.c     | 151 ++++++++++++++++++
>  drivers/gpu/drm/bridge/analogix/anx7625.h     |  20 +++
>  drivers/usb/typec/mux.c                       |   8 +-
>  include/linux/usb/typec_mux.h                 |  38 +++++
>  6 files changed, 352 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/typec-switch.yaml
> 
> -- 
> 2.36.1.476.g0c4daa206d-goog
> 
