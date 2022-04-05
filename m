Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCEF4F53DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360031AbiDFDYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1847905AbiDFCU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 22:20:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ED71C027C;
        Tue,  5 Apr 2022 16:39:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KY3yC4zPhz4xXS;
        Wed,  6 Apr 2022 09:39:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649201955;
        bh=F69dEHF/T1FOv3zeUBkqVqRNaF6UO3763xgO3JSC2xg=;
        h=Date:From:To:Cc:Subject:From;
        b=lYusTzKraCFHh9QLZEw+du1wEmR4d7+qIyDwJ8mFFmb1PCTKffkEjS1m5b37C/RnR
         KrjyMt41wNqFh2gIAwE0LGDz96abN0OiTd7OJg0iVk9JjMmpi0fDSHhdA4Y3zfK2jk
         4cXEBNofvtllXdryuQWoqqonUXQBHH6M1MpYVPeerxBPXwPxR5dJCvPzl41+0bwo1e
         AGwg6zE93yJRJnjfX6XCXX2z9t+H5q4cBMVc+w62+mAwnlq3U9VkOkSGy5WJx81Fw8
         Q5OhtsbL0VmG+rH3x/tRLjI5RfBbjldeD/wgdQTlIezNqoYAoVMoGPllw2CtcdbJrp
         +wUqiC1VpB4Wg==
Date:   Wed, 6 Apr 2022 09:39:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: please clean up the usb-chipidea-fixes tree
Message-ID: <20220406093914.25726c47@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/piP=.XV82Ge=s2fnkk9j77/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/piP=.XV82Ge=s2fnkk9j77/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The usb-chipidea-fixes tree has not been updated since Oct, 2021 and
is generating a conflict when merged.  Please clean it up WRT Linus'
tree as the only patch in there has been merged as another commit.

--=20
Cheers,
Stephen Rothwell

--Sig_/piP=.XV82Ge=s2fnkk9j77/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJM0yIACgkQAVBC80lX
0Gx9ZAf7BWvV9s4gl2ZDhV+ZRR1DB6whJTVyWsZnGLRujL22/sTR2JsACEHVLI6F
O4L113SLboTWuIR0M2qeFRBNjQgKtLP0d5KXP6w25NWGlqwQCD+w23x0er+Oq0g/
wxLqjFsWBNardaRmES2YGrwMSG/+p5+uQ9+2016vFcAZV7wR/n5zvbUiyRLI7nDN
+LxslQ5s5NFNZUKp0Q64UcZXO9F92rjGRe8DQ1R+J1edWxQXmN2ZWPsGftkDFOmp
UjafeSs5REYF3exMS0cfn1WZjszcs7ttAc6af4fMl3p8JQ14QdkKigFO8o5eC595
abhyd1Mn7qMc8sT1kI0Oq8QcL6Z6zg==
=UMxb
-----END PGP SIGNATURE-----

--Sig_/piP=.XV82Ge=s2fnkk9j77/--
