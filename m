Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9F149A895
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1319574AbiAYDJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3423872AbiAYCiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:38:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03262C061763;
        Mon, 24 Jan 2022 16:51:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B48D2B81229;
        Tue, 25 Jan 2022 00:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C7EC340E4;
        Tue, 25 Jan 2022 00:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643071916;
        bh=AYg99rtmRl9GS4yUuo5uLAiqb7quz2ZcDW/VMq+g7Kc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Nkvd5G5CvqgnP0RHpwCGmlz7ri/u3HmRQ7YqqvRhXbxf6WGS2LRXTVVHVaALs2Zmm
         5MaYkMuKA76K8ae7aF9Ur0vvAQXRWW2zAMIQb54bHPMe4+XFSyHx3QALKEeudvxc2p
         ABrYcKVyUJwQyPYW0umWNriQKC824SUVd9o9U6FCYlHu0zB2pIZc9d+dybQtgAEXFp
         fIGf7kbtEfMU34zFVlkt/wJUXGucoOHxJdeCzQoTmXDfIVKvQN3yZfndv5wXqjsU73
         zW/t9fkJJNvroxfOC7izEtKt3MUSmEDIr+sPQsIHgC5C/X1H9NDxSCoC3FMDnWfEbA
         w/td4kRTpRxRg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1634280331-4150-1-git-send-email-wangqing@vivo.com>
References: <1634280331-4150-1-git-send-email-wangqing@vivo.com>
Subject: Re: [PATCH RESEND] clk-si5341: replace snprintf in show functions with sysfs_emit
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mike.looijmans@topic.nl, Qing Wang <wangqing@vivo.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Qing Wang <wangqing@vivo.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jan 2022 16:51:54 -0800
User-Agent: alot/0.10
Message-Id: <20220125005156.63C7EC340E4@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Qing Wang (2021-10-14 23:45:28)
> coccicheck complains about the use of snprintf() in sysfs show functions.
>=20
> Fix the following coccicheck warning:
> drivers/clk/clk-si5341.c:1471: WARNING: use scnprintf or sprintf.
> drivers/clk/clk-si5341.c:1486: WARNING: use scnprintf or sprintf.
> drivers/clk/clk-si5341.c:1501: WARNING: use scnprintf or sprintf.
> drivers/clk/clk-si5341.c:1516: WARNING: use scnprintf or sprintf.
>=20
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
>=20
> Signed-off-by: Qing Wang <wangqing@vivo.com>
> ---

Applied to clk-next
