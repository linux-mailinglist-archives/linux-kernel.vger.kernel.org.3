Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998BE516D74
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384266AbiEBJjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384257AbiEBJjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:39:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C472D36699;
        Mon,  2 May 2022 02:36:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KsHyr4Zdjz4xLS;
        Mon,  2 May 2022 19:36:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651484165;
        bh=Tl85NKAKsV+hP4G9r7CY88kWbQ/hZj5rpBTRcLc6UF8=;
        h=Date:From:To:Cc:Subject:From;
        b=ZUsBlQXzxTdvtBvvM+o68aVlXtDQGEXWk5zVOrYwwV67p+7SjC8tCnhdAg0a64GiT
         pdQGjPdDssqBbv/esz3GX3AGM2+OcznN7ANNkucmUqc+27ak3Q3mSRqWiFRi/Fbj4W
         CZkSiY2oSdzLKg+igLXliWvPf4PhXrh6efNmOWaz67m8b+55O1QHtlDGoWdinM7wOh
         JCWUBIpG05AQ5IDQDEKta2PsO7HVFh20+W6uH+laTEBSPh1LmZndXwpGPKgXn7fM2B
         DnLjcnygIFF/yFQKugJU9bBMuCESpFeuJ+az8OPXyiDr1iktbkg7jliGC4hszIyl5n
         TYvwTayzggqbQ==
Date:   Mon, 2 May 2022 19:36:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        NeilBrown <neilb@suse.de>
Subject: linux-next: manual merge of the mm tree with the folio tree
Message-ID: <20220502193603.77d31442@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+lqtycQY9/F/58=Rsx8/1UA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+lqtycQY9/F/58=Rsx8/1UA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  mm/page_io.c

between commit:

  f6c95ae9b2c7 ("mm: Convert swap_readpage to call read_folio instead of re=
adpage")

from the folio tree and commits:

  152ac2c67212 ("mm: introduce ->swap_rw and use it for reads from SWP_FS_O=
PS swap-space")
  8272c4afbe68 ("mm: submit multipage reads for SWP_FS_OPS swap-space")

from the mm tree.

I fixed it up (I just dorpped the folio tree change) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/+lqtycQY9/F/58=Rsx8/1UA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJvpgMACgkQAVBC80lX
0GyjgAf/WjVBXl+jJ0+1fspCiEkIaUxQEv3sufEc/dMRUugTXEQqlcFVkfduL6wc
5qaGUEqDAvFAD8K+w9jEY4gvGzPtvVosd6JZtRgXZrxHZKZmuCdo/DoEInyWHKga
/cnVaWuv+aW89exrdW7/Sy9v1cJTS9tQsFRMhB6N9ZUF8PrnpVIGG7/l7NlMXtp9
jmAJZlXBvRVlU+0WhRsWkMJOQwErCm9bkYElEW2YQ60fUR4BJGqLbIObU64ls09f
KSUgMeYvwPuoXfPFnbM/biJlp5iSvA3k08YL9VCTuIF/hm5IibgFEF08hrlRPxUH
QiIhDvp78JW+r/sHsgaAHZ2Ry+K0tA==
=VV2J
-----END PGP SIGNATURE-----

--Sig_/+lqtycQY9/F/58=Rsx8/1UA--
