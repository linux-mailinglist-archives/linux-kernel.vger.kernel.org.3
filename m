Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2261B506CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350348AbiDSM4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348523AbiDSMz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:55:59 -0400
Received: from m228-62.mailgun.net (m228-62.mailgun.net [159.135.228.62])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 06B153702A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:53:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1650372795; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=0tzc7HF03IuRlUrqpWf7hbtsECy1+vKsvv33tnnOGHo=; b=Jt39QrJSChyVoj2kqUNiNvaKWvr+fvduKRzW+BywhRodgjmmqcaLm4lrxnA8fhDFKcqP+WpS
 3JMbkQr31OffsOw0IkuAe3B3rL+5YDl+B9PSYCZo0VGBiRYkQopbPB7HshbwFVH7KfPJJ0d3
 YI2P0uh7LczitxozOobMMBPOwg302PVdmCK4gAuCwxKn0kCBXxzhdakFKt5i0eg18MPQNMvb
 l5IxeU37/9v1wwPdwxG3bw7I15/b4i1IzmPz2VXJDMSPrYo//QEGf1u6w9cCWQjHvUnRMpMF
 lcrGl3ffVlQSavjVLrgAjcJbpoJFfYNtAOUiOt3CQ0aYaF9M+TJy3A==
X-Mailgun-Sending-Ip: 159.135.228.62
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (186-250-90-1.mhnet.com.br [186.250.90.1]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 625eb0ba38a4f8e57d9f4df3 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 19 Apr 2022 12:53:14 GMT
Sender: codeagain@codeagain.dev
Date:   Tue, 19 Apr 2022 09:53:10 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH 2/2] Docs: Update kernel series in changes.rst
Message-ID: <20220419125310.fss5634pxzujwkfg@AN5Bruno>
References: <cover.1650336366.git.codeagain@codeagain.dev>
 <a124c3c34e627c124673640aed177c10e401b052.1650336366.git.codeagain@codeagain.dev>
 <Yl4nOBlKnWIcGcYS@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pvgwtzpde4w23vmq"
Content-Disposition: inline
In-Reply-To: <Yl4nOBlKnWIcGcYS@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pvgwtzpde4w23vmq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 19, 2022 at 04:06:32AM +0100, Matthew Wilcox wrote:
> On Mon, Apr 18, 2022 at 11:58:35PM -0300, Bruno Moreira-Guedes wrote:
> >  This document is designed to provide a list of the minimum levels of
> > -software necessary to run the 4.x kernels.
> > +software necessary to run the 5.x kernels.
>=20
> We don't change the major version when we update the minimum required
> tooling ... why not change this once and for all to say:
>=20
> +software necessary to build the current kernel.

Indeed it makes much more sense, I'm making a v2 soon!

--pvgwtzpde4w23vmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYl6wtgAKCRAZtd3tyEY2
kn2pAQDATYppYpRY5w19hEu8qoCUpJcMbjKRvDY5b8f8RHxijgD+M7PeDtA3vB63
+STn8RAzLCUQD6cIFWh3pZhl7S2gMgA=
=VNQ+
-----END PGP SIGNATURE-----

--pvgwtzpde4w23vmq--
