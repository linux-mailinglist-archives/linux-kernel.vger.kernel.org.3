Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D5246F60E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 22:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhLIVkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 16:40:08 -0500
Received: from elvis.franken.de ([193.175.24.41]:38896 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhLIVkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:40:05 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mvR5U-0006qc-00; Thu, 09 Dec 2021 22:36:24 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id C2D81C02CD; Thu,  9 Dec 2021 18:11:09 +0100 (CET)
Date:   Thu, 9 Dec 2021 18:11:09 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v11 0/8] MIPS: JZ4780 and CI20 HDMI
Message-ID: <20211209171109.GA18973@alpha.franken.de>
References: <cover.1638470392.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638470392.git.hns@goldelico.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 07:39:45PM +0100, H. Nikolaus Schaller wrote:
> [..] 
> This series adds HDMI support for JZ4780 and CI20 board
> 
> 
> 
> H. Nikolaus Schaller (3):
>   drm/ingenic: prepare ingenic drm for later addition of JZ4780
>   MIPS: defconfig: CI20: configure for DRM_DW_HDMI_JZ4780
>   [RFC] MIPS: DTS: Ingenic: adjust register size to available registers
> 
> Paul Boddie (4):
>   drm/ingenic: Add support for JZ4780 and HDMI output
>   drm/ingenic: Add dw-hdmi driver for jz4780
>   MIPS: DTS: jz4780: Account for Synopsys HDMI driver and LCD
>     controllers
>   MIPS: DTS: CI20: Add DT nodes for HDMI setup
> 
> Sam Ravnborg (1):
>   dt-bindings: display: Add ingenic,jz4780-dw-hdmi DT Schema
> 
>  .../display/bridge/ingenic,jz4780-hdmi.yaml   |  78 ++++++++++
>  .../display/bridge/synopsys,dw-hdmi.yaml      |   3 +
>  arch/mips/boot/dts/ingenic/ci20.dts           |  72 +++++++++-
>  arch/mips/boot/dts/ingenic/jz4725b.dtsi       |   2 +-
>  arch/mips/boot/dts/ingenic/jz4740.dtsi        |   2 +-
>  arch/mips/boot/dts/ingenic/jz4770.dtsi        |   2 +-
>  arch/mips/boot/dts/ingenic/jz4780.dtsi        |  40 ++++++
>  arch/mips/configs/ci20_defconfig              |   6 +
>  drivers/gpu/drm/ingenic/Kconfig               |   9 ++
>  drivers/gpu/drm/ingenic/Makefile              |   1 +
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |  62 +++++++-
>  drivers/gpu/drm/ingenic/ingenic-drm.h         |  38 +++++
>  drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c     | 136 ++++++++++++++++++
>  13 files changed, 443 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
>  create mode 100644 drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c

applied patches 5-8 to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
