Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC0948705D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbiAGC1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:27:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39872 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344600AbiAGC1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:27:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6B92B82352;
        Fri,  7 Jan 2022 02:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFC8C36AE5;
        Fri,  7 Jan 2022 02:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641522457;
        bh=wMrnuKLVipxEQwYq49Wt5ylnblmw0aY97RFd9CHzOJE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mIBYwZC6r6FLI91Ygr8uLNBJYT3deW1eKGcoGuqyLs6u56uYRDmcB3NoS0J5Gs933
         HZwI78sIfqBeXRl6DQAajjKttqcRXVcmrFWhc+VZd3+GXdftYOS9eDXwNMNINHHPXr
         XwPYT02pQX7Xz+2tPpkHHSCBm0IQSOteX3COxha6g9Lea5An0s9LICTCohssO1m5tc
         K9WCMBwmuKPzgIOGqdHOy9QfUdR8gzAc6w4XjlsWHpFSMClavN6MClEqA/KTVkaGlo
         QB6ISWCsS1027noh4X169IVcthqTsfV8PQ9B36+Bzc8nBdSB6uA+GxgdDypBYXVrHL
         s2SZNkcsl3DnQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220103143712.46675-2-angelogioacchino.delregno@collabora.com>
References: <20220103143712.46675-1-angelogioacchino.delregno@collabora.com> <20220103143712.46675-2-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 2/2] clk: mediatek: clk-gate: Use regmap_{set/clear}_bits helpers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Date:   Thu, 06 Jan 2022 18:27:36 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107022737.6EFC8C36AE5@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2022-01-03 06:37:12)
> Appropriately change calls to regmap_update_bits() with regmap_set_bits()
> and regmap_clear_bits() for improved readability.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next
