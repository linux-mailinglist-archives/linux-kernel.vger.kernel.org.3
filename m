Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFEC579685
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbiGSJns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiGSJnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:43:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7B527B27;
        Tue, 19 Jul 2022 02:43:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LnDRg0mqNz4x1W;
        Tue, 19 Jul 2022 19:43:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658223823;
        bh=jcCBX/aIBPwRlTlq/v11b4nx4ZPwuisbjrYP748HRyo=;
        h=Date:From:To:Cc:Subject:From;
        b=N0VpdSN9GicdtK1cjA9JbCaj7uZKU2pxLUEMC/v0rgLE/VKJTMtx6VHo0pptoCEsI
         3ztdDOoBzsUjAafZT570RIwaq+R48DxFm8c4iM0oWD2jJJsAosKRElGRxRIBDRL+qT
         nM515ITOmF/AH2nIEKLd0MMEi5BYilRGlc0qYZhC3R+uvomISSTYUI4WWip1f9Sd3l
         1MybW1HraZBpG6UenmsA51i/lDbmr+xj8kNY5f2ZP74tOYJ5875pgA4nZJnDyr/ROH
         Gy3ouodXJ/Y38xlBGratLQSM/cjlPnrSn25gYncxitp5OIsNq2OgXjx9iMs/Ok+muM
         crdtOjNk+b4FQ==
Date:   Tue, 19 Jul 2022 19:43:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Maxim Devaev <mdevaev@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the usb tree
Message-ID: <20220719194337.64c490e0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KJEVSy0It/Nblpi5qYDCIyx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KJEVSy0It/Nblpi5qYDCIyx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the usb tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/ABI/testing/configfs-usb-gadget-mass-storage:17: WARNING: Mal=
formed table.
Text in column margin in table line 14.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
file            The path to the backing file for the LUN.
                Required if LUN is not marked as removable.
ro              Flag specifying access to the LUN shall be
                read-only. This is implied if CD-ROM emulation
                is enabled as well as when it was impossible
                to open "filename" in R/W mode.
removable       Flag specifying that LUN shall be indicated as
                being removable.
cdrom           Flag specifying that LUN shall be reported as
                being a CD-ROM.
nofua           Flag specifying that FUA flag
                in SCSI WRITE(10,12)
forced_eject    This write-only file is useful only when
                the function is active. It causes the backing
                file to be forcibly detached from the LUN,
                regardless of whether the host has allowed it.
                Any non-zero number of bytes written will
                result in ejection.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Introduced by commit

  421c8d9a20da ("usb: gadget: f_mass_storage: forced_eject attribute")

--=20
Cheers,
Stephen Rothwell

--Sig_/KJEVSy0It/Nblpi5qYDCIyx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLWfMkACgkQAVBC80lX
0GyKdAf/UHCnuE0PYYFKcSaX/CYHrtznEb8L6bGxwWlhNSYerFiECjbuhOJS4tPN
IZDNozLJqii6hsUeHHEp+Mwp8Rc8TQOah3dld8LEv/DkQenSiUPq0M+2IPjRhCNL
X2Vgh+qPN9IYQoZyEDwcCEklSHK1ACGkszv2mde1WEPa+cZV7LyKNEvJ4g9cHOM8
RjkOPVljcIf2MPY7ftCvJ0frbcMSpw9sZHmu590TYjWO0L378S4PBN3OXHx5HTfT
i8VBu4aRnXPqqzaAQqDR/wuq7LFx/nkF3eWQzdxO/PxRHJWxwP8QMP2CKa1ONx90
1RcXghPG15S1Qnopugm7waK8aMEU7g==
=RFCp
-----END PGP SIGNATURE-----

--Sig_/KJEVSy0It/Nblpi5qYDCIyx--
