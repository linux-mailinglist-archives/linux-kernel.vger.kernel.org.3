Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CC558A4E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 05:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbiHEDCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 23:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiHEDCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 23:02:03 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F026E2E7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 20:02:02 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <riel@shelob.surriel.com>)
        id 1oJnb3-0003Gm-HD;
        Thu, 04 Aug 2022 23:01:57 -0400
Message-ID: <17b83f59efbc568c1fe3154f82a5300f3b4cfe24.camel@surriel.com>
Subject: Re: [PATCH v2]  x86,mm: print likely CPU at segfault time
From:   Rik van Riel <riel@surriel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Thomas Gleixner <tglx@linutronix.de>, Dave Jones <dsj@fb.com>,
        Andy Lutomirski <luto@kernel.org>
Date:   Thu, 04 Aug 2022 23:01:56 -0400
In-Reply-To: <YuwpQEYCwTl+m6j5@gmail.com>
References: <20220804155450.08c5b87e@imladris.surriel.com>
         <YuwpQEYCwTl+m6j5@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-sfo3Dr2t/UfbUKbWu9TK"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sfo3Dr2t/UfbUKbWu9TK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-08-04 at 22:17 +0200, Ingo Molnar wrote:
>=20
> I've added the tidbit to the changelog that this only gets printed if
> show_unhandled_signals (/proc/sys/kernel/print-fatal-signals) is

The show_unhandled_signals variable seems to be controlled
through /proc/sys/debug/exception-trace, and be on by default.

Enabling print-fatal-signals makes the kernel a lot more
chatty, and does not offer the same value in my experiments :)

> enabled -=20
> which is off by default. So your patch expands upon a default-off
> debug=20
> printout in essence - where utility maximization is OK.
>=20
> Thanks,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Ingo
>=20

--=20
All Rights Reversed.

--=-sfo3Dr2t/UfbUKbWu9TK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmLsiCQACgkQznnekoTE
3oM/ywf9HSQSyIONKrJrIXMTu8dioxtpaXBB5mYPrWK3LS1WCbblGzd1WxU9VO3G
3K8VVUfXd2FL8zRE7kmXYlu6qwRY5V0B9zmH8E0uG29dpMHcMRxN0Z7fH1MTbB+O
a0l/vZlw/wYpUJGku7ww/2Wm0AKXvfOKqt6uLUlE4GrwA2kSOVWyZlgCVbC22gpV
RyyjnXyAi5veIJbCcqFPInkay48dR3Ls3tVHs6sdbcz5qJH6KohkQQB+qrKs5GBK
JT1qjgqgBipjTIz/YOzhZac2GCUyXwwYcXN142fi9gB38Ck+ihKxogk3cgT9RkTO
QyjKN/farKOgDuHKGRT1GBVLNn54LQ==
=HJ8/
-----END PGP SIGNATURE-----

--=-sfo3Dr2t/UfbUKbWu9TK--
