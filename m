Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0454454ABCC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353754AbiFNI2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240485AbiFNI2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:28:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A912E2CE25;
        Tue, 14 Jun 2022 01:27:56 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 57AE466016A5;
        Tue, 14 Jun 2022 09:27:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655195275;
        bh=ydqkHg2s0zBILzARZnJ3e6Y01dsz1E92/hWRLQFTOj8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LXxn9p9IDVY0mvOrzmmkZlAZb8MoYCJIuQhaq56qZwxy6F+FDSxBjUQDtYXvifB4S
         FLyb6/LHJCGs6RjGuNZ30ZxYYHod9uMU3mkAPpCYuXSBaxYnKPn2lb6bG0c5YMOF+X
         g8hEfy6bRp1LQER1il8q9p3mB3kf/RMlRxk05s8DaSJTnzw+NH9suU9y/sL22WLduP
         /3Agloj16pnWlgFRdGCuRx66C3sXmRIGLDjpZVjvUI8JKCdv8xQ7N3/Tfun7OuwMvX
         0lVeqyG8oIGFRpRsJPMv/Az3PDbFo3g8mS5OTQs0sHIUqJ7xGG109i5BNnuMCnOMfd
         jpIk1d/7cMibA==
Message-ID: <260305f3-78e5-6b57-398c-f63073eb6c03@collabora.com>
Date:   Tue, 14 Jun 2022 10:27:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/7] usb: typec: mux: Allow muxes to specify
 mode-switch
Content-Language: en-US
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Jonas Karlman <jonas@kwiboo.se>,
        swboyd@chromium.org, Pin-Yen Lin <treapking@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Xin Ji <xji@analogixsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Foss <robert.foss@linaro.org>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
References: <20220609181106.3695103-1-pmalani@chromium.org>
 <20220609181106.3695103-2-pmalani@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220609181106.3695103-2-pmalani@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/06/22 20:09, Prashant Malani ha scritto:
> Loosen the typec_mux_match() requirements so that searches where an
> alt mode is not specified, but the target mux device lists the
> "mode-switch" property, return a success.
> 
> This is helpful in Type C port drivers which would like to get a pointer
> to the mux switch associated with a Type C port, but don't want to
> specify a particular alt mode.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

