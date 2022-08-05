Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E150F58AFFD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241203AbiHESqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236261AbiHESqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:46:05 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081A79FE0
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:46:03 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <riel@shelob.surriel.com>)
        id 1oK2KZ-0007Fp-E0;
        Fri, 05 Aug 2022 14:45:55 -0400
Message-ID: <759cbd16bbfc8a9fcf797ae15bbe60aa656a0564.camel@surriel.com>
Subject: Re: [RFC PATCH 3/5] x86/entry: Add auxiliary pt_regs space
From:   Rik van Riel <riel@surriel.com>
To:     ira.weiny@intel.com, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Date:   Fri, 05 Aug 2022 14:45:54 -0400
In-Reply-To: <20220805173009.3128098-4-ira.weiny@intel.com>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
         <20220805173009.3128098-4-ira.weiny@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zLqFce/ErqDZh/fhYKX5"
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


--=-zLqFce/ErqDZh/fhYKX5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-08-05 at 10:30 -0700, ira.weiny@intel.com wrote:
>=20
> Prepare the assembly code to add a hidden auxiliary pt_regs space.=C2=A0
> To
> simplify, the assembly code only adds space on the stack as defined
> by
> the C code which needs it.=C2=A0 The use of this space is left to the C
> code
> which is required to select ARCH_HAS_PTREGS_AUXILIARY to enable this
> support.
>=20
Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-zLqFce/ErqDZh/fhYKX5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmLtZWIACgkQznnekoTE
3oNvdAgAhf5rGb/Xlju2A8jRn8eYcfo7iEJbdN7vL5ZD39iipjPGuj0Rsdexcn9t
NoQpWQBhj6e5fDwEijT3vVZPvW1Co0RaqsHuBPXRHPaxHyVxWxJLu1BD2xlpryQW
lThNqYYNmHGO1eDml+1tZRu08fSO0P+t0jccU4r4mtqVDOmn5uLmiMH+OwjvpqA9
KbpYS6F9rPxvYuKFn0SyZhGXb0lLeOrcNXjDY8MehRFrGKFtWdyAzJmsR1/FUuhF
mEwYxkK6NvWEYu+hjyXzKfXR/cgSiXuqgRnOsa6Ok48Ct1NYyalKQoPWletBOJuZ
/m0Zmu5Lm6Q2x9YXPxvnbHPNf3BEPg==
=5n6L
-----END PGP SIGNATURE-----

--=-zLqFce/ErqDZh/fhYKX5--
