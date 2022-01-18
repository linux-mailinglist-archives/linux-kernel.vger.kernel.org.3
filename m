Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B4C492955
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344878AbiARPCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:02:24 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:52277 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345851AbiARPBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:01:25 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220118150123epoutp03a66062876ce132ec6d42a69b46553ec5~LZX58sr--2046620466epoutp033
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:01:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220118150123epoutp03a66062876ce132ec6d42a69b46553ec5~LZX58sr--2046620466epoutp033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642518083;
        bh=cDzU9XPSHyqNaH4M/h3DMF34FfVxlA1olgy2CMDDxG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gddQ2jI1KAouQePhCJVLMYLVcPE0xmjs/67PTxhavVC8OFwNpGfMaGJXJQZsi3DXG
         Vu/cjsM/g4J/aFIu+aM3Q8IeXTqI41xd/lb5luAVl1NzcUkajYmOCf5JMjEjLIfAD7
         VBNpweth8IZheQiTaK13Y0z+r8kywYUe/tDwJjSQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220118150122epcas5p352b0adde5cc2ab507bf2e15329c92a81~LZX4_5vHW0676106761epcas5p3E;
        Tue, 18 Jan 2022 15:01:22 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JdX646441z4x9Pt; Tue, 18 Jan
        2022 15:01:16 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.29.06423.C36D6E16; Wed, 19 Jan 2022 00:01:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220118150116epcas5p415b4b658b3ca3fe5e52e11a33546b926~LZXzfNSlp1276312763epcas5p4M;
        Tue, 18 Jan 2022 15:01:16 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220118150116epsmtrp20c26a06e9e08a384894795fafd4e8b86~LZXzeXnTn2220222202epsmtrp2W;
        Tue, 18 Jan 2022 15:01:16 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-75-61e6d63cdda6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.F0.08738.B36D6E16; Wed, 19 Jan 2022 00:01:15 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220118150113epsmtip141d860c53dc5dbb6c894d36d8f6808fb~LZXxS7_hk0520405204epsmtip1Z;
        Tue, 18 Jan 2022 15:01:13 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com
