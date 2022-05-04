Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55084519D78
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348417AbiEDLAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiEDLAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:00:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F021AF3B;
        Wed,  4 May 2022 03:56:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KtYfh4ZKWz4ySb;
        Wed,  4 May 2022 20:56:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651661788;
        bh=lXu2HNZ90XM9MtwLxcDurCN/fphBhFKr1mu8Gt2/XFM=;
        h=Date:From:To:Cc:Subject:From;
        b=Jvtk47eOlE5Mumk6IsTk81+sOamWXYTU+Zg6YIQhd5iVimSkuqF6WaPP2WjOB5qnL
         EZ4WuWggHKDFrr9jN4L29OJGn8k0cGDZGC5FmaCVFaDQAJuMJ2tEVu+rK8PsfMFgia
         hVPSE9eGS8pBjKIpUSoUdqiAsIbk8SOEIAZTciitqVcdfdUgMes7BAxfvJrdxjj5LG
         RS5aZ3PwPwtDl+uyT+fAagAYng838C6+K8JLiq9xi2fGr9IPpRuhFMCrNIMKs/bOKe
         qNpOG2+GRApy6Jfa9hV3CgXkwHRdFgi1bgCle4PMCDE07sX/Zed24FQfMvqoRNoYZD
         eFV+3BSLFUO9A==
Date:   Wed, 4 May 2022 20:56:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>
Cc:     Raghavendra Rao Ananta <rananta@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the kvm-arm tree
Message-ID: <20220504205627.18f46380@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sUm06JZ/MHsTthJ71DRZcsE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sUm06JZ/MHsTthJ71DRZcsE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kvm-arm tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/virt/kvm/arm/index.rst:7: WARNING: toctree contains reference=
 to nonexisting document 'virt/kvm/arm/psci'
Documentation/virt/kvm/arm/hypercalls.rst: WARNING: document isn't included=
 in any toctree

Introduced by commit

  f1ced23a9be5 ("Docs: KVM: Rename psci.rst to hypercalls.rst")

--=20
Cheers,
Stephen Rothwell

--Sig_/sUm06JZ/MHsTthJ71DRZcsE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJyW9sACgkQAVBC80lX
0Gxmugf/Rli2WvwZo8sssLZm2HPuV7j8DoZ3MIDKSNkZBb1g5b/b6fCfLdxUbKQj
DDIwkABCQYdTNr3YQOeM6Ab6NPfMwnUtrDpY+465TA/ztPPqVOWQIc/dnEmWP1az
Fh1JLi6nRrqSII3yz1NTrnCbEN5kb4PRr7qR6RTuBGyqkPTxc3Zy0+aWzemNAnSb
OG8amLyhQKGtHhpWuKaMCi3U/Dx+Pwtx38rvPfQ8R6wnEC/TiJa6VePEHnzsQFXH
6vOxK6R8j7zBFG++dI8ZK7Qb5uaIBXPFfj/1/W8OCPhgzCmmDx79pIFyqy/dXQtS
pdcDwS0bnHs4VkHLnt/SUPp6gZefzA==
=PS4x
-----END PGP SIGNATURE-----

--Sig_/sUm06JZ/MHsTthJ71DRZcsE--
