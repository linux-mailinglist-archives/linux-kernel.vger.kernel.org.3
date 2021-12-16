Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18233477B61
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbhLPSTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:19:35 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:43409 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbhLPSTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:19:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFL3z6XlBz4xdH;
        Fri, 17 Dec 2021 05:19:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639678768;
        bh=APSRQCXA7zGeC454xcwaCyr4Rz1w4rEGAWDwrZ8GwVE=;
        h=Date:From:To:Cc:Subject:From;
        b=LR+TQvfDnrJqYARFn8sQ32x1kLXXndOmO8wMuKlGrDSlFZZhNmhV+81sGqX4dC1mE
         cx/B/EzALpMKPcL0IRQjbJi+FAkjrdEr9SI7j7HPrVfk60qnIBTJo0FeamKI8KXZam
         aou6BAXDsuq4QpQcSfkSn7k8OgHl1BmUo4EFUIYYXk88KfC6l5mCAgfPqMxmzJMleN
         S08zktsAn1WPKyJn+NlbJKaodeA7Q4O9tZfcz7jREdQVIqB//qGR/z8E9r7Lkq17Zd
         UFVcoYtIBJNinYUaQC2Xl2IfvhS5Xue7RNQ0d9z8gHZwKGeRym4pd/ANCZFxl5GckW
         MQ/P9u36WDx8g==
Date:   Fri, 17 Dec 2021 05:19:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Wudi Wang <wangwudi@hisilicon.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the irqchip tree
Message-ID: <20211217051927.68516ed4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IPGiXoaoMdJugU.pgum0Zmb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IPGiXoaoMdJugU.pgum0Zmb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  d094b4332232 ("irqchip/irq-gic-v3-its.c: Force synchronisation when issui=
ng INVALL")

Fixes tag

  Fixes: cc2d3216f53 ("irqchip: GICv3: ITS command queue")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/IPGiXoaoMdJugU.pgum0Zmb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG7gy8ACgkQAVBC80lX
0Gy/gggAggBNwVXYldXN5t+pZgEmOuKyqq6PAiefWXy5Ym3ESyX/KvAwrAo0YrqH
0wcbag872nrxV7cNptuxiohyc9WBqinJvtnoMaOuvLAeh/khaQEl5g96F7aFEYtp
WCiQbLkR9GRGVKuxGCivJGEZLjURD+c02nktBXSEW3+sEVj/xlW0kPMt7vBEocDL
X3rJVgMkQY9kyw5DRXXBPqBM0UKFFUnPAcy+OSx/bXQUO0e0Na7c52B1LCUFB6dS
JEZ2w6BUlpTr2ZRgGeMZYbanyNAqhNV02uXhsRbpqpy4lhl8ySkqyR4+p70Ow6Sj
ffO+PiV2iP4Rx/Byljs+qbpOueFdBA==
=mQOg
-----END PGP SIGNATURE-----

--Sig_/IPGiXoaoMdJugU.pgum0Zmb--