Subject: [PATCH v2 16/16] arm64: defconfig: Enable Tesla FSD SoC
Date:   Tue, 18 Jan 2022 20:18:51 +0530
Message-Id: <20220118144851.69537-17-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118144851.69537-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmpq7NtWeJBsvm6Vk8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNaPL7+h81BwGPNvDWMHr9/TWL0mNXQy+axaVUnm8eda3vYPDYvqfe4
        cqKJ1aNvyypGj39Nc9k9Pm+SC+CKyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
        V1LIS8xNtVVy8QnQdcvMAXpFSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBX
        nJhbXJqXrpeXWmJlaGBgZApUmJCdMfNxH1PBT5aKOd9WsTUwLmbpYuTkkBAwkdj3/zNrFyMX
        h5DAbkaJc7/bmCCcT4wSi/8vg8p8ZpRY9ayTEaZl8tYTjBCJXYwSHRf+sUA4LUwSu5a8YQep
        YhPQlrg7fQsTiC0i4CZxo7EDbC6zwFsmien7vrOBJIQFHCQeXJoGNpZFQFViQeNqsAZeAVuJ
        NXu6mCDWyUus3nCAGcTmBIpPbZjKBjJIQmAth0TrigNQN7lI7F1yhx3CFpZ4dXwLlC0l8fnd
        XqAGDiA7W6JnlzFEuEZi6bxj0BCwlzhwZQ4LSAmzgKbE+l36IGFmAT6J3t9PmCA6eSU62oQg
        qlUlmt9dheqUlpjY3c0KYXtIbLn6BBpaExglpk5/wzqBUXYWwtQFjIyrGCVTC4pz01OLTQsM
        81LL4TGVnJ+7iRGcRLU8dzDeffBB7xAjEwfjIUYJDmYlEV6p+meJQrwpiZVVqUX58UWlOanF
        hxhNgUE2kVlKNDkfmMbzSuINTSwNTMzMzEwsjc0MlcR5T6dvSBQSSE8sSc1OTS1ILYLpY+Lg
        lGpgEpGSPKLMa2XHWP7XO03oWv7uC8JbPwlU9P3Lmjhn63LPaH6rB5cc11YeerjRs9pwkqb1
        7H0+vhmCp2YV3Hwl9s4s7Lr9fpu9r3Ky0necWVvomSZmLRCa5TLbc73vwe/1U9aF8gScs1Pq
        VIl2ftcYxKq+W132loG5xcuo/ElTuz4vfWn1/LvERcVrqx+VSjKorN+uWrxt+YVJZtGx26Vy
        bT7faAzarXpil9qZSRMVrmgfPXyMZ+ukye6eJ03Yi4/VvdF8+uE5w/qLW2WNMic9f7GQ/1oL
        e/c3VgmPxvTpcyu8vY+ssbK3NXO+IpNx7tSn2yprtrEHnE2Pbloepa0/I7vOxuX/nsmv19gd
        MPhyRYmlOCPRUIu5qDgRAFClocorBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSnK7NtWeJBtdPM1o8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNaPL7+h81BwGPNvDWMHr9/TWL0mNXQy+axaVUnm8eda3vYPDYvqfe4
        cqKJ1aNvyypGj39Nc9k9Pm+SC+CK4rJJSc3JLEst0rdL4MqY+biPqeAnS8Wcb6vYGhgXs3Qx
        cnJICJhITN56grGLkYtDSGAHo8T31T8YIRLSEtc3TmCHsIUlVv57zg5R1MQk0bVpLTNIgk1A
        W+Lu9C1MILaIgIdE2797zCBFzAJ/mSS+vn4INklYwEHiwaVpYDaLgKrEgsbVYA28ArYSa/Z0
        MUFskJdYveEA2FBOoPjUhqlsILaQgI3ExZXTmCcw8i1gZFjFKJlaUJybnltsWGCUl1quV5yY
        W1yal66XnJ+7iREcAVpaOxj3rPqgd4iRiYPxEKMEB7OSCK9U/bNEId6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpj6e26EpB27Wvjl4e+Z/zZItUxK3cq1
        9gfrP5HHeRFpefqRUecm5NnlLvZRY7tkNtfwM6/Ii8hLbKWacze2seyU3Bay8XgWl27kydLV
        sfkapy6+O7qoQ+Ti3lpz4RW9Wut4V1o7m8TzPl8+wcb9ePHnhaZOm5qnP1S2vRS+mXvX7qjo
        qov3p/J8r5n1WzhN1GhfqKXjWsbyPXUqP0Pv/xRwT5nd7dzQN/UJx4MLr944JT/7y/AxdE7N
        USdvtd0G6lv3evkmzrm8L2GF4g1uJ93S6eEOt7yXrGu/M9PyS77fyhtXZmhMvHK56OHTta0i
        1sG8PNfn/76wQFl263Fux1qvtwon+WJNEjZ1MfkFqk5TYinOSDTUYi4qTgQAAtDPke8CAAA=
X-CMS-MailID: 20220118150116epcas5p415b4b658b3ca3fe5e52e11a33546b926
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220118150116epcas5p415b4b658b3ca3fe5e52e11a33546b926
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
        <CGME20220118150116epcas5p415b4b658b3ca3fe5e52e11a33546b926@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the Tesla FSD SoC in arm64 defconfig.

Cc: linux-fsd@tesla.com
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ee4bd7710a0d..7dd0693a233e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -54,6 +54,7 @@ CONFIG_ARCH_SEATTLE=y
 CONFIG_ARCH_INTEL_SOCFPGA=y
 CONFIG_ARCH_SYNQUACER=y
 CONFIG_ARCH_TEGRA=y
+CONFIG_ARCH_TESLA_FSD=y
 CONFIG_ARCH_SPRD=y
 CONFIG_ARCH_THUNDER=y
 CONFIG_ARCH_THUNDER2=y
-- 
2.25.1

