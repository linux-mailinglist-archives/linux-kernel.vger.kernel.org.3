Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461D948E270
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbiANCMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:12:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43890 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiANCMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:12:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED1FE61DCA;
        Fri, 14 Jan 2022 02:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FB7C36AEA;
        Fri, 14 Jan 2022 02:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642126326;
        bh=zYNUnqgjvKHifNaU8URoS+KmBKOiGhrukpCA2hRznfs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VZfyyTLDOlgNpU1Eih3rLZG8eeAEzTgT0NJ9YufQqQRhYJDRwjGUkPqmp75+f8asu
         pZ/Ji4e5mjlda+mUcdKoLvByt5jyHOgwTk0A0HQNQQmTrt6HxUjF7wfUnsjt3rmYjY
         r+jA6Pka4KNVxJUeD1xItq9K1mOY+caO4oiABsvKepADxapp45ID6dRZn58MbMtoGZ
         udR5trefwfiegM+WeWY91SdQi0C7iHixepFO3cAt3ajLnVuFpuibEn6pXsKEa/jqD4
         S9bmwn+MXXHTmv6izLKlycFWEOfsLFz7pPKpswC/tH7ZLaHs5SWA24U+ZHYgHSnfs9
         yH4OBKPpIMPvw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220110171000.24316-2-miles.chen@mediatek.com>
References: <20220110171000.24316-1-miles.chen@mediatek.com> <20220110171000.24316-2-miles.chen@mediatek.com>
Subject: Re: [PATCH 1/3] clk: mediatek: export mtk_clk_simple_probe
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Miles Chen <miles.chen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>
Date:   Thu, 13 Jan 2022 18:12:05 -0800
User-Agent: alot/0.9.1
Message-Id: <20220114021206.43FB7C36AEA@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miles Chen (2022-01-10 09:09:57)
> Export mtk_clk_simple_probe() to support mt8192 module build.
>=20
> Cc: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Cc: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---

Please send a cover letter for multi-patch series.
