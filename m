Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E115248E1E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 02:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiANBCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 20:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbiANBCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 20:02:46 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0848C061574;
        Thu, 13 Jan 2022 17:02:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JZjhK5l4fz4xtf;
        Fri, 14 Jan 2022 12:02:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642122162;
        bh=M141uA0Im2Hud7b7HD5pRH7hxR5HLZew7H/Em0uz5F8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aBX9q3LT7VgKBq97UcsruZbxQEEEqtRyPRC6pMB8NTmuYzZW+Wwnu2o6BNI96nxA5
         fJCqCgapfXI7tAY/Sb6z306cNo/ydkFXiRLsRluFzmp3Ew33fvrB2bJKrqNIFVwl1y
         2pj43GM0koK+PAK+XfI0nrGSJkkDck0gyd8yWFcxiOdSZ8KFjtd/MzsgSQqYSt3zE1
         //h/sYIRPGwV0yiB+QvhNa+nG3rbim69KXjfoF3071dveechIpPSQmREZoqfHoVR8u
         y9KhPjcaX7WLkWRLZLOXVAsRtg714EZjTtMhec50ySQaOgTLlUxauWmDWtd6MwK00g
         wwCt9ATDwdj/A==
Date:   Fri, 14 Jan 2022 12:02:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yinan Liu <yinan@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ftrace tree
Message-ID: <20220114120240.4b592480@canb.auug.org.au>
In-Reply-To: <20220112113103.7e03448f@canb.auug.org.au>
References: <20220112113103.7e03448f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wnYUD+_he4wYAMN/08IXqt_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wnYUD+_he4wYAMN/08IXqt_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 12 Jan 2022 11:31:03 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the ftrace tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>=20
> Inconsistent kallsyms data
> Try make KALLSYMS_EXTRA_PASS=3D1 as a workaround
>=20
> I am not sure what caused this - maybe commit
>=20
>   4f1f18311591 ("scripts: ftrace - move the sort-processing in ftrace_ini=
t")
>=20
> I have used the ftrace tree from next-20220111 for today.

I am still getting this.

--=20
Cheers,
Stephen Rothwell

--Sig_/wnYUD+_he4wYAMN/08IXqt_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHgy7AACgkQAVBC80lX
0GywVQf+IhUpgidbLaQEOV6MPgWQ8cxv8mMsZ7gaNLc/sYZ1Q7wBv8qA01SxnDCB
xEpML44palAVdC2Vc0hV2NosJjxFPEIM+aCWT1MPPLEp6IYITivuMk8tCZL2ztQ0
l9ityiL4izNpOhi90+7PebKMA1OMHWPgUrPIE8hvwPtSpz1R1ifXbKlvbIXQgYQt
itKdl7/8w0XGR6qPlNystJwzp2K5Sg2M/frxCjvfptCxlXHqALClEibmw1sYdGiR
wmfog3D8SrRV34cLemugYx/xuy1CYlY7ytjWSHfye7PVit1OwlVQlOuIEBfEY2cv
26hvv6DGrm/8psO20RYr9XoXeApGaA==
=9VNf
-----END PGP SIGNATURE-----

--Sig_/wnYUD+_he4wYAMN/08IXqt_--
