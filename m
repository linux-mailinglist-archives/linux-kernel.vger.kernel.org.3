Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F224DD54C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiCRHij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiCRHij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:38:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527491275C8;
        Fri, 18 Mar 2022 00:37:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KKbSZ1ZH6z4xNm;
        Fri, 18 Mar 2022 18:37:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647589040;
        bh=IKLDZdzuNP/RMd5I9+dikiLBg/WA/Pgy519XXzgDQ5s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q9ord5kVayLaoKNEHsNpmSLYa5QoidyIGUQ8BFwGCJU+UjNaCMUzjnLVN4nIVDwtQ
         UPpOs101i55rtraGWo0gZFmt0CZUgz0y1k+LEN7nnkwcgwdC+eW0LcXHtkM28G4Wuj
         GqdvhdKRsJTNO1GB//gcNYf5XRINq75EyJ+WXqH3yZXA0IAn0ITdYGj6cFA9bzR8wo
         ijy1NNXRPhr1jSn1jMOWuFwiIWjjFrc8Jz7mKP/fuEp3K/bdL+8SwuqmvJZYsu8PcX
         XlSZi2nNkt3CPJkBsVYqKG5TD4s11e07Nw5XkaaXbCim7Y/y0/cy/J2osuh4fVTsZE
         PKY/sI+nF0QVg==
Date:   Fri, 18 Mar 2022 18:37:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Gross <agross@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux-next: manual merge of the usb tree with the qcom tree
Message-ID: <20220318183717.7acac615@canb.auug.org.au>
In-Reply-To: <YgTGihSrtlRR3DPC@kroah.com>
References: <20220210141100.715b13e9@canb.auug.org.au>
        <YgTGihSrtlRR3DPC@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4cOHKNki2dlAKpjqULnr5b9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4cOHKNki2dlAKpjqULnr5b9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 10 Feb 2022 09:02:18 +0100 Greg KH <greg@kroah.com> wrote:
>
> On Thu, Feb 10, 2022 at 02:11:00PM +1100, Stephen Rothwell wrote:
> >=20
> > Today's linux-next merge of the usb tree got a conflict in:
> >=20
> >   arch/arm64/boot/dts/qcom/ipq6018.dtsi
> >=20
> > between commit:
> >=20
> >   d1c10ab1494f ("arm64: dts: qcom: ipq6018: fix usb reference period")
> >=20
> > from the qcom tree and commit:
> >=20
> >   5726079cd486 ("arm64: dts: ipq6018: Use reference clock to set dwc3 p=
eriod")
> >=20
> > from the usb tree.
> >=20
> > I fixed it up (I just use the latter) and can carry the fix as
> > necessary. This is now fixed as far as linux-next is concerned, but any
> > non trivial conflicts should be mentioned to your upstream maintainer
> > when your tree is submitted for merging.  You may also want to consider
> > cooperating with the maintainer of the conflicting tree to minimise any
> > particularly complex conflicts.
> >=20
> > --=20
> > Cheers,
> > Stephen Rothwell =20
>=20
>=20
> That is fine, thanks.

This is now a conflict between the usb tree and the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/4cOHKNki2dlAKpjqULnr5b9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI0Nq0ACgkQAVBC80lX
0GyGaQf+I25Ts5WbkH3++SiIm4wI2ANOEX5YG5EvG4IbI1gHlZWVm2nCU4/A5ymM
/N88UMBctFey13drC7Zi5iI14nA9LFugeeYwkHr0bPDnUyi2ry1mwwrPV4wunQ2a
6l3H/cj9LoWSS8HE+MvATxs97bQo6K7QUlNMYpdj6elb777KB6SucSb1xBZjqmks
T8giG8huyAtFarjY86dKsU1KASvcOwjz1mIXqG8bks+q6EE2FbbjqIPKWFCAJ+EK
CtVvCtx8pJyuGrWmrH3u/yGHffWVAfZlaihiOvkqMusIKtv845zX9PpkDKQTDNRL
wrD7AxU6wMOA0Qf9OG/Z90nydyFHGg==
=+A03
-----END PGP SIGNATURE-----

--Sig_/4cOHKNki2dlAKpjqULnr5b9--
