Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15340518FEC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242773AbiECVZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiECVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:25:47 -0400
Received: from zeus.flokli.de (mail.zeus.flokli.de [88.198.15.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAC141335
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:22:13 -0700 (PDT)
Received: from localhost (unknown [95.179.247.40])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: flokli@flokli.de)
        by zeus.flokli.de (Postfix) with ESMTPSA id 751E713053D4;
        Tue,  3 May 2022 21:22:09 +0000 (UTC)
Date:   Tue, 3 May 2022 23:22:10 +0200
From:   Florian Klink <flokli@flokli.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        ValdikSS <iam@valdikss.org.ru>
Subject: Re: linux-next: Signed-off-by missing for commits in the hid tree
Message-ID: <20220503212210.mqv3kxderfxesrue@tp.flokli.de>
References: <20220503073428.219a0ed8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4jchgaoyic3wz72q"
Content-Disposition: inline
In-Reply-To: <20220503073428.219a0ed8@canb.auug.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4jchgaoyic3wz72q
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hey Stephen,

On 22-05-03 07:34:28, Stephen Rothwell wrote:
>Hi all,
>
>Commits
>
>  5c9b8fae88bc ("HID: lenovo: Add note about different report numbers")
>  a0a5c2a69699 ("HID: lenovo: Sync Fn-lock state on button press for Compact and TrackPoint II keyboards")
>  24401f291dcc ("HID: lenovo: Add support for ThinkPad TrackPoint Keyboard II")
>
>are missing a Signed-off-by from their author.
>

Yes, this is "intentional"/expected. See
https://lore.kernel.org/all/20220121124116.cj6xtxvzw7rbkcs6@tp/.

TL;DR: ValdikSS doesn't want to use a real name, and asked someone else
to send this over (what I did).

 From my email linked there:

> It seems the "real name" requirement only applies to the Signed-Off-By
> (not Author) field, and sending a contribution provided by some other
> person is covered by (c) in the DCO 1.1.

Regards,
Florian

--4jchgaoyic3wz72q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEdQpT8aoDC+ls4wqU86BgVS9TAioFAmJxnQIACgkQ86BgVS9T
AioWSQf/VnCCI6BpVnr8UEdcvuhoXUBINxKuXbzd33QwU2nqY4B8zpnrUT4WDgCa
MYegYkEotroZy9UMWTGHuXYinPAjKIDdQwlbxCeGxpqsdnwATi3d/B3oGZAYDQBj
OUUQ36bMPWzP9Euv6D/x+ImX+qS5tXeFgiUnT9Kl8qfJTc3cAxL4QHywly+qmxgW
SziBhbI9kzQpfbfeazZNlxMW8OjUFLcwZKASBfaHn5qZIyDs5SrtV3kmmarNDBWg
Y7hKjbrMQVSTN9Kj6wi82HrpUqs1uk3fCjfPjDtpw5301g6ErqiBaa3WIxFYcEMc
RqoDQrIuSXlh37fgB71J5Y7jNzQbew==
=7cP3
-----END PGP SIGNATURE-----

--4jchgaoyic3wz72q--
