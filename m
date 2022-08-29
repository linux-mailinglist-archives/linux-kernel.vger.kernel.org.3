Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B15A542B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiH2Sq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2Sq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:46:56 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F7D7F248
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LIXwPXe6uDCw8puUWwXJwlt9Qctgfa7237R9Ay9Rr94=; b=lEkiEUddmC83T3gPlX9iC1HPqE
        SNqV0HNvj3WohDUJb3awRux40lCfk6tyQB/y/P0NkxAmJvnLotHmUwjl8aOOgP7Mq2i6NQQK+Qfzy
        aGX/MisxWkzuPdRvBFUrgVFV5Pp5E73ZOuHT2POkj46RBMOqXiYPFKcqFeqYAz83p2JMvS2jO7pEf
        1Nfovc1pcY/rW+YbwdLiXSg03RCMaci4y5cXg2twznwbCvQHEeFLKuqBYsK06/LVq5t3DUgZOvADK
        7zf9RrPQcFL/TgKO86KFtdoAnMH8IPBBc/k4+dp4YbP4PPdWhQGbwwkVcLgx7cXqgK+UELGvisvi2
        nlmQP40g==;
Received: from [2a01:799:961:d200:cca0:57ac:c55d:a485] (port=60573)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oSjme-00079u-AJ; Mon, 29 Aug 2022 20:46:52 +0200
Message-ID: <f6289e5d-98e3-1a0d-f514-136e2b7978c1@tronnes.org>
Date:   Mon, 29 Aug 2022 20:46:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 01/41] drm/tests: Order Kunit tests in Makefile
To:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-1-459522d653a7@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-1-459522d653a7@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 29.08.2022 15.11, skrev Maxime Ripard:
> Since we've recently added a ton of tests, the list starts to be a bit
> 
> of a mess and creates unneeded conflicts.
> 
> 
> 
> Let's order it alphabetically.
> 
> 
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> 
> 

Something has gone wrong with this patchset, there are double line endings.

I looked at the patchwork version and it look all right there so I
figured it might have fixed up the patches, but it failed:

git apply -v --check
/home/pi/tinydrm.gud-gadget/workdirs/tv_norm_gadget/500003.patch
Checking patch drivers/gpu/drm/tests/Makefile...
error: while searching for:
# SPDX-License-Identifier: GPL-2.0?
?
obj-$(CONFIG_DRM_KUNIT_TEST) += drm_format_helper_test.o
drm_damage_helper_test.o \?
        drm_cmdline_parser_test.o drm_rect_test.o drm_format_test.o
drm_plane_helper_test.o \?
        drm_dp_mst_helper_test.o drm_framebuffer_test.o drm_buddy_test.o
drm_mm_test.o?

error: patch failed: drivers/gpu/drm/tests/Makefile:1
error: drivers/gpu/drm/tests/Makefile: patch does not apply

ERROR: Failed check apply patch

pi@build-server:~/tinydrm.gud-gadget$ file
workdirs/tv_norm_gadget/500003.patch
workdirs/tv_norm_gadget/500003.patch: unified diff output, ASCII text,
with CRLF, LF line terminators

Noralf.

> diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
> 
> index 91b70f7d2769..2d9f49b62ecb 100644
> 
> --- a/drivers/gpu/drm/tests/Makefile
> 
> +++ b/drivers/gpu/drm/tests/Makefile
> 
> @@ -1,5 +1,13 @@
> 
>  # SPDX-License-Identifier: GPL-2.0
> 
>  
> 
> -obj-$(CONFIG_DRM_KUNIT_TEST) += drm_format_helper_test.o drm_damage_helper_test.o \
> 
> -	drm_cmdline_parser_test.o drm_rect_test.o drm_format_test.o drm_plane_helper_test.o \
> 
> -	drm_dp_mst_helper_test.o drm_framebuffer_test.o drm_buddy_test.o drm_mm_test.o
> 
> +obj-$(CONFIG_DRM_KUNIT_TEST) += \
> 
> +	drm_buddy_test.o \
> 
> +	drm_cmdline_parser_test.o \
> 
> +	drm_damage_helper_test.o \
> 
> +	drm_dp_mst_helper_test.o \
> 
> +	drm_format_helper_test.o \
> 
> +	drm_format_test.o \
> 
> +	drm_framebuffer_test.o \
> 
> +	drm_mm_test.o \
> 
> +	drm_plane_helper_test.o \
> 
> +	drm_rect_test.o
> 
> 
> 
