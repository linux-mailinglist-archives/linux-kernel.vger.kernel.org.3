Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E800487072
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345469AbiAGCcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:32:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41362 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345447AbiAGCcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:32:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B7DBB82352;
        Fri,  7 Jan 2022 02:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77FDC36AE5;
        Fri,  7 Jan 2022 02:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641522728;
        bh=YdNMm3YLxoeg6thWoy3+z5Vvy8+bQlB7/0IAGCZ6NYQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=F2Ix41jkwDOQe4+TZw78JUswoRPNj/wZu/gkOJHP/zuvkLxYuNCh2epnfj2jX8jkH
         ODPjDBISHEFR7CxOhlXTOcZwuZEHQWWanjufn9WC3jcX8WRhpcDWZvyK3/U/RN7zAO
         g0U1goXPfDmSGWnlAYcfDeVLvnqIDt8kkma9Opw9U8e+4HtD8XGAhcEPAmy77UouCX
         46T14bJexGUXH+ta/tEY9jnjdj4OfHo0m8gp6pVawFRH0E+z10VahKAtCUuNcxo8av
         /kSsOVFsFkwIdbRa57NqjPVhC8Mjgpz67mDQfITEI9gvgD0pQhbMC6S7Ql+6npymNq
         aOTAtFutYEk6w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211217121148.6753-3-sam.shih@mediatek.com>
References: <20211217121148.6753-1-sam.shih@mediatek.com> <20211217121148.6753-3-sam.shih@mediatek.com>
Subject: Re: [PATCH v7 2/3] clk: mediatek: add mt7986 clock IDs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     John Crispin <john@phrozen.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        YH Chen <yh.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Thu, 06 Jan 2022 18:32:07 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107023208.C77FDC36AE5@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sam Shih (2021-12-17 04:11:47)
> Add MT7986 clock dt-bindings, include topckgen, apmixedsys,
> infracfg, and ethernet subsystem clocks.
>=20
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
