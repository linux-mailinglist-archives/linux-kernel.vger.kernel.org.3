Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC914FA537
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 07:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbiDIFlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 01:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiDIFk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 01:40:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9A3129848;
        Fri,  8 Apr 2022 22:38:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kb3nh6TKcz4xdc;
        Sat,  9 Apr 2022 15:38:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649482729;
        bh=ObCX1vpWKGpP32D7eKNxSqylo2gtE408p2KK16VnR2E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iSwPbjuJb7IYQcCke0Tm4PPXvyyXZKqgTkn5WU/JX10fH0ZkgO1m/1qkF68B3+EbG
         H7quI84FqCFyGZktiFQ7APthTyfvZ+RAI0LZFcNCrYUPL8976NG1V5Q62TbFLFD9T2
         5LBqW2zZqXdFgy4lhyIGA1JLQnGJB1K/TQVmgs+YC/2PSvQv/QyTCPEyy7TzHwrxpy
         94VRLo/+u6bd/kA5Ybt/xsny7aVALRJpwnHS3ERDN5WcZeG3Hn9nacFLzsIPubO1xv
         PV4672PI6lAxUuz/hIL4Ja124tPU8RqCdQpyh3//aYQf9u+rCT4Rre2vY9SIFXfp3E
         G8lstgQqhNR9w==
Date:   Sat, 9 Apr 2022 15:38:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Peter Chen <peter.chen@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: please clean up the usb-chipidea-fixes/next trees
Message-ID: <20220409153848.4974ed6f@canb.auug.org.au>
In-Reply-To: <20220409014702.GA3421@Peter>
References: <20220406113242.3d7aefbd@canb.auug.org.au>
        <20220409014702.GA3421@Peter>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d_w0jRhXnI9CxJ90Vtxpxfg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d_w0jRhXnI9CxJ90Vtxpxfg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Sat, 9 Apr 2022 09:47:02 +0800 Peter Chen <peter.chen@kernel.org> wrote:
>
> On 22-04-06 11:32:42, Stephen Rothwell wrote:
> >=20
> > The usb-chipidea-fixes and -next trees have not been updated since Oct,
> > 2021 and the -fixes tree is generating a conflict when merged.  Please
> > clean them it up WRT Linus' tree as the only patches in them have been
> > merged as other commits.
>=20
> Sorry about that. I have a little busy these years, the USB patches
> which went to my tree will go to the Greg's USB tree directly, I only
> review these patches now. Would you please also delete my tree from
> your merge list? Thanks.

No worries, done.

--=20
Cheers,
Stephen Rothwell

--Sig_/d_w0jRhXnI9CxJ90Vtxpxfg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJRG+gACgkQAVBC80lX
0GxBjAf+MG3c2L5nDdAbGma+1CZDmtxZ0dStXqVwo7hueewdxKNE7dgoBAssgOtw
hFxaw1LNrI+iOjg790jm2PlESnNP2vTBu2u4SHSdwHA0VN+pZw1cGwU9g2ooR5/r
Q05+N+bfdarzacPK0U4IPRtPnksmmnetVnLHes3nWONhhHmNuIjiGZ6Qmus/t0Ub
sBMlLfTT+bDVMafRDuiiMzttjsrl/+2wQyJU+nRNNPOojxgjpABVpBSs02WuPOfl
yZ4+w2fQNXQaePXP35ETBpLRaHBx/Ctej+E8V2qvoRRz0MHrq0bQOp1R7pUxJswe
wwopiA+KIJxvGGHzqxM+qDOUHxmnAA==
=z+zR
-----END PGP SIGNATURE-----

--Sig_/d_w0jRhXnI9CxJ90Vtxpxfg--
