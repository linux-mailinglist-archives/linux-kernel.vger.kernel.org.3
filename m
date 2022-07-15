Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713EA575A90
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 06:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiGOEsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 00:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGOEsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 00:48:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D4F63914
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 21:48:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7265B82A63
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923F3C34115;
        Fri, 15 Jul 2022 04:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657860477;
        bh=g+KJyiSQWpqbUdFfXHyoIJVfzv33K9nGlIrsNPhu8Cw=;
        h=Date:From:To:Cc:Subject:From;
        b=jCMVyzxNdlcuMT2uW/abxxhZQ0wFmNqbg2645KT9/VWW/NsN5bIGYpVE1wzvFK48Y
         mI5vsSjGF6FkmRGsQVWFust+VUNyofGVSyq4F45lEC921RMoCz4wpwyjKGgOD8ooY3
         qsAsRNECXRFNSvrQTHu4XzNFPy9CE1UyKoW/wXW8xp0TDYjqwTCAK6zvTJxslcEMGJ
         mQZXChum88hnlnAvwVVLmkYlgXcD0XWSNkyFKCH6DTj3aDUeIN4JAbtdpfHe3LGCIM
         S7aW9g39YlsCB2+hE0vlES6BIzZsjI+nZQ0hEqVCoMNcXL3YdU2QNiUWGigy1LN2MA
         2MCWT4iNY06BQ==
Date:   Fri, 15 Jul 2022 10:17:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire updates for v5.20-rc1
Message-ID: <YtDxdBLgvAHG8IhG@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aOaSVjP4MFDG0xT4"
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aOaSVjP4MFDG0xT4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Please pull to receive updates for soundwire subsystem. This is smallish
request this time but few important changes:

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.20-rc1

for you to fetch changes up to 3f4a70268d54c41117bc4e1bed0ba4be756735a8:

  soundwire: qcom: Enable software clock gating requirement flag (2022-07-0=
6 22:14:51 +0530)

----------------------------------------------------------------
soundwire updates for 5.20-rc1

 - Core: solve the driver bind/unbind problem and remove ops pointer
 - intel: runtime pm updates
 - qcom: audio clock gating updates and device status checks

----------------------------------------------------------------
Pierre-Louis Bossart (4):
      soundwire: bus_type: fix remove and shutdown support
      soundwire: revisit driver bind/unbind and callbacks
      soundwire: peripheral: remove useless ops pointer
      soundwire: intel: use pm_runtime_resume() on component probe

Srinivas Kandagatla (1):
      soundwire: qcom: Check device status before reading devid

Srinivasa Rao Mandadapu (3):
      soundwire: qcom: Add support for controlling audio CGCR from HLOS
      soundwire: qcom: Add flag for software clock gating check
      soundwire: qcom: Enable software clock gating requirement flag

 drivers/soundwire/bus.c       | 75 ++++++++++++++++++++++++---------------=
----
 drivers/soundwire/bus_type.c  | 38 +++++++++++++++-------
 drivers/soundwire/intel.c     | 18 +++++++++++
 drivers/soundwire/qcom.c      | 32 +++++++++++++++++-
 drivers/soundwire/slave.c     |  3 +-
 drivers/soundwire/stream.c    | 53 +++++++++++++++++++-----------
 include/linux/soundwire/sdw.h |  8 ++---
 7 files changed, 157 insertions(+), 70 deletions(-)

--=20
~Vinod

--aOaSVjP4MFDG0xT4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmLQ8XQACgkQfBQHDyUj
g0dhIg/7BVHGyfvwJJyyw8FgAjqhOfI0zCDj6ppUWjL8HH0ONnPt86JrnApIyFoT
0YyTBjNVXi4mGzYwZ0ww1Pv2DqR161VUXHgBxev39ISqztG6xGr9FvVYqCOwdkvP
ilR4nxkFmdALeuPRJFz6dgcBndQY8lcHfmvsnHjwS7mOVgpgXpjg6hIkJB+tE7u0
Cx5et7dU9+RzBNQVoiKSn791WRtU6JkvkzaANjazOIe9/CmgHnVzXeomngb5RNqZ
7vHkta2gLqNcftm821JL0cCkSg8UIxSaS/3f20Oo0q5rHo1iwmfif9nepbb03dyD
5yunf2OznX7cTZvXEQRGSUa7VWEKzzPC3riCSdJLHjcYsod+8ef6vgZ2huchb8yE
2aOLrZi6z0MEcfZX9bvUHaDcrCDMEFx08cGtUnzIxvZVTmnRaO6yMCrIZ/gDI27r
xmkAxz45xUzhhHEjZcXZu1tSdMGCM94/eK0VPyKW3iSh4pm8wRPSh8XWFTG7RK8q
0wyvFk3Sx1RpKjp8jHTgp9H+fjEWrDxg8OAtqiHyyhMO/Z9sJcJ7fUFlHAx//vA2
Xp7nCP4NDSAstMHYGF/2pGBvu5wVWZZ0cEDp8wMcsKNdDbKoOjvMZJjCtRL9Rnql
Ikz1ERSD1OxEOOQso7gr36/HcLwsvXUregjV6fgZrMBitB+i2XA=
=Jrww
-----END PGP SIGNATURE-----

--aOaSVjP4MFDG0xT4--
