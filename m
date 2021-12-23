Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AD947E0B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 10:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347390AbhLWJHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 04:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347407AbhLWJHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 04:07:10 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648B2C061756;
        Thu, 23 Dec 2021 01:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+F9l4oaTYcTezns5dJwiIVOjH6VpsW1N0yjevEuxrKk=; b=U1KCjtRxFZAs1+SJMEnP4jjE3Q
        Rf0uJ9dXTATYkWCfAVUNbdJngAU35jR2BflmZpLuqHAyCYm/5wFKXxRV8TKhzxkCGQcFIRicAGzzp
        V8QmGC0pJUh2nBRqGgGs50RkNJBkw5whd4abKSMoYdpu9IhJpI7wYPMXP9OdQ2Pkqj1U=;
Received: from p200300ccff0e67001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0e:6700:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1n0K40-0002b4-P2; Thu, 23 Dec 2021 10:07:05 +0100
Date:   Thu, 23 Dec 2021 10:07:03 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com, alistair23@gmail.com,
        robh+dt@kernel.org, linus.walleij@linaro.org, rydberg@bitmath.org,
        =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v4 1/4] Input: Add driver for Cypress Generation 5
 touchscreen
Message-ID: <20211223100703.78bbdf84@aktux>
In-Reply-To: <20211222124603.326920-2-alistair@alistair23.me>
References: <20211222124603.326920-1-alistair@alistair23.me>
        <20211222124603.326920-2-alistair@alistair23.me>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 22:46:00 +1000
Alistair Francis <alistair@alistair23.me> wrote:

> From: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
>=20
> This is the basic driver for the Cypress TrueTouch Gen5 touchscreen
> controllers. This driver supports only the I2C bus but it uses regmap
> so SPI support could be added later.
> The touchscreen can retrieve some defined zone that are handled as
> buttons (according to the hardware). That is why it handles
> button and multitouch events.
>=20
> Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Works for me (with devicetree additions for my device)

Tested-by: Andreas Kemnade <andreas@kemnade.info> # Kobo Clara HD
