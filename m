Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E613C49A850
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1317721AbiAYDCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3415412AbiAYBqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:46:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEA5C06E00F;
        Mon, 24 Jan 2022 17:05:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38EF9B81603;
        Tue, 25 Jan 2022 01:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B04C340E4;
        Tue, 25 Jan 2022 01:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643072738;
        bh=C4zBnJsZ2BHLB/IT2MtkBDaS9vKy5lnt6zqu9oZCg5w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=D1Mcqa6whk00jKaF4NhYbHl8B6iOCcajCt8d70fLrBNeBDOzt0Aj80tTqnrF+cATi
         DyiVZZp9YkybjBeFeJzaHeFGzlYB2KarenVKdjIOJiaq5BRY1WjSyPYeQO6KsvIsRy
         JFiOBrpv6J/2M7iH9ijM+1R5Faobo+Xb1HX2yzgX6oLY7MiitYFQhZHjWJhgTinQ5B
         KWZho5ddeaTJDOPW8Zr5DtlsrfQj0XdIQiTrXSsZFF5ey8DwSRSIZafVy0v4SVX4QH
         XqFHbSoqsNtSBqEUfrwasAauTmFYu8MYq2M/GPduujD7mO61dvz0Q3JFmOGsHt4Q/s
         wR9vmep6Ao3NQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220111142051.37957-1-admin@hifiphile.com>
References: <20220111142051.37957-1-admin@hifiphile.com>
Subject: Re: [PATCH] clk: at91: allow setting PMC_AUDIOPINCK clock parents via DT
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Zixun LI <admin@hifiphile.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zixun LI <admin@hifiphile.com>
Date:   Mon, 24 Jan 2022 17:05:37 -0800
User-Agent: alot/0.10
Message-Id: <20220125010538.D5B04C340E4@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zixun LI (2022-01-11 06:20:50)
> Make AUDIOPINCK accessible via phandle to select it
> as peripheral clock parent using assigned-clock-parents in DT
> where available.
>=20
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> Reviewed-by: Claudiu Beznea <Claudiu.Beznea@microchip.com>
> ---

Applied to clk-next
