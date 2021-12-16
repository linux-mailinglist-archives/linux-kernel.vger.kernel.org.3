Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2AE4775DB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbhLPPZP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Dec 2021 10:25:15 -0500
Received: from aposti.net ([89.234.176.197]:35342 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238467AbhLPPZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:25:13 -0500
Date:   Thu, 16 Dec 2021 15:24:53 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v11 0/8] MIPS: JZ4780 and CI20 HDMI
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
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
Message-Id: <H5S74R.5BG9EDZORI63@crapouillou.net>
In-Reply-To: <cover.1638470392.git.hns@goldelico.com>
References: <cover.1638470392.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patches 1 and 2 added to drm-misc-next.

I'll pick the rest when the regulator situation is sorted out.

Cheers,
-Paul


Le jeu., déc. 2 2021 at 19:39:45 +0100, H. Nikolaus Schaller 
<hns@goldelico.com> a écrit :
> PATCH V11 2021-12-02 19:39:52:
> - patch 4/8: change devm_regulator_get_optional to devm_regulator_get 
> and
>              remove NULL check (requested by broonie@kernel.org)
> - patch 3/8: make hdmi-5v-supply required (requested by 
> broonie@kernel.org)
> 
> PATCH V10 2021-11-30 22:26:41:
> - patch 3/8: fix $id and $ref paths (found by robh@kernel.org)
> 
> PATCH V9 2021-11-24 22:29:14:
> - patch 6/8: remove optional <0> for assigned-clocks and 
> unintentionally included "unwedge" setup (found by 
> paul@crapouillou.net)
> - patch 4/8: some cosmetics
>              make regulator enable/disable only if not NULL (found by 
> paul@crapouillou.net)
>              simplify/fix error handling and driver cleanup on remove 
> (proposed by paul@crapouillou.net)
> - patch 3/8: fix #include path in example (found by 
> paul@crapouillou.net)
>              fix missing "i" in unevaluatedProperties (found by 
> robh@kernel.org)
>              fix 4 spaces indentation for required: property (found 
> by robh@kernel.org)
> 
> PATCH V8 2021-11-23 19:14:00:
> - fix a bad editing result from patch 2/8 (found by 
> paul@crapouillou.net)
> 
> PATCH V7 2021-11-23 18:46:23:
> - changed gpio polarity of hdmi_power to 0 (suggested by 
> paul@crapouillou.net)
> - fixed LCD1 irq number (bug found by paul@crapouillou.net)
> - removed "- 4" for calculating max_register (suggested by 
> paul@crapouillou.net)
> - use unevaluatedPropertes instead of additionalProperties (suggested 
> by robh@kernel.org)
> - moved and renamed ingenic,jz4780-hdmi.yaml (suggested by 
> robh@kernel.org)
> - adjusted assigned-clocks changes to upstream which added some for 
> SSI (by hns@goldelico.com)
> - rebased and tested with v5.16-rc2 + patch set drm/ingenic by 
> paul@crapouillou.net (by hns@goldelico.com)
> 
> PATCH V6 2021-11-10 20:43:33:
> - changed CONFIG_DRM_INGENIC_DW_HDMI to "m" (by hns@goldelico.com)
> - made ingenic-dw-hdmi an independent platform driver which can be 
> compiled as module
>   and removed error patch fixes for IPU (suggested by 
> paul@crapouillou.net)
> - moved assigned-clocks from jz4780.dtsi to ci20.dts (suggested by 
> paul@crapouillou.net)
> - fixed reg property in jz4780.dtsi to cover all registers incl. 
> gamma and vee (by hns@goldelico.com)
> - added a base patch to calculate regmap size from DTS reg property 
> (requested by paul@crapouillou.net)
> - restored resetting all bits except one in LCDOSDC (requested by 
> paul@crapouillou.net)
> - clarified setting of cpos (suggested by paul@crapouillou.net)
> - moved bindings definition for ddc-i2c-bus (suggested by 
> paul@crapouillou.net)
> - simplified mask definitions for JZ_LCD_DESSIZE (requested by 
> paul@crapouillou.net)
> - removed setting alpha premultiplication (suggested by 
> paul@crapouillou.net)
> - removed some comments (suggested by paul@crapouillou.net)
> 
> PATCH V5 2021-10-05 14:28:44:
> - dropped mode_fixup and timings support in dw-hdmi as it is no 
> longer needed in this V5 (by hns@goldelico.com)
> - dropped "drm/ingenic: add some jz4780 specific features" 
> (stimulated by paul@crapouillou.net)
> - fixed typo in commit subject: "synopsis" -> "synopsys" (by 
> hns@goldelico.com)
> - swapped clocks in jz4780.dtsi to match synopsys,dw-hdmi.yaml (by 
> hns@goldelico.com)
> - improved, simplified, fixed, dtbschecked ingenic-jz4780-hdmi.yaml 
> and made dependent of bridge/synopsys,dw-hdmi.yaml (based on 
> suggestions by maxime@cerno.tech)
> - fixed binding vs. driver&DTS use of hdmi-5v regulator (suggested by 
> maxime@cerno.tech)
> - dropped "drm/bridge: synopsis: Fix to properly handle HPD" - was a 
> no longer needed workaround for a previous version
>   (suggested by maxime@cerno.tech)
> 
> PATCH V4 2021-09-27 18:44:38:
> - fix setting output_port = 1 (issue found by paul@crapouillou.net)
> - ci20.dts: convert to use hdmi-connector (by hns@goldelico.com)
> - add a hdmi-regulator to control +5V power (by hns@goldelico.com)
> - added a fix to dw-hdmi to call drm_kms_helper_hotplug_event on 
> plugin event detection (by hns@goldelico.com)
> - always allocate extended descriptor but initialize only for jz4780 
> (by hns@goldelico.com)
> - updated to work on top of "[PATCH v3 0/6] drm/ingenic: Various 
> improvements v3" (by paul@crapouillou.net)
> - rebased to v5.13-rc3
> 
> PATCH V3 2021-08-08 07:10:50:
> This series adds HDMI support for JZ4780 and CI20 board (and fixes 
> one IPU related issue in registration error path)
> - [patch 1/8] switched from mode_fixup to atomic_check (suggested by 
> robert.foss@linaro.org)
>   - the call to the dw-hdmi specialization is still called mode_fixup
> - [patch 3/8] diverse fixes for ingenic-drm-drv (suggested by 
> paul@crapouillou.net)
>   - factor out some non-HDMI features of the jz4780 into a separate 
> patch
>   - multiple fixes around max height
>   - do not change regmap config but a copy on stack
>   - define some constants
>   - factor out fixing of drm_init error path for IPU into separate 
> patch
>   - use FIELD_PREP()
> - [patch 8/8] conversion to component framework dropped (suggested by 
> Laurent.pinchart@ideasonboard.com and paul@crapouillou.net)
> 
> PATCH V2 2021-08-05 16:08:05:
> - code and commit messages revisited for checkpatch warnings
> - rebased on v5.14-rc4
> - include (failed, hence RFC 8/8) attempt to convert to component 
> framework
>   (was suggested by Paul Cercueil <paul@crapouillou.net> a while ago)
> 
> This series adds HDMI support for JZ4780 and CI20 board
> 
> 
> 
> H. Nikolaus Schaller (3):
>   drm/ingenic: prepare ingenic drm for later addition of JZ4780
>   MIPS: defconfig: CI20: configure for DRM_DW_HDMI_JZ4780
>   [RFC] MIPS: DTS: Ingenic: adjust register size to available 
> registers
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
>  drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c     | 136 
> ++++++++++++++++++
>  13 files changed, 443 insertions(+), 8 deletions(-)
>  create mode 100644 
> Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
>  create mode 100644 drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c
> 
> --
> 2.33.0
> 


