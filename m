Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AD649A852
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1317786AbiAYDDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3415485AbiAYBqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:46:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B81BC06E010;
        Mon, 24 Jan 2022 17:06:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B251B81229;
        Tue, 25 Jan 2022 01:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB92BC340E4;
        Tue, 25 Jan 2022 01:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643072754;
        bh=bBOo08okVMvqslhBWA1q9W4jRC1hY5Ab6adyvd5iIxA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=n4c16DR6j7bySYYp+f57T/ZuWqFTDNGj5uB+xeoeEgjx6V6PUSb4crrfvRCoA6J6T
         ySMbuB+HPufZYsKDobTW3eQTvoIlZw0T1chNujhR8Nv0VFY5peBQVuwbip6nhp8nXW
         MGDlG6rYmch2hn5DCV9TnBqZEvLKp4leMuhVs+L+bfBnPLyIVbJzlI3jwT2By/hYOd
         yS9BfMOC2/SeyDB6bpdVMLber8Ig/m1EzkEyY98uLj9qIbiAavBtdZzDq5Whz56pzd
         747mIuG3gRETje+ShVwi9qukk5kVlKzLRRC/J91cPA7I/IEIkhy0OklBKnXUK2t1jr
         BKoKJ5Pe8ctRg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220111125310.902856-1-tudor.ambarus@microchip.com>
References: <20220111125310.902856-1-tudor.ambarus@microchip.com>
Subject: Re: [PATCH] clk: at91: sama7g5: Allow MCK1 to be exported and referenced in DT
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, robh+dt@kernel.org,
        rdunlap@infradead.org, unixbhaskar@gmail.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        claudiu.beznea@microchip.com, mturquette@baylibre.com
Date:   Mon, 24 Jan 2022 17:05:53 -0800
User-Agent: alot/0.10
Message-Id: <20220125010554.BB92BC340E4@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tudor Ambarus (2022-01-11 04:53:10)
> MCK1 feeds the External Bus Interface (EBI). EBI's clock rate is used
> to translate EBI's timmings to SMC timings, thus we need to handle MCK1
> in the EBI driver. Allow MCK1 to be referenced as a PMC_TYPE_CORE clock
> from phandle in DT.
>=20
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

Applied to clk-next
