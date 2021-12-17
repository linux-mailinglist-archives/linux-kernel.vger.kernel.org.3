Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C313347903F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbhLQPqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:46:05 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55616 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbhLQPqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:46:04 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id A9E8D1F470D2
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639755963; bh=g8FzHrZONn+sq9yOxyyO15ASj7LcA+jTCZr3Ns4ferM=;
        h=From:To:Cc:Subject:Date:From;
        b=nlMI2xDSeiHBllF1vsZmXyGv5d2IAsLBYIPL0wQQWGfBPsd2HROAFZ+xUNU5Wxp1E
         mn3cSZQ47JnpIRrBD4O/x7kLbF/5mFfgEa7Z/7OQosw15fm5hpnYy8jGOq97az7oqO
         v1cFNmah41dGEaqrn/5dXt9bVZ6uwLvVAAnYh43ZqfzXP3YQo4lg2Vrh0RYKDeVvI5
         lxcHMKydJVUHHT4RWaafnfr1/0CZds3/h/AV2FGZJPfv4BbIOXVNrjXQxCAFZSc4QT
         z3OeqGv8P/N63tsZFyoxle0yesiS1xyE08UIqfM4cYYf0RG6cFflvcM9t9Pc4MpN6q
         nbnwqcrp/gw9w==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH] arm64: defconfig: Enable cpufreq for MediaTek
Date:   Fri, 17 Dec 2021 10:44:52 -0500
Message-Id: <20211217154452.868419-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek CPUFreq driver provides control of CPU frequency/voltage
on MediaTek SoCs. Since there's no device-tree node to bind it to, the
driver needs to be enabled built-in. Enable it so.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f2e2b9bdd702..829e8bc045f7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -96,6 +96,7 @@ CONFIG_ARM_QCOM_CPUFREQ_HW=y
 CONFIG_ARM_RASPBERRYPI_CPUFREQ=m
 CONFIG_ARM_SCMI_CPUFREQ=y
 CONFIG_ARM_TEGRA186_CPUFREQ=y
+CONFIG_ARM_MEDIATEK_CPUFREQ=y
 CONFIG_QORIQ_CPUFREQ=y
 CONFIG_ARM_SCMI_PROTOCOL=y
 CONFIG_ARM_SCPI_PROTOCOL=y
-- 
2.34.1

