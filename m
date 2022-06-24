Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F94559C88
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiFXOiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbiFXOhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:37:34 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32C262BD3;
        Fri, 24 Jun 2022 07:37:21 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id EBCB25C01DF;
        Fri, 24 Jun 2022 10:37:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 24 Jun 2022 10:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1656081440; x=
        1656167840; bh=IKWmuaxZq4W64nFRyrLCp+/X6vkuOhmxO1SDK/mCoGw=; b=G
        ciuFDNQOVZWZNf/MsIVbROxou0+uYeGJgQSf+2KL//CLqgGzjLHFqsovAHW4K+Da
        MBpKFakt8hvQ44dS5KAamiZcbl8wpWNTTMgtfpAW9VikpyPFrHlU5TuYBA164/DC
        Xs9yh1cjrO9Sg4YIparin9G4NjjMyhb8pM0IDB49NVfcNwoCDWhw/8Cej5riwQVP
        scgUMEU0vPkQwZHthLRochUVq/sE0WR1C2XqROzldUob18g5ZFtfAvf7mlZpmqdE
        gkF1P9zi5E94lfBbumGph0rcH11AwFmeqDZiksBLiZIdEYef46K11R2GCDuhU1oi
        h2QfnchtLFProKQ+4fnSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656081440; x=
        1656167840; bh=IKWmuaxZq4W64nFRyrLCp+/X6vkuOhmxO1SDK/mCoGw=; b=I
        nRefOd3qnrybrmc1Ankhn19pPD9vIEBED6bPZnBRhsIoMAGa9Ot7NQTssBDgvvn4
        HmbqYou940DXRCgR5fbVOvyz1hfSplfaEqxP3STEI0+vtE4YFnyjhoaXrb5MrruV
        4iGdQDqD5h+4mQz8uEhiM5r8HbWharRzjFyRFJdv0y647D8VhonSkXseZR/rB8eS
        qZ1AM1bGzXtam6m9oxSZ61jCbr7ocLcl+UzSOgIE3P85afKP9hyHI4tuu2YROZ3J
        mn2PtoxuAfAdrj0rtx6DZY484ICrRDuXaTAZJ3nHQoqlkf5BHCyHNm8z4NFXwPTR
        3d1q+fomOOyGOflPfLuyA==
X-ME-Sender: <xms:H8y1YkbJKqOle67Yx_5AzqqIjUvofC0HIBe2IczfUqtlM1gM-pliZg>
    <xme:H8y1YvayinKkRYTIXUjYffS75pPcw6sra23xubjSn5otHgSrVElOxeAsraiR1dMSe
    gRjhK8p92DC0gc89PU>
X-ME-Received: <xmr:H8y1Yu-O_6dXhBpzcbD4YCmyb07L5aK2L3MGZ4II4xeWzj6r_cmi9Z7I4oT5Huk0IT0BmmFNBqs6VogIkTaTwjeCOxplHX7BBvJ-Rew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefledgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnheptefgleeggfegkeekgffgleduieduffejffegveevkeejudektdduueet
    feetfefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:H8y1YuoBcm3gsEdDnv5E6akUT79k5cJvLvrOMsyzP7z-OkbpC9Rg3g>
    <xmx:H8y1YvrQPvP36SVb-Xe19tHeWut8tDyHQAfIC5yyQ73UIjyY12rb_A>
    <xmx:H8y1YsQy3vQcmTEoyozfbbrp0QX3PxBlCdLfuFWdgfCKww6NtNNqog>
    <xmx:IMy1YgDvJymNt3qrxI2L2ELBRvyhXSMfQJpdXHuXQ0gfXmJBwi7u6w>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jun 2022 10:37:19 -0400 (EDT)
Date:   Fri, 24 Jun 2022 16:37:17 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm: logicvc: Fix uninitialized variable in probe
Message-ID: <20220624143717.tykkcznvzq5e5qz2@houat>
References: <Yqh6OfSiPFuVrGo4@kili>
 <YrXLrVUIavGWC4sx@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YrXLrVUIavGWC4sx@aptenodytes>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 24, 2022 at 04:35:25PM +0200, Paul Kocialkowski wrote:
> On Tue 14 Jun 22, 15:08, Dan Carpenter wrote:
> > The "regmap" is supposed to be initialized to NULL but it's used
> > without being initialized.
> >=20
> > Fixes: efeeaefe9be5 ("drm: Add support for the LogiCVC display controll=
er")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> Nice catch, thanks a lot!
>=20
> Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Since you have the commit rights to drm-misc, you should apply it

Maxime
