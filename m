Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75821527EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbiEPHxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiEPHxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:53:34 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D99275C3;
        Mon, 16 May 2022 00:53:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B95C63200977;
        Mon, 16 May 2022 03:53:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 16 May 2022 03:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1652687610; x=
        1652774010; bh=3pNP4lkw2arx3DEO7xosFHza4XodA+DQ9cP0mdORw0E=; b=C
        BY8RdDlTi9S5yAqghIBhAvsJ9Z9JFnZ15BnqDgi3fXaCsVVE8zAQcrPqYSEqVPUr
        McRqjpR3HMHvzfmYwlaV9knOFEi6n3unw/xN7cvKOiUoOTfpoSV8162qLqMiPm6b
        vJ9QzlSpUWdWVoMZmA8oyRJ7xDlyw3RnZ27ZasILubYkkmImgdk7FPymC1kWHQdS
        0x3+CcekhI3VnxEg0rwC+ug9oqPfjLmaleCiVEVGu+h3I4SyoHgsFZ2UyQhB1jM+
        Lwh5bpToWDOfni9t8XYnRGWJjIWP8Pkace6LWg54c+L+VeE3tkXnukdjAdFyi3CQ
        GnadUJeA6VRBemwOvknOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652687610; x=1652774010; bh=3pNP4lkw2arx3
        DEO7xosFHza4XodA+DQ9cP0mdORw0E=; b=AoVri4LT+R1c9JiAgs8nFEvz2EMnz
        pW3sOudgVIzUPEDYAIVj3ak1WInoKUHfjp9QcvNsGV4ozJSPpkEMRFm/PeC9pR8C
        cqICI/Y9H+LCo/Ev0wY1XQfEhYApEkScBGYoW3nI75gSCS2lxu3r8jYuCZDx7EFy
        iP4GSNxaiPFj81RAfCgwx2szlCRjMQ+hU7q0QtbWOCIcRLTd93Mf9RiylFvQAC2o
        uUK9rolMTv1rBJT7JyYKpmWyYFpzxTmHWC3E8w6Z8Xi7omhWssNmq7NyEnuujKgZ
        DuZ28CKPS81mghPMpc0nBXHFiAdR5/7l1Dw2jmbDn6IC9AIK/y0Imsqgg==
X-ME-Sender: <xms:-QKCYhPOhCiLS1TKae5X53vLPuM3XPCzDyAcTMXqNMu4cszIRAHZPA>
    <xme:-QKCYj_sKk3UQpp3LSXTl7QTsXlcAvLGqDEtd6jMfk_u4jAxe0PBdQxruBAQXMQR8
    vxOFvI2c4amf7z8PVk>
X-ME-Received: <xmr:-QKCYgSJ-86RwrBARaKK4nZ893pmBsUl5YlbDihst-7CBMMfhASX4aDxbXqc6_zlSWGVmhxDnhKuCCe4kDmsPcDm7obyDXb0FdV5clM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrheeggdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnheptefgleeggfegkeekgffgleduieduffejffegveevkeejudektdduueet
    feetfefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:-QKCYttaxirpg-hdWnyu-dyUWzq4YVacRDIhbht6JN_YlsQovPcDZA>
    <xmx:-QKCYpc1PVQApPVPXR-xj9FnSw-SvyshlI3IwUWhBckDxDmiLmFx2w>
    <xmx:-QKCYp0XULYlGOnJUub9T3OIGlorP2VqRz0nf-znCN_nSW4qwFSR-w>
    <xmx:-gKCYl7oY9G4refKfxe6WqEOsFFKSkat5VQ2oeC82DI8LrXWx9AEKA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 May 2022 03:53:28 -0400 (EDT)
Date:   Mon, 16 May 2022 09:53:26 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     qianfan <qianfanguijin@163.com>
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ARM: dts: sun8i-r40: Add "cpu-supply" node for
 sun8i-r40 based board
Message-ID: <20220516075326.hccburhu743t7p6r@houat>
References: <20220512071858.10805-1-qianfanguijin@163.com>
 <20220512071858.10805-2-qianfanguijin@163.com>
 <20220513073849.cu4jzykefat2sepg@houat>
 <1352b9d7-5219-af09-948b-6462def39ea5@163.com>
 <20220513081556.knd3tf6pangfblh3@houat>
 <666ead08-af1e-81f5-6fe1-e5e3370e6d6f@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <666ead08-af1e-81f5-6fe1-e5e3370e6d6f@163.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 04:23:20PM +0800, qianfan wrote:
> > > > There's a similar issue for all the boards that don't have a regula=
tor
> > > > in the first place.
> > > >=20
> > > > The way we worked around this for the other SoCs is to have a DTSI =
with
> > > > the OPPs with a frequency higher than what U-Boot boots with (1008M=
Hz?),
> > > > and only include that DTSI on boards that have a CPU regulator hook=
ed in.
> > > Is this really necessary? It seems like every board based on sun8i-r40
> > > have a cpu regulator.
> > This probably won't be the case whenever someone starts a new design,
> > and then they'll face random crashes for no apparent reason, and waste a
> > lot of time in the process.
> >=20
> > Whereas the alternative is that you would be missing some OPPs,
> > something that is fairly easy to figure out.
>
> How about remove the OPPs which greate that 1.08G in sun8i-r40.dtsi,
> If some boards want to run at a higher frequency, can add them byself
> in the board's file.

You did all the work to support and test them already. It's a bit of a
waste to do that and not include it.

Just do a DTSI like we did for the A64 for example.

Maxime
