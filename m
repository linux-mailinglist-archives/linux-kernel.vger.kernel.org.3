Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A7253E851
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbiFFOgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239936AbiFFOgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68876138B79;
        Mon,  6 Jun 2022 07:36:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1B1B6146A;
        Mon,  6 Jun 2022 14:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E025C385A9;
        Mon,  6 Jun 2022 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654526178;
        bh=gGiL7UP+UCHE8qudjPfXRRQzkXMWAY+JPxcumutHd/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SbSnjyVUUzuwWifw9o8ka/MKbGIdxYFvyQxfrdMK2pzJU6WSWASMwRxTdFMWVa0vc
         c2DezpK2eQTbKxHxLIlDEKXWy4SIKNCFrb4jQU4hPc/MNQJ5T+I4+8ai/+SR/kcD1O
         E42GmUf/jqDNAmdBtjVsLAi/ycNL7tr3P/0Bl56pDzUrM8mwpRKUi9JVfkzyCa1XkL
         CfQ06wnNM/T4kcBMHpsh8DzQAaW5aTy76upnfgZRUISqLHdMQWOPrIDBPpnnHgMEhD
         DsGB0keK5imzKKylWzBR6ZCWVJ/zHBiauSGs421VaI0myOupU5cxhBmi2SMIjht+L+
         0NoZ4I4VBUeuw==
Date:   Mon, 6 Jun 2022 15:36:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, gregkh@linuxfoundation.org,
        lgirdwood@gmail.com, lars@metafoo.de, rafael@kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] regulator: axp20x: Add support for AXP192
Message-ID: <Yp4Q2mNVjMfgzMv0@sirena.org.uk>
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
 <20220603135714.12007-8-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Uk4ld2o6r5VJ06+j"
Content-Disposition: inline
In-Reply-To: <20220603135714.12007-8-aidanmacdonald.0x0@gmail.com>
X-Cookie: Bedfellows make strange politicians.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Uk4ld2o6r5VJ06+j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 03, 2022 at 02:57:11PM +0100, Aidan MacDonald wrote:
> Add support for the AXP192 PMIC.

Acked-by: Mark Brown <broonie@kernel.org>

--Uk4ld2o6r5VJ06+j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKeENoACgkQJNaLcl1U
h9BRxwf/b0P1wPzce+1thOKF1W1DrQfBWbTjDTd82nga68AyMAsQD5RuRHN+CD3S
MU0+osmy2aXsijrMiEVW2Ibm/5QkbfgSpof9qMvnkH4TFVBcRraCYfgo03YLNHCo
9Z90Kz1iYijvLMhhOdQ+VfxjbsPv7A2tIp8MeTNfKTNqKwWO0g3fHRnrLrUFJk1S
b4fyQZLP3lCOTTfrFiCdm7c1uzem0lkivDO03iIoEbZUwgrhX9iJ/emSWdhSIqff
XC7YkvnQ7kCTunE5FQKI3VfpxkgoKzqq+HliMFim/MAxQhD8RS3/i5RE0DLcPj52
gLiDgoA+I5xLJKMf5muHXY7OwKCcHQ==
=wwxP
-----END PGP SIGNATURE-----

--Uk4ld2o6r5VJ06+j--
