Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC4A5ABEA8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 13:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiICLMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 07:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiICLMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 07:12:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE576B660
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 04:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C02760B26
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 11:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805DAC433C1;
        Sat,  3 Sep 2022 11:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662203523;
        bh=+UvzqH1QDFPmQPVn1gryZ3anDIwLfLLPp25gCyAKngk=;
        h=Date:From:To:Cc:Subject:From;
        b=kwVco4vrevgzAcgyTdJZVjcSgZDEG+VtnkceWDBGB+Fqfp5LJOdwqRMw4pAfoRnNh
         r1OZxqbk5JFonuURh9KERKlOC8jQzl+3SH+26WnmQl50O50dBPgnX9In/GUOAMA784
         yVRzLeZ7bluqoEQLfff8bESAGTOY0sROP0AjTq9n8FhgLuUxi9vwCLHo8njyeNK5Vy
         dykuDuKdbH+UJna9Bu+oxbcrQc0h0V7K4KK5lO+kjFCdJu7uK+kuoLEqJ/uer+xZ2H
         Td9onCZ8fvThhsA3771mTZ4Gtg7mTPmZ/rQJbBRzCxI2hZd+ZJ7hLaFPSkMdOhAl8A
         GfzFc53XpR2LQ==
Date:   Sat, 3 Sep 2022 16:41:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Phy <linux-phy@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy fixes for v6.0
Message-ID: <YxM2f3BCvYm0tvWt@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ug023SCU/+hnlU35"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ug023SCU/+hnlU35
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Please pull to receive a single fix to marvell a3700-comphy driver which
fixes broken reset  in the driver

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-6.0

for you to fetch changes up to 0a6fc70d76bddf98278af2ac000379c82aec8f11:

  phy: marvell: phy-mvebu-a3700-comphy: Remove broken reset support (2022-0=
8-30 10:32:33 +0530)

----------------------------------------------------------------
phy: fixes for 6.0

Fix for broken reset in marvell a3700-comphy

----------------------------------------------------------------
Pali Roh=E1r (1):
      phy: marvell: phy-mvebu-a3700-comphy: Remove broken reset support

 drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 87 ++++++------------------=
----
 1 file changed, 17 insertions(+), 70 deletions(-)

--=20
~Vinod

--Ug023SCU/+hnlU35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmMTNn4ACgkQfBQHDyUj
g0ccmhAAyi8YWvbZPRthVfdGq0nQ2DcvZAooBdNYZwpJoEPXFDUF8I8qL+GrshJV
VEOZERZpINOvijaPMQKznxvd0DSI5nlABwQLFCgwm0bN28Lf2lJzSL/Veq+Kb4Xk
pEiW1AVgnuUDnmdBECuYYLGyeue7/q11M04vEEXiJcFs5mxqLURSEM0Lr+hbcFHb
HrMRhlISBrEQZ6oKcwg3uwscpS0MhLQBaOAV/mDmBCsZj3WMavRnAo3NSBX51HfK
DFE2nSFbAWvPo3Ov/7WbEu25pMDYBhHh9/aV6SWSkrf58RthZUMfF12bdFALYnp6
1JsCLzmjY7ZAmfE8kFMv4pEXXqPYfElfsLv8w3pD4mo199whucOBLWz49Nur2Kx5
FlWWBlVF4GyO2f2Z/+/uHPS85qSO4jpA6z1Wg+uApbMKYhYD4HZC9M08g4MCd5J4
TrfvmXLMuE9qNyNeD/KC3AOW9xry3fW9uFzXXjJYyYNalRLFAuS7aCR8bLDaoGSi
zO1frvdTCaZC8jL+9WlmkfLVCR2Tczy27DSINiM80E9I2CFNah7D6thNUEPEm4yc
Mip6uZ+jnq+CPMuQLwGTG906+8A1zKMGXA5iHqcOPLJMMHFecA+2CHAs8hWklIvB
qMGe2G439PfV4A5DZhupWTqIiHCJZZ7d/yc6Kge8wFL1ZPhDx08=
=nCmi
-----END PGP SIGNATURE-----

--Ug023SCU/+hnlU35--
