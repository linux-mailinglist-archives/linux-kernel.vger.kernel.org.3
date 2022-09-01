Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD04E5A9B67
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiIAPTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiIAPTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:19:38 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A730685AB7;
        Thu,  1 Sep 2022 08:19:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id DE0C832009A1;
        Thu,  1 Sep 2022 11:19:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 01 Sep 2022 11:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1662045575; x=
        1662131975; bh=TNsoNCzvViKt3VcPND+jjvKdD2DvxsX4hTj2K9cQ/vw=; b=T
        a5eyiigbp+x5c8Y/UHnpVCKhAHsnBey1ieZSDl8vsBY60K4unlLyPdzzEH9Y5/HX
        ie7DhoM4iIcU880x20HjF+53RMa4x9k87CdkqLEU4N0wCqPzIVHm2bcpEhsMJLO4
        Uo/gKSR64mQ2TccWQwggjfeQG0JUwaHzSQcScuDkMb6Put31iaM2CgMIWIBaczRe
        GFSYSUbZ6My+qZchwsYTgUDVrHAc38nwp7hDUyM7588i5TcArOL9xLnMGT4zPTdR
        kIFkKAd/MSv0lI8VcY/Vv+ajH+7hkucPqqaP6DgGdDwHbUqUx1apLKkZkIbTMYL1
        nWhzFt8ssz8urfTkcZcbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1662045575; x=1662131975; bh=TNsoNCzvViKt3VcPND+jjvKdD2Dv
        xsX4hTj2K9cQ/vw=; b=3WSp8Tnxqe8RaUri7PlYqJrhuFNAHm1TC2xq9OUQqSM0
        0G47H4TCwzkRneRY6u6zpaHbArwTQSJSliJhvYoGu+l3RHXtMqATHnAGWTqh82Kv
        SZ/t9LmwQfD5F3A3M/e851P7NnryzZv0y2hzjaj1FfM+x/7shXYDYro6kxbzwYYJ
        0EqI2TlQP+nu4yRZBVAuA7ogHX63nCFoFCxuPasifwibx+HbN4NqpQKq6USviTSn
        Gw6O8qn12ZKN9h+Y3+IrVh0Fh06aFH4D1AvMONNApxfkyNjdK5/vR+HgmXcQ0AUt
        XPSAapu4QdJr3tK9X+3MpYvYWd0kLXLWyzr2gENhAQ==
X-ME-Sender: <xms:hs0QYxKpZ1XKy4wwd4LujSgZuWGuyHL71UAp-scer4GCkpgNsVwk5Q>
    <xme:hs0QY9JElz-Gc68gxl9eCaqFZe2tFBxmblf9ZQxfJVtO3DhEGvLPSuqmED-ogPERa
    eYhLdBzssMg4A>
X-ME-Received: <xmr:hs0QY5tRNYBM-ty79HXGH4k6nRwE-uz0zwMU6whxIm2BsRZsMT9Dvp6pY9pjK4kTnCMCqHivBXANchgDzvM5Ux_0fL9DeSLouzlo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekkedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    orredttdejnecuhfhrohhmpeforghrvghkucforghrtgiihihkohifshhkihdqifpkrhgv
    tghkihcuoehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeeluedtveefffeulefgudeiveeuffdtkeehveejieei
    gfettddtfefgkeehudetfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghk
    sehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:hs0QYyZtzGdvyajhCaRCO0mZPJ7mjEScTI9o_vwJkPTD1Z3mNoFyfg>
    <xmx:hs0QY4ZhZqutDJ6raH-9oRUev32IbvDD-_r3PZiLhfm4_LaxeIndCA>
    <xmx:hs0QY2CGpJLdNeqHBTUrBPmc17YSNiA2qppW3mhfTjQPO49QdX8SYA>
    <xmx:h80QY9N2OYa_YwTT1fAyMCyvNUGmwxYxImbFAiWKuZlidhc8YcTukg>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Sep 2022 11:19:33 -0400 (EDT)
