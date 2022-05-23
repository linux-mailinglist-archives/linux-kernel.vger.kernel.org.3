Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A2153090A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiEWF4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiEWF4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:56:16 -0400
X-Greylist: delayed 577 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 May 2022 22:56:13 PDT
Received: from gimli.rothwell.id.au (unknown [IPv6:2404:9400:2:0:216:3eff:fee1:997a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD716477;
        Sun, 22 May 2022 22:56:12 -0700 (PDT)
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.rothwell.id.au (Postfix) with ESMTPSA id 4L65t34C7Hzyt1;
        Mon, 23 May 2022 15:46:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothwell.id.au;
        s=201702; t=1653284785;
        bh=Di2ytdI20hGLvdYTu+D5TDiSjO5bL6Fmj+Y5Mr1n9UI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p61dwhfIqraUBvusDZjXVmhi1S7L//Wylp+fxffPmqR/t8rAr7feaNgrNRD2uhxSY
         ISAtl1pbw0tkHh3v38L2pHOPFyqcSWLFbZmXuWmOJV9RJVpgMDlak62ilVdmr/IG/j
         f3sgtyRTnWrJ9fuL5dl/ZwmKuR+RVZBpOusaefBEROuPlOuSCKPk0fywELzPtiIpl8
         +ngkx8zKgTDghwL76Esj3UGwvUv7nOJLLW0tehUSTvpHVGboDXwq4G7j8US7ednldH
         +STNua4Fmh9ChrJBEOYyFk/ZhaBw0QbOn3TGm7k1sJqeSi12c5ecU/Sr9a+1ZlXHWN
         +ATLXj79MAoUA==
Date:   Mon, 23 May 2022 15:46:18 +1000
From:   Stephen Rothwell <sfr@rothwell.id.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with the kbuild tree
Message-ID: <20220523154618.69c5f126@elm.ozlabs.ibm.com>
In-Reply-To: <CAK7LNAQcRsuKrepsMiV20D+SSQQYWRqeoWqpo4UoQMtdW2A8SQ@mail.gmail.com>
References: <20220523142431.10ff2f77@canb.auug.org.au>
        <CAK7LNAQcRsuKrepsMiV20D+SSQQYWRqeoWqpo4UoQMtdW2A8SQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zluxm=Jzz5yePm7bHq5Ggbc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zluxm=Jzz5yePm7bHq5Ggbc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Mon, 23 May 2022 14:37:28 +0900 Masahiro Yamada <masahiroy@kernel.org> w=
rote:
>
> On Mon, May 23, 2022 at 1:24 PM Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
> >
> > I am not sure if I fixed this up correctly, please check the final resu=
lt
> > when linux-next is released.
>=20
> I think you can fix up around line 420
> of scripts/Makefile.build
>=20
>=20
> $(multi-obj-m): objtool-enabled :=3D $(delay-objtool)
> $(multi-obj-m): part-of-module :=3D y
> $(multi-obj-m): linked-object :=3D y                        <--- Add this
> $(multi-obj-m): %.o: %.mod FORCE
>         $(call if_changed_rule,ld_multi_m)

Yeah, I tried that, but it needed more - see my upcoming reply to
myself ... (which is probably overkill, but gets rid of lots of
warnings).
--=20
Cheers,
Stephen Rothwell

--Sig_/zluxm=Jzz5yePm7bHq5Ggbc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKLH6oACgkQAVBC80lX
0Gx3Wwf9El+4lthpJcxPmPWOWxiTDTEIFti7XxteURAqXoTgatfFXY6pPEn6yxQq
Gp4U/n4bsdfsquPlHF43ZzUwz96BgBbpRjztMu6daNNPvEjHYJcorFHylyfSBk2t
inwIwTg0zdGIEe5phEIWGr+3VShRd8WE4jwafajze7bJb4G96wd/XHRTkXW/87Hv
wpmQsD0OUzlnVX7c3Z9cn1BayjqkAYMzWeNRJ5R7lUIl5ozxrqbN9Wb5t2Gnmfsr
K1xGFuueLCVYZoG1nUiza6WjOsceZvG5wG0pLrCW4uLXTTZKOBSO/na3iY/Ff/0+
/T9NcoxvxyIII2SHqkIlzGSUYKdFWw==
=8MpL
-----END PGP SIGNATURE-----

--Sig_/zluxm=Jzz5yePm7bHq5Ggbc--
