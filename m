Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BAE4E802E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 10:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiCZJ1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 05:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiCZJ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 05:27:17 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1D6427DC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 02:25:40 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C6AFA1C0BB0; Sat, 26 Mar 2022 10:25:38 +0100 (CET)
Date:   Sat, 26 Mar 2022 10:25:37 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel test robot <lkp@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Unsigned emails from Intel robot was Re: [linux-next:master
 9122/14381] drivers/leds/leds-pca955x.c:149:19: warning: unused function
 'pca95xx_num_led_regs'
Message-ID: <20220326092537.GA8704@amd>
References: <202203260634.OFB2IPFf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <202203260634.OFB2IPFf-lkp@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey robot!

> FYI, the error/warning still remains.

Could you please sign emails with real name of person responsible for
this? Was there human writing this?

> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

I'd preffer to credit human if human was involved.

> >> drivers/leds/leds-pca955x.c:149:19: warning: unused function 'pca95xx_=
num_led_regs'
>    static inline int pca95xx_num_led_regs(int bits)
>    ^
>    fatal error: error in backend: Nested variants found in inline asm str=
ing: ' .set push
>    .set mips64r2

This sounds like an compiler problem, not a kernel problem, right?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmI+3BEACgkQMOfwapXb+vIz3wCfTCgWpO4WqMqLtapjf0br4Pfl
QI8AnRo7F+w0K3c41XdBy92riVz2L9Vu
=PEiz
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
