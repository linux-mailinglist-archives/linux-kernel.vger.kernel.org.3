Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C87548DF9B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiAMVaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiAMVaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:30:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2296C061574;
        Thu, 13 Jan 2022 13:29:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B145EB821C3;
        Thu, 13 Jan 2022 21:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768FFC36AE3;
        Thu, 13 Jan 2022 21:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642109397;
        bh=yW9AcQzuoUaR989bsxK4TgDY9aBm1cvbSwLkItbJe+Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZQThfKK7ttBmAVSKpY2YgYBHP94O7LeXCIJUdl8+pjbRPJ5abqlr9/PQ0a51XddUZ
         8LbcU3NMrR/Ywb8RRYOYLmOmKw2LexzZdyKzP+MTJ58lp+s7BSqHY7+ujWai4G68sz
         vo1epPK0h4ahadtDZ02MF5PsftcG2/N7C7U3/haig6JBbTsJClSXKHxlVbjHMN0cbc
         DFxt8ZH+FqVSbvnA2R9QQsM3xwuRJuJgt4INQ7G/7J5h8YV2nRjCHTXyNHH/LvgnIs
         4z1jzXa0SUpD1P7s4xOHuZ/RJ3rv4X0NNURdLQEVfwqP6hBg/llz6vLHQ1squwWF9R
         CC/IPehM0jiGA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220113115745.45826-4-liang.yang@amlogic.com>
References: <20220113115745.45826-1-liang.yang@amlogic.com> <20220113115745.45826-4-liang.yang@amlogic.com>
Subject: Re: [PATCH v9 3/4] clk: meson: add DT documentation for emmc clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org
Date:   Thu, 13 Jan 2022 13:29:56 -0800
User-Agent: alot/0.9.1
Message-Id: <20220113212957.768FFC36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Liang Yang (2022-01-13 03:57:44)
> Document the MMC sub clock controller driver, the potential consumer
> of this driver is MMC or NAND. Also add four clock bindings IDs which
> provided by this driver.
>=20
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> ---
>  .../bindings/clock/amlogic,mmc-clkc.yaml      | 64 +++++++++++++++++++
>  include/dt-bindings/clock/amlogic,mmc-clkc.h  | 14 ++++
>  2 files changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-c=
lkc.yaml
>  create mode 100644 include/dt-bindings/clock/amlogic,mmc-clkc.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.yam=
l b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.yaml
> new file mode 100644
> index 000000000000..a274c3d5fc2e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/amlogic,mmc-clkc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic MMC Sub Clock Controller Driver Device Tree Bindings
> +
> +maintainers:
> +  - jianxin.pan@amlogic.com
> +  - liang.yang@amlogic.com
> +
> +properties:
> +  compatible:
> +    enum:
> +      - "amlogic,axg-mmc-clkc", "syscon"

Why is it a syscon?
