Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D3D51D10F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389358AbiEFGOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389387AbiEFGOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:14:05 -0400
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A1C6152;
        Thu,  5 May 2022 23:10:20 -0700 (PDT)
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 86CCEC3F3EDF;
        Fri,  6 May 2022 08:10:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 86CCEC3F3EDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1651817416; bh=y0GeZHLiygxlzwP+WNGgq4yVdAFs+iQYlgfDeL4u/fM=;
        h=From:To:Subject:References:Date:In-Reply-To:From;
        b=D0V7GZYrqSTzcTuJFrBcjSBlCzsRR9bLODEPSb4wtobAPQ0YcbsdmBW23TmJGSXvA
         9EEaRXLnZjxrd8oSXPLicMcAgbmlPGOzOnon1SB+gva4wR52czLBjZmhX1DMbbsBvL
         JzzF65j9u+QwCN7yRlxwRkDF+OWJl3ldv9wqicXI=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v8 2/2] On Semi AR0521 sensor driver
References: <m3pmn66pie.fsf@t19.piap.pl> <m3h78i6p4t.fsf@t19.piap.pl>
        <20220301093107.ihokyp4xptkzpbpc@uno.localdomain>
        <m38rtt7sx7.fsf@t19.piap.pl>
        <20220301143044.2l4vlwbnh5n3g5ng@uno.localdomain>
        <m37d7ufrzx.fsf@t19.piap.pl>
Sender: khalasa@piap.pl
Date:   Fri, 06 May 2022 08:10:16 +0200
In-Reply-To: <m37d7ufrzx.fsf@t19.piap.pl> ("Krzysztof =?utf-8?Q?Ha=C5=82as?=
 =?utf-8?Q?a=22's?= message of
        "Tue, 12 Apr 2022 13:41:54 +0200")
Message-ID: <m3pmkryywn.fsf@t19.piap.pl>
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

Mauro, you are the drivers/media maintainer. Is the AR0521 driver ready
to be merged, are there still unresolved issues, or the driver is not no
be merged at all? I understand everyone's so busy but a simple yes or no
isn't too much, is it?

> Since it appears all remaining issues with the AR0521 driver have been
> resolved weeks ago... is there anything I should do in order to have the
> driver merged, should I rather proceed with the "staging" thing, or
> maybe some other option should be used?

--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
