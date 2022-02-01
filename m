Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7194A6559
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbiBAUF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236935AbiBAUFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:05:22 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C78C06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 12:05:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 236261F4241D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643745921;
        bh=yU2F56YdOfLO9M08byIymTF2DYaCDx6ayojgw1FF++I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3El24sGy3dBOC3q5QKp7Ps20IyRwa20htSCsLL+rFc4sHCwcuuKNdyo3sPVZwehN
         vdn1R2CgGqEJVwfDSNJMaabRkscf1PhsUkzGuq+W2Q6eh780M8Y/RMcTkdd3AfCDC8
         paRpVxRtELfMV6qIi0iZIkhvxOnDc4s7KBdfyQcnw1bglmheEixOS/Ergpvo6ZbLGd
         34o74UykbUIjs4rwb5Wo+C22XN61VTdTjm2L9Kb0p0+vawGQBIxulKG0zn1sl0asLz
         vF27DG9L8WTo9PQKWNcIDnCA0XjsfFbD3KtoFoRufoucn4pxyhQMoI1u1NVUMMowxU
         52OBsb8+nVG0g==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Sameer Pujar <spujar@nvidia.com>,
        Saravana Kannan <saravanak@google.com>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: defconfig: Add SC7180 VIDEOCC as module
Date:   Tue,  1 Feb 2022 15:05:04 -0500
Message-Id: <20220201200504.854917-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220201200504.854917-1-nfraprado@collabora.com>
References: <20220201200504.854917-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

This is required in order to be able to probe the Venus hardware
video decoder/encoder driver on the SC7180 SoC: being this driver
not boot-critical, it's sufficient to have it as a module.

This is being done as there are SC7180 device trees enabling
support for this hardware, but not being probed due to these
drivers not being built.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: "kernelci.org bot" <bot@kernelci.org>
[rebased and fixed conflicts]
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Rebased and fixed conflicts

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dbdb634a3d4c..49c9cfd3a3cb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1006,6 +1006,7 @@ CONFIG_QCS_GCC_404=y
 CONFIG_SC_DISPCC_7180=m
 CONFIG_SC_GCC_7180=y
 CONFIG_SC_GPUCC_7180=m
+CONFIG_SC_VIDEOCC_7180=m
 CONFIG_SC_GCC_7280=y
 CONFIG_SDM_CAMCC_845=m
 CONFIG_SDM_GCC_845=y
-- 
2.35.1

