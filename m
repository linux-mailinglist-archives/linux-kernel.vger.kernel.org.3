Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2C04936BB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352720AbiASJAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:00:08 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:45381 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352296AbiASJAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:00:07 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DE8C332021AE;
        Wed, 19 Jan 2022 04:00:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 19 Jan 2022 04:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        jttUtP8/f+vMu1H9KR3Yahp8iiuzAC35HjtG9XBaq+o=; b=FTz0lGyQGKT2n7rj
        gmMCxdYykUhyeeVMZQUA1dXgdhJilSK7m1cQhvq/daOv15tx62mUFq9NT3/ELCO0
        qBHjTcz3gyJ3ZrbMrL/9XQKnvLd++eAXl/lJv2Kmn9YIncHs+ozhRK7lS97AhP0q
        E4pNkPR1ZQAMXnBYcWw0h1yvOZThdqQy9za92IB21yK5JliSnlTqjjB/Ah9iE2Hc
        5q1O/eH1VRg93wBEGao4XZxZoBwd9ucozoD9BCcnXEMUoIE5gDIjhpDdtSkBfwUs
        ShFXlcKieicZbRIGTnqKYD2Z1qyCZgJ5l3uGH5bHPb+w/bvsndFhTwnGLGUsg2Dd
        piwzpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=jttUtP8/f+vMu1H9KR3Yahp8iiuzAC35HjtG9XBaq
        +o=; b=bi1HHhhft6xAZFV1XCm3cPUx7uMhinRlaRN/xxsoexwb1Bc9LzL3hlwvh
        asWJQ5gZk6UrndqK5WXuEmCH1ybF64Zewfa60MM9CwHcVr3HR2iEmxziByb0ZYSD
        Xw/qkf30Z7AkIMWZWg+zE64xuWMSamfKCW5V1neM1mbp7jam9wTHfwNWmKGmSBgp
        AAWA9L8GQuNgVvqzs8YkOHtI+rrOoHi3QY04Fnn2mlbt8nKtiyUdTOTg6gr3fFuU
        YJbT4MgwZA4KRoYWH0LfEESztTIYf5cD3jgCqjcJuOAEUcuq8+RmfOeWQl6fkkwG
        fW83/MiUBmx/3ZomEwgz8ye6FkCiA==
X-ME-Sender: <xms:E9PnYcSEKGNZxM9k2AasfCE7QjZ60QEBff8CjR5_mCjFQuH1TuLrdg>
    <xme:E9PnYZy7LkRrDJOcE0QE3WcoAvBlUd_idvgLo-whkrBp3peGMzh_VTYhZYJKcBasJ
    _Ya9TD0YNeibU6lNpY>
X-ME-Received: <xmr:E9PnYZ1hpDc7tKswxQRFW9pIq1mM0KTrCuRtbqHE4n4cnNr0Micr88l8aPw6OBSBxudx_9ZyDN8-JkBp3emxr7ZLVOhNxswvK-94wkM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeggdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:E9PnYQAKUMhtz01lpk6Q_P55GX5K0ZeGrGdefUB0vmQWQRlPscrzjA>
    <xmx:E9PnYVgGVKci9PUzpcb-9iYBiRTbi5p7oaT0dkura16WDB8aV7dg-w>
    <xmx:E9PnYcpfgGYe7eP2v17JkHGUoguVJqRYJnNFHb2MTtFTtsG9bNbcTQ>
    <xmx:FdPnYQWjkNKcfpjyegDMZSRTyIwPQO1mF3Sk1WusRPEGVs_GbpFRLQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jan 2022 04:00:03 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     mripard@kernel.org, Conley Lee <conleylee@foxmail.com>,
        wens@csie.org, robh@kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v4 1/2] arm: dts: sun7i: Add A20-Marsboard
Date:   Wed, 19 Jan 2022 09:59:58 +0100
Message-Id: <164258279605.29285.8984289239298980655.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_C2E26D0935C9157CB3597BA4BD3316E8940A@qq.com>
References: <tencent_DC7B4D416B69D6D6789356010B5B9647C606@qq.com> <tencent_C2E26D0935C9157CB3597BA4BD3316E8940A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2022 00:31:47 +0800, Conley Lee wrote:
> The Marsboard A20 is a A20 based SBC with 1G RAM, 8G Flash, micro SD
> card slot , SATA socketm 10/100 ethernet, HDMI port, 4 USB2.0 ports, 2
> USB2.0 OTG, USB WIFI(RTL8188EU) with antenna.
> 
> 

Applied to local tree (sunxi/dt-for-5.18).

Thanks!
Maxime
