Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620E746E440
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhLIIfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbhLIIfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:35:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59201C061746;
        Thu,  9 Dec 2021 00:32:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A58FBCE241B;
        Thu,  9 Dec 2021 08:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BAAC004DD;
        Thu,  9 Dec 2021 08:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639038717;
        bh=tnpW+JsUuLj2wWcANc9sa+ZLsGkL3XLw2Vx85Xbamp4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Od3HY/3NlYUc2Z6ofVIIkbDLdhgAXsGcsEsEAfH8Mk1bhj2CjoINR3sN+t1GUDP34
         glUYfP8Zc8vyoK8A+SuwRYCWblG5mwMtxDZQpYs5mi3i1PLpTln+5u6fW6ocVQPX/P
         Krpka/KBh42ItGeeNqxCgK1bRXnrz4OP/4G0PxExfcHFyctGeazqdAE8C/tt4Ywvr5
         qWgYuFrMu9LLjzLR7wJ2yikDDEsGcf9g73eztqr1QhdEfzIzE0qIg2vUviKdUKMZSO
         QpNheyX5snXV++iG17vaypf8M6BsN+Okbo+GNgGoa0ohhzlpi8pbFAZ9qhfoiNm3B4
         bUzNrhvUuW2rg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211208133145.28267-1-nicolas.ferre@microchip.com>
References: <20211208133145.28267-1-nicolas.ferre@microchip.com>
Subject: Re: [GIT PULL] clk: at91: clk for 5.17
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
To:     linux-clk@vger.kernel.org, mturquette@baylibre.com,
        nicolas.ferre@microchip.com
Date:   Thu, 09 Dec 2021 00:31:56 -0800
User-Agent: alot/0.9.1
Message-Id: <20211209083157.C0BAAC004DD@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting nicolas.ferre@microchip.com (2021-12-08 05:31:45)
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>=20
> Stephen,
>=20
> Here are the clk changes for 5.17 which collect changes to the lan966x pr=
oduct
> line. We agreed to include these Microchip patches into the at91 branch w=
ith
> Kavyasree and Horatiu.
>=20
> Please pull.
>=20
> Thanks, best regards,
>   Nicolas
>=20
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0d=
bf:
>=20
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/clk-a=
t91-5.17
>=20
> for you to fetch changes up to 5ad5915dea0047a6376d8f809ea3470ef68b1f92:
>=20
>   clk: lan966x: Extend lan966x clock driver for clock gating support (202=
1-12-08 11:19:20 +0100)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next
