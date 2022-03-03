Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5234CBBFD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiCCLAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiCCLAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:00:20 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6AA154721;
        Thu,  3 Mar 2022 02:59:35 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K8Sfq1J3Wz4xPv;
        Thu,  3 Mar 2022 21:59:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646305171;
        bh=6DYqyin2JejukR+wgiGBjgLNrx3CsPedPZngc/l8iVE=;
        h=Date:From:To:Cc:Subject:From;
        b=my0VBNENO6hSAsBslLFcw9NPsBn5LEEpBw1mzbAAH/V+q5jq9VpvWU0GwK62egKLx
         9sncdTl7NunBln/y/y+XDTjI99tq4/nHs19NjxD8nu3edqWPSDhssy+19sbY24Yytr
         jF/GXo5iFynXUaMwf1lsenEDeJU3wg72XlOZK9jUFIdVrDjQLfY8KSYyjxlzf6dGZL
         kYsy1a5NrBPkzbX/eskpviKBH/AX2qcldmG/1jeL5PR4FR6vbRBAHX2TrVWtF7ehLz
         QjBxo3KgQyTMuZZLFRlllTvZ81AnhNKfVzIBT+svsR1323xrlFJ49pHn6gDAzq7Q/2
         Jyoh5fUK4PlqA==
Date:   Thu, 3 Mar 2022 21:59:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the soundwire tree
Message-ID: <20220303215930.014e72f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yj5CwKeOAZSMxy0YI/2pmVV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yj5CwKeOAZSMxy0YI/2pmVV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the soundwire tree, today's linux-next build (s390
allmodconfig) failed like this:

drivers/soundwire/qcom.c:1460:12: error: 'swrm_runtime_resume' defined but =
not used [-Werror=3Dunused-function]

Caused by commit

  74e79da9fd46 ("soundwire: qcom: add runtime pm support")

--=20
Cheers,
Stephen Rothwell

--Sig_/yj5CwKeOAZSMxy0YI/2pmVV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIgn5IACgkQAVBC80lX
0GyAjwf9HfXxENXoOLOXLgK5qgePdhMDT6id5dFfOc7pHDWnG29+nSXQ5GH5TeqI
iNKOt084aSQ+sJtVQP6CCqMzZw8DwRYjJFgNukjuUl61MvB9rcvMb5eWvHLVf5ZO
kOMM9n1f+ZOW2t1Lv4oORUn+8R3rw/JrSAEyBWn3M2dRxTT1BRxHOeVMGXxQI1mG
0M3qc/IO3TSt7oRNBJA1baphXA9fqQIvRME/C7Hffh8+6sRiC/HDDAAM+K3kLw5T
Kp2Bvwpoeas8bp4Yl3ep58rKP25uOxHUdM4ivNgChFSkRH9T5CcFoEUwst86Adbd
eRht1uwBzNraJNYU3T7XVWhJ6FabOA==
=gIlA
-----END PGP SIGNATURE-----

--Sig_/yj5CwKeOAZSMxy0YI/2pmVV--
