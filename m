Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8C2465EE1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355864AbhLBHyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:54:40 -0500
Received: from st43p00im-ztdg10061801.me.com ([17.58.63.170]:43350 "EHLO
        st43p00im-ztdg10061801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240968AbhLBHyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1638431476; bh=1PuOkBgRpKHM41Kzpj8lnhhlZGkKZQMc6IJzXdwo2HI=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=zOW8Unzfyxekc69cl5uWyZ50jdankbJu91etXaon+TNciraV0qKMbgu+2y465DcGV
         ZwKYhoQqrdaXLCtDRzYLAcVrvzNtqZL9iJy6gzINM2qdFhYqLFw58+qWLD4/5wlxQU
         PgImY0YRhKbP5SLA40lcQY4ngHRLdpMmumy00RLXw7hGWVKIfeB7Si4EYqvxQNDh3q
         c7hjs6jVcvzpg37wg84u8jHwvIvjaIdV6y91sFv5cpBLo7QLMLMFx0bRBFd1Y5WgiW
         9LZtZ6+az3A+kv6hGoI90J5IoGjDbjBgSDefZodGtIymnQZndYRl/Ar844k1OxQ1b2
         w4XOWoTLeGLzg==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10061801.me.com (Postfix) with ESMTPSA id 2F9768C082B;
        Thu,  2 Dec 2021 07:51:14 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     patrice.chotard@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH 00/12] ARM: dts: sti: various DT fixes to avoid warnings
Date:   Thu,  2 Dec 2021 08:50:53 +0100
Message-Id: <20211202075105.195664-1-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A first serie to correct a large amount of DT warnings seen when
building with the W=1 option and mainly due to having several time
the same reg property (clock) or having unnecessary reg value.

The first 3 patches related to clocks require that recent serie [1] of
clock drivers improvements be first merged.

[1] https://lore.kernel.org/linux-clk/20211202072850.194314-1-avolmat@me.com/T/#t

Alain Volmat (12):
  ARM: dts: sti: ensure unique unit-address in stih407-clock
  ARM: dts: sti: ensure unique unit-address in stih410-clock
  ARM: dts: sti: ensure unique unit-address in stih418-clock
  ARM: dts: sti: move some nodes out of the soc section in
    stih407-family.dtsi
  ARM: dts: sti: update stih410-b2260 following stih407-family DT update
  ARM: dts: sti: update stih418-b2199 following stih407-family DT update
  ARM: dts: sti: update stihxxx-b2120 following stih407-family DT update
  ARM: dts: sti: remove delta node from stih410.dtsi
  ARM: dts: sti: move usb picophy nodes out of soc in stih410.dtsi
  ARM: dts: sti: move usb picophy nodes out of soc in stih418.dtsi
  ARM: dts: sti: move usb picophy nodes in stih410-b2120.dts
  ARM: dts: sti: move usb picophy nodes in stih410-b2260.dts

 arch/arm/boot/dts/stih407-clock.dtsi  | 101 +++++-----
 arch/arm/boot/dts/stih407-family.dtsi | 262 +++++++++++++-------------
 arch/arm/boot/dts/stih410-b2120.dts   |  16 +-
 arch/arm/boot/dts/stih410-b2260.dts   |  30 +--
 arch/arm/boot/dts/stih410-clock.dtsi  | 100 +++++-----
 arch/arm/boot/dts/stih410.dtsi        |  52 ++---
 arch/arm/boot/dts/stih418-b2199.dts   |  22 +--
 arch/arm/boot/dts/stih418-clock.dtsi  | 101 +++++-----
 arch/arm/boot/dts/stih418.dtsi        |  38 ++--
 arch/arm/boot/dts/stihxxx-b2120.dtsi  |  22 +--
 10 files changed, 351 insertions(+), 393 deletions(-)

-- 
2.25.1

