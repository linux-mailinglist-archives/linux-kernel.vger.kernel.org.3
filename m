Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD40D58C84E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242638AbiHHMZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242788AbiHHMZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:25:46 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45973634B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v49Gv+vvLdx2K8EmwF94ITIRDlwX8hbS7d3UiPb1pM0=; b=qr4XgPypiXoBj/EGs5WV0wPjUl
        Nm//fZoqFvDP4KJ7stWC6EZH8lS3KZAVLRztAS215esJhmOH71vRxOoKydxK0vubFnolyzYbLf1Kd
        erG+gveaYm54y+J6TWgEx9dUiwtGZy47rZRNgE5nvDfgF9OXZVLRxS6I+NPrV56XUhCl/xyT5JAaU
        uvutKHw7fytMD/AA38WxKcsTuhzuxobpDTVjeAt6G4qtbKcK+XQOW8m1vfy7gMOxaP/mlEt/juiCN
        iMsIr/HTF46es8F2dboXYr/sfQAFhCpLo+tlz1XFxfhK36YLld+PtctnTvDRLgA5MmsoiiMfnMzgy
        Jekey9ZA==;
Received: from [2a01:799:961:d200:fd91:af1e:9da7:f964] (port=64062)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oL1pF-0005Gv-RZ; Mon, 08 Aug 2022 14:25:41 +0200
Message-ID: <633ff81a-8fe1-da85-1235-18d14aebf6b0@tronnes.org>
Date:   Mon, 8 Aug 2022 14:25:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 01/35] drm/atomic-helper: Rename
 drm_atomic_helper_connector_tv_reset to avoid ambiguity
To:     Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-1-3d53ae722097@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-1-3d53ae722097@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 29.07.2022 18.34, skrev Maxime Ripard:
> We currently have two sets of TV properties.
> 
> The first one is there to deal with analog TV properties, creating
> properties such as the TV mode, subconnectors, saturation, hue and so on.
> It's created by calling the drm_mode_create_tv_properties() function.
> 
> The second one is there to deal with properties that might be useful on a
> TV, creating the overscan margins for example. It's created by calling the
> drm_mode_create_tv_margin_properties().
> 
> However, we also have a drm_atomic_helper_connector_tv_reset() function
> that will reset the TV margin properties to their default values, and thus
> is supposed to be called for the latter set. This creates an ambiguity due
> to the inconsistent naming.
> 
> We can thus rename the drm_atomic_helper_connector_tv_reset() function to
> drm_atomic_helper_connector_tv_margins_reset() to remove that ambiguity
> and hopefully make it more obvious.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
