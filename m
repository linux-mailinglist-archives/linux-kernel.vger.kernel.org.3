Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CDC49FD13
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349565AbiA1Psd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:48:33 -0500
Received: from gloria.sntech.de ([185.11.138.130]:41220 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348753AbiA1Psd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:48:33 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nDTUC-0007d7-G7; Fri, 28 Jan 2022 16:48:28 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     robh@kernel.org, lukasz.luba@arm.com, arnd@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v7 5/5] rockchip/soc/drivers: Add DTPM description for rk3399
Date:   Fri, 28 Jan 2022 16:48:27 +0100
Message-ID: <3660693.PMFMTDrQKU@diego>
In-Reply-To: <20220125171809.1273269-6-daniel.lezcano@linaro.org>
References: <20220125171809.1273269-1-daniel.lezcano@linaro.org> <20220125171809.1273269-6-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 25. Januar 2022, 18:18:09 CET schrieb Daniel Lezcano:
> The DTPM framework does support now the hierarchy description.
> 
> The platform specific code can call the hierarchy creation function
> with an array of struct dtpm_node pointing to their parent.
> 
> This patch provides a description of the big / Little CPUs and the
> GPU and tie them together under a virtual 'package' name. Only rk3399 is
> described now.
> 
> The description could be extended in the future with the memory
> controller with devfreq.
> 
> The description is always a module and it describes the soft
> dependencies. The userspace has to load the softdeps module in the
> right order.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by; Heiko Stuebner <heiko@sntech.de>


