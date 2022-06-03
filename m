Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F1F53C6E8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 10:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbiFCIY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 04:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiFCIYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 04:24:23 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348BC1B793
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 01:24:21 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 978765C01F3;
        Fri,  3 Jun 2022 04:24:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 03 Jun 2022 04:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1654244660; x=1654331060; bh=WSWWhdSOQK
        dEUaHqyqEBOb+/qAji3ZgVcCXOcQfuj/w=; b=mX+E1LyPOiThUobyBvfFXjVreG
        IYTDFMyvGWA8FS8FFyIPfIU2oYLOMMHn+L9gPxNFDwiMevG0nLXEkyJoEpYTbsEP
        BIDzE0BtIH0eGd1EIa4pFaNht6Mmwkm6+uSr7vGPebatRwbHU+SN2qvRd/OZx11J
        iS3jKMLA1HK6yweGLCTyGQ/g9jNLQMoJ8RPmVA3n68bdRqR+j5yq1gVhI7H0LNQk
        ymYOBEPiBgEDc+QCBpdL57yR+QeBAN28w96afp2/j8WWEmfkcLot/E6sjnUf+1NC
        FAK9jEl8zSXkwXNG1Uu7TVXNPEMeC3k6YPftgYNXx0jtZS7xCuUOwhgTmCfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1654244660; x=1654331060; bh=WSWWhdSOQKdEUaHqyqEBOb+/qAji
        3ZgVcCXOcQfuj/w=; b=pSVVD7CgWjuVCHvoVIbP9Hb0zvmjUspNwG2zm7F5EWYX
        I2zrK4kjUc6dM8q5qrZ5x6kohUU09TIPTl3E58vKKB/z348qHm5Xv0Qfsh0JZaFK
        l++7mkhTQAUbGUxNZEKDW67ponV721LbNTezqS3pJH1nflHdtAHTdwrTYK3WPb8K
        cI2J3u+nr/ytkGKPKZf3DbybJE5DP1LIYF/ayya9h+KOVpialq3XPVs4LOn2xuWD
        5ab73tqelbEH23Ej0ymBIwF6i8nZamnsEsI0k7mcfxZPi22Hd8CdePp2tbDCikli
        q2iJbZebKv5Mzcat9v1lWDgxYbmy+ZfHEaUqznN5mA==
X-ME-Sender: <xms:M8WZYjL0dBHcN5A5PfczR2j7e6KfDK3yG3KZPH4pu3h-Jx7_7XseBg>
    <xme:M8WZYnIBP0TYiDw5jAPEznLopQ8lhiA4mk5zv48rLvHcUikl7F6TN4i-hcmHumGxA
    tkZG9dvJfljMbH0xvM>
X-ME-Received: <xmr:M8WZYrthmNKKC1_KyhWWzWegeHabvQpRAmtx3teOCUJUl3EtKiUn1Kxi8cMM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrleeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepkeetjeevgfdvleeiveeutefhfeejtdegvdeugeetvdduffeigfdtveeuffet
    feeknecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:M8WZYsYK9xlQHDCngiuRvwCvyP0TajeHNBi0JE4RD2F5NJVN67gjuQ>
    <xmx:M8WZYqY-qeAPEQhxH1yd5kx0L9SjUwWaONTSapmaPKDX3VPAacXS4Q>
    <xmx:M8WZYgBtR-xY_N0-moc8yw9X0BO1EBZZKt49cwZk78hlrPopYGt_JA>
    <xmx:NMWZYglpnMRgdrdttyBZqzsYmQqedX9hiQRO27htDtQWsvtMRLzOyA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jun 2022 04:24:18 -0400 (EDT)
Date:   Fri, 3 Jun 2022 10:24:16 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     wens@csie.org, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, samuel@sholland.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, megi@xff.cz
Subject: Re: [PATCH] drm/sun4i: sun8i: Add the ability to keep scaler enabled
 for VI layer
Message-ID: <20220603082416.ukohug3mwzu43csu@penduick>
References: <20220602180118.66170-1-r.stratiienko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602180118.66170-1-r.stratiienko@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 02, 2022 at 06:01:18PM +0000, Roman Stratiienko wrote:
> According to DE2.0/DE3.0 manual VI scaler enable register is double
> buffered, but de facto it doesn't, or the hardware has the shadow
> register latching issues which causes single-frame picture corruption
> after changing the state of scaler enable register.
> 
> Allow the user to keep the scaler always enabled, preventing the UI
> glitches on the transition from scaled to unscaled state.
> 
> NOTE:
> UI layer scaler has more registers with double-buffering issue and can't
> be workarounded in the same manner.
> 
> You may find a python test and a demo video for this issue at [1]
> 
> [1]: https://github.com/GloDroid/glodroid_tests/issues/4

Please describe the issue entirely here. The commit log must be self-sufficient.

> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 12 ++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c |  4 +++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> index 71ab0a00b4de..15cad0330f66 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -27,6 +27,18 @@
>  #include "sun8i_vi_layer.h"
>  #include "sunxi_engine.h"
>  
> +/* According to DE2.0/DE3.0 manual VI scaler enable register is double
> + * buffered, but de facto it doesn't, or the hardware has the shadow
> + * register latching issues which causes single-frame picture corruption
> + * after changing the state of scaler enable register.
> + * Allow the user to keep the scaler always enabled, preventing the UI
> + * glitches on the transition from scaled to unscaled state.
> + */
> +int sun8i_vi_keep_scaler_enabled;
> +MODULE_PARM_DESC(keep_vi_scaler_enabled,
> +		 "Keep VI scaler enabled (1 = enabled, 0 = disabled (default))");
> +module_param_named(keep_vi_scaler_enabled, sun8i_vi_keep_scaler_enabled, int, 0644);
> +

It's not clear to me why we would want to make that a parameter?

If it never works, we should fix it once and for all and not allow a broken setup at all.

Maxime
