Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAF44F0DBE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 05:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348230AbiDDDlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 23:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbiDDDlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 23:41:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC8439805;
        Sun,  3 Apr 2022 20:39:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KWxN25d4Mz4xL3;
        Mon,  4 Apr 2022 13:39:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649043555;
        bh=Xv/VYrN3nnzwh73foVTRVc0CU1Gv4Sr+YLzYnCdE+9M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=druhi48TJmt4+Y4HoUuNnEQ/FyKzqgFdsHSWf8oy33E+4LPx/J0uJtyFgjJwTzYaR
         TwRssAGv6tWysu9PP9PhJYuWNCIzFZMEWtILOsnu+MN6tu0n6mqJYLxo4ybpzxJ2bX
         t3/wEyFH2yt/s7912WwLKh5sxpW3eAUt7vntP3O4UzgPvevb5E3ea92bruFjBIpO78
         65S/rTsxipjamcNPyOe9aDMBF/V3TcUa7ES5S8KA3/maapZZy883lqLxJD8mGAJxPy
         cZ/hd9/VGv9aQ6lTIrYTYbm0cXSpHnCzb0CVGCK7UVfS9vCdPBvVyp4sfVKdgSNm6l
         0kzJSFu2gXRzQ==
Date:   Mon, 4 Apr 2022 13:39:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Wei Xiao <xiaowei66@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the sysctl tree
Message-ID: <20220404133914.09f23f65@canb.auug.org.au>
In-Reply-To: <YkpOBykNOI6YjMon@bombadil.infradead.org>
References: <20220330115617.4d694d11@canb.auug.org.au>
        <20220404102617.572de1d8@canb.auug.org.au>
        <YkpOBykNOI6YjMon@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//yZav+sQmN2xonWSV/CNKp7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//yZav+sQmN2xonWSV/CNKp7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On Sun, 3 Apr 2022 18:46:47 -0700 Luis Chamberlain <mcgrof@kernel.org> wrot=
e:
>
> I have fixed these issues in a new push to sysctl-next just now.
> This all goes tested through 0-day with no issues found there.
> Sorry for the delay in fixing this.

OK, thanks.  I will pick it up tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_//yZav+sQmN2xonWSV/CNKp7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJKaGIACgkQAVBC80lX
0Gwplwf+Mlrg2R7W7zYQQZ1cOGCgefMTLx+FQTz88KBh+cO3mq2F0Xj7mFI4bZNQ
zBSud0iOSmKuvf+IHOB1u7CtJDuSLj6j8vXLNCu3WyxqjuzV86/MUFNIU3RHe6nZ
jNzC7XOUcBpqS8KEncN1L9/sa/eu8vUwrmWBHuipoxpQwIXgMfMDzCZKDsBAr3YJ
aYUEdm4cDBU3f1V/cq/wzAZhe0Tq21toMIOgkwY6657D5CVnZaMWT4LJEezdb1Lt
3U14e7sVgM8lID3mVEaw1FneuDbDrIHFKiQqZnPwqiQ8ccJRHfDLxnL3Wt0+thw4
v4wn1MNwD0GencF58qmET5daYhfNmw==
=28fX
-----END PGP SIGNATURE-----

--Sig_//yZav+sQmN2xonWSV/CNKp7--
