Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4841850374B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 17:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiDPPef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 11:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiDPPee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 11:34:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B1F275CB;
        Sat, 16 Apr 2022 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650123115;
        bh=UuIa4NncgBzm7/YdsDatj96+GIOrv7mzg7bU99kLIN0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=c83qE0YDVO0RT0pzlgN/N1f/M85PDvCQHpiwojrIdaI+IN6QhxBIKWDmhq1gleql5
         QJr75ubE0DkRdRTwL980eGEkrsgHN28w+SHa31QAabpxE4NJ5ov0Wiw6lyoREPtC4n
         7GD2nAlscos6AFp9EIYF5YypuzaCOeLzUllMNNVY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([178.9.154.198]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdefD-1oF59X41VR-00ZfPJ; Sat, 16
 Apr 2022 17:31:55 +0200
Date:   Sat, 16 Apr 2022 17:31:54 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2] docs: media: uvcvideo: Use linux-media mailing list
Message-ID: <YlrhavU2K3neXNEy@latitude>
References: <20220315221007.1045878-1-j.neuschaefer@gmx.net>
 <YjEQz1GhLV0Kf3mO@pendragon.ideasonboard.com>
 <YjESZwTHRuD4pBkY@latitude>
 <YjEVzF1NMWJZ1MQw@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2uaPgbLouLhwQsiC"
Content-Disposition: inline
In-Reply-To: <YjEVzF1NMWJZ1MQw@pendragon.ideasonboard.com>
X-Provags-ID: V03:K1:dHDTiPYcqBzys/y0zAPO5PwA5WAxWk4kf0UeeRdfcyp/vfA4V+f
 A8L9f43sspMMcDF6b3VT/3ZhRTW6c62PhCfrPYMxo8iMY8WmjfM7WB760VjPqvxgDbtelrA
 ZGWuQh3BlM0ET08eem8baWheUqIVQO42soLHqD2bbuJBrovSbxObk04easMhGaJioCHuW62
 FohyDxahpqBlX9S6QjIkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vYGcCSiBzBM=:cOKFxv9k9gunVvhzrCgs2m
 pI2M9r4bX6cjoCv9bFCIG8zHzFWWLX9VTrDnwj6a210szrO0M17FlUi61XpEh020GuIBJveoW
 sA2hDHXWkIj3AqcT8viATJ6mceLO/L7fe2pOcI0E76HUmyiXaHjhjliIsD61tT9idLS28bTpn
 2OwmtF5x3fl9DrXbppyQO6w1eDvgQAHHt0CSg5+UpKD/tiWfxOaGim1WittzahOILbhKDbmOv
 NSWTX1iKaFUopUuXSLw9q8HXYMRb0QISF4KR/+Uj4Uw3mGHNlN21g1Mu2TkfpCzpDHQN0H7Tq
 aSHzXMb1NyOBoeLksnRzfvUgD7WV6aYY9/qbkoLe94kMgQaehKmX5m0Q1/XPGLVqmMyqLGsLW
 WRfRwBQphLCYPoF2jHSaUeydMKeFY9GYjaWosHOUtnY4tZM+SFHF4bTVelZQt8jjWwq+DA/xL
 +wlvLRN+rD+RW/Nx8OQ9h8CliSnux0kxbBDpBqFaz/DC/vwqyK++FXJ/eTPc1OdMMshJxX59o
 QQITCptmi9aVwld/cHtdLcKOJ60xcEGXV8WzCaEkk1vW3nChFVErtt0AO1qw9dCGLqGtEm7Zq
 no+DClQ5PBHxGx7ccTl3xWO0cctvyGg2q+EPgjVfSmg9mmFzlMbeCQyYAxdVquZ2mgLuFnO+N
 Wlf2pym5HvIlkRoYRpCIlD7rJCwMtacu2yF2Yq3gwPG4GrIk8u66htgYXmloIMqqJyaTTBf3h
 6z1PS7dkD4+zIuojloZ44K3af9IwK0/6ia0V9u5qlk9nvRHu09Bw8hUaqCCnrp/4+jj0FrOYW
 gTs7S4OaMGwd/M6oIxxn4jP3veq8wZElZB+2i8QpOSEMmSIfv4aGH8WJQ5ctmaSzz4z2AiEBt
 8GAwvXPX3sS1dhM2hyG8+ZG+ZweEgu+IY4diVeCevRRIC2cblrP7hD3/OAcFHMdt/JtkTjht3
 EaK5BbnITxXmcKk4JzlbobiZ7DNdXUzOhyYCq9hbFmngrI/WNFylBBiUoPO7zZc4uta9fExHS
 5qDp/tazO52AokTCXVDkEeBNXYT3WWT4jg43b0YfEe99NpmI0TJyhKC+SqrNRNCRWJGE+6DRk
 QD3hx91O5hGZQ8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2uaPgbLouLhwQsiC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 16, 2022 at 12:40:12AM +0200, Laurent Pinchart wrote:
> On Tue, Mar 15, 2022 at 11:25:43PM +0100, Jonathan Neusch=C3=A4fer wrote:
> > On Wed, Mar 16, 2022 at 12:18:55AM +0200, Laurent Pinchart wrote:
> > > Hi Jonathan,
> > >=20
> > > Thank you for the patch.
> > >=20
> > > On Tue, Mar 15, 2022 at 11:10:06PM +0100, Jonathan Neusch=C3=A4fer wr=
ote:
> > > > As discussed with other developers, the linux-uvc-devel mailing lis=
t is
> > > > not very useful anymore, and it's better to send people to the gene=
ral
> > > > linux-media mailing list.
> > > >=20
> > > > Replace/remove the old mailing list address in uvcvideo.rst and
> > > > MAINTAINERS.
> > > >=20
> > > > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > > > ---
> > > >=20
> > > > v2:
> > > > - Changed mailing list to linux-media@vger.kernel.org instead
> > > >=20
> > > > v1:
> > > > - https://lore.kernel.org/lkml/20220312203323.626657-1-j.neuschaefe=
r@gmx.net/
> > > > ---
> > > >  Documentation/userspace-api/media/drivers/uvcvideo.rst | 2 +-
> > > >  MAINTAINERS                                            | 1 -
> > >=20
> > > This looks good, but I think we should also add the following:
> > >=20
> > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/u=
vc/uvc_driver.c
> > > index 5f394d4efc21..6c6a82af07ce 100644
> > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > @@ -2443,7 +2443,7 @@ static int uvc_probe(struct usb_interface *intf,
> > >  			 "Forcing device quirks to 0x%x by module parameter for testing p=
urpose.\n",
> > >  			 dev->quirks);
> > >  		dev_info(&dev->udev->dev,
> > > -			 "Please report required quirks to the linux-uvc-devel mailing li=
st.\n");
> > > +			 "Please report required quirks to the linux-media mailing list.\=
n");
> > >  	}
> > >=20
> > >  	if (dev->info->uvc_version) {
> > >=20
> > > If you're fine with that change, there's no need to resubmit, I can
> > > handle this locally.
> > >=20
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >=20
> > Ah, just before I saw your reply, I noticed this instance too, and sent
> > a separate patch for it.
>=20
> I'd say great minds think alike if it wasn't presumptuous :-)
>=20
> > I'll leave it up to you to handle it as you wish, I'm fine with it
> > either way.
>=20
> I'll squash the two patches as they're closely related.

Ping =E2=80=94 I don't see this patch in linux-next. Is there something I c=
an do
to help?


Jonathan

--2uaPgbLouLhwQsiC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmJa4UkACgkQCDBEmo7z
X9scnw//WAGomKe9hcu+gUqLfFzfc1W2pU47/I+YPFQ+Bn8Z81G4JBOZEee/jRHz
XUDsfJDm7DnnAcw9LF39TXJeWUnosBWyMeoXIHBqCZOc9HjVDz7VBvwiegqE1RZ1
eILU7ijZwTzku+HWMQ7TSIGsXuCM62pp2UvDsK2EOPx5ER77FMQfd9n7P93YA2C1
1QZ6dFx8+mQo5Xs4UQOnWgEb6AZXJk8DG+ir89OMRVVI92DE8xsPOW99951PVFNn
Pwf352Lp/mZpgSBiZbt+fAOLTl4Y7Lyzoeom3BVrStyLLXRMG9EMVmnbH3crg1P8
p0JQQQcL5x8iXPoiCDLMmv2SnnSZg/Gg576AZq1W5ZbL/nurgg5+h7J9YyCy0/el
Mw23SwG7LhjC3cxKDDmSXjtcYfS7w37RnA3wiPCOEg/HSING2yrfh0VZ9ptZevpK
Zpv+lNMTL1o05N6fQrNK2TYR0lxVyJ3jFTTpvtje6HesSeSEfM/mvmMI5fyISOUd
Vl/ISkVcXz+nE95Q6rj5GVH5JsOmCyjHRZ7ZhAI7QBQW90jL50vDaNEMa79gZD8C
ODmNn/qzqsUcuKIalXJDjyQPX4yn0x6E4TtgBpn8x5/u3Id4wAiAGUBGxi1B8c4Y
+03psNqBUQunL8dS7A6/tAPOU9blukxnyh7790c3dHcUmP4F0v4=
=38zg
-----END PGP SIGNATURE-----

--2uaPgbLouLhwQsiC--
