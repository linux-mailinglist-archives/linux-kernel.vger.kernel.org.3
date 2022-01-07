Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B26F487080
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344811AbiAGCez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344761AbiAGCey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:34:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C06C061245;
        Thu,  6 Jan 2022 18:34:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DECEAB824B9;
        Fri,  7 Jan 2022 02:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C52CC36AEB;
        Fri,  7 Jan 2022 02:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641522891;
        bh=v/UysLRyR3ZSlYOfKYLwtg+YpmYmJmwLdARF6BhGaVY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LfXDDepduhcDgcZ7TXNP2BmPlFyOTDxDpJ5agIb2ONPXGQ0jBrC7FFhXa7ddDXQLT
         XxKIvKxLkPYR0mxTRNSC7FdgiEDvoLcArfcJmQ5crc/p+d33RaH/whKTW4Uj8Kg+Ql
         GOpIVeaL/+ufR9dHez029Bm65QIihOsDb8tMcirq7zY2YJiJHX4I3endUqNYze+ZJK
         6vQGD+54lZRXQO05QSP6BFG8yAW+OXxAbzJjoqR5uH8a8WBW7UlNZRO6Su5KDSKt/9
         0SNRf+kxtULLtaXruJSGWoP8f7MyL/hVhNTRhyBPyHg3It7edBq05hkKBJa49ZETIA
         P9GHYClRv+Onw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGXv+5G5vnOuW46q7b7m6BDS+R4vCLJehrofjfv95uOFbwyzEg@mail.gmail.com>
References: <20211110022258.2358-1-chun-jie.chen@mediatek.com> <CAGXv+5G5vnOuW46q7b7m6BDS+R4vCLJehrofjfv95uOFbwyzEg@mail.gmail.com>
Subject: Re: [v1] clk: mediatek: use en_mask as a pure div_en_mask
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Date:   Thu, 06 Jan 2022 18:34:50 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107023451.7C52CC36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2021-11-09 22:59:37)
> Hi,
>=20
> On Wed, Nov 10, 2021 at 10:23 AM Chun-Jie Chen
> <chun-jie.chen@mediatek.com> wrote:
> >
> > We no longer allow en_mask to be a combination of
> > pll_en_bit and div_en_mask, so remove pll_en_bit(bit0)
> > from en_mask to make en_mask a pure en_mask that only
> > used for pll dividers.
>=20
> AFAICT this looks like it continues the work done in commit 7cc4e1bbe300
> ("clk: mediatek: Fix asymmetrical PLL enable and disable control") and
> commit f384c44754b7 ("clk: mediatek: Add configurable enable control to
> mtk_pll_data").
>=20
> It would be nice if you could mention this in your commit log to provide
> more context.

Please resend.
