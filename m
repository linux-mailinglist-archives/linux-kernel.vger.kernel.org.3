Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AB05994D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346309AbiHSFsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiHSFsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:48:12 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F68DB6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=U5coVC/zGS6DWIvCheW2Ak7LyT3S
        RdDMZFsyY6wUQM0=; b=mOhiFL0HLxl0NhNx0gBTqq0IK4H4EArtu/PeGPM0jQgQ
        ZPsPLUMoQDvNTauOdt+9+GE5/+RYYfhjktxDp9Sm3PXn0Teal9vz+VqOoAi7FM2X
        OaMPWcFrnU6nqDhsEunTsOWOaDTwSgzXoDXBZyjCoxFmlO6iESQyTPBvAYOZcdg=
Received: (qmail 4113229 invoked from network); 19 Aug 2022 07:48:09 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Aug 2022 07:48:09 +0200
X-UD-Smtp-Session: l3s3148p1@i/mVpJHm+L8ucrTL
Date:   Fri, 19 Aug 2022 07:48:09 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Subject: Re: [PATCH] cifs: move from strlcpy with unused retval to strscpy
Message-ID: <Yv8kGdt8e/VgLRxY@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Steve French <smfrench@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
References: <20220818210142.7867-1-wsa+renesas@sang-engineering.com>
 <CAH2r5muBD8AV51ZQMapGoXyF=5Mk0GW2tYz2ng9XrhKRp_b96g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hqqaMmxIJ06FJ7g5"
Content-Disposition: inline
In-Reply-To: <CAH2r5muBD8AV51ZQMapGoXyF=5Mk0GW2tYz2ng9XrhKRp_b96g@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hqqaMmxIJ06FJ7g5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 19, 2022 at 12:00:34AM -0500, Steve French wrote:
> Looks fine.   Do you want this merged through my tree?

Yes, please.


--hqqaMmxIJ06FJ7g5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmL/JBkACgkQFA3kzBSg
KbbAbg//QVHmt/y7zDwyraqBCXaN7RgJoNT8iXiv2JmkGcmRDVQmzKYjfawD4uFA
ytO8JVkX56psgiPzb8JOMT5tfdDbGDq6rxJvByWiMcJ4x4FcVMiEvh0l2usCpWaR
zjvFYIeU+CpV/j7dOJ3JGa+KV/PcvKd+R9MVrcaV0ZxtE6pgIsLpVC6TAAxD/uRW
U2213dAc3QG0qcvIrZe86X0ZJOKGc9zl8bwjW2rqRQLEizAIAlKvjwCwHd7pMcDr
20wv/pVDEjQCYzUe+L0tV7S41oM7hr2GsrFS9D3UuyRLc7JhGCMMJYrAqDMb5fsA
x1s/SLqYH1AE6eziiSSelEpFoEyHtvDHnnN0j8lsTwn1BcP08h+EbU8xleT2XJAE
XU2J/UDXV6wU3lXN7coG4Tjb8EiKtCQ4Box9B6V0osvJwYYiKgbKmk8z/3UcNxyn
NMj1tGoSg6N9V+rnM5mENCLoQAPXR3ysHVkPqW+aKwQZLIDtsiISsM83VjQX/QTx
XIoqTlbrLAdWwM32XYkvFuxsBYU/bOmIY12SUPM0N8ZybcU1sTtwvCavX0Wkdgtl
GkLAFnSdl4Gg9o7Nr25G42IW8+m6zb/qP3o7VKegjQjG8EF3QQ9RJPLqVgJSBETF
7Fiq9UmD+SZBAczpaYa6IVZGDs6OOGIe3fcZU2+X8jlGV618Cpk=
=GNvn
-----END PGP SIGNATURE-----

--hqqaMmxIJ06FJ7g5--
