Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A9457421B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 06:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiGNEK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 00:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGNEKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:10:54 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9692325286;
        Wed, 13 Jul 2022 21:10:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lk1Hl650nz4xv2;
        Thu, 14 Jul 2022 14:10:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657771845;
        bh=EUpWvg4QeToN890n80xBxk7BRkOA+3mQaqTGlvqBQmM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F+jvUdKbNgqi3JGovX1u5sSpDI+E59O/McJVyBG1/HCTGDHiAIhMJnit7oDAJ93K8
         3S4nOKpCWBsWvAk7D9b7aEMPL3D8Shcbh0GuBrL0WJZf1sg0KZto8FS7RihIGTl4M3
         iLJxiTOvnueniGambMW15iQfDcKqq4JwyEma+Q/rjIvaN5kFzAwGNmod/vzcGzadNZ
         Cqd1RsrBUYXxpaVCe77VIGgie/KsQ7MHbkR1HcxB0vnVbzSupB5os6iC98v5MjhR9r
         jqCznz5VGDqRyUMJOPhBoRSRtolDzIrwDupDWHstjx0zNMD/ICm+KpP/74dGDY3xnX
         7jzAVyAjI/DXw==
Date:   Thu, 14 Jul 2022 14:10:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greg KH <greg@kroah.com>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Zhang <william.zhang@broadcom.com>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux-next: manual merge of the broadcom tree with the spdx
 tree
Message-ID: <20220714141019.43b45f68@canb.auug.org.au>
In-Reply-To: <8a37363d-f4d9-669c-9cc6-3e76b9417352@gmail.com>
References: <20220711095520.4fad4c97@canb.auug.org.au>
        <20220714091321.4ecfe830@canb.auug.org.au>
        <8a37363d-f4d9-669c-9cc6-3e76b9417352@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lJqVZN6pv+jUawIO4gp_rCc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lJqVZN6pv+jUawIO4gp_rCc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Wed, 13 Jul 2022 16:26:33 -0700 Florian Fainelli <f.fainelli@gmail.com> =
wrote:
>
> There was a link in the cover letter that I sent to the arm-soc
> maintainers referencing your first email. Not sure what else we could
> have done to prevent that conflict.

Nothing really.  Hopefully between the 2 notifications, the arm-soc and
spdx guys will remember to let Linus know ...

--=20
Cheers,
Stephen Rothwell

--Sig_/lJqVZN6pv+jUawIO4gp_rCc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLPlysACgkQAVBC80lX
0GzBtgf/d6Z8/LmHBwqo8RoTs1coEoOF30gOGkb95r0e+qTlMtjyfS7oFA/+Jrok
qdLmsdKDnzLNBXTJQ0tAg8BAmKY99YKKfn7Fx0Z9yu3+IfgWLwCT3FntpzH2oUKE
MQqirs1slSI5iR3m3/s72/Ivgoh9I1ddIwI+d4J496MRRUZJkbZ6Tf5V2Yb3nRS/
mHFdcQbWn4nNpf1fT4BcXaR2HZ8e5lG4OjJoAmirp1rKexMn0Nr650+zr84L/aap
9fq+dBiw0urhl4bBIfqyYHNjY5s2GF00B0Jdm7h0rmqAolWQPXDkDUyt2FFARV9w
u0/aEJB4QuwDekcuMjQ5hKfthNQ1Kw==
=suHo
-----END PGP SIGNATURE-----

--Sig_/lJqVZN6pv+jUawIO4gp_rCc--
