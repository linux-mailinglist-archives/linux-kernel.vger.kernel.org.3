Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A355475129
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 04:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbhLODCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 22:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbhLODCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 22:02:46 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C213C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 19:02:46 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id a23so14318925pgm.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 19:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l67OnNQFpi2JYi2qvaEeFRFUbyO8Epk70jYmuOz7uo4=;
        b=Lf9QL5bNinlRjGR8nZNc3KOPZx+c7Jhvml5Bb5Hp6PHijmQCEdGur26Q//GujanDlh
         VBd2sNiTwtb0UZL3+57Zl3naAaatM5v+vMSZZTTqXC9LytN5uAhweC/s6Jt+EmphikxO
         0aFcVCPgG3f8L7RPgjeRKRtQEvgaNBEB16gAj1wxzUJAlMheztpuVBJ/+B2+KBTa4zYm
         ORpDhYsnXBp15zqXWG25IBclPAFrc49QmxOoPF+siP1ZghLZIOwJpiaouhMJQUCzskBW
         DlJr/LxJvHRvCOYtS6GBIl/bHmMiiCa7hixaMB9r0sXr2bz/phi1PdPAEckkjPfz028w
         IUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l67OnNQFpi2JYi2qvaEeFRFUbyO8Epk70jYmuOz7uo4=;
        b=OFcIPRtaDfFxu1Wk1uKAsDGhC5ZT0UzQt45hghoeMX/Qz+oB4JVjRPmJmTcL6jsz/4
         dnA2mn+Au6nfjHI/grh5d4GTbg/SByG9GXRaKVPQZQRtPl818Vf1qEGINgmkJPNCKw0v
         zY0gZXPbpOcMP56gNKfD4eYj5ywDt3IGP7j1FvOriitdJiZbqQAq0H8rW+1fg6RsE/ng
         9kiwIS1hycmElni2YChCsJ8hW8V/VPinCQLpczt5Pzq6RENCUz21Wy+sJO1BI6Ykccx9
         bUUFKljtueOBHVV/FB9IvQqZUwz/mdm8MZ5fwXkzGoyCiYROeKz0deMdFQe7t/lBYrC0
         liYw==
X-Gm-Message-State: AOAM532ToE1uz3TdtssP/yD67pN8qVhzEOg/6Jl4mvx+z+taDHcwDNwM
        tqOjH3ZGtmUFPTu4wiXkNCg=
X-Google-Smtp-Source: ABdhPJxY3eE3zPwATkRF8wmarHs7T8JxnX7iltrhlfirDvo192Q7t2UsImxYFDbChKVoFY3Sraz1Fg==
X-Received: by 2002:a63:65c3:: with SMTP id z186mr6154548pgb.308.1639537365986;
        Tue, 14 Dec 2021 19:02:45 -0800 (PST)
Received: from localhost.localdomain (104.194.74.249.16clouds.com. [104.194.74.249])
        by smtp.gmail.com with ESMTPSA id d185sm402490pgc.58.2021.12.14.19.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 19:02:45 -0800 (PST)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com, art@khadas.com, nick@khadas.com,
        gouwa@khadas.com
Subject: [PATCH] arm64: dts: meson-sm1: add spdifin spdifout nodes
Date:   Wed, 15 Dec 2021 11:02:36 +0800
Message-Id: <20211215030236.340841-1-art@khadas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spdifin spdifout nodes for Amlogic SM1 SoCs.

Signed-off-by: Artem Lapkin <art@khadas.com>
---

SPDIF IN and SPDIF OUT both tested and works fine for VIM3L (meson-sm1)
same as for VIM3 (meson-g12)

SPDIF in and SPDIF OUT both pins available via GPIO header (SPDIF_OUT PIN
13 spdif_ao_out_pins and SPDIF_IN PIN 35 - same PWM_F spdif_in_h_pins)

https://lore.kernel.org/linux-arm-kernel/1jtuhwvqxa.fsf@starbuckisacylon.baylibre.com/t/

ALSA spdifin test example
=========================

# arecord -fS16_LE -r48000 -c2 -Dplug:spdifin

# cat .asoundrc
pcm.spdifin {
type iec958
slave {
pcm "hw:0,1"
format IEC958_SUBFRAME_LE
}
}

DT sound card configs for testing
=================================

&spdifout {
    pinctrl-0 = <&spdif_ao_out_pins>;
    pinctrl-names = "default";
    status = "okay";
};

&spdifin {
    pinctrl-0 = <&spdif_in_h_pins>;
    pinctrl-names = "default";
    status = "okay";
};

...
    spdif_dit: audio-codec-1 {
	#sound-dai-cells = <0>;
	compatible = "linux,spdif-dit";
	status = "okay";
	sound-name-prefix = "DIT";
    };

    spdif_dir: audio-codec-2 {
	#sound-dai-cells = <0>;
	compatible = "linux,spdif-dir";
	status = "okay";
	sound-name-prefix = "DIR";
    };
...
	audio-routing = ...
		"TODDR_B IN 3", "SPDIFIN Capture",
		"SPDIFOUT IN 0", "FRDDR_A OUT 3";

...
	dai-link-10 {
	    sound-dai = <&spdifout>;

	    codec-0 {
		sound-dai = <&spdif_dit>;
	    };
	};

	/* spdif or toslink interface */
	dai-link-11 {
	    sound-dai = <&spdifin>;

	    codec-0 {
		sound-dai = <&spdif_dir>;
	    };
	};
...

---
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 3d8b1f4f2001..1e0adf259d61 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -356,6 +356,33 @@ tdmin_lb: audio-controller@3c0 {
 			status = "disabled";
 		};
 
+		spdifin: audio-controller@400 {
+			compatible = "amlogic,g12a-spdifin",
+			"amlogic,axg-spdifin";
+			reg = <0x0 0x400 0x0 0x30>;
+			#sound-dai-cells = <0>;
+			sound-name-prefix = "SPDIFIN";
+			interrupts = <GIC_SPI 151 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
+			<&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
+			clock-names = "pclk", "refclk";
+			resets = <&clkc_audio AUD_RESET_SPDIFIN>;
+			status = "disabled";
+		};
+
+		spdifout: audio-controller@480 {
+			compatible = "amlogic,g12a-spdifout",
+			"amlogic,axg-spdifout";
+			reg = <0x0 0x480 0x0 0x50>;
+			#sound-dai-cells = <0>;
+			sound-name-prefix = "SPDIFOUT";
+			clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
+			<&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
+			clock-names = "pclk", "mclk";
+			resets = <&clkc_audio AUD_RESET_SPDIFOUT>;
+			status = "disabled";
+		};
+
 		tdmout_a: audio-controller@500 {
 			compatible = "amlogic,sm1-tdmout";
 			reg = <0x0 0x500 0x0 0x40>;
-- 
2.25.1

