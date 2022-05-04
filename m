Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F09519874
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345519AbiEDHpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiEDHpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:45:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97531277C;
        Wed,  4 May 2022 00:41:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KtTL911z7z4xbN;
        Wed,  4 May 2022 17:41:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651650113;
        bh=Ijp0uFTI8NoLOKpl5zQz9vp/Fj/DnqWjekXZnVDfCIk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nsAPtSfEv+6RgSsFtTNIcAWdjsHHvucECXRyN07Wd8Y595Jh65nAgGLJMWXdbEKJb
         oUekEUoG02VI8cH5ljGOxlKy05QO+UW9MQ7iyrpBrY81nKeftMUEuytGVfNsfGkCwY
         e2EZCfd7+XiDt1I4g6O4tmClZmphyYIokBDVcT+opcCEejsl1HOvtI8noyq1woBPLo
         ihfmpMRpT/t33N/SYGQMjzkmZmJ53g0NGqvDDIzoAauKcC/6PBAKikExHP/iz59YNr
         QPbhcMxjC/vAUEIbGSWnlr2fc925Jk/uqV1ft6bXF6cB/sHEy8NfIA4cNQ36IbxMNd
         xX3aZXyLReFxw==
Date:   Wed, 4 May 2022 17:41:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexandre TORGUE <alexandre.torgue@st.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the stm32 tree
Message-ID: <20220504174151.3bfeeaf8@canb.auug.org.au>
In-Reply-To: <AS8PR10MB4712B3354DACBB8A4F8309C9EEC39@AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM>
References: <20220504072746.0f59f2d9@canb.auug.org.au>
        <AS8PR10MB4712B3354DACBB8A4F8309C9EEC39@AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eoaP/2nwrE3bn.DZtC0Xg8G";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eoaP/2nwrE3bn.DZtC0Xg8G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Wed, 4 May 2022 07:28:53 +0000 Alexandre TORGUE <alexandre.torgue@st.com=
> wrote:
>
> Actually this patch has been already merged in Rob tree. I just
> cherry-pick it in my tree to avoid a merge conflict later for other
> maintainers. So I didn't add my "Signed-off-by". =20

You should add a SOB for every patch you add to your published tree.
That includes cherry-picked commits from other trees.

By the way, most maintainers (and Linus and I) are pretty adept at
sorting out merge conflicts (unless they are really complex, or course,
in which case you should probably have created a branch in one fo the
trees containing the conflicting commits from that tree and then merge
that branch into the both trees - and, of course, noted what is
happening in the merge commits).
--=20
Cheers,
Stephen Rothwell

--Sig_/eoaP/2nwrE3bn.DZtC0Xg8G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJyLj8ACgkQAVBC80lX
0GxXQggAi/VqXL/k3CwCgMtPj+gO9K8aL6MTpiTBZnUa1D9JnqKGAj/+LQa7YIVZ
l86bblf3ViZEVpcp9AYVmtWZFo5aVRERPjkp2ndQcHX75oWXkWVv3+rHEMJGbfOl
cDeChMI5ln9yT9bobE0AJa1bbmqxgNjmlZvZntPB6Y9YJZ83eIOVUPY2FMRiM2iU
DIA8Qxvj/KJgxYRh4ZQ3ORjzunWQm/Rj4NFHXWOiec/8RVOJfXkgGSihNakoFgTx
o+00C4SMvuoZgFBUKnsvx/OFVlUscMivbT94glHkLblEFRe08mSZaMiLbj3SH7w2
5mBrKtIuj8Eb6ktW9ETQFH0KSZd28Q==
=1utS
-----END PGP SIGNATURE-----

--Sig_/eoaP/2nwrE3bn.DZtC0Xg8G--
