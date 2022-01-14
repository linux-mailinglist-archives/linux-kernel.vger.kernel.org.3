Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE39548F254
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 23:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiANWTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 17:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiANWTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 17:19:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D28C061574;
        Fri, 14 Jan 2022 14:19:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1753B61ED2;
        Fri, 14 Jan 2022 22:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660B5C36AE9;
        Fri, 14 Jan 2022 22:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642198770;
        bh=zWsLY3ky24QWmemKhcAlVIHzefIeXpr+gm+UbQH9Zj0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=V6VondQqTNiZd9F9fU2EjAEbUMVRmQVCbtezr9MVQFnl4Mnp2uxgZYnoZcOUKKK2F
         6dzm5E+3rfNEoRqrue//pOwZF/+ZWN8roOhLfH9cBBEggjsztjWPrvRjsHZEqKFn/8
         JHyTkE/bmlBPL1ScCULbFBRiLpsegVMhLV6qvDUEsf+0O3+E/sh31DVkvGuXA87AQI
         yBpfZY6QhUcuvgT/VzxKpujFyAT/2y0XAM1IxHeUB1Emn5Vcq5L4yApkKFHptue+dt
         YpRdknoghrcNUJGXXsGT9oTSHKUksxTWpwDMghlLII1MU6Hi7YucpPj3K1hIn/L+QJ
         625XrLnUZcQ0A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220114083511.18906-1-miles.chen@mediatek.com>
References: <20220114021131.1F7C9C36AEA@smtp.kernel.org> <20220114083511.18906-1-miles.chen@mediatek.com>
Subject: Re: [PATCH 3/3] clk: mediatek: support COMMON_CLK_MT8192 module build
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     chun-jie.chen@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, miles.chen@mediatek.com,
        mturquette@baylibre.com, wenst@chromium.org
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>
Date:   Fri, 14 Jan 2022 14:19:28 -0800
User-Agent: alot/0.10
Message-Id: <20220114221930.660B5C36AE9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miles Chen (2022-01-14 00:35:10)
> Hi,
>=20
> >Have you tried removing the modules? And then reloading them? I also see
>=20
> Thanks for the comment.
> I did not try it because we do not unload our clk modules.
> After testing I understand that the clock driver does not unregister clks=
 so=20
> we cannot remove then unload it.
>=20
> I think I have to add some unregister logic to these drivers.

Yes

>=20
> >that mtk_clk_simple_probe() doesn't actually unregister anything, it
> >just frees some allocations. Please fix this before making these
> >modules.
>=20
> You meant that mtk_clk_simple_probe() has no unregister logic in error pa=
th?
>=20

Yes
