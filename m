Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A54559409
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 09:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiFXHT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 03:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiFXHTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 03:19:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3189867E63;
        Fri, 24 Jun 2022 00:19:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LTpRC5Zdjz4xR9;
        Fri, 24 Jun 2022 17:19:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656055191;
        bh=RkD3yu0JQ4KaQKEH57aQag4T2Tqdx+EslsyPHbbXNgI=;
        h=Date:From:To:Cc:Subject:From;
        b=Ysg4S0cucnjxTK8NE0firSBg1TnXZ1JBPyCxFlW5CATU47aEbNNRicFkOkSMjqe4r
         68oan/YhZ9GfmWE3IJy0OI3i3HC7/+mN1A9+vFAc2RJZeuBKVmUBk/IvDuj74vSCQB
         fWDNf4pZL8g17F1wuOuyhbg49iNe7dAdZ6CE50iVIOg/BGAKlBO8ESkUyYAGcu+7K1
         fR8TTHCiQG/sHgirq22nE4fuIhFN2RtwPtQtWGmYT+AeduX/Wkhdo2Di7YBTChquIt
         2kobuSjJLlayhMslu3q4uIDbd8W1ZGXbIprYlQsRK5KmjC66xaUoIValgD44dB3NWZ
         weXUTxV11EmIA==
Date:   Fri, 24 Jun 2022 17:19:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the pidfd tree
Message-ID: <20220624171951.3e65d7e1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yJo2ZgmlBQggHQ9Jr4sYbj6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yJo2ZgmlBQggHQ9Jr4sYbj6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pidfd tree, today's linux-next build (htmldocs)
produced this warning:

include/linux/fs.h:1714: warning: expecting prototype for i_gid_into_mnt().=
 Prototype was for i_gid_into_vfsgid() instead`

Introduced by commit

  526b0b1c14c4 ("fs: add two type safe mapping helpers")

--=20
Cheers,
Stephen Rothwell

--Sig_/yJo2ZgmlBQggHQ9Jr4sYbj6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK1ZZcACgkQAVBC80lX
0Gy5mgf+LF0O1SQzAOz+KZC0lFV9Jh3N86Sn0GCrGBQHznDZ4sIHJA00X8ShBYdO
d/6JW+mqID8gF2Y1TmiXfu3gK/mVmYBK3E9XxA2f6edaxzYNVhHG149Q3AycfGtJ
KD5m0fm3B3xDadVWRA1kNeEiK9tOPGIGxAfZj8IuFqKgFCJGbPw6aTL5oalscKXU
wZ0kyKODSaLgl2RiCZ7+lZkhUxwsXzt/sOhKIQR/3on/gkkwAO3uxjgDlsQLr65F
M9O4cZUxsK6JVUNItweDhR4s7aiv6ncWVfYUEV+adRW80ep8Ee/oYjRGswXD5FZt
fYUwyVnsOqB7JSmNppSsrwYeAiTGlg==
=QPHI
-----END PGP SIGNATURE-----

--Sig_/yJo2ZgmlBQggHQ9Jr4sYbj6--
