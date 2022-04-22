Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3E150B550
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446714AbiDVKkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446635AbiDVKiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:38:51 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6892403ED;
        Fri, 22 Apr 2022 03:35:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 34867580055;
        Fri, 22 Apr 2022 06:35:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 22 Apr 2022 06:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1650623744; x=
        1650630944; bh=sialgZLQyO92Jzz731mhx4P39e8kWtOeqoXhw0cCtXY=; b=W
        xTSy59TGhUVrDTR5ZZ9AihUZQI4ztc0COij2niyKHFseYaXY1k1iijFElgMlbzjj
        IgW79/RwLv6Fp4X6u1RNldYGUTYXAc3mckrXYDpkxLD8Z0+bSam6DaOQn6RH8JJV
        Qurrb/7pXjRhV6hrBlyosxRCFXsVsKBzWSBUFBCKC76wZdJrkGNy/PnPSeGc6ESL
        uS9PQ4Df7oGGULaYujEqbEX0gkpBXi38nCiC253MjtXIcEU+DlXgHhcSk5SLyWR8
        DMCfpqY0+5d3saPZJOXn8wIeAiyRKjBJE3kBwqEP2fTi0gJ5AUl4LXi/x+9R7+KU
        HwyrBchREXwkM8JuhkQ5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650623744; x=1650630944; bh=sialgZLQyO92J
        zz731mhx4P39e8kWtOeqoXhw0cCtXY=; b=xCGQhbzjwFiulmF6LlwEI2cPB3bBF
        0ZqiYsKEqcIu5ZJxYH0mF7KEYuIof1NLNHoW4TtCBHWDqwK+z2RZi+HgbfH1FOpb
        5nEg/us+9DLek/Br6MvB1IWNoskzsjdYAysFTHU1OckKOZaOQbqHZyDf//HLon6T
        d7mcQhAcY1FFLvkEiygt802ZKh7zDfaBMBxNldjoO4kRqUQb6whLZwd8ZmEBlIhp
        ctpWULiSYUe0CMhkaloAbV6hB/Gu4jw3+6LjXHWnZntyvDNrP/WiB1ZJOf9x6Xwc
        3WHrccx3rtfbAlPOI3TziqtZIPUOpSkUOAhqS5u+rspah0ghgnBo8a+Ew==
X-ME-Sender: <xms:_oRiYlIPkSce9J_iB2dx7YVzLXKxS60W4-Vyw3zmLO4U1aLiaFmmbg>
    <xme:_oRiYhJOFbCsPLyYHVGGL4uD5HM-gey6IrG0BNy0SHfJOB4Q2dzZGy0EfuD4xixYV
    3YhQ9CUuNJWy7-W19Q>
X-ME-Received: <xmr:_oRiYtvBLqnHwVb37WFesVwZ0PMShNb6BvWXvV8Vm7Y4HetLslo-SvwCRTZi3P3Uu5oZYU4g5GlpHVUV0fb323r_rgqp4WPTvpHVZpo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdeggddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuieeggffhffffieefheduieeuvdetgeeufeffvefgtedvffehheekffev
    udefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:_oRiYma42u8bFsyuaEoHigJkGAD8rHqS6b6IrkpHQB1N2nS1P6TckQ>
    <xmx:_oRiYsbrF1C3QRv8Y5kK58OXIM5reFvVFe9fVe3wBCRWdmYHf-Yu9g>
    <xmx:_oRiYqDjcSeHlAIkkqXF6PNc-gW-JT9Geogu1FY8mL5VO4njDgDJWQ>
    <xmx:AIViYlRpbFTOma7kkn3FGWD0v6WQLAHvvXHX_xxmOtMZ2RMdHubTSg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Apr 2022 06:35:42 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        inki.dae@samsung.com
Cc:     Maxime Ripard <maxime@cerno.tech>, daniel@ffwll.ch,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, alain.volmat@foss.st.com,
        lgirdwood@gmail.com, broonie@kernel.org, samuel@sholland.org,
        linux-samsung-soc@vger.kernel.org, p.zabel@pengutronix.de,
        airlied@linux.ie, kyungmin.park@samsung.com, mripard@kernel.org,
        jernej.skrabec@gmail.com, jy0922.shim@samsung.com,
        alim.akhtar@samsung.com, krzk@kernel.org, heiko@sntech.de,
        linux-sunxi@lists.linux.dev, hjc@rock-chips.com, wens@csie.org,
        dri-devel@lists.freedesktop.org, sw0312.kim@samsung.com
Subject: Re: (subset) [PATCH 5/5] drm/sun4i: hdmi: Replace drm_detect_hdmi_monitor() with is_hdmi
Date:   Fri, 22 Apr 2022 12:35:38 +0200
Message-Id: <165062373584.1462930.6032469942386231983.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421170725.903361-6-jose.exposito89@gmail.com>
References: <20220421170725.903361-1-jose.exposito89@gmail.com> <20220421170725.903361-6-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 19:07:25 +0200, José Expósito wrote:
> Once EDID is parsed, the monitor HDMI support information is available
> through drm_display_info.is_hdmi.
> 
> This driver calls drm_detect_hdmi_monitor() to receive the same
> information and stores its own cached value, which is less efficient.
> 
> Avoid calling drm_detect_hdmi_monitor() and use drm_display_info.is_hdmi
> instead and also remove sun4i_hdmi.hdmi_monitor as it is no longer
> necessary.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
