Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B4D48144E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbhL2PFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:05:15 -0500
Received: from ni.piap.pl ([195.187.100.5]:50514 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233681AbhL2PFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:05:14 -0500
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id BF59CC3EDF3E;
        Wed, 29 Dec 2021 16:05:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl BF59CC3EDF3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1640790312; bh=noaWpL0uyqppfJdEypBYm6UZUrSDRoYEnF0eZdDwzQg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Lo0zVjNzP2LaR23CzF7BSUqz+tcLa9ADuveutPUto6dXEzms/OUyGDoXQhl9MCzUs
         1We7+kfZNrGdLPaXTNeQQhbxa0HQ7hJpsvn8vWyFE1ZfSMV5AruWMvglMaLGl5FUPb
         lquLEt3pOgNFJTcxkmL1ZcRFrioOauG3twPRCriA=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Joe Perches <joe@perches.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v6 2/2] Driver for ON Semi AR0521 camera sensor
References: <m3ee63hkuu.fsf@t19.piap.pl> <m35yrfhkaf.fsf@t19.piap.pl>
        <cee1bbe6c8dda1c79ba19f7bbf68fc1d74558cae.camel@perches.com>
        <20211223184856.v34ecibwzepahsju@uno.localdomain>
        <02c71d9fe95f72c5aa5a01adadda8fb7e756fae1.camel@perches.com>
        <20211224092226.vmqkmybpx4zodezt@uno.localdomain>
Sender: khalasa@piap.pl
Date:   Wed, 29 Dec 2021 16:05:11 +0100
In-Reply-To: <20211224092226.vmqkmybpx4zodezt@uno.localdomain> (Jacopo Mondi's
        message of "Fri, 24 Dec 2021 10:22:26 +0100")
Message-ID: <m3pmpffo48.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 3
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Being that "stubborn developer"...

I think all those always increasing restrictions are a dead end and
serve no useful purpose.

I strongly oppose restrictions which are just for the sake of
uniformity. I think the coding style rules make sense only as long as
they increase readability, and should never extend further. And in
particular, we should NEVER sacrifice readability for uniformity.

Unfortunately one can't measure readability easily, and what's better
for one, is worse for another (think - vision problems).

Yes, some arbitrary basic rules like tab size and brace style are
needed, and there are certain rules needed for correctness (like
"type* ptr" vs "type *ptr" which is quite visible in "type* a, b")
but the rest should serve the readability. I.e., we shouldn't want to
have all code identical - we should want it to be good.

E.g., for me, it's better to have 99 worse source files (like wildly
formatted to 80 columns) and 1 (perhaps simply more recent) file with
a better, cleaner formatting than to have 100 of the former kind.

But what do I know...
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
