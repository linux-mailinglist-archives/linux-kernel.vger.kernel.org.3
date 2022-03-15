Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D499C4DA289
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351115AbiCOSlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345461AbiCOSlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:41:23 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5888E593B9;
        Tue, 15 Mar 2022 11:40:09 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 821CC1C0BA4; Tue, 15 Mar 2022 19:40:06 +0100 (CET)
Date:   Tue, 15 Mar 2022 19:40:05 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Clark Williams <williams@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 4.19.232-rt104
Message-ID: <20220315184005.GB30901@duo.ucw.cz>
References: <164642254363.3441070.3803906129050387693@puck.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <164642254363.3441070.3803906129050387693@puck.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm pleased to announce the 4.19.232-rt104 stable release.

Thanks for all the releases. I believe there's tag missing for
e9e0405cb34e459b713ed0aca4e3ab5ef61f540e aka 4.19.219-rt98. Tags are
there for for other releases.

pavel@duo:~/cip/19$ git show v4.19.219-rt98
fatal: ambiguous argument 'v4.19.219-rt98': unknown revision or path not in=
 the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
pavel@duo:~/cip/19$ git show v4.19.219-rt97
tag v4.19.219-rt97
Tagger: Clark Williams <williams@redhat.com>
Date:   Thu Dec 9 17:04:52 2021 -0600

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYjDdhQAKCRAw5/Bqldv6
8sSIAKCbv/V96cG8QKwO8wQWQz1K6bOBIwCfXcSMCChT7k+s4Wf6ZmTNeTV5dZ4=
=bjOo
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
