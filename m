Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FCB4AB7AA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbiBGJ1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344934AbiBGJYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:24:37 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAE2C043181;
        Mon,  7 Feb 2022 01:24:36 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id F0CBB5801A4;
        Mon,  7 Feb 2022 04:24:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 07 Feb 2022 04:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=iSknFfgihoz9cY
        jsB49tquH7M9oK6rXonBcNar0/E6w=; b=g06c28B6jZMt5BHIajzts1tMVOsqxC
        jd9VJqjCvqxWawTL04UEtBO402ejuO2BSppxfhK7mVpZDtWDHwYjSljNfJuEM7Nz
        ROEPvsrFj/y9Nj+RS6owvposXMs92XTRrEUNTgF7XA7zUxkZ4V9LlUFbA/cne7xE
        wFknzRrCOYNbooIIefbVEYPmFAiCtEphcDFpcfEqxu6Lb7hAkdidGxczqKui24LF
        jpYRaCPNqnSJUIfOKutuAwvXw3Rl8NSwLtKu0KxIl/y+HnA5WaPKFRMvoEQMCpCP
        HEmzcfJTGzKjduBVl+G6D7/lITGlLmm//A1I1YEHxBdOSbmnF7CgYdvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=iSknFfgihoz9cYjsB49tquH7M9oK6rXonBcNar0/E
        6w=; b=U1NT+MWLZ02mQOf8kBE+uK6kts+S3hxLpE3s9F/l9KARcbtBnkX24Dze9
        0nLSgthgM4jwzWQeg2ceeqN98JQmIgTwmAUeN3kuUsLsbC9ytF+8+zIP7aNZcoXr
        7rdrkMpLbm3lPxGj58ChTfGU1UH+wsAKRu3bJu5+/O3qbRMcK1Nt5xBqyf6tgQay
        nMbvZ11ZjtA8eTkwk8dMzEdc6Yaa9xcR2+v9Ok52pNSzeL1J1u8GdsdYoY1KyKoH
        zwrM8UW4grEHLGxcB5p43jwDT6LvU5XlsDI7A3MPGUciSmAmK+cza/GCH49KgNEq
        F1/H/vKq9TjZOse52afHeqLbTAVKg==
X-ME-Sender: <xms:U-UAYrtIwQgHFPDLxj7aSE8LhyJCOSMRhFSXzMak2ZkkS38Q2AnZLw>
    <xme:U-UAYscV_t-YFP4sAMikMj1PTrODEkbNC_71S2rCWe7mt3r8muudddDli-aZnLb-R
    agRmGjSfcJzjIxCZrs>
X-ME-Received: <xmr:U-UAYuxnlEN7l3AOzw-FLDOYfanDql-QHmgM4P3C1Vux9JVwKZsIHeCarqW12AnZ0GJR4srNMjFiaTWhrIc7oLhxZeiVFPUbFsIT2PQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvufffkffojghfgggtgfes
    thekredtredtjeenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvg
    estggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeejuefggeekfffgueevtddv
    udffhfejffejjedvvdduudethefhfefhfeegieekkeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:U-UAYqOzAdYqqOUabPejPK6EimsjHVm5IoKEm3U65YxSM92QgGQXbg>
    <xmx:U-UAYr-ypdbGSOKY6fGtF9fOWZgG6FvEfpbpe7CtxfgQncI4cD5axA>
    <xmx:U-UAYqVRHy5_7nEa8vahYdXNkEwxhxcQgzsTDUixHv96wQJzPVVz6w>
    <xmx:U-UAYmf9k2mUC6x-QrtJd2Lhz-x1iKtyulTQ34erSqwk9rkJCiGSXg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 04:24:34 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Maxime Ripard <maxime@cerno.tech>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Helen Koike <helen.koike@collabora.com>,
        Yong Deng <yong.deng@magewell.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: (subset) [PATCH v2 01/66] ARM: dts: sun8i: v3s: Move the csi1 block to follow address order
Date:   Mon,  7 Feb 2022 10:24:31 +0100
Message-Id: <164422586926.25686.14643523821893289727.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-2-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com> <20220205185429.2278860-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Feb 2022 19:53:24 +0100, Paul Kocialkowski wrote:
> The csi1 block node was mistakenly added before the gic node, although
> its address comes after the gic's. Move the node to its correct
> position.
> 
> 

Applied to sunxi/linux.git (sunxi/dt-for-5.18).

Thanks!
Maxime
