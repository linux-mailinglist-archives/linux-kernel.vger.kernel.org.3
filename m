Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CA25775BA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 12:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiGQKYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 06:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiGQKYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 06:24:08 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2F664FA;
        Sun, 17 Jul 2022 03:24:08 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0EB441C0003; Sun, 17 Jul 2022 12:24:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1658053447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cz/G+c2AGMxFEDwxsaEiPePiAf+y8BVJI6soaHR5kss=;
        b=T0KoFQX/GqrV3NWfENN0lJqx6df8hjibziTGvXZzcJK5KvTMxWIj055I9GwUrYI5y+xdkT
        5vtqb8c8rcgbPzo2eQDPAoRXpIkeXAyQDOaNEqOzNB44N5XLJKOCCNAlTO9jAS1qWtL24T
        /QEbmFp907AmBYA/q3IYgZqIXe53p24=
Date:   Sun, 17 Jul 2022 12:24:06 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Lee Jones <lee@kernel.org>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 6/8] dt-bindings: backlight: Update Lee Jones' email
 address
Message-ID: <20220717102406.GC14285@duo.ucw.cz>
References: <20220714112533.539910-1-lee@kernel.org>
 <20220714112533.539910-7-lee@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline
In-Reply-To: <20220714112533.539910-7-lee@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Going forward, I'll be using my kernel.org for upstream work.
>

Acked-by: Pavel Machek <pavel@ucw.cz>

Let me know if you want to take it through the LED tree.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYtPjRgAKCRAw5/Bqldv6
8nV7AKCbxH4jIosCzuAbU3zYw4DixJz3RwCgve3ZW6VcKjjtgrbbPxAGoqtl3Ss=
=JbF+
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
