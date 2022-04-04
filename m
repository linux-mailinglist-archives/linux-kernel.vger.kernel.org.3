Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DED4F1F52
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbiDDWt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbiDDWtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 18:49:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6830E5EDF5;
        Mon,  4 Apr 2022 15:02:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KXPsP63fqz4xXK;
        Tue,  5 Apr 2022 08:02:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649109770;
        bh=yiSBoGqlvTThDCgo44GBRLmKbS5VR7RXDH9cnFaLqjw=;
        h=Date:From:To:Cc:Subject:From;
        b=PrqA6zsXH4ZHulc64QKE2mrpHYvUCOX/M0JE2CPd6YXgCOKCy1IwiROLBoBf37I4T
         B3f8Ja5FOTWmVluq48I9txQOdQZdzifBqAl+g3HSPdOs6MmYzsT4P3PBA7rrVgOlRt
         SuztaR3QeyNO562PV9ecngdj8inPwFn/p9Dnt7k0UIvnt0KHQ6y/RMQkxSVWT6alvn
         3UmGCTT+yOkfhmrxGwwa15x22DCbn32fx6dM2vxxddgc5pHXrvwkSWBwsuNGvN+kkq
         Cn9U3s7q1R4pdueFOaVhZS9fkmPm0WjIuPY1wPJB6VelVxYCIeBO7mjRvJiA0elj38
         hHJgX2jRv4HCQ==
Date:   Tue, 5 Apr 2022 08:02:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the scmi tree
Message-ID: <20220405080248.1cc96ea1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ii6j=cnxd9AcAwkJjzz0Nyi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ii6j=cnxd9AcAwkJjzz0Nyi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  1b855727f915 ("firmware: arm_scmi: Fix sorting of retrieved clock rates")

Fixes tag

  Fixes: dccec73de91 ("firmware: arm_scmi: Keep the discrete clock rates so=
rted")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/Ii6j=cnxd9AcAwkJjzz0Nyi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJLawgACgkQAVBC80lX
0GwNMQf+PZP9kyrDhh2ACqGLNYabB8DfiHrnpY1NF7Mfg8iBxuWRw6vXODOtRl4D
PF/7MBE4Gy8CeGehcWkfcNn3GW6oFRtNot9ZtEUM5i3ZYF2tDpOdPRW+6QxgwVb2
iTmpm4PeWdds9x9lanWKdi8rhYeYhngYv+oHIeGYqR4U6Pvu2ZYTwB3zChDiUD+E
47Oz0//MJvCbpGUczFoPK0/gtANxNZWRJyZCb2fr4fBbPJypJHICq4WPOfS8uCzU
5sYwmim3zyzsKWXXLVLE2BfgITlLWz4hXQAnxN4Y5hwzVjJJIvgGJn86UGt3ozmo
tzLN51+PpL7GxACcRI2R4S3ya8XZTw==
=w/TJ
-----END PGP SIGNATURE-----

--Sig_/Ii6j=cnxd9AcAwkJjzz0Nyi--
