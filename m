Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA6D4F7645
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241268AbiDGGix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241240AbiDGGij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:38:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389D88EB4A;
        Wed,  6 Apr 2022 23:36:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F76761D5B;
        Thu,  7 Apr 2022 06:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3D5C385A9;
        Thu,  7 Apr 2022 06:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649313397;
        bh=8uwDrdT/rAtS3qmkIgZ5IYHNiw59FST1McQcPgyt7MI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wd3Ux118X5M+RL+44A+6MKkElKcpBe4L+yqGu0Cj4p9pyVkeFxPxRVQsEVCUVLul7
         mSySVH5wJakKTIPZzlztrkvZRIYgtOj9d63eyX5Wwsso5ciQV9KooPo5DyPqd9J7oY
         Qb+IrgzxF6vm5U0xYAXpIAmoCzAWrnPcz5TYi5AhhW7pnqcBIYbGmaOm4D1Ps18Y8k
         nmwWXth9G2XpHC54VKXI9KZaqqAbzv4VLDnxslKLO/dvt4KgTwQDXhGhgOJKNfulZv
         cka9WINzFR3Ja4H9oC+iD20oxfu31HW34SG/zjQJ9Wj9u31z3fFKaki1BsiIQgkaFH
         N0x0WMi4YYALQ==
Date:   Thu, 7 Apr 2022 08:36:34 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: memory: renesas,rpc-if: Document R-Car
 H3/M3/E3 support
Message-ID: <Yk6GcjtYcqnH6T7c@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <3784b6cb76a008fb56d6cb4ba228d78c77e710fa.1648546583.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yA7mIVcGHpaFnB3t"
Content-Disposition: inline
In-Reply-To: <3784b6cb76a008fb56d6cb4ba228d78c77e710fa.1648546583.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yA7mIVcGHpaFnB3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 29, 2022 at 11:38:03AM +0200, Geert Uytterhoeven wrote:
> Document support for the SPI Multi I/O Bus Controller (RPC-IF) in the
> R-Car H3, M3-W, M3-W+, M3-N, and E3 SoCs.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--yA7mIVcGHpaFnB3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJOhm4ACgkQFA3kzBSg
KbZc5Q/8D/HrD8s7Ole+CGOFemu+BxNlEqin0mYgn67gkxzUcXcM+y4Nnvq4Rz+X
MPktd7ovJRosDSwtbZcANiT5gn1BwoCB+dU5/vA7+2Ym5QXeuTXUPLGrK89n+llB
9B5QFfRaXkKk83fvLQHYQcYUzx4p6RLY78h3Mxhb8kPtXebvsZs8BKQq7KiHtDyU
Ygtmof5dZ06qRDY/4y4NtXbjCUOEy3+7aRwfnpcmGE0pjXhjRjFdgja7W42/Vv7z
lzB7tmyZbXAiiw32jVhrlng1j8jS6v9AERm9JmxHm8uNE9OZ8GNf5FMlbapN4p5Z
5rI9HW0pU0jbsFAFqpK8QJ1o2ll7qzuX3TZ5lyH5BkHhtNnYZ9d3AG86pC3ino3M
fKTsJtLm4Pk/RyEWAjerMYVBlhJgwzAXjZlDYPwd43C5m0vkqGM9BSsFQf7z6z2x
SR4S3QPQuBHWQbLgMYDC1djqxZEn6LyRonK3k64nl4Hi3wgHG13ac7FAgNNnmrqr
GkAUP+XoGchzF0Twnlg+NOnzJTkNK4bIFOCy34vy/dH7imUpNc17HEsnZ1cIICw0
9CMWbv+xqDIq023X4PdcKByiiMLsaQ4osYePhbo0WTclrWlV3bzB35XsbYDHmCMN
hqgTd9GTXGCGklr8KafND8qTK4N6drWTqSq5c8buGlZBrNB6zKk=
=x8UI
-----END PGP SIGNATURE-----

--yA7mIVcGHpaFnB3t--
