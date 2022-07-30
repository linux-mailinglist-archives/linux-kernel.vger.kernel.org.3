Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0950585C53
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 23:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiG3VbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 17:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbiG3VbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 17:31:03 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC9413E26;
        Sat, 30 Jul 2022 14:31:00 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1D5FC1C0001; Sat, 30 Jul 2022 23:30:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1659216659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o9GONExi2bMzEQw12WI9p6+Qh5VXr1fFNHfflQl3nxw=;
        b=cSY49q+q6Yc2MxDLhSVDO5DseSSWxSphwN08c+PDJwwl3Bm1ceR8BfmtlkTZDhMRMkQgWT
        6hgHQOc1WS0juhjHH1FOan8RAuwST7qllswVe6Iu0ECAnUyZ9Tlo67dwNty/31HU96/0eX
        tuwjCFSCzKGcnj8PqNUObH7zDgNN+ZM=
Date:   Sat, 30 Jul 2022 23:30:58 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        andy.shevchenko@gmail.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang@richtek.com,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 04/13] dt-bindings: leds: Add MediaTek MT6370
 flashlight
Message-ID: <20220730213058.GI23307@duo.ucw.cz>
References: <20220722102407.2205-1-peterwu.pub@gmail.com>
 <20220722102407.2205-5-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6b3yLyRKT1M6kiA0"
Content-Disposition: inline
In-Reply-To: <20220722102407.2205-5-peterwu.pub@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6b3yLyRKT1M6kiA0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2022-07-22 18:23:58, ChiaEn Wu wrote:
> From: Alice Chen <alice_chen@richtek.com>
>=20
> Add MediaTek MT6370 flashlight binding documentation.
>=20
> Signed-off-by: Alice Chen <alice_chen@richtek.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

You'll need to get sign-offs right... And review from dt people before
this can be applied.

Best regards,
								Pavel
								--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--6b3yLyRKT1M6kiA0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYuWjEgAKCRAw5/Bqldv6
8o6vAKC4ARVicLPm5uV4zxu75IiOs/DsvwCgn6SlrzK+9+kIJXHJNS6WoAmW4j8=
=aw5u
-----END PGP SIGNATURE-----

--6b3yLyRKT1M6kiA0--