Date:   Thu, 1 Sep 2022 17:19:29 +0200
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     SeongJae Park <sj@kernel.org>
Cc:     jgross@suse.com, roger.pau@citrix.com, mheyne@amazon.de,
        xen-devel@lists.xenproject.org, axboe@kernel.dk, ptyadav@amazon.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] xen-blk{front,back}: Fix the broken semantic and
 flow of feature-persistent
Message-ID: <YxDNgfyqypzWJrgH@mail-itl>
References: <20220831165824.94815-1-sj@kernel.org>
 <20220831170817.94903-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Pi/sglFMMbnoUUwn"
Content-Disposition: inline
In-Reply-To: <20220831170817.94903-1-sj@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pi/sglFMMbnoUUwn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 1 Sep 2022 17:19:29 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: SeongJae Park <sj@kernel.org>
Cc: jgross@suse.com, roger.pau@citrix.com, mheyne@amazon.de,
	xen-devel@lists.xenproject.org, axboe@kernel.dk, ptyadav@amazon.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] xen-blk{front,back}: Fix the broken semantic and
 flow of feature-persistent

On Wed, Aug 31, 2022 at 05:08:17PM +0000, SeongJae Park wrote:
> On Wed, 31 Aug 2022 16:58:21 +0000 SeongJae Park <sj@kernel.org> wrote:
>=20
> > Changes from v1
> > (https://lore.kernel.org/xen-devel/20220825161511.94922-1-sj@kernel.org=
/)
> > - Fix the wrong feature_persistent caching position of blkfront
> > - Set blkfront's feature_persistent field setting with simple '&&'
> >   instead of 'if' (Pratyush Yadav)
> >=20
> > This patchset fixes misuse of the 'feature-persistent' advertisement
> > semantic (patches 1 and 2), and the wrong timing of the
> > 'feature_persistent' value caching, which made persistent grants feature
> > always disabled.
>=20
> Please note that I have some problem in my test setup and therefore was u=
nable
> to fully test this patchset.  I am posting this though, as the impact of =
the
> bug is not trivial (always disabling persistent grants), and to make test=
ing of
> my proposed fix from others easier.  Hope to get someone's test results o=
r code
> review of this patchset even before I fix my test setup problem.

I can confirm it fixes the issue, thanks!

Tested-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab.com>

> Juergen, I didn't add your 'Reviewed-by:'s to the first two patches of th=
is
> series because I changed some of the description for making it clear whic=
h bug
> and commit it is really fixing.  Specifically, I wordsmithed the working =
and
> changed 'Fixed:' tag.  Code change is almost same, though.
>=20
>=20
> Thanks,
> SJ
>=20
> >=20
> > SeongJae Park (3):
> >   xen-blkback: Advertise feature-persistent as user requested
> >   xen-blkfront: Advertise feature-persistent as user requested
> >   xen-blkfront: Cache feature_persistent value before advertisement
> >=20
> >  drivers/block/xen-blkback/common.h |  3 +++
> >  drivers/block/xen-blkback/xenbus.c |  6 ++++--
> >  drivers/block/xen-blkfront.c       | 20 ++++++++++++--------
> >  3 files changed, 19 insertions(+), 10 deletions(-)
> >=20
> > --=20
> > 2.25.1
> >=20

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--Pi/sglFMMbnoUUwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmMQzYEACgkQ24/THMrX
1yyDYwf/VfKN646vVgi2jJoF6YTtEC9WtaCKnkgp9Bhbx6MBspI0VMcMqlUW4iON
qs/hnpOCkht7ZawoVqnlK6mb+u6M4W7MFSMNXWSXYvyiCs4fn0dYKm+V630g0eY2
jf7RIMbtjMs7D6GCEmg/FRYft2igtwVu/DQrrJeYXB13QgwXb2/5+PdwlDugMJE1
2ZUeCBQH680TnNsfw68eF4LY7+nZAqaC357Ns/5ANz0GR+M+CxG6B2zPsk7hd5ab
pQt15XHMlzSeJNo2TpDWpZ3Rq4mKDzXL2V55S4eqq82rGymLYTaWzZzNGNmEhEtD
abuZg0mXO7/n/yrWpUclPsSC5TwaXA==
=NzXu
-----END PGP SIGNATURE-----

--Pi/sglFMMbnoUUwn--
