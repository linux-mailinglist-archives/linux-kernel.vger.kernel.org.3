Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D9E53B1E3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 05:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbiFBDTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 23:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiFBDTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 23:19:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413CF23CA1C;
        Wed,  1 Jun 2022 20:19:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LDB835sp2z4xD9;
        Thu,  2 Jun 2022 13:19:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654139973;
        bh=E+//hDsmvB3zuaCgRs7jMhl87gw5tuJD7IgL5GScDHA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TVkIK5XIg4kyfsC5a9bC5GfryB82JhSKHSQnd7MqFdT0X4T/ouRzFY0NrBogxNd5e
         +R7fzQqLEwvthSt87Js1JHukj3bXIPJdaikpTFKmpHnekLkMfheq2+pXbl5pM2KH3F
         aQm8vKsYtWUco7HSEca9npUQDg9mv+KsqkDEJlr1R+0vYKV7BADMk9NWqQ8VzCPFCi
         Rl+ZlhUl73qlI5GRk/Y0LdlloWJx/g33tozVQ8d6W3VOAQIPARvVZKI1At8tbgx/mq
         aKRhepZuSrHMO0+7X34hkMgfiIuJFxfFQiVAIt8qqsNtwTZkPj1Yyc6xhCQX9WZvV7
         MOZD39uJqHmTA==
Date:   Thu, 2 Jun 2022 13:19:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Bo Liu <liubo03@inspur.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vhost tree
Message-ID: <20220602131930.1128f31f@canb.auug.org.au>
In-Reply-To: <20220601060641-mutt-send-email-mst@kernel.org>
References: <20220601114240.1dafefc6@canb.auug.org.au>
        <20220601060641-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OOpm8wCH_V1MHxEsTg=xXo5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OOpm8wCH_V1MHxEsTg=xXo5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, 1 Jun 2022 17:57:12 -0400 "Michael S. Tsirkin" <mst@redhat.com> wro=
te:
>
> Indeed, pushed a wrong tree :(=20
> I hope I pushed the correct one now, pls let me know whether this is now =
fixed.

Looks good here, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/OOpm8wCH_V1MHxEsTg=xXo5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKYLEIACgkQAVBC80lX
0Gx/Ogf+NqMYbRqN7YYPqiGpnN2w3EOIw9k6jdYC73uKFWMzXqJTPSrOFZbET9Do
9YfpxUfBIM9jCIqYqBJgLt1yF4rig/dLlHNXZy4mnKtF8DyVBN4JRHawaqc0UWxY
n4iUGcDoEX2QZegLShH8BvEem3DQQblfP1Tm4mpa4Iv1xGpoPvI5vKe27nOS0xvc
TCR+dzRw/tSKhitwFxFj+/IfWFuRXiPj3/tIZWceSzTIqVGF+bZ9KeMCZ86WaKo+
kC8kR9L94+Vmi2Nzy/c3kohjlPBTx+PprAk2qGnbVK+7aA4vSHtf4mHxbpOPXmNP
vX/qGZoA4oFAcIrOKlBs6XQaZVOH6g==
=Ks2b
-----END PGP SIGNATURE-----

--Sig_/OOpm8wCH_V1MHxEsTg=xXo5--
