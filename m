Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047F05098DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385692AbiDUHXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385689AbiDUHXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:23:06 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CB525E9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:20:17 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id CFAC83202232;
        Thu, 21 Apr 2022 03:20:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 21 Apr 2022 03:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1650525615; x=
        1650612015; bh=1QXCu/fF6Tw4Hup1ppGCGo749Dtz4mOpnGlClTt0tQs=; b=E
        N8DYp4I9ESqufshYsUTA3BTrggbTd0X/Q+cOf5/cLTFU3kdtO0lR2vb/pqBSV0m8
        KgpVhpB/huG2qBS3BEwJ5/+id2Wh4iUFpEe7hqKRKwZJSXrO1gJLbLjzC7RW1qBQ
        pW7e1Rb86vJA19GLNUZsXa4PBk+e0YVdSYjLkFx+4acRqv5zXBL4muENeVz8fXF5
        MdV6AGhSnMf0ziyLAkLEjFlCdNw3gIGO3TvGOioRMhmk1CSqSJvqePU4U53k0Gjf
        zkbkYT0u7ckvjZuknxhgJiH/uCKmfazOFrliBjEe1/IVUouKzy+jSeJumWLzbOx+
        2sGjKBw2lShHq0Ph812UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650525615; x=1650612015; bh=1QXCu/fF6Tw4H
        up1ppGCGo749Dtz4mOpnGlClTt0tQs=; b=TKLd9vtByEv7H7kykfEsiwfMEBrgL
        GafFRgenfihQU9eXRZea0Oei2nexUNITfagAT9+H1B0tQq15lAXQLuiYIfQurrpV
        nX74p5OT1iPpXawDdPJnKXknM92lDkBkS8/unZaF7321yMApsI7JhoIik5VV/SVL
        ux23Rkwxdqth3aQN7VVEXyLy0MHRvFqzlQekIKD6BLajuaFCjh3ToGtak7g3IQf2
        1xF/S6Q/9uQIyPWSyEhri73QKtNaRSaPbBo8Bppq6jFMqVtzVapYJJW9u8GG5bO4
        mEiQB81jyIeuLX8/swJgste1tDSjI+4B8Q1huL3NSlDUVzloatYwEdZIg==
X-ME-Sender: <xms:rgVhYnuGBJL0L_l2fGRSpNjHvcKELfIO4OLBUE_M47chDLwjeEfssQ>
    <xme:rgVhYofgGShPNFzYJsxgsGfljrzaa-p_VTHuHFVGfy47yUigd0ABb175tmDK_uq25
    xipv8JhvvlQt2OdXs8>
X-ME-Received: <xmr:rgVhYqw7kljXuvPACBGVuwuX9Aw9VJzGT_sJtdCJ4bE6IhkTmddOg3JEm3DVVTO0yg9Zo4E7O1W4YZn0SE1uHWV0k1o45kvnnFAbTXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtddugdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueeigefghfffffeifeehudeiuedvteegueefffevgfetvdffheehkeff
    vedufeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:rgVhYmNcU4dtXbK08tnFhbrhR4sCsviS0_08QgG_7bX232Efwi5hXw>
    <xmx:rgVhYn8MB8Wnw2CamLwmQhRmagGKAseNKh9yU9rKm8A_wW85hTS0pg>
    <xmx:rgVhYmUINWH-RKnTTeOqb-85FEMcMYOnrtKnhHprkzl-SfkZRHv7GA>
    <xmx:rwVhYo281e7g0QlC1iqCVxQLui27trBJZaevW0daD7VAx2LCXWpstw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Apr 2022 03:20:14 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: (subset) [PATCH 2/2] Revert "drm: of: Lookup if child node has panel or bridge"
Date:   Thu, 21 Apr 2022 09:20:08 +0200
Message-Id: <165052560307.696645.12112489752622485846.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420231230.58499-2-bjorn.andersson@linaro.org>
References: <20220420231230.58499-1-bjorn.andersson@linaro.org> <20220420231230.58499-2-bjorn.andersson@linaro.org>
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

On Wed, 20 Apr 2022 16:12:30 -0700, Bjorn Andersson wrote:
> Commit '80253168dbfd ("drm: of: Lookup if child node has panel or
> bridge")' attempted to simplify the case of expressing a simple panel
> under a DSI controller, by assuming that the first non-graph child node
> was a panel or bridge.
> 
> Unfortunately for non-trivial cases the first child node might not be a
> panel or bridge.  Examples of this can be a aux-bus in the case of
> DisplayPort, or an opp-table represented before the panel node.
> 
> [...]

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime
