Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FEF4DA553
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352173AbiCOW1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbiCOW1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:27:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F995C642;
        Tue, 15 Mar 2022 15:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647383146;
        bh=gezpXeqZKeOJgDNVmlP/PASqXl6EtLGYAMMQ2OJLYQY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QyWmUIYlRBwGPhkUKKtM4v1zuBslyxNpEwfNgDBqctJiMv/HQ0uM0uDy457fI44uP
         J9I1zsA2nr4vJgZTwtLjxBsd0mRNOsnp1fZQr6klIqidOSCVqPfgGf6AAogsyJdU7t
         xhQksL3h56XU7epGKg9f4cT5Z3daRkN0CR5420Gg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1po0-1nWSX41bEO-002CPA; Tue, 15
 Mar 2022 23:25:46 +0100
Date:   Tue, 15 Mar 2022 23:25:43 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2] docs: media: uvcvideo: Use linux-media mailing list
Message-ID: <YjESZwTHRuD4pBkY@latitude>
References: <20220315221007.1045878-1-j.neuschaefer@gmx.net>
 <YjEQz1GhLV0Kf3mO@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PGBuFKEhEAhjKk2F"
Content-Disposition: inline
In-Reply-To: <YjEQz1GhLV0Kf3mO@pendragon.ideasonboard.com>
X-Provags-ID: V03:K1:clt0/13K0OpCOrZ4/Ou8E73ptSswZsChTokDqf2zWHsvJl2Bn7t
 9jFCeqIzPnvFSQclIBYEbjJaP3O+jBsSSi7RFaSMvBQguRs8fLsU8es9gFqX5rPi3pRXYO0
 GRKxeXNUfTErJ9GOhzggqfVoEEHKWcHMnvKGAT4haK7ALtWJS1bn77uwleYy+LxkXbKx9uo
 qHY9yXgVq1V6CSdFjsmKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nSIlKLXDZuc=:hfKmDuGNFnMfDa7BNLeAvZ
 f+kKQ9SpctqjtmV7MkVodM4LVZ4uyHq8E2/d/ibgjay/2A0QgOf+PHOpHyfT5qvlgKL4R8nMw
 AAbhKviuLCx+o8h0HAaLMaE9XNFG7nOO3NDlarma1ddftrcPg8Zlqc0QlwGx7+pSxr3Q6rF/J
 pP6v1u0I9dG68FclOKqBBAojgyKUrmukpbPhGAAf2MukD9mutQkg5lec0N5nWIm/AFJziakNE
 2Ny8rU7svlAJ95mlvnbF6LvUA1qBmGZGq3qNdtrcbemOJFcQhaBlnFSlg1RpWVaVcP0FJ01WD
 2e7KvfbD8BQJQgFCNxuo1dvsVYN1ItXUPgIpbShBPVpTuo76gb/YTrzD7jePteG3cZrSzwVFK
 eaucp7DieLkSuBvWMwf85ArTzEH3lW50GQ3HRUTesa4QpCbF6ahfOsCNQmF0mdu2Z9uthJqV7
 b0ODZ/uRJ8NocN7ZO5nMD8u8S8Ada5bpMDZHqn6wvudWW4F4qFHFIuo5er0w8dZyBESjTSJVy
 TU8u9o+Tt/3Ih0VwV3V8sgcnRQaBinIebcwA+ulENJG9ncKSnjySv7XJTPsAK9evIy/aAYDrI
 JVXV9bwXfHV6VSMSKRFce11bw4hwFzzx5Tf51YqZFzxE52juKYMZzKfLi9rajwXRMZXGUnG9k
 CitCILWY3ZqfvcIR6NrelisFrcJbXp5aSQUdl2rmv8N8vIGdboZUPdH5HOLarwjAtbCc0x32g
 XbrxJRFGcUZ3wIjGXc/pT3BExvYTEu2QWG+RnX0GkAA9fUPDu0CpHsR9k8ze24+aCu65tN+Hz
 0dQzbIdKDyVqlf9oXuXlMRUY5hnEIJTLtsllUUicJIIMtvqcsCYdMxuUP7g9klhyF65g0mXyg
 38zFqMn/B9Grp8y7xfehxHfdsd2cHMzKZqQ9kcJN3vmmOCbcEHQye2XvRjI1ubcSFfL55wc+p
 QWOepwbrWK5Syfiob8nld5sivv3dn5nwqxecRVySDWeUb3fp+GLnhMIUYR4awTCV8PxBIz54c
 9agm0hBi4bu61fyLerE+6YjsrmSxRUUv7gtIpIwLvgiU1b5I2bb/TepZ1XEyxvumQPkEY/AoE
 Nj7u6zL02V+LWw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PGBuFKEhEAhjKk2F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 16, 2022 at 12:18:55AM +0200, Laurent Pinchart wrote:
> Hi Jonathan,
>=20
> Thank you for the patch.
>=20
> On Tue, Mar 15, 2022 at 11:10:06PM +0100, Jonathan Neusch=C3=A4fer wrote:
> > As discussed with other developers, the linux-uvc-devel mailing list is
> > not very useful anymore, and it's better to send people to the general
> > linux-media mailing list.
> >=20
> > Replace/remove the old mailing list address in uvcvideo.rst and
> > MAINTAINERS.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
> >=20
> > v2:
> > - Changed mailing list to linux-media@vger.kernel.org instead
> >=20
> > v1:
> > - https://lore.kernel.org/lkml/20220312203323.626657-1-j.neuschaefer@gm=
x.net/
> > ---
> >  Documentation/userspace-api/media/drivers/uvcvideo.rst | 2 +-
> >  MAINTAINERS                                            | 1 -
>=20
> This looks good, but I think we should also add the following:
>=20
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/u=
vc_driver.c
> index 5f394d4efc21..6c6a82af07ce 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2443,7 +2443,7 @@ static int uvc_probe(struct usb_interface *intf,
>  			 "Forcing device quirks to 0x%x by module parameter for testing purpo=
se.\n",
>  			 dev->quirks);
>  		dev_info(&dev->udev->dev,
> -			 "Please report required quirks to the linux-uvc-devel mailing list.\=
n");
> +			 "Please report required quirks to the linux-media mailing list.\n");
>  	}
>=20
>  	if (dev->info->uvc_version) {
>=20
> If you're fine with that change, there's no need to resubmit, I can
> handle this locally.
>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Ah, just before I saw your reply, I noticed this instance too, and sent
a separate patch for it.

I'll leave it up to you to handle it as you wish, I'm fine with it
either way.


Thanks,
Jonathan

--PGBuFKEhEAhjKk2F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmIxEkYACgkQCDBEmo7z
X9sUFg//Vw0uunjOIswQsWyVk3L9vHSpYa6ITOCuogT0/MozqLcCtbi8b55iU7Qx
eyJueNPPi+4HrF7yk1Ur8yCw63p53rpy1YV2JQGLjY8BVRotTxX9vqAgerbuKzFt
l6+31+Pqvt8CB0R7OSjtDdWfhNco0doYijGKta7Zjd2WC9RqIeWlSgCYopoWQdX6
4Kz9+BhWpuFIee0fMT3ff2JTakf7NNgCUAigAM8rn8MLLu0uyDxaa+2gJgY2v+/y
8nHVdraG+IOkEVA6J5X4qRTpMk5usV30sHbUEiQxpeZ0A8fDPyK1OdTmuqVB9igJ
7AEByXFtldkHrMxt6RBAL1aytH890hVXNvsP5g4hYzYnPPrxRYYBdWWY4OfLTDuw
BQ6n7anRTT8CdIjY7yeSGtQrh+fa2WenuxwjKnOFEvj7AmDjrUZ4huUaLY1/NBvz
n/VuuR9hG+Y9yN1JCT9pA8Kz3nrdr7VLBn8Mr2pWvaNK701nak6+zN6+mX6yLRqu
/5QpkLAVX0dm7jDkbmguGkwkYuQEKccthtzI5kug4bRcdjsZNknOJDxBEDlZTbKb
5zBfD6jrZOYvkkEQHlomGc6MD8GyN/szwM4cKlfOHyfevNmf4UD1ZOe6kw3UOCiJ
zLg4YdLkBBMQ0JwhXgD1vqNa5TzV0F+3gmGZynsHQ/r+f68cKMM=
=0Tc0
-----END PGP SIGNATURE-----

--PGBuFKEhEAhjKk2F--
