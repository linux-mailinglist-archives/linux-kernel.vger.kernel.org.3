Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648FD4D1616
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346227AbiCHLWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbiCHLWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:22:11 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728BE4578C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:21:15 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 264513201C39;
        Tue,  8 Mar 2022 06:21:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 08 Mar 2022 06:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=vUt/hjyYKhUFZD
        0GhNOiqTdU+eUWZ03MPpM5Tk05368=; b=jbJXNIhNlNT0Kxp99CnpljQebPdruO
        GZMLyOJwrrf2ul8HxXpy+WHjtTAV5fw9hlNelPjLa7emZ8xbs/wqoqnr/v20Y1GP
        voXzjOa4/RvBX0v7zfVJqVs+xHlctYFa+izR+OtcaZX2ZtOohXUW12V9FMiSb4Wq
        jql2OmB6KrVe8Xn73e6laNyh9bakeo9JasaYZ7Mx4NTySLUko57f0Fww6GM/M8Fi
        npRvON/QUFGwoR7oz1Y1BJf7X+Je/eU3+0pqZJ8TAVQ3eweNPOqs0vxkjEtioOx5
        R1PS+rQ58Rel5VCHFi2oXywNmeWlhrVFLq5egPG0EvTysJAHrE7mgjlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=vUt/hjyYKhUFZD0GhNOiqTdU+eUWZ03MPpM5Tk053
        68=; b=Qijw5CGdpPaIJWJXNogQyuxbMqHss/mcKfkHpXd9XtnyUT6UqoMI+d3/h
        7XteXLn7fc6IzwPEh7PfDw+fpKLZBJm4Bd7ExI+pwBgnEd2RU3YezN/zbM4wGPmG
        lc8mJQmsa58VSwUbCFEYlWceeOLMTAOnopZogs6/1iI0LcdCwUg5h2BtIEWBwOGe
        B/qmQPDReW0Gl4Dc5RHlc3fb+PV55veXx8O83QVMRde8vQH5hkHP9cU0MUzB6cKg
        63//ryNUqaxW04GWShO5y7K1XezU+F7PnpUGk7DslZ7eJXMvSRBJa5zGS2Eecpji
        Mda0mzrddAwiWcnaVrZ+0H2uAWiPg==
X-ME-Sender: <xms:KTwnYlZz3SwecXiiFtzhXErSu6clnZ5l93aZCqAIYR1Wh_vBuhLB8A>
    <xme:KTwnYsZ7Jz-EyO-XAyg5X2ZwkW5TfZcvSxx0f4-0a2OBU_THx6ZSv2ro_x4Eu0ius
    uNDuuvQ2Kggw68lDy8>
X-ME-Received: <xmr:KTwnYn_v6yKzq1s9KxCIBj0q3yW-cYmuTei2b6Hrp-20Drla1Zb-cwGXyVLvT2BmljxswVbeqE5vP2Yo6nxXGlxqf_yJKebuilRPo58>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudduiedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:KTwnYjp_mAdHd0J9fgmfKiNMFxzYq9TvRkBlajrvGB1dObcCqy-ypg>
    <xmx:KTwnYgoM-A93FUjMnNFUjbnbOLe1qf1GCSei_9ydjyTPGGlFuuZaCw>
    <xmx:KTwnYpS4jO2HGN8Icj-WTJVY56sS81p0mb42zX5g5MmrO2uVh0S50g>
    <xmx:KTwnYti0AcNLBT5gU7J0vyFTzQNe69HY3Y5e0wxk0lqXo-BYW95J0w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Mar 2022 06:21:13 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        andrzej.hajda@intel.com
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        jonas@kwiboo.se, narmstrong@baylibre.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com,
        airlied@linux.ie, Laurent.pinchart@ideasonboard.com,
        robert.foss@linaro.org
Subject: Re: (subset) [PATCH] drm/bridge: parade-ps8622: switch to devm_drm_of_get_bridge
Date:   Tue,  8 Mar 2022 12:21:02 +0100
Message-Id: <164673846305.2436174.1857157702611077242.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228182904.22982-1-jose.exposito89@gmail.com>
References: <20220228182904.22982-1-jose.exposito89@gmail.com>
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

On Mon, 28 Feb 2022 19:29:04 +0100, José Expósito wrote:
> The function "drm_of_find_panel_or_bridge" has been deprecated in
> favor of "devm_drm_of_get_bridge".
> 
> Switch to the new function and reduce boilerplate.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
