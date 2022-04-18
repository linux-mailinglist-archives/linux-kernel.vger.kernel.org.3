Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADBA506051
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiDRXmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbiDRXmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:42:21 -0400
Received: from m228-62.mailgun.net (m228-62.mailgun.net [159.135.228.62])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 43FF8286ED
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:39:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1650325180; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: To: To: From: From: Date:
 Sender: Sender; bh=fksJxHBbasPH0E1HIDrtxhBCh0tAufSksTmpcRK4Loo=; b=Kyde/Sz5u2Zw4jYWMg8Il8UnFCuI7RIMP4SCvQ0YqgwDtY2/iZIX/StltHd402DxR6eL9T7D
 Ptob3WCirMeMyjlBzIdGhMSDrlhmn88XCMTiR8yl3xHgmP1o6c4pvFf49IxtzbXo0HaMnRz1
 hSl4Eab2GinbjSWl8Sn3kQg5NcexE2/qq1VOoquksqWvg7bxeRSppv6L3Q+RY4S46AiyzSEP
 ZI5OdPhBnUxGwV18uaSc0ouOzX65Ix+8vaFoqQFYA2ZMbi8gj6+rrXBHyFhNDs67pSqewcFJ
 cAmUXOnW576FEq0MCp40YG2CQ55N+Y/yT8KLUuucTDpT1YPLbYmjqA==
X-Mailgun-Sending-Ip: 159.135.228.62
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (186-250-90-1.mhnet.com.br [186.250.90.1]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 625df6bb225c469082e88b1a (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Mon, 18 Apr 2022 23:39:39 GMT
Sender: codeagain@codeagain.dev
Date:   Mon, 18 Apr 2022 20:39:29 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v2 2/3] staging: vme: Add VME_BUS dependency to Kconfig
Message-ID: <20220418233929.zz32dil4u6hbwtqv@AN5Bruno>
References: <cover.1650321310.git.codeagain@codeagain.dev>
 <00de5644d7c2f8c8878eccf86b761e0602732080.1650321310.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="asozunj7lfs2jxfg"
Content-Disposition: inline
In-Reply-To: <00de5644d7c2f8c8878eccf86b761e0602732080.1650321310.git.codeagain@codeagain.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--asozunj7lfs2jxfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please, disregard the following message as there's a typo in the prefix.

On Mon, Apr 18, 2022 at 08:31:09PM -0300, Bruno Moreira-Guedes wrote:
> The KConfig file for VME_USER ('drivers/staging/vme/devices/Kconfig')
> sourced at "drivers/vme/boards/KConfig" misses a `depends on` line for
> VME_BUS, which is unnoticeable for menuconfig users who aren't be able
> to select it through this interface without setting the CONFIG_VME_BUS
> option because it's nested on VME_BUS menu entry.
=2E..
>  	  VME windows in a manner at least semi-compatible with the interface
> --=20
> 2.35.3
>=20

It's already sent a new copy with the proper version number. Nothing's
changed except for the message ID and the v2 typo.

--asozunj7lfs2jxfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYl32sQAKCRAZtd3tyEY2
kiJSAP0WSPiSATXPmE8k1yuJdqmHmM4YrWW22tlqO0FAJedghQD+KLK9QB4+YbN3
tRPhg1KTwKnyxRsi5+O+2Q4GN/DyOQQ=
=QUOj
-----END PGP SIGNATURE-----

--asozunj7lfs2jxfg--
