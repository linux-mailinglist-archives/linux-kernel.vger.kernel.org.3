Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B8148BD6D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348942AbiALCwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:52:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51838 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbiALCwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:52:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAD21B81DBC;
        Wed, 12 Jan 2022 02:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C4BC36AEB;
        Wed, 12 Jan 2022 02:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641955920;
        bh=pYhb6dYTiKQIyigud0WBES7Miwz6szh1LNYMaHQQldE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JY3XDvFyZXt3/PZGaZH0VSJJBaguuqSEDAFP1wsz7d+YI9EQj2bvOxu8GOIqJnT2H
         Dvwv0dLhY/I8xd/hSyc84qnUby8O7mhu7fU4ry4QBa1Hx2fYWt3NcZ0PDyG6ISQQ0y
         1xU3ISEcaFIXAkgrgjLjjqnGNKbFMFyQbqUFLUk+cW0RWbbHRjOgxMdRmtb3KyJ3iH
         vnu/wjihNmT0uR2IsSIIPiOhVwCG+1saDepT+yuWvJ+5Isae+0eAvSI278rAW1QAEc
         NetC6mna8UUCKD6y8AAkrZrTTztUNtsSiKrLEbRQpKEd+MkfVC7etlEa299vfGZs5j
         iseun22PDVHlw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220107082436.17716-1-linmq006@gmail.com>
References: <20220107082436.17716-1-linmq006@gmail.com>
Subject: Re: [PATCH] clk: tegra: tegra124-emc: Fix missing put_device() call in emc_ensure_emc_driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linmq006@gmail.com, Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Miaoqian Lin <linmq006@gmail.com>
Date:   Tue, 11 Jan 2022 18:51:59 -0800
User-Agent: alot/0.9.1
Message-Id: <20220112025200.95C4BC36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miaoqian Lin (2022-01-07 00:24:36)
> The reference taken by 'of_find_device_by_node()' must be released when
> not needed anymore.
> Add the corresponding 'put_device()' in the error handling path.
>=20
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Please send the mail To: somebody

Also, please add a Fixes: tag.
