Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CE6476A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbhLPGnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:43:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36938 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhLPGnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:43:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C50CEB822CB;
        Thu, 16 Dec 2021 06:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74707C36AE2;
        Thu, 16 Dec 2021 06:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639636988;
        bh=49P69ONQv4uPCUHqOitVHUW4w4lQcOe/h5lWhfYEfHI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Nk2kSq8R678h9c0UP5d5/qFx93f32pCfntFyJdkAM0hOl5raWG68+lEj19A321WXz
         0C2xSMCq1NDwMpUsKl714xA5mtVctWZTQrMzr4YXKrH32oyqPR4ksvqkoMol/QSwrt
         x9NpSUtlvM4rdp2YW1OH9yQc8VuER8OXzqex97yh9X/MicPgOzDW4lvPk9ZfuAGSae
         3dxMJpJ2nJZkiV5WnuG2V4IJDYZVvGXThs8l5jb9uWGxHhZgL4Lf11jKXPg2A8pSCf
         Tqo8GWlr+/tl0gTFzWPX4hly4qTx7XLAVjSZ3G/sACkjIYVdkGkM8lls14iGRXcmO/
         +WLbDIbAUiutg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d2c9bd9bec36ebbd57dc7ec4d44887d5ce67bcc0.1638515726.git.qinjian@cqplus1.com>
References: <cover.1638515726.git.qinjian@cqplus1.com> <d2c9bd9bec36ebbd57dc7ec4d44887d5ce67bcc0.1638515726.git.qinjian@cqplus1.com>
Subject: Re: [PATCH v5 05/10] dt-bindings: clock: Add bindings for SP7021 clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, tglx@linutronix.de, maz@kernel.org,
        p.zabel@pengutronix.de, linux@armlinux.org.uk, broonie@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, wells.lu@sunplus.com,
        Qin Jian <qinjian@cqplus1.com>, Rob Herring <robh@kernel.org>
To:     Qin Jian <qinjian@cqplus1.com>, robh+dt@kernel.org
Date:   Wed, 15 Dec 2021 22:43:07 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216064308.74707C36AE2@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Qin Jian (2021-12-02 23:34:22)
> Add documentation to describe Sunplus SP7021 clock driver bindings.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
>  .../bindings/clock/sunplus,sp7021-clkc.yaml   |  38 ++++++
>  MAINTAINERS                                   |   2 +
>  include/dt-bindings/clock/sp-sp7021.h         | 112 ++++++++++++++++++
>  3 files changed, 152 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sunplus,sp702=
1-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/sp-sp7021.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.=
yaml b/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
> new file mode 100644
> index 000000000..1ce7e41d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/sunplus,sp7021-clkc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus SP7021 SoC Clock Controller Binding
> +
> +maintainers:
> +  - Qin Jian <qinjian@cqplus1.com>
> +
> +properties:
> +  compatible:
> +    const: sunplus,sp7021-clkc
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  reg:
> +    maxItems: 1

There are some parents it seems, so please specify them as clocks and
optionally clock-names in this binding.

> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clkc: clkc@9c000000 {

clock-controller@9c000000

> +      compatible =3D "sunplus,sp7021-clkc";
> +      #clock-cells =3D <1>;
> +      reg =3D <0x9c000000 0x280>;
> +    };
> +
> +...
