Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431D8524899
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351843AbiELJJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245413AbiELJJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:09:45 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA536622E
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:09:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id F30C43200975;
        Thu, 12 May 2022 05:09:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 12 May 2022 05:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1652346580; x=
        1652432980; bh=/bgeaIMZnvjlafXAlm2rjsulUtrzd+cfFyKgpgA/3mA=; b=C
        InGOtHQrkek0v/aKfaW3jBjPyHqSJ1i/MeCFPgqBfiSZ0I2QtKgjeQztnQg074j8
        CWnTuPzPMKU4lKegZ89mRS3iQJrDvHjR9NIznjCLPF24ppv6Mau7tA/h+PNlZQ5W
        lRZhro0NARB4noSXHmFkIyvkPQWp6ejj/ikztHBi50IehoptkYKNCxblJwk9yBzK
        1OooMx5hkQXCyEgYiTvfetPkf0WrL54894kfHUw6w3eXcl23UF0mo3TrX3l41v0o
        99o5S1/KQSKD5y/DzQ9a8qTETFbn6A39wSgGcPnoguPizimJpIUoY6rH1LGljtSz
        MQ4MWs2nlT/dwAOwP8gYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652346580; x=1652432980; bh=/bgeaIMZnvjla
        fXAlm2rjsulUtrzd+cfFyKgpgA/3mA=; b=jk/vkqRItwLfUyeC8/DFxGx1MkKni
        eHjVtgTNcBMD2fjfx2JZIw+sBeXHU3mjoguHjJm5Fwku+8Bp82hJDGgI5vQK6RoW
        D8FHiXvkFu6+PzRslHsX83FCmIIwPYuJvAf/ozPU423+TgBVVsV+oVN7iEsjtRNb
        upjuJd6ewq8nOEk1/JlUBF8bQjHcIbOQjqNu/Ycoard1TpyfNVVZbb19BG9eWjYx
        /nn7hEgzXFrS2HxjRUIL7XLLw385Gl3pV/L33FuiwMGB6HL6dF1CSaVljo5xKa7l
        66Cud69MEcMfbp1d4evWpDgTUaVjOkY2m7wazwlEBRAfJ54u0bVwJHeyQ==
X-ME-Sender: <xms:0858YrGwf_OyQQxM7IHZ8l4ZIAaS_ASOwQ1ZcCJfoOVWzAPqHpdYUw>
    <xme:0858YoVdPw_dr5OGierM6BB1VEqteVuqnJgYWNtWJsSsezoSnXGOAdqF6IpeYE1aw
    uPSJwesl0cxi_fU9GE>
X-ME-Received: <xmr:0858YtKn_O8YwkZ3_dwsjQOCXa-4nlmCK-mb15X_JseKjiuwx1n90MzDF-57pvUv_DNAyx4KEye7iGvhwkhdN9_2ixJgsXtHd8ZZWCM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgeejgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuieeggffhffffieefheduieeuvdetgeeufeffvefgtedvffehheekffev
    udefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:0858YpGM1UNIkOhRMg85gWPm0KqaxUPWdaX9W4yGi5RKxXhiw80NwA>
    <xmx:0858YhXkJk536kUuPi-WjtheTc0oiiocWBdDPdGMHjPU22TOU-4lNw>
    <xmx:0858YkOXvDH-xNgfglt85F8gpFGiyHq2e35AdCvq9-HPpZV2kEnDsg>
    <xmx:1M58YgFTf5DCrXJuFcKNIX6911OuvgWEIIW9rBstK8o48nAgHcamUg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 May 2022 05:09:39 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     emma@anholt.net, Hui Tang <tanghui20@huawei.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mripard@kernel.org, airlied@linux.ie
Subject: Re: (subset) [PATCH -next] drm/vc4: hdmi: Fix build error for implicit function declaration
Date:   Thu, 12 May 2022 11:09:36 +0200
Message-Id: <165234657363.650256.10198774771301868859.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510135148.247719-1-tanghui20@huawei.com>
References: <20220510135148.247719-1-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 21:51:48 +0800, Hui Tang wrote:
> drivers/gpu/drm/vc4/vc4_hdmi.c: In function ‘vc4_hdmi_connector_detect’:
> drivers/gpu/drm/vc4/vc4_hdmi.c:228:7: error: implicit declaration of function ‘gpiod_get_value_cansleep’; did you mean ‘gpio_get_value_cansleep’? [-Werror=implicit-function-declaration]
>    if (gpiod_get_value_cansleep(vc4_hdmi->hpd_gpio))
>        ^~~~~~~~~~~~~~~~~~~~~~~~
>        gpio_get_value_cansleep
>   CC [M]  drivers/gpu/drm/vc4/vc4_validate.o
>   CC [M]  drivers/gpu/drm/vc4/vc4_v3d.o
>   CC [M]  drivers/gpu/drm/vc4/vc4_validate_shaders.o
>   CC [M]  drivers/gpu/drm/vc4/vc4_debugfs.o
> drivers/gpu/drm/vc4/vc4_hdmi.c: In function ‘vc4_hdmi_bind’:
> drivers/gpu/drm/vc4/vc4_hdmi.c:2883:23: error: implicit declaration of function ‘devm_gpiod_get_optional’; did you mean ‘devm_clk_get_optional’? [-Werror=implicit-function-declaration]
>   vc4_hdmi->hpd_gpio = devm_gpiod_get_optional(dev, "hpd", GPIOD_IN);
>                        ^~~~~~~~~~~~~~~~~~~~~~~
>                        devm_clk_get_optional
> drivers/gpu/drm/vc4/vc4_hdmi.c:2883:59: error: ‘GPIOD_IN’ undeclared (first use in this function); did you mean ‘GPIOF_IN’?
>   vc4_hdmi->hpd_gpio = devm_gpiod_get_optional(dev, "hpd", GPIOD_IN);
>                                                            ^~~~~~~~
>                                                            GPIOF_IN
> drivers/gpu/drm/vc4/vc4_hdmi.c:2883:59: note: each undeclared identifier is reported only once for each function it appears in
> cc1: all warnings being treated as errors
> 
> [...]

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime
