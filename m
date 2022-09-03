Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E4A5ABF24
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 15:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiICNis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 09:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiICNiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 09:38:46 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95C05AA37
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 06:38:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E78FE3200564;
        Sat,  3 Sep 2022 09:38:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 03 Sep 2022 09:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662212318; x=
        1662298718; bh=Tw9iM29JVXAAF7Othcl+TL+b6fxAKApvQt80+NZTFOE=; b=L
        SP//Dm7OEHbO67NnFPFM+vC3oGQcVlOvTBoh+HsPJoSyQYR4S4FYAdnQMJTzjVtS
        z8bk3w0B6yqAOIFh7j1wMl2kCg7fz8arDnKot3xg9VNOuk0OAWSjMEj8EjhH03N0
        mZXWve7OJ7LHYE5vy3L/1prNgZ94KiKOX2WpB4Ebeh642RUVvfuScdakjXpE+OxN
        pzwkhZgDpqS1c73iZPWL4dXl3v9iCKAZreg35e3fzhAmjM1xu79Vq8FZGYRRZERe
        QjLGSF91SmFnCt4LhgBQOQKjz9bvP3e2vOUTzkbN34gUkso4V+gtDtJtbj8Uravu
        yn5Ahif1HeBVbMuavt4dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1662212318; x=
        1662298718; bh=Tw9iM29JVXAAF7Othcl+TL+b6fxAKApvQt80+NZTFOE=; b=A
        EIAesrryWEGyHobgL255e5n+z6GRTEogqcn+7R1sQiKES2fINewK+OhTDuUGYUVH
        sbNBbG57NxDPUCxvm09360HTO+PnxrtAbqWxvImf0XYSeXRst1aQad7XoyROtIDa
        2SADG4Fj+2E+C5CATDaywTvcMFQJs5mJr9i+ozMtP6k1WyD8AFZvN68YPpUS2i3X
        Y9pVwsa+WbFNvU5ih+hZjV+7B5IQmTApFj6VEqSdAhCeGrBtY/8kkou9j8sWIxMJ
        5Mu25Qwkv4xyIZZ4+wGBgE2lc362Zk4WQXKZnxbgvjsxvYRSGgWseOnSL7YWiht9
        j9o8N4MZyIz5dbjPLs/rA==
X-ME-Sender: <xms:3VgTYzv7p9jY5z0Xu7Ua707s367WXjOaG38VPxMUC4owOpFs0YTQSw>
    <xme:3VgTY0cWlzcu8cYJDG8YzsvwJ6qMuAac691f6LWzoqajrosHQFOUQUKgG_8ak3OLt
    LVdHl7PiDOHTkr1jg>
X-ME-Received: <xmr:3VgTY2yeLHytvSNAGgoBVyCDbXkay1pIyCTCHYZYhBa4H_m7UrhesdNOzjmSC7_1ZvVz-QWWI7L2JBopFXj01L8kJCRCum4B3LdBqQkhP9N100ju7hfg83xTbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:3VgTYyPox-38QOvAU_iNQ_5Yi1rMUOQ9KVZgBTa33_ukSGmTRJNGVQ>
    <xmx:3VgTYz8NNW-_uV12sYVjWlseiicqq6CtxTOXl_QGBu8J1wOKatII5A>
    <xmx:3VgTYyXad1x6MUa25zBTWT3_IiGkxKGPpIaKeoUAo98O5p6FDhEHZA>
    <xmx:3lgTY_T5L2HxBVCZ3BSZP1GX9lMCpJyTVj7-kwixdl28PIIU8cUX0g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Sep 2022 09:38:37 -0400 (EDT)
Subject: Re: [PATCH v4] phy: rockchip-inno-usb2: Return zero after otg sync
To:     Peter Geis <pgwipeout@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220902184543.1234835-1-pgwipeout@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <9a2d493f-d4af-0880-d593-50120cfd3328@sholland.org>
Date:   Sat, 3 Sep 2022 08:38:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220902184543.1234835-1-pgwipeout@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 1:45 PM, Peter Geis wrote:
> The otg sync state patch reuses the ret variable, but fails to set it to
> zero after use. This leads to a situation when the otg port is in
> peripheral mode where the otg phy aborts halfway through setup.  It also
> fails to account for a failure to register the extcon notifier. Fix this
> by using our own variable and skipping otg sync in case of failure.
> 
> Fixes: 8dc60f8da22f ("phy: rockchip-inno-usb2: Sync initial otg state")
> Reported-by: Markus Reichl <m.reichl@fivetechno.de>
> Reported-by: Michael Riesch <michael.riesch@wolfvision.net>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Michael Riesch <michael.riesch@wolfvision.net>
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>

Reviewed-by: Samuel Holland <samuel@sholland.org>
