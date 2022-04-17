Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C504B504851
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiDQQcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiDQQcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:32:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1542ED40;
        Sun, 17 Apr 2022 09:29:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16A1CB80B52;
        Sun, 17 Apr 2022 16:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CA0C385A4;
        Sun, 17 Apr 2022 16:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650212979;
        bh=jNaiYWXoDSpUF7xdbp7ZhbnJyOJIfm1Fz4slt4TBZFQ=;
        h=Date:From:To:Cc:Subject:From;
        b=RZsACDGUZ0W01+9fbWQQ4Ajf1OQzkHmIv4U33cKUXvB1nF137fr7apvdpbdZt7w+2
         dm8WRWaJJW7z2sna0NvU3VP24I2T0Y2aSin1XUFGVpLhk2rUyiq2J7ix8o2rCjT0Gr
         d5efBxPOd0iyv5bjD/3/RLzY8jwUl/qF011sRF5i9fVYgfvBCOHahGCqg9VUXibMHM
         IXX0yAWw8DzeMwXua8jYdTgu99SjQxrHGhjma3ik+0TGhjnsCy0euqfxlI8s8EA1mb
         x72tnDZEXoED3ZBhFrvrKB0Ecx3E+His4qNN0/PkpRLEFPwpcb+wXm9VFXL/vvk8fM
         ROWg9GqIC8krA==
Received: by earth.universe (Postfix, from userid 1000)
        id DAD2A3C0CBC; Sun, 17 Apr 2022 18:29:36 +0200 (CEST)
Date:   Sun, 17 Apr 2022 18:29:36 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 5.18-rc
Message-ID: <20220417162936.zqxxjmfpdut34qjb@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gxgqls4pt2jpholf"
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


--gxgqls4pt2jpholf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.18-rc

for you to fetch changes up to 581045ed5cfa42ed7f5364d6ccbcb6fcc077ffcf:

  power: supply: Reset err after not finding static battery (2022-04-13 12:05:22 +0200)

----------------------------------------------------------------
Power Supply Fixes for 5.18 cycle

Regression fix for the 5.18 cycle:
* Fix a regression with battery data failing to load from DT

----------------------------------------------------------------
Linus Walleij (1):
      power: supply: samsung-sdi-battery: Add missing charge restart voltages

Yassine Oudjana (1):
      power: supply: Reset err after not finding static battery

 drivers/power/supply/power_supply_core.c   | 6 ++++++
 drivers/power/supply/samsung-sdi-battery.c | 2 ++
 2 files changed, 8 insertions(+)

--gxgqls4pt2jpholf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmJcQG0ACgkQ2O7X88g7
+pr3ExAAlAjqE1l5FAHX8D4My6duJFaxuwOW8IpM/CsPsbD6jebC63TNbsiZ8gQe
kk6kslly2T0jD5N76wmNz8Nj5u2yVZbBen0kbyUJT33kgE0ccqwkeG5NPhTFX2km
powIK94uEPkhm0C4yQmN21S4mMc7w2fey3rWR3if7una5HUJMlds0S69G4WL0iBJ
3gn3DVDUTsPAPHKkH4hIagwfKqNMRkGgBHrxbbvKGV+xcETA2aU2GlBc+j1JqD1s
GqprtulnVb64u+azd4DXSC0lDhv/Rw0EaoMcpph81xVJhLq+HLtUWqgINlSkK8Ga
svpM2RK/ZEEOo1Zl8PchOv+ysaTEJLxicV3yIbgjrUjgBtkgZpX76DkiADi2QWp3
QvfDagZM+JaW810x9n/Mtf1bTKObxyUg02lNrhRw4Nc/WM/+h1rfh7EDZbOtIJcJ
vNyT0qk7D4wMpJXEdhCUeTEO8resSJzGhMKaJcoxCJzFksUiDxJAxuQNlOfEkNg9
+8hZ/zmcYbt2rEs9b46FzFcUB01Xvm5JIcUPj9EUdmMdmF8xMvKNzCcAPLNUsf9P
faxRC7zCXYEYE8GJM1hlU2KKaJeETKmsFyg7V/RkPCP22YepQAZzCyFZHEaIrobe
hmlNJRZkwxRDS4+YcgSoaTuGg5Q8OB7hCEa+5/n6HIlcyK6w770=
=PvvY
-----END PGP SIGNATURE-----

--gxgqls4pt2jpholf--
