Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559AD476B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 08:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhLPHst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 02:48:49 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:59251 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234540AbhLPHsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 02:48:46 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id A3B492B00211;
        Thu, 16 Dec 2021 02:48:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 16 Dec 2021 02:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        brGpKAbHSatyt+6U6fdOq8xciGlXAc1QxVcd3uIFK0U=; b=ngRC06rmjNE67xVf
        W/gX1CEXkhFQNpzlFChPu1OnpwjXx1YhZVnDqwusfRn++/KNuJVTpMTxcODV6fIc
        UErmQpDa6wjnTeqnc9GSMj8V8Cj9n4AhXhwz8Qgx76PZqUda5W/9ppZj7SamOmms
        UxwdWjtG1yLljMc5ChnYiR+o86FqkI5sb9Mfu3kkzmONyQJzE/8S/2yruP1rHKFT
        s+UFpbFbHs6YkwaYf130VfG95ircvi9QaUtW3e3HPY7S3QpxaVkP4vGlAnEqDngC
        qhRlOPqrec0dLhN/1CXnaAH10pQzpBidUDZ7N/+XouhQsOnQnD7tMAqHedIPUHrb
        oCvD5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=brGpKAbHSatyt+6U6fdOq8xciGlXAc1QxVcd3uIFK
        0U=; b=hoF6LyZMg4KxrolnBGyy34gytPD1g4asZq0IuEncfmjLUw1OoMXlzwH3r
        F3hz6VOIuWVKtYqiveUvVXl1kEKaT6WgPrCOLOIk+HXADq51V/xE5ihhHbqPECHd
        yr5Y5mkdEYac8sSz7prh0tJ12YxcITFJVlcdEbnkxdhi7hnxxTZqmX4bylwttx4A
        WD3/BMOodJUPa4CZsG3AlT91cyQOGD6aErQhx+fsmfSIoL36ETXzKOrZdgQvOF8n
        P+sfi3Jdg7cBvqI25NMOHyFxG1TH78Vj/ZgBI4aWcv7OdX6B2NIGKVGh0SAHjdRd
        k1xziFU6vE6JqphyNht/HnIN6Qt+g==
X-ME-Sender: <xms:WO-6YVBejOPnLuF7QQreVcLtIHf8Oc3zBZ2W1YP7pe3I7fq0MaoVmg>
    <xme:WO-6YTgkNpmFSKzkymJgma7F8LNVGdyLvahEmfrIBVAQQ2sLDYNa6o6hU4LK_U9Mm
    Bo97_FAuDWbV-f-AU4>
X-ME-Received: <xmr:WO-6YQkUmMsqExnbW1qxmjy_mdyYcwTcer6covo1qOHd8rFthSaTFLJPhDgIdP8Af4uRdlY_1Fqs0aMt8lEOpxiVe2IjDt0DG_t51mI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleefgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:WO-6YfwJ8NzFD30EzKqtWEQUR-gP6zydJTydOePqYNmabKb9dPzkMg>
    <xmx:WO-6YaRswLMDMkWb3W-aY3MwFDPTMIoP_FILoi-el_VKOZLhaUU3NQ>
    <xmx:WO-6YSY2oEqyyHthmrmgtmxLUcmWx1Yhx74Mof-K4NLp4TtU0mjmTA>
    <xmx:Wu-6YfjSNPS1AQZm15noobMAiBbP4g6ej828fmP0MYmvmf9jIIp1pvqih1Y>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Dec 2021 02:48:40 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-media@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-sunxi@lists.linux.dev,
        p.zabel@pengutronix.de, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        mripard@kernel.org, devicetree@vger.kernel.org,
        ezequiel@vanguardiasur.com.ar, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, wens@csie.org, mchehab@kernel.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com
Subject: Re: (subset) [PATCH v2 9/9] arm64: dts: allwinner: h6: Add Hantro G2 node
Date:   Thu, 16 Dec 2021 08:48:37 +0100
Message-Id: <163964090958.427634.7595301324701306993.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129182633.480021-10-jernej.skrabec@gmail.com>
References: <20211129182633.480021-1-jernej.skrabec@gmail.com> <20211129182633.480021-10-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 19:26:33 +0100, Jernej Skrabec wrote:
> H6 SoC has a second VPU, dedicated to VP9 decoding. It's a slightly
> older design, though.
> 
> 

Applied to sunxi/linux.git (sunxi/dt-for-5.17).

Thanks!
Maxime
