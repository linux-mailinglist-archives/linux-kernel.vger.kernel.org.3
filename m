Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC54D49298B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345380AbiARPTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:19:14 -0500
Received: from gloria.sntech.de ([185.11.138.130]:40340 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233767AbiARPTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:19:07 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1n9qG7-0006C3-8I; Tue, 18 Jan 2022 16:18:55 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>, Alex Bee <knaerzche@gmail.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: Re: [PATCH 0/4] add GPU for RK356x SoCs
Date:   Tue, 18 Jan 2022 16:18:54 +0100
Message-ID: <6645896.O1m7UbTlE4@diego>
In-Reply-To: <20211126151729.1026566-1-knaerzche@gmail.com>
References: <20211126151729.1026566-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Am Freitag, 26. November 2021, 16:17:25 CET schrieb Alex Bee:
> This is a respin of Ezequiel's series which adds GPU for RK3568 [0]:
> 
> > I've decided to split the GPU off previous series:

do you plan on a respin for Rob's comments?

Thanks
Heiko

> >
> > https://lore.kernel.org/linux-rockchip/2147216.TLkxdtWsSY@diego/
> >
> > This series now contains only the GPU support, as the VPU
> > needs a tiny rework.
> >
> > This is compiled tested only, in this case. Similar patches
> > have been tested on a v5.10-based kernel, so I'd say it's good
> > to go.
> >
> > The mesa side is merged https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/10771
> > and can be tested without a display, using something like weston --backend=headless-backend.so,
> > which provides an environment for GL to work.
> 
> I hope to have resolved all DT-binding issues and added cooling map and trip points
> which can make the GPU a cooling device.
> 
> Tested with mesa 21.3.0 on quartz64-a board.
> 
> [0] https://patchwork.kernel.org/project/linux-rockchip/list/?series=526661
> 
> Alex Bee (2):
>   dt-bindings: gpu: mali-bifrost: Allow up to two clocks
>   arm64: dts: rockchip: Add cooling map / trip points for RK356x' GPU
> 
> Ezequiel Garcia (2):
>   arm64: dts: rockchip: Add GPU node for rk3568
>   arm64: dts: rockchip: Enable the GPU on Quartz64 Model A
> 
>  .../bindings/gpu/arm,mali-bifrost.yaml        | 20 ++++-
>  .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  5 ++
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 77 +++++++++++++++++++
>  3 files changed, 101 insertions(+), 1 deletion(-)
> 
> 




