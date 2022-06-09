Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681AF544EDF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbiFIOY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343921AbiFIOYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:24:03 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C842FB41B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:22:56 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 036755C011B;
        Thu,  9 Jun 2022 10:22:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 09 Jun 2022 10:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1654784575; x=1654870975; bh=o1EHRu9B5r
        k/WJhXMZ6K6RF0/qjhNtzzN+6E8T1siOo=; b=NUfsB2MD6ihZHxnJKxHNAQUsUp
        HjTpVx4fQ3eRbuek5IPhMlYDJtpqK05T5lC5mM/A2aPxPFdlRWNtf1dU6wHgRYr8
        tXYSCjYzEKOAipK44Bu5NW7hO45/xWybAaAMEy+rcQ6B/FOUZPnitmCLMmxHAEZZ
        106V8Xez+IgY3vS/te34A2F/3G/8n2Ln+kBmjHMNGOJ3OXMOxQO5NHxuHea/aQII
        LKCHSDWlYqhhuoaTPNekpztQmreqi0AcBiEiv8joYDlFTvITGhjtgxy7pac5cNWn
        VJtN5nY/01mKhGOC184/hVz+HW5dRImaQT0FrWrrnLT1E3TyxchJHOLsc4/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1654784575; x=1654870975; bh=o1EHRu9B5rk/WJhXMZ6K6RF0/qjh
        NtzzN+6E8T1siOo=; b=CQr4buNAoSbF6tCRfZM/AUcWyK2nOEJD6qkoWmliYJYD
        2WI5jOqNnKYw81Pc8WIlPyT/VKNCOou8ily9SiteI5vFufJ9X0eiAhVvzGc4H1Re
        6RvFt1m9I8bILznTzJ7itE1Uu/sBwfIuQKjYRvH+JqtmD2+nVjK3071N9p4V/y5B
        3exHdOF1tRk/K9u3swcvXguqagOcCWJHHBz5W3PmRJAC3ZRy0ZywlaS694X5ZWGv
        8s+a5bGSAcKw6oYsB8l8rg+1K7/GXLTBQI0v1f7KhKdrC7P2eC7vofQ3vplXUx93
        kVfL9iKReIhEGmw+SKRWVEsXzR3myzjZuCvOi0pK0A==
X-ME-Sender: <xms:PgKiYvnpSGDQiaJQ-BherlQL4csXWub9-fk09muagPVzSXL7hYzFSA>
    <xme:PgKiYi1xw2gj2dLGXjNyUIDfMJZGCqE6QAqVchTFzIXx-hgp76jmg-MCTwlRTsihD
    hEOS8ZkI8oEPl5GZH0>
X-ME-Received: <xmr:PgKiYlr2wYV5rtVLF0iCwkGLh2hQC4PtNaGHWy1OnwuScHnZpAT8UfsjMnCeEEt_lT8kCQ8kx64e1tughrFtPdJZ_u8DDrkxF9Bh7as>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtledgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetfefffefgkedtfefgledugfdtjeefjedvtddtkeetieffjedvgfehheff
    hfevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:PwKiYnksxqKut4DCbF23BkpLQeg4jt6CeFb6Z0O7_Mr2x6GmjSaLAw>
    <xmx:PwKiYt1pJYQcC_QAvPhioNvvXfpXZpd7Ipn9uxBLmUR_EZ1nTnSJAw>
    <xmx:PwKiYms9rZ8QeA2JXN68ue8LS-e65_F6U_w8Q_wwUfMiBlMpbzI_EQ>
    <xmx:PwKiYnq_mBQIJatXRiW-xWIGBl4x1M9YMRAHZe8SBE3h8sDQ1ASecg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jun 2022 10:22:54 -0400 (EDT)
Date:   Thu, 9 Jun 2022 16:22:53 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Saud Farooqui <farooqui_saud@hotmail.com>
Cc:     jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, wens@csie.org, daniel@ffwll.ch
Subject: Re: [PATCH] drm/sun4i: Add return statement in
 sun4i_layer_format_mod_supported Add a missing return after the
 IS_ERR_OR_NULL() check in sun4i_layer_format_mod_supported()
Message-ID: <20220609142253.7aad4jlaoahqkmy7@houat>
References: <PA4P189MB142180104916392C559B44308BA59@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pau22cvielrudrtl"
Content-Disposition: inline
In-Reply-To: <PA4P189MB142180104916392C559B44308BA59@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pau22cvielrudrtl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Jun 07, 2022 at 02:51:50PM +0500, Saud Farooqui wrote:
> Signed-off-by: Saud Farooqui <farooqui_saud@hotmail.com>

Your patch doesn't seem to be formatted properly.

The commit title should be much shorter, and the commit log should
explain what the issue is, and what is done in that patch to address it.

Maxime

--pau22cvielrudrtl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYqICPQAKCRDj7w1vZxhR
xY0uAP4yFkFuPx+QhUwoeXQChX42nSHYYKQzaiiHP57iWvmKZwEAy4n3+I9JSRKm
0sGsGa8eWevNsiB22zOUiDwpFvY+3QQ=
=56V8
-----END PGP SIGNATURE-----

--pau22cvielrudrtl--
