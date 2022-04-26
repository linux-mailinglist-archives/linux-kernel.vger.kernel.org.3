Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3EF50FD4C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350123AbiDZMon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345870AbiDZMol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:44:41 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C907FBB08E;
        Tue, 26 Apr 2022 05:41:31 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 492345C0074;
        Tue, 26 Apr 2022 08:41:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 26 Apr 2022 08:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1650976889; x=
        1651063289; bh=AC3fXGBXmPXraihRLIM77w9frliDq7HqkQUBjuY+6ZM=; b=g
        YFCyGxOW2D6uHceOc3OwhFvYxkQUfmrhYbBZViG9qtOP9Fci3L9JahnM0bShrlGj
        ik0Unwn6qEPc+AwHVaf4kneMox0e4MiN4r7ixdDIu7mSle6bLznBHyp14ROdKNHP
        0bfrLhe3cK85z/hyTaThkGf6xgDjgI/XCwbCPKr0S1Ve8/n4D7/Td642e1vK/c/H
        YmlXmMFXR8YorvL34Kn2gwRVe0zDYG1yRhFRs/uA6G7dvRyV973BRESAPZRhAOOi
        IjZyyo+Yk2xrRLGrlahUiKZxI3GErmbkjDeyBb9bl+14BWPinjpL7bndA8sFRWsN
        5B6EZ1unPU4Z59BF+h4gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650976889; x=1651063289; bh=AC3fXGBXmPXra
        ihRLIM77w9frliDq7HqkQUBjuY+6ZM=; b=EaDO1lKq2CqgxpawH9zKOm5CgVnbK
        mDDQrCsfkOgz1ebrEJSeg6urqSwJsCUjAUU+mhFNJqjSui/aq0MrxW+0R2Q2rAXR
        3P2FWg9VahGaSJI07boDtQ46OyUe+jA3gTIPsPsOzHjtJW3ScoLESjEbXJZwFxEh
        ynfP32MIBckcr591xNs5Z1yxE+4sRhudFMkoCCUyFQVfOXorSt6IOCz/Wf2XCNGt
        tC1zt6zGqtA9khdv6tl/Zxy4HL+zCI7b8idYGuopg3AYCtwx+wJZiYugWGO3IzHc
        WdvV2P5m7sJAB48JisKDl3M+8gPUnUwhG5baHjzMjq6YcaHAYn6qe+NsQ==
X-ME-Sender: <xms:eOhnYjvMYorkKsA77MWQO4fxGMke0WWzDVjMGT59CVYtBL7hlUBMYA>
    <xme:eOhnYkcT6GeskyBpjsL-2Kw79X_sHO_gGf8hqnjAEtcC2VeBd2t41Bq70VY382xtb
    AC7IOUOefFNnWI6hMI>
X-ME-Received: <xmr:eOhnYmxX9g37oMqHCmZDkX-5BB__hycdC1UaNbGefIHn8DuzT0CYJsbnT-Hm5_WCZlvT6oyJbYy2lUKeOY5g1zb3IDP8IgwjifcpPcE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuieeggffhffffieefheduieeuvdetgeeufeffvefgtedvffehheekffev
    udefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:eOhnYiOt4cgKwKfL-lFolxFwcboWqnuu9bRHsSbSl1ff-0GHDi9t1w>
    <xmx:eOhnYj_uK3zthnQf0Cb90wGDUVzfzrgbY-Bk8xuTf3PZHWsdmuWX3g>
    <xmx:eOhnYiWnuxuZfgD__pZjVlSzaLbyvLM_m9P7aazza1Wt2H2_BcUqSA>
    <xmx:eehnYmUaVr1UECo73YZzJQ2xbMjsoj8kQNADB7Nfs6kKjE5LsFQn6Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 08:41:27 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, David Airlie <airlied@linux.ie>,
        linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: (subset) [PATCH v3 03/14] drm/sun4i: Remove obsolete references to PHYS_OFFSET
Date:   Tue, 26 Apr 2022 14:41:24 +0200
Message-Id: <165097687063.513954.2708926846046765429.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424162633.12369-4-samuel@sholland.org>
References: <20220424162633.12369-1-samuel@sholland.org> <20220424162633.12369-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 11:26:21 -0500, Samuel Holland wrote:
> commit b4bdc4fbf8d0 ("soc: sunxi: Deal with the MBUS DMA offsets in a
> central place") added a platform device notifier that sets the DMA
> offset for all of the display engine frontend and backend devices.
> 
> The code applying the offset to DMA buffer physical addresses was then
> removed from the backend driver in commit 756668ba682e ("drm/sun4i:
> backend: Remove the MBUS quirks"), but the code subtracting PHYS_OFFSET
> was left in the frontend driver.
> 
> [...]

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime
