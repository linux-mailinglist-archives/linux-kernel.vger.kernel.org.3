Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451A14A3F25
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238556AbiAaJVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:21:35 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:33739 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231476AbiAaJVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:21:33 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1E9533201F32;
        Mon, 31 Jan 2022 04:21:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 31 Jan 2022 04:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=yUDZE4c/QgB5X4
        ztLzqYxeifoxmkCBP/adi9DeT4MKo=; b=NqsFfm8SyKSStrBGGVkfukHoMcVm/V
        H9xnruaYrEZr11B04mE0vSykBL1Eh6bTLicQ2eQ/y4FEhbAYSynIwNgXu1sSdveV
        TIqtug9B8s9j71DoNWoU7cgiYr4omBik0YssNXPpb7n5hbyOTDa09jETXyHo++Y9
        U8mXqaND2Uijpc5OAl2JfkHpnIX9jhNeleQ1cT2YrvQ7vdGd7r58Et096qA/TEp+
        v9UNG7aqdUJryoDbnVovqoRH+RQHappXdm4xkKsGwhDFfAxHwhEsppjjYuC0w5fz
        ru0nhjH27HmI3Unz/UroylgiPmwBKPn182f/hjy9kEAFfsv4eU4mNNPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=yUDZE4c/QgB5X4ztLzqYxeifoxmkCBP/adi9DeT4M
        Ko=; b=CXzrMpfqacKhJzJwRr7oN4PaKjo8uEPGbu/NSXHNXu5ohI64j5+A7Wson
        kzA119iJzxXr/0AagSaXgXeCcMghQvfsHK/7atxKOiiG9PRkko6/e7u45NJoHLEm
        9JZiusRux2sD855GUDrY3VLnPyGkFMiF3DEELo4TXIMIFXInDmH68YbHvI45HGCZ
        WdHVcAb//Qxn8JKoIVPrsU6F4roN9ICarSAfdV78rxlGgn04ZVWw0Y8mwIHqf5wH
        DRqP8AQJjq++Ye1SJfLefD4Itiy01GEc3GVQQmf6kypVa0zX1lfT0tzIuGuT6w9N
        CzDV41U+C3eIMjlI5oEWJmXtU7qYw==
X-ME-Sender: <xms:Gqr3YTE7h3A-xoH81Q-0wyTqOdxPrMtht-idf7jhv6M5DrikDMUSRg>
    <xme:Gqr3YQVW5L_SfjRdjADrffUZPc-Wxv91NubYjA12OT_SA49q-BwzMsfN61M0s2dJZ
    INPRTUKzPCsB3h0KFM>
X-ME-Received: <xmr:Gqr3YVJ2fXNZK5Nl5EIiEAYvJ9KmhKeSRGKlZT4z8xcQVK3IA85D1VxsjrxjA7w0Wk09_VVsVsOdtKZGTlj2o4-6IH6Ar4XkIMiy85Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgedugddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeeugfegkeffgfeuvedtvddufffhjeffjeejvddvudduteehhfefhfefgeei
    keeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:Gqr3YRF5NFkuv5MwUkqduSFnP74JR39Z5tkGz3oMCmrzEvPgW_KTuw>
    <xmx:Gqr3YZWWDLYoIdkuVEKPVSs-YaW0-jxsJtPtUzzbtwC8mpELg9ugOA>
    <xmx:Gqr3YcOX6FqcjhAaGlerl8kz3nlyDfIvl_RgHJQdDFWuopN-Zi9dZg>
    <xmx:G6r3YVqXnuLPUJuiTxnLTfgkWmKuSjjsCfk9eD_YBrIBNhDYDbKUqQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Jan 2022 04:21:29 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Baltaz=C3=A1r=20Radics?= <baltazar.radics@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH] Add ethernet0 alias in Nanopi NEO's device tree
Date:   Mon, 31 Jan 2022 10:21:26 +0100
Message-Id: <164362087329.15921.5807470907175600465.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129154214.45629-1-baltazar.radics@gmail.com>
References: <20220129154214.45629-1-baltazar.radics@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 16:42:14 +0100, Baltazár Radics wrote:
> This is required for U-Boot to generate a MAC address for it
> automatically.
> (Without this, the MAC address will be random on each boot.)
> 
> 

Applied to sunxi/linux.git (sunxi/for-next).

Thanks!
Maxime
