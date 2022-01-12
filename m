Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B0748CD35
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344640AbiALUnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbiALUn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:43:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAD1C06173F;
        Wed, 12 Jan 2022 12:43:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD8CC61997;
        Wed, 12 Jan 2022 20:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354DCC36AE9;
        Wed, 12 Jan 2022 20:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642020208;
        bh=Ac7uCpPE99DsSqddUNSny/kXs/+W3vMP+9SzM1bqi5Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KvltawUOr6vMDJKKeqdbhvC9zFgQ9x13wrlLoHrp7wdqTbt/r2BGtNHmxUuIoDdcd
         XjP+voQsPddNiYsdKxKcEBTFTTmeBeJZEyYahCS9hZKwYRuLAEUmYEzrJF96qedEni
         evXKJKMGxDt8iiBAGXFUaA0UIPrxJ4ExI4Ik6wqN/jkm7/aJ6CRkEpn4FpAVN1bQ0K
         hMLxVwNokR9tTO6nGCtQtVAvCvSycyYqnSl7Hw8b2nXZGvDl1owyPX7+ix4tmSDTQU
         tOkbNk1zekdWfVziiBaSdSRTwn1WFZ+nc2VO8Aj6E7Vk2oNYeD1DB85GXrgPueS5d2
         AhZtzJ+IUOzEQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211215060019.441549-1-chi.minghao@zte.com.cn>
References: <20211215060019.441549-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH clk-next] drivers/clk: remove redundant result variable
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     pgaikwad@nvidia.com, mturquette@baylibre.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
To:     cgel.zte@gmail.com, pdeschrijver@nvidia.com
Date:   Wed, 12 Jan 2022 12:43:25 -0800
User-Agent: alot/0.9.1
Message-Id: <20220112204328.354DCC36AE9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix the subject to include tegra

$ git log --oneline -2 -- drivers/clk/tegra
b1bc04a2ac5b clk: tegra: Support runtime PM and power domain
e360e116a0ee clk: tegra: Make vde a child of pll_p on tegra114

Quoting cgel.zte@gmail.com (2021-12-14 22:00:19)
> From: Minghao Chi <chi.minghao@zte.com.cn>
>=20
> Return value from FIELD_GET() directly instead
> of taking this in another redundant variable.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
