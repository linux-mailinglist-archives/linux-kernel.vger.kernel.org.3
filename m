Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E520569EF6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiGGJ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbiGGJ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:57:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE2C4F182;
        Thu,  7 Jul 2022 02:57:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LdsJk1GTJz4xZD;
        Thu,  7 Jul 2022 19:57:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657187830;
        bh=m2N/CY1UNR5vI4HQ8svnMwb9Kz3keEatqO3ubARoiok=;
        h=Date:From:To:Cc:Subject:From;
        b=H3wnziJ0n6fTPYu9iC7VeLh+hk5HvWPMqeXqcacAcYWT1vZUpyqzYMwXtl4EbpBK3
         B1fzjEc9cCUAT10/3UrNytMnCOGM+0O1w7Fo7iufTIUtpyQQCDwoZh0CgjGPjzs6uL
         e32dgFYBr07KHjhawPxV0m/tLWjPw2wkhkaLCKcolJDAp7k9SDyhWv61Bq31lBc/Bx
         gkkVPQAmnvnmskZGxkvMP5nqeHPKBBbu1iYCG5YDBEYpVTvu+vPHUFSJrGsWtEoZXY
         yON7xI2f3p7j8Gu0/egZqfikjNY3hzB3zEFbdXAg+R1XSiCxQjr1yKm4UlfpSQ2G2H
         JiBfy3jBL9R7g==
Date:   Thu, 7 Jul 2022 19:57:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Guangbin Huang <huangguangbin2@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the arm64 tree
Message-ID: <20220707195707.7aec2e13@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QfVCx8ZB5ut6yNpNi4YWikG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QfVCx8ZB5ut6yNpNi4YWikG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm64 tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/admin-guide/perf/hns3-pmu.rst: WARNING: document isn't includ=
ed in any toctree

Introduced by commit

  39915b6b5fc2 ("drivers/perf: hisi: Add description for HNS3 PMU driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/QfVCx8ZB5ut6yNpNi4YWikG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLGrfMACgkQAVBC80lX
0Gy7fAf+KZOGfeyzTAmR/d1Z+0tmP12k4tkjH1TJjrmHB1+V9xwBu8Foxo/kYXEC
vJBIepzEhIqRa3vWcLOAizodHJrdqFVJEUDlivUq9JXXbUsuvXRoqHYz2B3nLaZO
Hfrt7HnTpIxg4RF32iov5Y2u1TdMueUeiGBOrtmSkk0wNEATN/5zIxeTVogmWLrp
/wyV6rz9EnHJpA8oI1a9D/3W8KRByTGwLIh1EOOth41bsi0DPzMno9Mr/nhSr11Q
KrBqP6/0w8BVTHFXknhUw9Z6S55Y6xvlSN9N9QLXoa5zPHRRte0HcWeshJxPVc+b
5vRd8eYsT3f/Jv9PqlcZjxlUGYSKKA==
=43aM
-----END PGP SIGNATURE-----

--Sig_/QfVCx8ZB5ut6yNpNi4YWikG--
