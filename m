Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1791A487075
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344719AbiAGCca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345462AbiAGCcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:32:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6486EC061201;
        Thu,  6 Jan 2022 18:32:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CB7261D15;
        Fri,  7 Jan 2022 02:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EC7C36AE3;
        Fri,  7 Jan 2022 02:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641522736;
        bh=GZT+2y9W/LYKIckQ7nhu2pQ5tWSH9XoDLshaOtLjGNc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pyfq7/1O89rNncSYEcXLRgjsE/P/68+/hCrrvqC+nqxqdtLZJllHj2T0mz+U+O7or
         h7b/6iABs3FE+867qfKAV4m5sQfMRgahCdqqSrKEr5lrCCz7dE2MlF9fq7nYyIZ8xO
         AreYkjov9GhNlknMXzU7c3K5g0tLgdvKfRcb3xpf+WKyxaj2nSvyxFFjCrEMJ1aZi1
         qA16l7RmMwnA3pSxsPpPgSI6xf+3cEV3MurBkAiv1xjouFmEXPNrBaya7YfyBQws4j
         W/q1eS9jGwguUAqbs592JXbp10KphiMGz/v8mnSYpoBnsaUKCv8osgH2fKNhBsP01s
         SzungOWx4FyDw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211217121148.6753-4-sam.shih@mediatek.com>
References: <20211217121148.6753-1-sam.shih@mediatek.com> <20211217121148.6753-4-sam.shih@mediatek.com>
Subject: Re: [PATCH v7 3/3] clk: mediatek: add mt7986 clock support
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
Date:   Thu, 06 Jan 2022 18:32:15 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107023216.64EC7C36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sam Shih (2021-12-17 04:11:48)
> Add MT7986 clock support, include topckgen, apmixedsys,
> infracfg, and ethernet subsystem clocks.
>=20
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---

Applied to clk-next
