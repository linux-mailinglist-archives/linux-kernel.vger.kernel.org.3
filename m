Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ACD58AFC4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241341AbiHESdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241324AbiHESdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:33:43 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508157AC2B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:33:41 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <riel@shelob.surriel.com>)
        id 1oK28b-0006gI-Hj;
        Fri, 05 Aug 2022 14:33:33 -0400
Message-ID: <82b27eafe952c9f5a8ea6a8bcd902a38e2b2c77a.camel@surriel.com>
Subject: Re: [RFC PATCH 1/5] entry: Pass pt_regs to
 irqentry_exit_cond_resched()
From:   Rik van Riel <riel@surriel.com>
To:     ira.weiny@intel.com, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Date:   Fri, 05 Aug 2022 14:33:32 -0400
In-Reply-To: <20220805173009.3128098-2-ira.weiny@intel.com>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
         <20220805173009.3128098-2-ira.weiny@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-JFh7ZqUa7s9ijmyuP8qU"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JFh7ZqUa7s9ijmyuP8qU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-08-05 at 10:30 -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
>=20
> Auxiliary pt_regs space needs to be manipulated by the generic
> entry/exit code.
>=20
> Ideally irqentry_exit() would take care of handling any auxiliary
> pt_regs on exit.=C2=A0 Unfortunately, irqentry_exit() is not the only exi=
t
> from exception path.=C2=A0 The call to irqentry_exit_cond_resched() from
> xen_pv_evtchn_do_upcall() bypasses irqentry_exit().
>=20
> Make irqentry_exit_cond_resched() symmetrical with irqentry_enter()
> by
> passing pt_regs to it.=C2=A0 This makes irqentry_exit_cond_resched()
> capable
> of handling auxiliary pt_regs in future patches.
>=20
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-JFh7ZqUa7s9ijmyuP8qU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmLtYnwACgkQznnekoTE
3oP1FQgAq/4oo6OX183QaOkso7rRPPrz42VmLpnAYpRbCi6GYzGZoFVrActKJlh1
LnC28neeVEwVQmhYKzX/DPfTjeY+CTzyRG1NHb4PtZlLU+glH25HqVF4ag8YRnmg
ULrXIq47s8WkfQya1Ps6a1ypp1B4hO5nAaOqMzsv5d9vynG3sCs5MD1PQu97UVUy
HwPzeaXPHcYQ8L9Vm7goEW4DlQjBZvDK24GtW8/24GCaIEeoEXXHxgVbZicM9eeT
R29FN520lXJEvINZpvvi5PBIbrF/5gV37plJesGyu/DWP8xq4NknFhg5F0SuCpPj
SuQz2fiaSDoQQrPlizq35kI39cVnKQ==
=c72J
-----END PGP SIGNATURE-----

--=-JFh7ZqUa7s9ijmyuP8qU--
