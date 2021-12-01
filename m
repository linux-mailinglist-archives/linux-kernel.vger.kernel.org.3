Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC581464985
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347889AbhLAIZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:25:15 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:48623 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhLAIZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:25:12 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5549B3200E31;
        Wed,  1 Dec 2021 03:21:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 01 Dec 2021 03:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        tdPEg+U3TLS2hwbuuXjF2mBi3jyYrUxzHA4hSiAkcLo=; b=NFodBgGHT6f+Quak
        mJ8rLKHUS27NrdwrsHsrQN+KYnQyk5GYGf6rdKkZKx2s4ct1VvGOyKrYJfJbNXfH
        +PBHduh81GhvXM3joNX+nP8BgSDcIpyNU1Oba+12ila7zRvfFL8EvYMu5DbcN8e8
        V6IeWTVjVZQmQGyykp27Cz90wUVX8SqOAaciTHGE35gkzDwFqcxcSm85JmGr5ak3
        FvUhvqRQffX2JsmIIhCSD3D4eCsNW2DySxuLgFb6VAI2NXrL8IrPkZ9tvUDvX6G6
        clJMezIBZtY6ock9c048v067J7tyXHom7JcjzQ9q02FGECzqzVXng5fnl6j78qYZ
        +t1CMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=tdPEg+U3TLS2hwbuuXjF2mBi3jyYrUxzHA4hSiAkc
        Lo=; b=TYBOMs9cJPCSCYJ11VaITJZgbWBiNHZW9R0Ft9tnqur/qZPQmD+vx8zd4
        CykskVCHtIj3Fw/MPlNwKgv5TsgGjDNgK8A6VHP0DHTMefZzWkmOwdaupayOhJdo
        DZQafi3CPxMATiGNSw38h31bJxcmU0D74Tw5Hkfs7kRwNnEmYgKvEnowtGlmgWkS
        O9cntTs6uJilnSH1jmm+81RUwlufYJ4LZTgK1Gk+5pASMvmRu/UrjpontTGvd5Io
        44y8anHQ97M7KldlY7eSnCmaV4PTxlK3/KlgbCWBp8zjzwFKk4acIx9rnPcy+LGm
        8toprgiOu8JkkO+3BngRdJNWeQadw==
X-ME-Sender: <xms:mzCnYUZaHyfxm4plR3wbThO803wgiEMrIKR-dZQ-E4xTK054AXX7uA>
    <xme:mzCnYfZv8gemPNOLkGz2Jl2_oN0z5EQpQhFt_LCFp3f1ppy4mLkdTPdAeURL21F7w
    zKTKS0TFWlNWgS7iew>
X-ME-Received: <xmr:mzCnYe8H-bTB7MYbSY9sErABSrDNVgBs-BN8xhDA3swT9U0sUMOhFqFnMkTWe5Oe4ITcTcinQawa1R2_oXYsKp4LS4wXfB51A_Q6gY9XusgbbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddriedvgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:nDCnYeqGYKJCgrmGS3SuhV4Up0g-d-OJ-tfIE73hcOdI-62aAp-NpQ>
    <xmx:nDCnYfpxS2RKJYNpOxf0u6NdVXuvXnW3pWvEzwrh1vFXImGNtzYxnw>
    <xmx:nDCnYcS_5NtyDoyFJTyD-84oyLNuhMcedr32b0MdNhWRg3jTInchKA>
    <xmx:nDCnYTfKRVVZKCBwtDu7kmX1xIhDwyjGRcsgS7B5MukO0M9tBuo3dQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Dec 2021 03:21:47 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     wens@csie.org, mripard@kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-sunxi@lists.linux.dev, Michael Klein <michael@fossekall.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v2] ARM: dts: sun8i: Adjust power key nodes
Date:   Wed,  1 Dec 2021 09:21:44 +0100
Message-Id: <163834688049.16473.3626415624264430661.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129165510.370717-1-jernej.skrabec@gmail.com>
References: <20211129165510.370717-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 17:55:10 +0100, Jernej Skrabec wrote:
> Several H3 and one H2+ board have power key nodes, which are slightly
> off. Some are missing wakeup-source property and some have BTN_0 code
> assigned instead of KEY_POWER.
> 
> Adjust them, so they can function as intended by designer.
> 
> 
> [...]

Applied to sunxi/linux.git (sunxi/dt-for-5.17).

Thanks!
Maxime
