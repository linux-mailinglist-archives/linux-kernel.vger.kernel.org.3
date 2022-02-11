Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57C04B1F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347855AbiBKHt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:49:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiBKHtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:49:55 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F774B35;
        Thu, 10 Feb 2022 23:49:55 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jw5P62TRWz4xcY;
        Fri, 11 Feb 2022 18:49:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644565793;
        bh=gNbUFF91eRbp2n/8xdXGTesci5ftBWuDnIOJVDWoZ1g=;
        h=Date:From:To:Cc:Subject:From;
        b=T1YxXDz7EpV5Yn8rpl9ZDyP0C0baSaTTEK2doMfjdEkTS5ujVOHtuynPYyRSn3Wle
         DnOxpf8vlZHGVlbFRVEipq+q6vpI78JieeGWoxHMlKz/8qtrGqojma4elv/kTz6S5g
         E95xW83JXDns7JnlkCEG+dXrenSebRZ0so7d+YMHRbIG6/VicBVqVnL/cREhiN8/Co
         5rd8jU4sYYfN0dghWMrcyh/mi8g45H55Tf5hlq/vLZZDWALSULqM9RZ8htbtEOumpu
         ijTOOR9ffiiCVypQwOv7Y75/LiTEGhRzIWRZYWthJh03lVl6SRryJJ6A6sB1goIxqy
         8VG7PHNq7D4bQ==
Date:   Fri, 11 Feb 2022 18:49:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Wei Liu <wei.liu@kernel.org>, Wu XiangCheng <bobwxc@email.cn>,
        Yuki Okushi <jtitor@2k36.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the rust tree
Message-ID: <20220211184945.7b2fb872@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/04o7gX0+LP=3JwbS/ocZhtN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/04o7gX0+LP=3JwbS/ocZhtN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rust tree, today's linux-next build (htmldocs) produced
these warnings:

Documentation/rust/coding-guidelines.rst:74: WARNING: Unexpected indentatio=
n.
Documentation/rust/coding-guidelines.rst:79: WARNING: Definition list ends =
without a blank line; unexpected unindent.
Documentation/rust/coding-guidelines.rst:80: WARNING: Block quote ends with=
out a blank line; unexpected unindent.

Introduced by commit

  0b154fdfa6ec ("docs: add Rust documentation")

--=20
Cheers,
Stephen Rothwell

--Sig_/04o7gX0+LP=3JwbS/ocZhtN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIGFRkACgkQAVBC80lX
0GxaoQf+NTMGhmJWIHcQH14GDZZ7uwkynzXAWrA98V0pD2Gv2mqfCLXLAGgjT19c
x7+fhsGRGlsDdXa/Kj3g+aWjO5QuZdtk9eK1OLQrOYi3aM8k4MwW+pPXQJo5Mw5R
zHQAkNSpgm3SgufJbB+6ln8lQ+OZExK8T6bK6W/dJgPSdOOIWJL/GHFmuaKnggHo
WqtYG81v+Rv3R08INK5DP8SOQAZ9vOHjt3jdptxAPneHPyfU7uWbsszU9UZKti9U
P3BtN/e6X64WVO1Mgub341dhuhyUHK5Y9IIcY+54OPovtO6x30CRQlIuYd7Gvv/x
5E5iRTRJFGdQY7QoILZ0WEa2phltZA==
=c2BT
-----END PGP SIGNATURE-----

--Sig_/04o7gX0+LP=3JwbS/ocZhtN--
