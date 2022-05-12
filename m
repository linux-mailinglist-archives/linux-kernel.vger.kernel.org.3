Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3527524A84
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352754AbiELKo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238974AbiELKox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:44:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD3468FAB;
        Thu, 12 May 2022 03:44:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KzT1V3NyPz4xR7;
        Thu, 12 May 2022 20:44:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652352288;
        bh=3CsWVHRJHvuzc4hd+oj4lD0PBg5fFuGkXRApcTmKBs8=;
        h=Date:From:To:Cc:Subject:From;
        b=mkt60qq4c01I0OyOTo4iA5pTGovjwZG+rvMqx+hV/9s4/0tRHeXEkeau8QIcxrBgu
         v5/+pWJS05of7bKwyXnTH5csf4IQRGNvIvF//1sMkKJTr8rjfTyQ8yuQR57SEoOUo3
         zul5QH2YvkNqUq/s48jjaAgo1IsyPr4tLteYxlW4sCxO7ji8e5AnDjbdBVGAcxwdr0
         MNJYQfNkmSA3gUA0uXrYqg96ES7KLsk51iDdGo3Gq5A4qnPtoxl/y0p+lAdbHFTJmn
         V0APOc2YhQP1+8wzLFUt6eWxDgfFBxIC3nRKOYOMhb5otRjGGbCG0gWNzd2BOJ1Cby
         EMTkwpdV0GDyg==
Date:   Thu, 12 May 2022 20:44:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Zucheng Zheng <zhengzucheng@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <20220512204444.29f3c634@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.Hl6UOumR8r/xaIHfx.MOZH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.Hl6UOumR8r/xaIHfx.MOZH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  2cc6edea3673 ("perf/x86/amd: Remove unused variable 'hwc'")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/.Hl6UOumR8r/xaIHfx.MOZH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ85RwACgkQAVBC80lX
0GzXLQf+I/vd5u2G0NKoJuKOCSag5mYchXwXZyCV7mInk1wAmh3jHal2FSzlPyPJ
5OjbIWGxf/P7E+dOnTeSOuNNvLVu5txfTUlB2oRbn+7nxF1lZ7Vlh8ND9sY50+Yl
TaUUWjtIeWMCyxdBQ6JXNSOmKGh1vecCANGPTeHJrwTM85yXjT+ruPMvE5+yhw/I
+/8Je+BfyWc3PLmbtMwkX12ultA4QkA6xp7Xl3ZwOhcye/zU7PJtBLwG1SggLsaV
+xpxQqbnPnz43FG2py2eKWM/4hFoxRByMQBvJjlkKMXrr39XmWqi0jDUjTqxfTqC
mk4+53XBJvWsl1PD06ip6nV/YJ52FQ==
=1Dme
-----END PGP SIGNATURE-----

--Sig_/.Hl6UOumR8r/xaIHfx.MOZH--
