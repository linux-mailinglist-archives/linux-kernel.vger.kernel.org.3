Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9800E4D1548
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346053AbiCHK5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346001AbiCHK5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:57:37 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D7541336
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:56:39 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5FFD73200E5F;
        Tue,  8 Mar 2022 05:56:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 08 Mar 2022 05:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=yjUncJHKU6QhdU
        GVHrY9w8/SgC17hVJfVi1G6k5UjMc=; b=P6/iyWcsOszl771U+3WQhqb5HJl/uL
        tqkHPjK5/h3WXEBLKoq+bQm0ZpPZznQIXjMR3ILW/jD0COwRO0JW1iv6prtkCaAZ
        ptwP0ttUyUErw+4ixv0aLgvoc2o0nutQeqH1ZHaVjgHs0nw44x5xwLmm9yEjUlEk
        3OH+P00kgajKW+RBy7Asrsv7+J/Anco16SWoijW8NZcvolr+55KGFrKZ51ogXA96
        vQC2PblNPZpgV8XUagiaxrHjvTkrXgN6JFz9KIUgo5c953gSMUJIzNqD0YHW/Y5Q
        O/V8vF/tjmsPT5ZXeiHCQmgN2PCOlpZN/+vqeUzODwXk8mxcpX+xIlvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=yjUncJHKU6QhdUGVHrY9w8/SgC17hVJfVi1G6k5Uj
        Mc=; b=kl/KzXqPa2QjrMUATtHPhAXzOzsM8/qsf/hZ27PHvNIyzw42RHqoHKSF2
        xdgsZ1376bfOpwSWpB3hqAmP7iYP2yK77G4YcHurZa3L0d3qpMuQMCMtx+rofWXb
        CKyoohMLXyhWlqPf16diLkvb6SvKZuyL0KIn0IAsF1nSe83pyiZb/istQfK+qpO2
        aJmjDyAYJL+7aqEg7azls+NV1fg3YWHlxx3EanF6ruPvVr64lkdU9+UtnsBUCdy1
        AqxiVKz/mmvqdesXHW/3z0E3WIfU+OaJtV4AS0hNppeDuntBf7+f8Yt/5Tdwva6a
        acYrxxy6pwQxCIr9uEaEqaGtz1x2A==
X-ME-Sender: <xms:YzYnYv_-qTKkXlvhCHY34MncxGV-9CUOLYGBVGHCvCLBuZRRIX3hGQ>
    <xme:YzYnYrvIhMoXmi-HudwJq3PzJOK5j1ODxk-KeWCjHd4qDj_82z4EIlkQGJaLrtNSj
    F4F2gdyuzaPlBTKRtI>
X-ME-Received: <xmr:YzYnYtDRpbSQkw6TKs4tJZUZtBjdotZfRa98MUqYvMJ8BiEE9ngf9lHrHf-AxD9F7b-0fOdXbpQisSL2FuJJAAMBzSAFmw5Z9009G8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudduiedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:YzYnYrehvvXYbfnTQWxfBQYW9kPTfQ3C5lDBTepn3HWD5y6tD5es_w>
    <xmx:YzYnYkMJberTk8rtDQj6zn_MGf7IBmfZvr5dYlfD-UEUZHK06-nRyw>
    <xmx:YzYnYtm_aesTKEXCF-jojAJjw8DFLcbsVuqJAGZG28Pj4KY1gmru3A>
    <xmx:YzYnYjqeq-ayVI5ovkJWRwx8N5naON99eNrrMyYYfOB0uxXyfb5cxg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Mar 2022 05:56:34 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, mripard@kernel.org,
        wens@csie.org
Cc:     Maxime Ripard <maxime@cerno.tech>, airlied@linux.ie,
        samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: (subset) [PATCH] drm/sun4i: mixer: Fix P010 and P210 format numbers
Date:   Tue,  8 Mar 2022 11:56:32 +0100
Message-Id: <164673698776.2315788.17487106194036352050.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228181436.1424550-1-jernej.skrabec@gmail.com>
References: <20220228181436.1424550-1-jernej.skrabec@gmail.com>
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

On Mon, 28 Feb 2022 19:14:36 +0100, Jernej Skrabec wrote:
> It turns out that DE3 manual has inverted YUV and YVU format numbers for
> P010 and P210. Invert them.
> 
> This was tested by playing video decoded to P010 and additionally
> confirmed by looking at BSP driver source.
> 
> 
> [...]

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime
