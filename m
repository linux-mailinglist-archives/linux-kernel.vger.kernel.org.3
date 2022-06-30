Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBD6561030
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 06:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiF3E3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 00:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiF3E3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 00:29:12 -0400
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90FF33E28;
        Wed, 29 Jun 2022 21:29:10 -0700 (PDT)
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id DB312C3F3EDF;
        Thu, 30 Jun 2022 06:29:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl DB312C3F3EDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1656563347; bh=h1CvsX5f0r5ND4l/vVuhCgjxDaKnyXHFKfDiL3Ks5Yw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GLt2XT7f6rm1gzfK7d46W8JtcpT/qQH4WaOG5gTiptH7NCqixhgnuT/E4NdnYvupp
         7ssruRSLPXILRjAq7OdvvoAfdHDzyKR8b4FQdLa8zQ34Fc5sCsdTOCxvQlaEeOrnDG
         J5O5bUhy5qPn0/VWvC+aDSgQA/hrIoH2acyxgbz8=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v8 2/2] On Semi AR0521 sensor driver
References: <m3pmn66pie.fsf@t19.piap.pl> <m3h78i6p4t.fsf@t19.piap.pl>
        <20220301093107.ihokyp4xptkzpbpc@uno.localdomain>
        <m38rtt7sx7.fsf@t19.piap.pl>
        <20220301143044.2l4vlwbnh5n3g5ng@uno.localdomain>
        <m37d7ufrzx.fsf@t19.piap.pl> <m3pmkryywn.fsf@t19.piap.pl>
        <YrziTabYLlZ2bX+1@valkosipuli.retiisi.eu>
Sender: khalasa@piap.pl
Date:   Thu, 30 Jun 2022 06:29:06 +0200
In-Reply-To: <YrziTabYLlZ2bX+1@valkosipuli.retiisi.eu> (Sakari Ailus's message
        of "Thu, 30 Jun 2022 02:37:49 +0300")
Message-ID: <m34k027p0t.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, license restriction
X-KLMS-AntiPhishing: not scanned, license restriction
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, license restriction
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

Sakari Ailus <sakari.ailus@iki.fi> writes:

> I've
> applied it with these changes:
>
> diff --git a/drivers/media/i2c/ar0521.c b/drivers/media/i2c/ar0521.c
...
> @@ -1056,4 +1058,4 @@ module_i2c_driver(ar0521_i2c_driver);
>=20=20
>  MODULE_DESCRIPTION("AR0521 MIPI Camera subdev driver");
>  MODULE_AUTHOR("Krzysztof Ha=C5=82asa <khalasa@piap.pl>");
> -MODULE_LICENSE("GPL v2");
> +MODULE_LICENSE("GPL");

Why did you change this? Are now "GPL v2" tags forbidden in
drivers/media?

Thanks for looking at this, though.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
