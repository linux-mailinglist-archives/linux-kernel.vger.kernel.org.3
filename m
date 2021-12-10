Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E115946F8FE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 03:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhLJCPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 21:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbhLJCPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 21:15:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05D7C061746;
        Thu,  9 Dec 2021 18:12:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F357B82644;
        Fri, 10 Dec 2021 02:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE19C004DD;
        Fri, 10 Dec 2021 02:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639102335;
        bh=0tqoAYcVsMV4yoz2DptTe40PGDGwUzmdYpssOWCmJZ8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Lc02yxYh8yVztBMSpXcmOQkmurXdIXFIdmhtWNg7IQcoXQf2o7/s7uaQagTirX8Tm
         Qag65LTxZ/r/9QGSQ6AYnTzuKrN9/fxiKXYj/9sJnueRWEidB65qfYU/mu2jxGQXff
         Hk2wZPC4sFRSTOfm1YSIqHVuOwFQ7tWHN75hSr06EslVpuwLjDmXizmBt8Lh2gk3LD
         sL1DGqGoCDkfChN9LKG5TTrCtc3seb3zzfl5d4obtwJJc3xvY0nVLMasqLHqZQnrQJ
         /KHoRvrEE3bOOL0dTFX6aTkeMo+ALb1paP2xkyI/npf3EI0iWOM75tdp4Swk0lXI3m
         5q1Ejn5eqNixw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211119034613.32489-1-james.lo@mediatek.com>
References: <20211119034613.32489-1-james.lo@mediatek.com>
Subject: Re: [PATCH v16 0/4] Add SPMI support for Mediatek SoC IC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        James Lo <james.lo@mediatek.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
To:     James Lo <james.lo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 09 Dec 2021 18:12:13 -0800
User-Agent: alot/0.9.1
Message-Id: <20211210021215.0EE19C004DD@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James Lo (2021-11-18 19:46:09)
> This series adds support for new SoC MT6873/MT8192/MT8195 to the spmi dri=
ver.
> This series is based on Chun-Jie's patches[1].
>=20
> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D52=
1655

This isn't needed though right? I've picked these four patches up into
spmi-next.
