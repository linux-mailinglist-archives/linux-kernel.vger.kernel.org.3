Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE2F533FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbiEYPH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237638AbiEYPHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:07:54 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8316CF5E
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=BJEwSF0VFzzm4SSlTnqkx43Dx9ql
        RDdWcTyYt9+rs48=; b=SZb0r3wH7T3mcvIZbw+oFa9ylQ/zQI6xKloH8Z9oc2Sx
        JPSKIe5ZwFaoQyQKqR45jwHs0P7DYdfl9cyiNANSe9VuZWdtv/8obzMTBKxke17L
        fCmkGI1YN0WGIuH+jfqjZH00Z5R3beGiyI0KEHj27djoM72fSuY/NkiuIK/UMZs=
Received: (qmail 1642742 invoked from network); 25 May 2022 17:07:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 May 2022 17:07:47 +0200
X-UD-Smtp-Session: l3s3148p1@3K89b9ffqjtZD++C
Date:   Wed, 25 May 2022 17:07:39 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v8 1/1] gpio: add sloppy logic analyzer using polling
Message-ID: <Yo5GO5RkBC3PQLTg@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <20220329091126.4730-1-wsa+renesas@sang-engineering.com>
 <20220329091126.4730-2-wsa+renesas@sang-engineering.com>
 <YkRuXtTzd11R9IrY@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jFJpOaCzFEltHHpH"
Content-Disposition: inline
In-Reply-To: <YkRuXtTzd11R9IrY@smile.fi.intel.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jFJpOaCzFEltHHpH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 30, 2022 at 05:51:10PM +0300, Andy Shevchenko wrote:
> On Tue, Mar 29, 2022 at 11:11:26AM +0200, Wolfram Sang wrote:
> > This is a sloppy logic analyzer using GPIOs. It comes with a script to
> > isolate a CPU for polling. While this is definitely not a production
> > level analyzer, it can be a helpful first view when remote debugging.
> > Read the documentation for details.
>=20
> Good enough I think,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, Andy!

To GPIO maintainers: can we apply the "new-driver-rule" and still have
it in 5.19? There can't be any regression and it has all comments
addressed. Also, I am talking about this project at Kernel Recipes late
next week and it would be great to say that it is finally merged :)

All the best,


   Wolfram


--jFJpOaCzFEltHHpH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmKORjcACgkQFA3kzBSg
KbbzCg//beP7i2WnbH6i79F9nAkbYBPQG5FfgUWlX6KcFnSYmS7TMDuycfwGlOvQ
xG4PBt4Jq6Agj4t0tV2KXeQMkZx02aQPXJwmF4t/UK00UsaJicg6pLb1uwqKvWAw
5T5bZT91PTfZHeZP1Di0wV2rdJJNCDbFd4OLI+I+zI+wW34p76IXLRE4/8BOdSDu
AMgRosikUFLo+UnqLf9u3V9WsSlBUBemLlWdMFLf3i9Ze8XBRa0KtmHulpbVd4XD
YdrJQiq3sIpR+wNL4FxeuF6KetNanc0VmD5GawL4W05Jad/4u55OXbvMg01vF5SX
S4AIlkkZ5naP5s9Pzq0DlOrJty81A3zSldSxc/4qxlNyC66j5oIYu0SHm+8YL9T+
ohUrH90PrfDS/iqzT6oR6jxHkIh++h6rpP5igxTwQTEVgaPAmpcUfT3U6VEGgMEz
RUqGAohGoLNennpOqSc2rfoS4nPQHcamG3C3nuAeWCldGdFa4Zhfyjf9zHeqMnrj
LdsYhYaTfJV8zOf+ShxPfWhiWg0uLsX9nWbpTBg6374yrAVLydjZm1nu7f9dPjgq
4hbjIm6B3bjMpPFa3xA1uP33kf7+bl4P5v8LAQNByT5ZLgPWWl5czXhwBPeMxQpT
fi7m2BPp+Xo1yD7xfU6KHsHWvITFVAvu1tlGRvNmt3MGujQB0Yw=
=yfzu
-----END PGP SIGNATURE-----

--jFJpOaCzFEltHHpH--
