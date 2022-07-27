Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5015825D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiG0LsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiG0LsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:48:12 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05744AD56;
        Wed, 27 Jul 2022 04:48:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LtBqX6r66z4x1S;
        Wed, 27 Jul 2022 21:48:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658922489;
        bh=sxwTwysWUUSJLdH+6rSWo9FimaOOiqcP/qE/4KkvJ6E=;
        h=Date:From:To:Cc:Subject:From;
        b=li+b2/Z8b1fgQzZNmsCtWaWwHsHtTh3UlAJ2xXqP1auCJPadUVuTTPf0gq6Dli1kc
         lD2DDA3UDidkuG3WBQCE9Ewx+Lqp/BJs3HutH9JMSvue/yUsEe+1xI2vvM9VQFRPoA
         KvpJ6FszwrUlOdxk5ntX9dwjp80m18tMZORcIrykfEIHf4u9JnIVQB1lOxIFi14c1B
         PTI9Y4U5rgFM6hyWb0T7ECuN6Vu2hO21BJnAEDf74h9Br0LN12IfwQcCsfp1XvxAfE
         qePRq0+JH+m0IoV/6M6TaGzNmpQMoKcfKuiJmRZ6JttQFEy5CXiymzA3beLyZKc31G
         wYomXATUInFpQ==
Date:   Wed, 27 Jul 2022 21:48:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the dma-mapping tree
Message-ID: <20220727214807.6209642e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NYGUea=y+kJ=vMTnL3aVkKv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NYGUea=y+kJ=vMTnL3aVkKv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the dma-mapping tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/driver-api/infrastructure:50: kernel/dma/mapping.c:258: WARNI=
NG: Option list ends without a blank line; unexpected unindent.

Introduced by commit

  7c2645a2a30a ("dma-mapping: allow EREMOTEIO return code for P2PDMA transf=
ers")

--=20
Cheers,
Stephen Rothwell

--Sig_/NYGUea=y+kJ=vMTnL3aVkKv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLhJfcACgkQAVBC80lX
0Gz+ygf+K9mXwy3gKdBfqiaf7G/hzaVBWDUL4yGEqE4ZjdLk/PeO2b/65S8zSlHN
udWbNKyVRcMX7AxlowTup7uafbLVeGTzrLYcd5axoothBINqcBNqQyRfXJVz0ZcW
XzJ2golDUlYL2Kt8pikdA2MiG42YL/VLmUXTmg7Ru4K0ravSBh5WIqNNUq07kq1Q
kIfj08TQ/dH4/NfEs93o2VnH2GbWojT0mEuaE2Xrx3YhqsrIUWEBdD99QmWqErd2
/ZZm/EfjxSyyJglUE9W7nR3Kwp5wiZdIsyFOha4EWKOX5HHoy0u67saQ36t8v1F3
/rIOjjCtEa/c5masC04jCgCeYlrIBQ==
=+eWR
-----END PGP SIGNATURE-----

--Sig_/NYGUea=y+kJ=vMTnL3aVkKv--
