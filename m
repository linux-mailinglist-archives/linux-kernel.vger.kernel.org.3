Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A95648A956
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348916AbiAKI2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:28:39 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:44129 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236309AbiAKI2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:28:37 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B719D3200D98;
        Tue, 11 Jan 2022 03:28:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 11 Jan 2022 03:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        TyQ+j7UyTzvsWhunneq/4hrpAqyluvUgnpKBvbe6ing=; b=GXTjhW/Or3k5WJok
        74tGvIARx/ka8M3KUCUM7IIFUFTiLsjCZMGf/dFj5PWE/JIasDVfkrI39lkbjdin
        S4Q/+AtI1FcA9vJQCp7KfMvgJyImJtBPzry4zlXU5FlMfQ5KtP/qXuWWxQK0NTZD
        B7uELbql3jHnC+Sz3Wd+m0zmhW9sh6bt119V82ZAgjFjXZ99jYARzNwCejZMsyBN
        inmcThFed7HE9AsOKPzxmtw/85GonLVE8BHhkm4Xa4LA9vL9eRvQoE0i5V3Sj6x7
        Dkv34RJmicXcULSe8eug4yKgSJteLoWdRkD1gSG81uh7SEpCGBJmrtD01mC5+Hof
        vsZwnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=TyQ+j7UyTzvsWhunneq/4hrpAqyluvUgnpKBvbe6i
        ng=; b=lzJV1X9PtzBVozU/+gRLOcH4GdWTEkj75f5sBXzwtyfQP4f8ZZKE44/2F
        IbbM5aNIaQmWwMwARMAd1kFNuwjkzqO38eQwnkDTnFpeHnXFQtmkz5wXiLLL/VsD
        arxSOWoOcYS6/GbsDHU/sSfdag3LuJ4ZQDd3gDc9lIUQG3IaR5fTXE+E9MP7H53+
        K94Xk+eXC4KcW7BeHkUhgCl2Vq7bgjMFuS9f8Nu+PlN5v79MIrEmpv2AJkZs32kl
        f6uKWawD4wG0py9TP/vyxPiq8dIlcXAAsui9yuNtD8b1r25ybkMKXjJnoMOj8FYY
        h7w5wCWEktgrp4NMuvfAP8DXHVTJw==
X-ME-Sender: <xms:sj_dYTJMuoP9NHbdxBSmAfamhttEAIGcA-HHXjx_Id9LhJo6GKHozQ>
    <xme:sj_dYXJ51Vitt5KhIJlJ47yrwGd82zmpw4u4Htpul-JKtIgM0ECYj0kLcEarQFc2p
    9atf3C1YwanitGhZXo>
X-ME-Received: <xmr:sj_dYbt5eWbDKV5TFM-2vXKTvShzkcxdtRTmon85T8pgTVsvDv0yn9X0m_5ve87TnAomNTk4NFU363OUZGHH7J6HpEmFGsHhPJFxUwo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehvddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepjeeugfegkeffgfeuvedtvddufffhjeffjeejvddvudduteehhfefhfef
    geeikeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:sj_dYcZCXmxFBBcyl9nxYJEbBtb0hgZWdWtXoSHH3j9RavM4dXIxvQ>
    <xmx:sj_dYaYW7FJOTIiuhaz9Z0UTS2guLJTxYBe3WbOrUrHj-WmoRqMAhg>
    <xmx:sj_dYQBlzcD203nwnD7jKZrQaXjJRK8bbu3ZCMVGMaIq8_IfIX898Q>
    <xmx:sz_dYQNHNngEQp4BGwVsxCIrltrWPIdsricBQVRTo9CGmtX0zbw6BQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jan 2022 03:28:33 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Maxime Ripard <mripard@kernel.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] ARM: dts: nanopi-neo-air: Add eMMC and bluetooth
Date:   Tue, 11 Jan 2022 09:24:54 +0100
Message-Id: <164188927517.774115.5653853938961736601.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104193719.87091-1-mike.rudenko@gmail.com>
References: <20220104193719.87091-1-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 22:37:18 +0300, Mikhail Rudenko wrote:
> Enable the bluetooth part of AP6212 chip (connected to UART3) and the
> onboard eMMC (connected to MMC2) for the NanoPi NEO Air board.
> 
> 

Applied to local tree (sunxi/dt-for-5.18).

Thanks!
Maxime
