Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFEE4AA813
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 11:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379687AbiBEK3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 05:29:00 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:59569 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233088AbiBEK27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 05:28:59 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 893B73200BD2;
        Sat,  5 Feb 2022 05:28:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 05 Feb 2022 05:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=kDIVNzj7Wmv2um
        X4p4+USo9n563udVzIVi1lCU9eBZc=; b=hdDALldVe6+S/QPKYThCWr9wp/sddm
        ozGHp8eHCO+O+3eyOxcuWnVcaHVU0btXIBy5wmMvUuZp1byAzP4MVm0xrplNwyr5
        ChBJEVr4XEcDAUuaR80u2auxRRbm7n9ozIJJrbatdaeLGuOQOMc9Kkin5z/mEo/b
        Nhuu2YaBk9MV5V2VrhOXoO0M/YoPMXjWr6YruYGrMWZlGm933yLzl01qWzokmWiL
        5m9A7SQwVqU1YeaZrU3XOwwT3Zhls6DoiFVW3b22gIzlYkfZu0JKi1WyxLuiIN5r
        nhWdM+bfNI5Zt0ATUtbVpWvZs6wFKH7ZDQgo9WuEXd/hBCanQC4qAIwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=kDIVNzj7Wmv2umX4p4+USo9n563udVzIVi1lCU9eB
        Zc=; b=Seku+8XrNnyp/Jl+m462wmfmYKcsMxjPAshO7AGHuhsFz0frJVC3YBT6w
        SWmO4FKUBharAWxlDG1nVzEoAyHlLcfURlhqRMjfJe7xCp4HkhpxDVGS1Lfg+qx7
        kGtJz0EXTlPe5909vYZx7pB4356I00ICm/pncsI+YFwQB9celWstwhONrW2s0t/y
        9Bg4I4eNUTLoieCt9McLkDkCJZybYdKaDOfumHr7H1tH6pACJAfPwH/5ntw4DWZF
        sXJPH3PPxu1ugdxlbu5ml+1hvw9Ox6Lfd/dsHGb4DW6+CaQ/dqAPOkX/7FtC1euE
        aklyppyMvZt/V505WlSpBSrh2JDlQ==
X-ME-Sender: <xms:aVH-Ya8lU-te0HbneRWha2h86S8WIjZ0XWDdvyjrdm5h_trw-zeOiw>
    <xme:aVH-YathjK3Jteh-eNMxNYbp_i6OgU1EwMWOdhMq9qsUK8cwLcysLEBe_riyeIVFQ
    aD0EXTQZ-bjKTXWcoM>
X-ME-Received: <xmr:aVH-YQCQiU9jhIYug_i98FdGdZIxXiVIZx_yWhJlp93czYNyaPWqDQfYuzJhjiYJaPuyF1Ol0YEd1at0vAZ298DYsaA7sQHBCq3c2dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrhedugddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepgfejjeekjedttdethedtfeelteefffduvdevvdfhtdeiudetleejgeelfeef
    uedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:aVH-YSe81XnDWXCNubtmtEbXYS8ajf5nVZyAg6RRtgk_Y5G2oz1WYg>
    <xmx:aVH-YfPqQ2kRi3_Nmf3zsJI-nMsz4flxH-2BL5P0qxMcn1jbkzVBbw>
    <xmx:aVH-Ycn366n9gyzlkRLv_7iNmnC-irmo95TlKSYVRk_5u90OC2FMnw>
    <xmx:alH-YaesTX34_qQChH6ZwNwT0Uq0xAy6ZDAOgDz8VmS_wOCsY-QCnQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Feb 2022 05:28:56 -0500 (EST)
Date:   Sat, 5 Feb 2022 11:28:53 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        mchehab@kernel.org, wens@csie.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: cedrus: Add watchdog for job completion
Message-ID: <20220205102853.54wcmxzalb7uj7n6@houat>
References: <20220201183324.493542-1-jernej.skrabec@gmail.com>
 <YfztZE8ymJ5RERTq@aptenodytes>
 <12946098.uLZWGnKmhe@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <12946098.uLZWGnKmhe@jernej-laptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 08:40:21AM +0100, Jernej =C5=A0krabec wrote:
> > > +void cedrus_watchdog(struct work_struct *work)
> > > +{
> > > +	struct cedrus_dev *dev;
> > > +	struct cedrus_ctx *ctx;
> > > +
> > > +	dev =3D container_of(to_delayed_work(work),
> > > +			   struct cedrus_dev, watchdog_work);
> > > +
> > > +	ctx =3D v4l2_m2m_get_curr_priv(dev->m2m_dev);
> > > +	if (!ctx)
> > > +		return;
> > > +
> > > +	v4l2_err(&dev->v4l2_dev, "frame processing timed out!\n");
> > > +	reset_control_reset(dev->rstc);
> >=20
> > I don't think playing with the reset is the right approach here.
> > First we don't really know if the reset is shared or not, so this might=
 have
> > no effect.
>=20
> AFAIK only few reset lines are shared in all Allwinner SoC, never for Ced=
rus=20
> and even then, this is considered as HW issue. So, I'm good with using re=
set=20
> line. This principle is also taken from Hantro driver.

Also, we got the reset handle through reset_control_get_exclusive, so
we're guaranteed to be the only user.

Maxime
