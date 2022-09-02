Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09725AA7CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbiIBGJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiIBGJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:09:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EB0B959C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9651DB82977
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CE2C433D6;
        Fri,  2 Sep 2022 06:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662098964;
        bh=umWYjsp3s6IUGNUykoLi8MtftN0IAQQsWWy7+ncFnLk=;
        h=Date:From:To:Cc:Subject:From;
        b=MfWBxMyk3W0pHL3htfsSBW52MokC4uHJMqJvpwEO+J3I42nkvDbSmX+kKZw9v6+XF
         HqswL/1ex7do2wrxeVCBY/PHwFMnf+jUvRmWWf7nVbxT/HlI7ydEGoJ4l2wS5fc2rx
         unT0J+Vu6gTEiR9flRdTbPs/QksGGvjlJoad3XB/lJWzbhpHnND8qbtidIugiWnA/4
         gGUdgHgXxb7yCohMC+xIpti5tjL4nWf5GQq9MWnYSBGf4geDPDdP4FEKx13G3ge3ut
         yrfoBgxwVsB2UV947ZIM82D3CT+35+DffRYIRvIvEI/kh797mk+im2l2fZrQDIvy9/
         CrBau6LyIP0ag==
Date:   Fri, 2 Sep 2022 11:39:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Soundwire fixes for v6.0
Message-ID: <YxGeD1ZoLB/IOB4x@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7BNRM/pcKqhgk+jC"
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


--7BNRM/pcKqhgk+jC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Please pull to receive two fixes for qcom driver. Both of these are in
linux-next.

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.0-fixes

for you to fetch changes up to 4ef3f2aff1267bfa6d5a90c42a30b927b8aa239b:

  soundwire: qcom: fix device status array range (2022-09-01 14:26:44 +0530)

----------------------------------------------------------------
soundwire fixes for v6.0

This contains two fixes to qcom sdw driver which resolve duplicate reset
control get and second one fixes device array indices.

----------------------------------------------------------------
Srinivas Kandagatla (2):
      soundwire: qcom: remove duplicate reset control get
      soundwire: qcom: fix device status array range

 drivers/soundwire/qcom.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

Thanks
--=20
~Vinod

--7BNRM/pcKqhgk+jC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmMRng8ACgkQfBQHDyUj
g0dlvg//cgcGCv5GCdwVNfS6VZuSpjXGvlG6Ndaw7p6H+72E6jvJ2ULdLPoHe2oG
DcuIOoCvtAQuqktiBnK4G3QbUgPfCKSjQxu4+s4FjewIO8M0FkiZlxhnUN4RHuvw
pXI28vT4QRjHskDpBAY3ENVA4JW1vg8m8kDIbyH+4I3f06GvnptYGnf/6lx37AxO
0Bo/SusaHXLdBfy65eaTiQk2T+dm6Rb4cG8XMy5H/+RGweeKN6Tj8rAWJkSO9NlL
iQbne+4/jSdeavmy70CzO4V9LZw4/dBRaqvEO/tCE0rJ7KfdfPtbgFpI3xyR23fB
TrNrlgUj+u22AukDyaoxn+NISpy/5c507pjiiOKovfqAwXrl0n/cYwp2yFP9nxnr
6W6qig4uwh5Pp6gZ/AUNRjHzx/x9maTkzs17/6uxLS2PhdsQYs0q8SE3s3LHkbrV
Uv4lcsjrWgj3JLwTkgP3MyC1SUSWYO47Oc9QQ/q0EHDBRhqXH9+Pmc7Dsi2KOv43
tJfkLJBJtiJosXPcQuJ9BOLzcAnREWLAsIGh3CWle4wPvgOOVcRv05xU1RYqMYSb
sH8+QBKa6fSexJ//nmr5JjOwRGDhhlznjfe4r5yxRXXpHbX9/NprUb20wMBiXSP6
usy0vHV5JZN1lNtu5/oJPE2QWsXGOtaKVzCsGw11kDkXltg+Yrs=
=4b3y
-----END PGP SIGNATURE-----

--7BNRM/pcKqhgk+jC--
