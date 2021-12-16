Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7BD477D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbhLPUWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:22:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35302 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbhLPUWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:22:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5603B8261D;
        Thu, 16 Dec 2021 20:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D01C36AE8;
        Thu, 16 Dec 2021 20:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639686156;
        bh=OvM4Fo1FaqaY6K7myas7FoC/tQlV0ibFV9VzGYMSJY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eZT7qP6OyKkpnHrMLodQ39KCLYOo0SdUeuPleKtkpLPjIvGZ+V63gwfDnHjUXBS03
         r8YRBSl4kvEMKOh+QEAL1o13vOCTPrXBxzQHjCZvxrb5qMVA4dM1SVXnssB7cVkjJL
         NK2aEB4GZztJ3ogwVCE69MAQ6+Le/rR+4gvLijkuWmh1ZGfWw04Ohl2lNqx1JwrbQB
         UVZyXlAzVMTABr3sm1JaDz7UnKKfCJxESvQhOV3mHDth6cFhUDl+QQ5rBvgLemkZah
         +RdB36Qbee9G/5rF2nSGUezKkKX60b5HpUcJKbR1sigeNEVOBMHRzw24Iau/6JighX
         AF18wfEwt4+bg==
Date:   Thu, 16 Dec 2021 20:22:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        NeilBrown <neilb@suse.de>
Subject: Re: linux-next: manual merge of the userns tree with the cel tree
Message-ID: <YbugCP144uxXvRsk@sirena.org.uk>
References: <20211216193412.2441434-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cw2z7MWa/LcJc6jq"
Content-Disposition: inline
In-Reply-To: <20211216193412.2441434-1-broonie@kernel.org>
X-Cookie: byob, v:
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cw2z7MWa/LcJc6jq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 16, 2021 at 07:34:12PM +0000, broonie@kernel.org wrote:
> Hi all,
>=20
> Today's linux-next merge of the userns tree got a conflict in:
>=20
>   fs/nfsd/nfssvc.c

This is also causing further build errors including but not limited to:

/tmp/next/build/kernel/fork.c: In function 'copy_process':
/tmp/next/build/kernel/fork.c:2106:4: error: label 'bad_fork_cleanup_thread=
group_lock' used but not defined
 2106 |    goto bad_fork_cleanup_threadgroup_lock;
      |    ^~~~

Partly due to vaccine side effects and partly in the interest of time
I'm going to use the userns tree from yesterday.

--cw2z7MWa/LcJc6jq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG7oAcACgkQJNaLcl1U
h9BhOQf+JIzsigXFMrkPI7484WGCSpN3aeAxMwkyEhbtqsyV+AVohfc7yjfxZ/Yy
RJDJ9m2edLp5DZRUrBqDDbnmSaE3soEVhoWQ5oQBqwrR/CbkHhYLOrAKdhWwjhVf
9l4Bz6jFifcC2yhN3kni5rtS+lFhuJmelhppN/5YQCN3pparGh1AHzradfvLrW9Y
KvQjVrGxR3Vp35hpkGze6w0xtej+ONur5PZggqWxsksbSgG8IG+k+SLdfT4hC6pC
RMB1IftveWRsDFWsE6ngbl/MItFZQPhGxTq1Ey38dewhKU9sfSK3ZVvmilPN3sIz
VrmULrc8Iy8+D4qJzYWLgyGPYM5yHQ==
=+QSr
-----END PGP SIGNATURE-----

--cw2z7MWa/LcJc6jq--
