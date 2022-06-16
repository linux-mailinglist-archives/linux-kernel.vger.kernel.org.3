Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ABE54DDB2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376468AbiFPI4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376702AbiFPI4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:56:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275992AE3C;
        Thu, 16 Jun 2022 01:55:57 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1856A6601747;
        Thu, 16 Jun 2022 09:55:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655369755;
        bh=O7PilF/o1r+d7NMD9LMHqoxJRhg19289oyK+92cn2Lw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U5ebokBYeZaOcQdxx6viSf3M5OvdZ7pQ86Puj2mx3+JckPwT+K+oBg8QNVaS/SNBf
         P3BxQYNyBaEVJGHN4fTuUNrXfW0NWOfFSQ24T87PuMcRWF+YQLt0Qplc/Cd/EgeNCd
         rFfSmoVP4irWpSRlKPWimyTg42zT0B4Cv4nvW+0oyu5KCcp1THhdpzN5E02YWLAwHc
         5DfH5w02R2bZ4L85wuoEiaR6r2sYqYUI52ZB9YaXlBsI5lz+HU0DAYPEOL7i5biMJG
         sy17EheP5Y1RMPhTWk1j4QfoXjmBbAI7UhJz3xO/Ca7MmPJkClo3TWzMfWEPu/D8wo
         wkccZayaTzM3Q==
Message-ID: <b27b6a36-410e-e44d-e03b-d0194b794e90@collabora.com>
Date:   Thu, 16 Jun 2022 10:55:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 0/7] usb: typec: Introduce typec-switch binding
Content-Language: en-US
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
References: <20220615172129.1314056-1-pmalani@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220615172129.1314056-1-pmalani@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/06/22 19:20, Prashant Malani ha scritto:
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
> v3: https://lore.kernel.org/linux-usb/20220614193558.1163205-1-pmalani@chromium.org/
> 

For the entire series:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Regards,
Angelo
