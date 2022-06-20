Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA46E5517B9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbiFTLrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbiFTLrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:47:18 -0400
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F4965D1;
        Mon, 20 Jun 2022 04:47:14 -0700 (PDT)
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 60B59C3F3EEF;
        Mon, 20 Jun 2022 13:47:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 60B59C3F3EEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1655725630; bh=zVAjM2tmOCFjOeWx0q9T800geGdrhxbgvRA9OL39OZU=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=WBDBwKgIgrp5kWzwSKFLiNguH5X/dsHDEkQpPWiFLHF1mOoPNqdw2LiK1wIWOcqT1
         ptcuK4oI+BNby3X/s42rssKgZ4Nfprxa9ivdfsQsCL23+UShabC94hudTZk8gHPoEb
         0xvRosD46bsjfhFeZQ6fKfXFO2hMh0ZnUa9PY8Rk=
From:   Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v8 2/2] On Semi AR0521 sensor driver
In-Reply-To: <m37d7ufrzx.fsf@t19.piap.pl>
Lines:  18
References: <m3pmn66pie.fsf@t19.piap.pl> <m3h78i6p4t.fsf@t19.piap.pl>
        <20220301093107.ihokyp4xptkzpbpc@uno.localdomain>
        <m38rtt7sx7.fsf@t19.piap.pl>
        <20220301143044.2l4vlwbnh5n3g5ng@uno.localdomain>
        <m37d7ufrzx.fsf@t19.piap.pl>
Sender: khalasa@piap.pl
Date:   Mon, 20 Jun 2022 13:47:10 +0200
Message-ID: <m3bkun7e0x.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 3
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro et al,

it appears my last mail dated 6th of May hadn't reached you.

Mauro, you are the drivers/media maintainer. Is the AR0521 driver ready
to be merged, are there still unresolved issues, or the driver is not to
be merged at all? I understand everyone's so busy but a simple yes or no
isn't too much, is it?

Perhaps we have a breakage in communications here? Are you receiving
this?

> Since it appears all remaining issues with the AR0521 driver have been
> resolved weeks (now months) ago... is there anything I should do in
> order to have the driver merged, should I rather proceed with the
> "staging" thing, or maybe some other option should be used?

--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
