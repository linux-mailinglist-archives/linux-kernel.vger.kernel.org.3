Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7794A00DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350712AbiA1T3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:29:14 -0500
Received: from www.zeus03.de ([194.117.254.33]:59932 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242610AbiA1T3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=DbyGkOtNDLmJ11IoUBIoQIwbMk4Q
        v7a7wS/TdOkN6GE=; b=m/IPNpLIsgtUhglDACnaOzWJQBBr1P+GJ3Z5ycQI3Tf2
        rsb1wKQVu9V6fztSObNkhmMoM56DYk+czEnC3ltInL2U7LSTQ9CRe6PzH3C6drV5
        GMCiX+C1aKjJcBEBNMu5dmalpDQyh6holyWi4lzO0b3KV9ib3zJdrCqQqHyzJ7A=
Received: (qmail 350951 invoked from network); 28 Jan 2022 20:29:10 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Jan 2022 20:29:10 +0100
X-UD-Smtp-Session: l3s3148p1@oy7HcqnWrLK8ahEL
Date:   Fri, 28 Jan 2022 20:29:06 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Krzysztof Adamski <krzysztof.adamski@nokia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: move efi_reboot to restart handler
Message-ID: <YfREAiRMjQ9ci4LC@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <YfP0osb45uJldtM9@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1PII+0ii8SgDzVgd"
Content-Disposition: inline
In-Reply-To: <YfP0osb45uJldtM9@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1PII+0ii8SgDzVgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	/* We want this to take priority over PSCI which has priority of 129. */
> +	.priority = 130,

Is it an idea to add a #define for the PSCI priority somewhere and use
here the define + 1? Hardcoded priorities look a bit fragile to me.


--1PII+0ii8SgDzVgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmH0Q/4ACgkQFA3kzBSg
KbZBZg/7BFmhSj7Km1jb3GhobF5TQI93V4dJCot9fJ5Og6mEnv/VGHv8Tr5qi1bS
KrZKekCloCv8CDg8TLY6H4+ODK3guJfZiMqhE3o3CRnME6ZD0GTLvuRdJ5rVxf/z
NU0r5tNKnVL51OH29H/VK/L35JziiV1kvpwpUbT7iGXS1Sk4UjLDpyA8iVJAx7Ul
VcvgjdMtxv9CdIXup9opMQhrCLjyLVK6MydnGoyCfqviz6BKdwwRqn1M6KLk+7YQ
okmwOwwro/MFRPAP4Tl9fF+UHyDPYL2EekN6Sh5p1QKQE+z6SyN7vSBS/ziybw9l
2rmFRuCcV2Tt5YKyrxtRaAMkFuGEKjHKf/+BimHdBZZawosg+M2likmcOxe3RKA4
EW3iCtE7ZsROJ+xmvtwPyphGrpPqq5uU2vesq5U5eJJ4EbiO3/+UxVn1fjunM2Zr
g6I6aUq+KCahlMu1PX4hW9oOg3m3s2DPlgZYBqU65E5j0WlxxqrFpwnEA9/MCpGG
vaTkrGbMuZTFVlp4lE50N3Lscp+geKO21ogIzedUAuej3h7C/x1oPSA6p/gPjfB9
YqymQzoBPP2GbejltfaeNooM5ZZyXxLG3LbEy5/ox75lMmrAoNfhBu+tOnvQWdB4
KCjCNvqpz9ODp7jvY1Bld3GxEokY4oiHIE4eqqKDVK3YdNjKvd4=
=6G4K
-----END PGP SIGNATURE-----

--1PII+0ii8SgDzVgd--
