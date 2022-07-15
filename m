Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597E05760B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiGOLne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiGOLnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:43:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930D288771;
        Fri, 15 Jul 2022 04:43:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LkqHc1fXbz4xj3;
        Fri, 15 Jul 2022 21:43:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657885406;
        bh=K4C9Ab6k4RFc7Z/Eo8aF4zVbgVqNEvSSiVdD8xWVEAY=;
        h=Date:From:To:Cc:Subject:From;
        b=rkaxqaRR6hJeEo4rXchlUa4+l9oXbC4/bT2oT4S2BbktN/Yk2lX+RXN3488mz21v2
         SzY5E7q3KlTNLmR/FwuMU5Hehlb9XokuxDLlWDPU85X3yfJkuR1vss5afW2PFMLJ5K
         g9l07gcusq46nnZSx/xn+iu/fZ+5zwjXGNVuSpKhjXDFZeAb7eZLfcZavVgNjOM0j7
         SL3/tYZheQ3KgPZY7BDkd17/40tDsM/YP6vkeTM3XjLla4BQ0JLLUNxOHyrmXsPgKU
         j9WoNhgAnz03wxJq13h439N12VjsNlY3IJ2oZ/mcjRj4cHXKCrX8e5uDdV60dqR1Ys
         tGaofz3DU2jow==
Date:   Fri, 15 Jul 2022 21:43:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Ang Tien Sung <tien.sung.ang@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the char-misc tree
Message-ID: <20220715214322.14731426@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zSgMQC69_vCwSaOBGPp_7eA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zSgMQC69_vCwSaOBGPp_7eA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the char-misc tree, today's linux-next build (htmldocs)
produced this warning:

include/linux/firmware/intel/stratix10-svc-client.h:55: warning: This comme=
nt starts with '/**', but isn't a kernel-doc comment. Refer Documentation/d=
oc-guide/kernel-doc.rst
 * Flag bit for COMMAND_RECONFIG

Introduced by commit

  4a4709d470e6 ("firmware: stratix10-svc: add new FCS commands")

--=20
Cheers,
Stephen Rothwell

--Sig_/zSgMQC69_vCwSaOBGPp_7eA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLRUtoACgkQAVBC80lX
0GxkNgf+Mwyt38l+QhYYUinwQYKPqS03nsbeszkJ2y6h6F0S5D7L/Ydwk8BK3rXC
t/DxejIPNoyAshtKnLdq5QmMOJNXwBSLA8S7FvBtbCSli5V3PLxmLa0/I6eosoKq
3MP5DjMVp7AwG1/P2xkLtm8pdVNMZ0cNQylV1rc1cmCYo9W5PLj984zLstivpfW0
ZUJI3dUhWd81fmDr6EIMXjQlkl4F/B1QyT/PjHolfZVjPgV8JkBdrzHQcm16F62q
JtDpr2bih61L/BmfmOMXMfpGqFlyFtz5ZRj8Kxb/hNpmY80ZR0a0N1kSb3mqpDH3
qstpkfZBOS0VQfQ5F/c7b8iJwkef0Q==
=JGTx
-----END PGP SIGNATURE-----

--Sig_/zSgMQC69_vCwSaOBGPp_7eA--
