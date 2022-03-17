Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50CE4DD015
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiCQVUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiCQVUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:20:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39A1DE9F;
        Thu, 17 Mar 2022 14:18:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KKKky3w3Sz4xXV;
        Fri, 18 Mar 2022 08:18:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647551931;
        bh=jqK0nPVtwvYOHbKN9F3phggl61z9dDkP0bv/+owb1cs=;
        h=Date:From:To:Cc:Subject:From;
        b=BueAf71JoiUmW+CB8lI5l3ubEFhjscGX5qCh6LoWpvg1tk2VKvLhZ9bTStK1ZosgS
         mSn72S91v2hqItq6qJjFds0vL9MAUbTJVhiY4SmpJ4mDplDKhky5A6hg95dAW6gT66
         5OcfSLpS5NS7+dV7+mUXLggKMth8eO19wNRwnMa7NLcitO2wTLZBHuUpNrQ3XZYyzn
         QhXwSTMYeE8F+yxz417+ABU43eEB/+VP75tzDcs2LamiRWw4aDye3kwJa4plxBUXP+
         17eej4qmEGIFvkXbvEqSV8kkz9/ITeQ9JwedDJDZbrlfbPB1/a3GUszMfQtVucoYmi
         s1ZtVySji6I5A==
Date:   Fri, 18 Mar 2022 08:18:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the spi tree
Message-ID: <20220318081849.71228339@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dffVoO4x=ie4M/uiw6W0RMs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dffVoO4x=ie4M/uiw6W0RMs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  ebc4cb43ea5a ("spi: Fix erroneous sgs value with min_t()")

Fixes tag

  Fixes: commit 1a4e53d2fc4f68aa ("spi: Fix invalid sgs value")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/dffVoO4x=ie4M/uiw6W0RMs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIzpbkACgkQAVBC80lX
0GxU7Qf9G65RsTpMLymE5l1gsFUfTs+x8fscNzAT2eKQ1YQiA6QqjYHAn8KDqMfw
/LVS7Rvdl71Uhx0QrPCRZ3djLa85Vyda8rGhiGHb843kuNQpLvvfkLWuKbO6BYD4
uGA/Ce5xbp85HiQSjo8vatmyqUi/fblU6R93eAuHNP+7KpHRsCTRuAklERHmVS0f
95m/D5hINbEYr27UXq8kK3Wi6Iwz6w5IoodybLOW5qbndLOD6uoWb0pHoiRenUKI
HsUxjF4P4kLD/AN1skuN1pq6vItO6ely3gzs6wUB/tIu6qMXdCMfsDxSWemI9RNY
uX7kmBbiEj4bNqFP85MJTyz/+qqVOQ==
=DfGM
-----END PGP SIGNATURE-----

--Sig_/dffVoO4x=ie4M/uiw6W0RMs--
