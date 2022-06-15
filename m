Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C3854C583
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240596AbiFOKJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344457AbiFOKJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:09:43 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C587D49271
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=ONJnBXu6t4zF8NFHPUMTOY/c4b3k
        CKbK/S/MH3jepMo=; b=zvrfXKeOW4l0ubRQcvx6RZ39t/9w00DZSEy6CJn8yqWl
        e8uJf8AUcamd7DZCpbuEawNVFPUXhkuj1ukGv2fkdFZT/+TGkPtdGXKYw6xA2U3a
        TcRNXgb593WpgGlaNpSgtkgZhAmAbwKzsParp/WzdTxhYwKHDO6qlcgycwGS1KE=
Received: (qmail 2072654 invoked from network); 15 Jun 2022 12:09:39 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Jun 2022 12:09:39 +0200
X-UD-Smtp-Session: l3s3148p1@0cYUuHnhYW1ZD+7R
Date:   Wed, 15 Jun 2022 12:09:39 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: thermal: rcar-gen3-thermal: Add
 r8a779f0 support
Message-ID: <Yqmv4/zZrCM3PCns@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220610201701.7946-1-wsa+renesas@sang-engineering.com>
 <20220610201701.7946-2-wsa+renesas@sang-engineering.com>
 <CAMuHMdW3uxQHk6SBX5MqnZsYqwY8p+0wmD6gHwS3ESUrkmpWkQ@mail.gmail.com>
 <YqjtBQdzexzCRrmq@shikoro>
 <CAMuHMdUTR8+8TbM_AaMXk96adHvdp_Oof8v48_zCY+R5FsOLnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Wx79W/Vpvtk065FE"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUTR8+8TbM_AaMXk96adHvdp_Oof8v48_zCY+R5FsOLnQ@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Wx79W/Vpvtk065FE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > What about splitting this in two separate checks at the top level:
> > >   - one for regs (R-Car V3U vs. the world), and
> > >   - a second for interrupts (R-Car V3U+S4-8 vs. the world)?
> >
> > This task seems too much for my YAML-foo :( I couldn't get it to work.
> > Can we leave it as-is for now?
>=20
> You just need an allOf with two if statements, cfr. e.g.
> Documentation/devicetree/bindings/media/renesas,vin.yaml?

First, I don't think the negative logic is as bad here because there is
no 'else' block which is far away. Second, I think we need a 'not'
anyhow because the condition is:
	'if not r8a779f0 then required interrupts'

Third, I still think we can fix it incrementally later if we want. The
new board has enough issues to take care of. For now, I'd rather
investigate those than YAML ;)


--Wx79W/Vpvtk065FE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmKpr98ACgkQFA3kzBSg
KbZS3A//Vv1st2Dr/K5iI3fgTRG5fR5kAvsNf1rSb2Oa6Vfr0qL2KNeWKOhVwnFH
n8R4myFDto8c5Exs3p9vuyVDGizGQlPfBxk6C2QX0kVW/AA0QDgbxFStfvkEQr64
SubiEf0eGY3ds+7PG+nk21GBqn//sna1k0SdOxKpEADj5R3HCJRqaN1v4FPiwZ23
74GbZsbns997EW5XjU6FwrTQV6TidTGjLTl5+DnnR9OVOV8WVsSBnphShl0RdOv1
Gs7i3JqKRKG7iN6xU+4ZfPhyNBB7iW0VaXBpcCOikhMxwD5QzBCim7vx5HPRIjCm
HAGSgSnBSbnRcnGkEEiAP+2LIif9g9nn9ST1QSQYUS57iIuZIGw2G+5kXABem4LB
OwcUMUAnrMxnrjYA2L43qDjHQVxT4Na0CI+qtxShvrGgTWTB7zX54AI02FMUiQcM
12RwN+Jy8tnd1bSKPSAzqQaxe5BQpPPJjK7YAe8hr24lJpXxdZmz0HsCWDCNCbw7
fNFcB3i7CWDr3U+QXjQbuupHCrD/CL/SHkB//N+cx/UqqFGyIIf7en6HZJl1+fB7
cfUHZQg25PcpVh3dER5SvWysS+fhfO18Lja4xxVP+G3EtStY01rQm9kSUHHFQbJy
ZB89mXAo5b/wiDYHqKd6nHEZhlxeTOegKbHA4J3kf2MTWSOvHRQ=
=9reG
-----END PGP SIGNATURE-----

--Wx79W/Vpvtk065FE--
