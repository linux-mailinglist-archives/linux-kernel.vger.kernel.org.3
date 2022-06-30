Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C56560FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 05:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiF3DhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 23:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiF3DhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 23:37:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602D41117A;
        Wed, 29 Jun 2022 20:37:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LYPCY6fy6z4x7V;
        Thu, 30 Jun 2022 13:37:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656560234;
        bh=0ERk33ZGimAvhMDpUrHc8OMoPxZlnQftHPly0/kXP3U=;
        h=Date:From:To:Cc:Subject:From;
        b=WyfGuHyx0jWoPFBVi/c/QxvQUN5qSRrDN+ztCdtD+N04ydlaul5KAErTbZbTIp8vw
         J8Z8v8oGou+mAiyoFtGYnOtlY86QgOeKP66CSpMmOSUDdpRR90ncp7Rzrx8wPQ7Fn4
         QRosb09Mi4CugFME86stv0BG8ApI0eXKqDZ1akEr5pCw7DSd9Ilis/vR6fPKfPWr72
         J/zdYcaPrXpKID2T6GVs+BsxC2mVJ26+fypeK8gEwYnEl6P1po4RtFx8ok8+CITO2Y
         2c0ybH9fddTtlT1HkRGtD1sdFUrBBZyee7Cd/N2Fr1Sz4WpW2PtHcMCmLeMDA/qLO6
         m/vzr0vjzA3EA==
Date:   Thu, 30 Jun 2022 13:37:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm tree
Message-ID: <20220630133712.1a3b0ff9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aVwxAAb22P_01OExSTyM6il";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aVwxAAb22P_01OExSTyM6il
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  500caa69a5a0 ("test_maple_tree: add test for spanning store to most of th=
e tree")

Fixes tag

  Fixes: 1d3ae73e4e86 (test_maple_tree: Add test for spanning store to most=
 of the tree)

has these problem(s):

  - Target SHA1 does not exist

It seems to be self referential ...

--=20
Cheers,
Stephen Rothwell

--Sig_/aVwxAAb22P_01OExSTyM6il
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK9GmgACgkQAVBC80lX
0GwyAgf9H/8hqOVzHfkn3cIkBDA0RubU4jxnn7+CU+n4ziLaEi/qbPjz21D8bqD+
tcOFes4QN/x2rsUIqznvh748FYzVXITmYWIq/Tc/BqixHWkPlXlrRpYd5FkYkvGG
EZhR7CXhwcCKtQWoHaHO0ZuW/gt9JKUtQNNmHeOvDMZ9JssRIj66RJkcYe9XJGVR
i+QDQ5Bj7ZkRUdfE742uDrKJnO+aQa2Ba6R9lYif68gddZr7on+oOQnUYPmp/obH
62ix+Qd+AcNlLZ2HARxhEVLwLRl6NWfh6t2HDkWD0BX6+1F2crLqxmaWYFCzZodl
pW4hM7glq+RcbILLRRFIVQ9VT/wfRw==
=OJxL
-----END PGP SIGNATURE-----

--Sig_/aVwxAAb22P_01OExSTyM6il--
