Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBF753566A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 01:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348281AbiEZXeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 19:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiEZXeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 19:34:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F6D91570;
        Thu, 26 May 2022 16:34:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L8PQW6nDfz4xDK;
        Fri, 27 May 2022 09:33:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653608036;
        bh=XFoNMtB3cc6oq9Q1Rkr5wkpH62qt/IyUA02WEP+IHQ8=;
        h=Date:From:To:Cc:Subject:From;
        b=C5ajthcUmM8YIBIjZZP66TPF04V7lJLpdHa7h7NKmyRmdHzKUN52rXyHvNuGNDKWx
         SFQBkknGbqthqLTwyo2I5q93rQlerWiER9Cu10qvxZeaKKIl7KFsGQs8fExMsWtJnh
         nWYn4dB1RwvDjqqBCVI3oYLlXX/27Z9jCg758zvfyxmVJqvvyuMtTQ72tyJDOTe0pS
         cqV6Yg+NXnt/PWKP4hnhe4KrqoyTTRdKaJ/zgbhrS59DdqWhZBO2FJ9MWTpH6Pt/wr
         FwrvgTGlt1JCIvpv45XPLbjkz/16oyqBN1fSJFTWWhcOmL1Dd8++ctCjosDYk38F+P
         mQ+ovD//qbrSQ==
Date:   Fri, 27 May 2022 09:33:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: linux-next: manual merge of the kselftest-fixes tree with Linus'
 tree
Message-ID: <20220527093354.27316445@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/obFMnZXiSG7AxV3ULKZ53le";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/obFMnZXiSG7AxV3ULKZ53le
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kselftest-fixes tree got a conflict in:

  tools/testing/selftests/vm/run_vmtests.sh

between commits:

  b67bd551201a ("selftests: vm: refactor run_vmtests.sh to reduce boilerpla=
te")
  33776141b812 ("selftests: vm: add process_mrelease tests")

from Linus' tree and commit:

  e8f0c8965932 ("selftest/vm: add skip support to mremap_test")

from the kselftest-fixes tree.

I fixed it up (I used the former version of this file which seems to have
included the latter) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/obFMnZXiSG7AxV3ULKZ53le
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKQDmIACgkQAVBC80lX
0GwNEgf+MXNwmAlMGcUwFzrhGXM9SA3cSPweJrRikUq4EiBtip+XowZEfz6AULqh
mAiYBpK+iy7eLyVglrRZnfDj1ZccYzZ2eZv9yHUcEdmr7CklgVyCsY1vWVPNv8OH
DHi+kqgK8U4WP04jDACFK+zhW8sMzRjxcvv4IQxae9/2SxXkmFPqjjvsTcelbHgY
OfidCnqsSk6yTDd5tnGPlFwm6PZD6sn6/CFJu0rD5YbsgSc6znsU+wNpOp5bb1mN
DYlNDRGnM1hxLDts0VDvRSp8Iq2z4YFGg8n1DpBSsyt8RutfYeY9vM3o7Nd9vtDn
le+baFm6wsBTCI+IshXsFcxlIG46MA==
=1Mvw
-----END PGP SIGNATURE-----

--Sig_/obFMnZXiSG7AxV3ULKZ53le--
