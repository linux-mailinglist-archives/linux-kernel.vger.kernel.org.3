Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F17351EA56
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 23:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387294AbiEGVYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 17:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiEGVYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 17:24:17 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86BE186DA;
        Sat,  7 May 2022 14:20:29 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A48211C0BA6; Sat,  7 May 2022 23:20:28 +0200 (CEST)
Date:   Sat, 7 May 2022 23:20:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: qcom-lpg: add missing PWM dependency
Message-ID: <20220507212028.GG11004@duo.ucw.cz>
References: <20220505080358.12288-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GUPx2O/K0ibUojHx"
Content-Disposition: inline
In-Reply-To: <20220505080358.12288-1-johan+linaro@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GUPx2O/K0ibUojHx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2022-05-05 10:03:58, Johan Hovold wrote:
> The Qualcomm LPG driver fails to probe unless PWM support is enabled so
> add the missing Kconfig dependency.

Thank you, applied.

Best regards,

								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--GUPx2O/K0ibUojHx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYnbinAAKCRAw5/Bqldv6
8nCVAKCm5+16xa7L39w82o1QAxuwqETbRACfRPhSWvybyoqkoS97mDVHporYQs0=
=yK0H
-----END PGP SIGNATURE-----

--GUPx2O/K0ibUojHx--
