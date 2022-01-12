Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B0648BD92
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 04:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349093AbiALDPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 22:15:08 -0500
Received: from out162-62-57-210.mail.qq.com ([162.62.57.210]:49939 "EHLO
        out162-62-57-210.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348760AbiALDPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 22:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1641957304;
        bh=hhNaH8odzLNq7RNDxak807iAKwajzU422otvRpMcvBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=h7zcvlMxZpFbm2wNCFWHkYQ2te8zETI89wOUWZF4MLns6/ZsAWbEAshF7NeXg4ktc
         XGONRVEAERAIOI8T8FPq/X8HewChbEAAqTSvu8/cwrZOkJWXqtPBcOQpCEYBfdjScf
         +PLZU16pb1GGE8XS5Ks9u2jkoPEytSMjvNbwPcEY=
Received: from fedora.. ([119.32.47.91])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id 3711B294; Wed, 12 Jan 2022 11:13:49 +0800
X-QQ-mid: xmsmtpt1641957229tcgd10n3e
Message-ID: <tencent_FDDA0568A55F5BBE4D20055A6C2D1E34EF08@qq.com>
X-QQ-XMAILINFO: M1xqn9pGP6LNsumNHUMccUTwhindkdGtA0yvLRReWzwQdccqwYCkdZelcFjHKE
         kVjinoAULlUJ43M3QOHwlZpcH4GddSlVyESziKj2x1jx3zqg09RF027QOiKFGDvEEw7BCp3b3hcA
         qceWhAweTGzzvsWtxiThupNKJZav/TkGzoHJRmmkT/NX09ogTS4a5ndb21E1UjquCy6BUabAz/o1
         uRnNbBw0XUGQewLACD3tNJrxypruP2WMypR2zLD1THW+6J8HgPS9r+9w4E0ffBfMuiQxCorqY6fM
         G2nVR/POtYru4fEtWeKgPhASWLxPGPKZbWA/HqPB/iKhQZQKzDdhrDKOvFfN7Hr1zETjDSdsn8XM
         We/3fcHhxt/uFbVPHNOtkqIAL1+rtWtAY0QQECp+MJOnkSWELyOaSsTi3Yh6PeHFSkPPtLV6s+Bj
         D7jpohxM5H5f3XfAYS/wfe51QO1FTzfeeZDrGQauKk4dicJXfv6E3meNFljUFOmXjn5j9Ac1s8ko
         e5Mx5n+okNnsaETyzwqQYXMQymVdthsug2b01kLArTs1+vk7YSYnP1uvaSwdPgRyD9UrP31oEBVz
         oENYG0TQu0bPjoURVt7mAFtIcuxzzWQN/qFdbSq76KzOcgXXJjJXdw5RsyWjamChKKJvJiOUYRSf
         uURHYrN0zb9K4yZ/+N3Jk7b2A3VgjPr1vBasT6pBoDrIjvSzRIRRtXutBq2UZcNbzQWLYPrn5Wmz
         IeHi8h3NIoocT8VSMxB3sI7L1lZN0VI8ZGoujdY5UBvZ3MGwoXsoVKchE7tSDLm/IIkhRAfx2Fe/
         yJml9aOU0eYwSKvKLZyYiivTFuAh2X0DhEG0QhdSYTuP+o0NQbMAJq5IAT8980yxf/XDulL7s2Fd
         L+EsRemKy8V5jUEEs94AhuveTVVA1CJbheJuL1Q8veRQKznzuqyOM=
From:   Conley Lee <conleylee@foxmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conley Lee <conleylee@foxmail.com>
Subject: [PATCH v3 0/2] dt-bindings: arm: allwinner: add marsboard A20
Date:   Wed, 12 Jan 2022 11:13:45 +0800
X-OQ-MSGID: <20220112031347.2492813-1-conleylee@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <tencent_DC7B4D416B69D6D6789356010B5B9647C606@qq.com>
References: <tencent_DC7B4D416B69D6D6789356010B5B9647C606@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM dts: sun7i: Add Marsboard A20 board

This patch add support for Marsboard A20 board, patch 1 is for the
dts file and patch 2 is for the biddings

The Marsboard A20 is a A20 based SBC with 1G RAM, 8G Flash, micro SD
card slot , SATA socketm 10/100 ethernet, HDMI port, 4 USB2.0 ports, 2
USB2.0 OTG, USB WIFI(RTL8188EU) with antenna.

Change since v1.
  - Spearate biddings and dts as two patches.
  - use SPDX tag

Change since v2.
  - reformat patch
  - dual-license with GPL and MIT
  - rename dts filename to sun7i-a20-haoyu-marsboard.dts

Conley Lee (2):
  sun7i-a20-haoyu-marsboard.dts: add marsboard-a20 support
  sunxi.yaml: add HAOYU Electronics Marsboard A20

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/sun7i-a20-haoyu-marsboard.dts    | 183 ++++++++++++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-haoyu-marsboard.dts

-- 
2.31.1

