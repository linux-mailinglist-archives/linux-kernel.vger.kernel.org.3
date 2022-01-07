Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708DC48706F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344673AbiAGCcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:32:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36428 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344700AbiAGCcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:32:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B69861D15;
        Fri,  7 Jan 2022 02:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCB9C36AE5;
        Fri,  7 Jan 2022 02:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641522722;
        bh=wqrLQ8xJsAam3WCj6CV+t05ORa4KMZ45YTRPs1CsPdM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bdLq406E1iS5TVhx6sKs1n0wokbRjZ+4+K+xYFY0mVK3/soFuRPeqdj6Lt7m43MOu
         usBEblfxAVVnAeSFO+Y0omdCsgFSG1QfScKvS6HL5NgvZHA+E/O75aLVfn/c+mrEkk
         1Fcl7Upn73/gNRKMJW0/6J/x0ia6hC7fntGUs/QwlXgEHk8XirNGCsk80qB5wqDfJG
         bubkeCafx4AH2qd+K9zrmSJL2EFDr5kwe81vMBRIoPUkWbkA7YX1nlzIZUeKiqrq3+
         bc7gTqSd/YMuQF0TruXGS30z2aQ1MN59hREgaZMkjygsLHsX3QUAI6r3/c9gXP0Qxt
         nxIwKg09AIpiQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211217121148.6753-2-sam.shih@mediatek.com>
References: <20211217121148.6753-1-sam.shih@mediatek.com> <20211217121148.6753-2-sam.shih@mediatek.com>
Subject: Re: [PATCH v7 1/3] dt-bindings: clock: mediatek: document clk bindings for mediatek mt7986 SoC
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
Date:   Thu, 06 Jan 2022 18:32:00 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107023201.DFCB9C36AE5@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sam Shih (2021-12-17 04:11:46)
> This patch adds the binding documentation for topckgen, apmixedsys,
> infracfg, and ethernet subsystem clocks.
>=20
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
