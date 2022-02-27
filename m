Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025CA4C5F1E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 22:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiB0VjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 16:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiB0VjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 16:39:17 -0500
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7F44BFF4;
        Sun, 27 Feb 2022 13:38:35 -0800 (PST)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 1EF44DF7491;
        Sun, 27 Feb 2022 22:38:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1645997913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=auuyEhFvI9O6E7K0eY+/3pvXha2pZMkC/DntTyWHWHY=;
        b=DDQ+6xSh7odwZlp+syE+bHr9FuZmMlX3tbJ1AZvewGDaiDeGgV8ouwsBt9ykPM5e/XyqsR
        Z2UVkHJd3PFAtTuycKSjfXpU1SFBSnCWPItkTWvGf8PkFWPU+u3yU1O09OEN8vti4/8axe
        zZ4KQy3G2OEbXqnU/yDPiN13ORLeA2E=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Renze Nicolai <renze@rnplus.nl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] hwmon: (nct6775) Add i2c support
Date:   Sun, 27 Feb 2022 22:38:31 +0100
Message-ID: <4719747.31r3eYUQgx@natalenko.name>
In-Reply-To: <YhrFizhgOpZbi3dE@hatter.bewilderbeest.net>
References: <20220226133047.6226-1-zev@bewilderbeest.net> <2620147.mvXUDI8C0e@natalenko.name> <YhrFizhgOpZbi3dE@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On ned=C4=9Ble 27. =C3=BAnora 2022 1:27:55 CET Zev Weiss wrote:
> On Sat, Feb 26, 2022 at 04:14:12PM PST, Oleksandr Natalenko wrote:
> >Hello.
> >
> >On sobota 26. =C3=BAnora 2022 14:30:42 CET Zev Weiss wrote:
> >> Hello,
> >>
> >> This patch series augments the existing nct6775 driver with support
> >> for the hardware's i2c interface.
> >
> >Is it something I can test on my ASUS Pro WS X570-ACE board as an ordina=
ry user, and if so, how?
> >
>=20
> You could certainly test that the nct6775-platform driver still works as=
=20
> it did previously, which would be good to confirm -- you'll need to=20
> enable CONFIG_SENSORS_NCT6775_PLATFORM now to build it.

Ack.

>  From what I've been able to find about that board though it looks like=20
> it doesn't have a BMC, so testing the i2c driver on it probably isn't=20
> going to be possible.  (Even if it does in fact have a BMC, it would=20
> require at least a partial port of OpenBMC or similar, and re-flashing=20
> your BMC firmware with that, and is hence a non-trivial undertaking.)

It should have, the BMC is based on RTL8117, although I have no idea if it =
is something that can be called true IPMI as I've never enabled/used it.

Thanks.

>=20
>=20
> Zev
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)


