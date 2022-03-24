Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52714E6262
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243592AbiCXLYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242748AbiCXLYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:24:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EAAE0E1;
        Thu, 24 Mar 2022 04:22:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KPN9t6bj4z4xQv;
        Thu, 24 Mar 2022 22:22:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648120964;
        bh=F3k3olfaRXpJNR9IQ1M/I1TDGs3xPsbBq+98VlQDp28=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ptjLyEK8ZgZcHaeTMiEIcsDp0uSS48XlNQcLpB6t7fCPnq5//2sJQ90QvK32CLSHk
         40Sf0vASPcDFWv1SngSJUDWZ8leEQjoX1PP6QDbQ15qihSCMYoYlMYu9k+YxFaE545
         IGzwgxLmVxjCSLgIJQ9iqda2cX/v5ATuz0Fdxe6r4hGrG8B/lUkTKUUwDN2nNJ2evf
         5b2VGMqFh8UIypL3y0m7BHXmQCNmK6B720/azFs69ySdMP1arDrC+/b+lZCpzHatoA
         XhPwIZIxok5Vkd003HbCBMf1Y0ZXrLH1dGoHGWndVNLavYtuvHSG1nQ34kwXhX+mPe
         dFyf250A/hfuA==
Date:   Thu, 24 Mar 2022 22:22:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: linux-next: build warnings after merge of the drivers-x86 tree
Message-ID: <20220324222241.42896e9e@canb.auug.org.au>
In-Reply-To: <2f33bdce-a002-708a-dd65-7bfb6ebc4cd9@redhat.com>
References: <20220301201659.45ac94cd@canb.auug.org.au>
        <20220324183329.22c97ea1@canb.auug.org.au>
        <2f33bdce-a002-708a-dd65-7bfb6ebc4cd9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/whk1pzxo15pA9p2wo.zZlZE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/whk1pzxo15pA9p2wo.zZlZE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Thu, 24 Mar 2022 08:39:19 +0100 Hans de Goede <hdegoede@redhat.com> wrot=
e:
>
> I replied to your original report on March 1st, but I never got a reply
> to my reply:
>=20
> """
> Thank you for the report.
>=20
> So I just did:
>=20
> touch Documentation/ABI/testing/sysfs-driver-intel_sdsi
> make htmldocs &> log
>=20
> In a repo with drivers-x86/for-next checked out and checked the generated=
 log files.
> But I'm not seeing these WARNINGs.
>=20
> Also 'find Documentation/output/ -name "*sdsi*"' does not output anything,
> is there anything special (maybe some extra utilities?) which I need to a=
lso enable
> building of htmldocs for the files in Documentation/ABI ?
> """
>=20
> If someone can let me know how to reproduce these warnings I would be hap=
py
> to fix them.

Sorry about that.  I am just doing what you are doing but with the
whole of linux-next (which I don't think would make a difference).  One
possibility is that we are using different versions of the doco
software.

I am using Sphinx version 4.3.2 (using Python 3).

[Adding those who do doco to cc for advise]
--=20
Cheers,
Stephen Rothwell

--Sig_/whk1pzxo15pA9p2wo.zZlZE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI8VIEACgkQAVBC80lX
0GzF9wf/WDZFn7AtwNBLxsjCD6KLiIZTQF0ErZAKkaX6a6Xi+BV/jnTy69bcs1SD
jqYETCvxr7NFGr+2iwnDESQO1DpOk723MXE7MqvRg6Ij9bpoxgt5pA/s3kLzhsKc
vnEwE0K/OuOMQOBP2T5YOGUusIhfDQIX95mQs2mynsLt2RM7pKx4Dvf285bc6NdI
44shUxnSvNMZaBSlhXi9MLcgnHJzpaTyutExB0BMjq0a9XW/pVOaIlpd7ZYRYanW
NHFLCJtoEl0rnZH7PRwYJTF9+5GjFiyZ888gvowx/gX3zdCd+KiOG/r95P3LCPCT
4bBGy0MlNHCHkojrI8soRzGsvWSKVg==
=ptWH
-----END PGP SIGNATURE-----

--Sig_/whk1pzxo15pA9p2wo.zZlZE--
