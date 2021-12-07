Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1C946B2A2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbhLGFz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 00:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhLGFz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:55:57 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946BFC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 21:52:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id CDCCA41EF0;
        Tue,  7 Dec 2021 05:52:24 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
Subject: [GIT PULL] Apple SoC fixes for 5.16
To:     SoC Team <soc@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <cc9a1a67-3b2d-ae9f-5733-859111eb78c1@marcan.st>
Date:   Tue, 7 Dec 2021 14:52:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SoC folks,

Please merge these Apple SoC fixes for 5.16.

These fix some minor post-merge DT issues we found.

-Hector

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

   https://github.com/AsahiLinux/linux.git tags/asahi-soc-fixes-5.16

for you to fetch changes up to 0668639eaf14813a39a8d3e0e6597d568581d4ea:

   arm64: dts: apple: add #interrupt-cells property to pinctrl nodes 
(2021-12-01 23:11:45 +0900)

----------------------------------------------------------------
Asahi SoC DT/binding fixes for 5.16.

Just some minor DT fixups we found after things got merged.

----------------------------------------------------------------
Janne Grunau (3):
       arm64: dts: apple: change ethernet0 device type to ethernet
       dt-bindings: i2c: apple,i2c: allow multiple compatibles
       arm64: dts: apple: add #interrupt-cells property to pinctrl nodes

  Documentation/devicetree/bindings/i2c/apple,i2c.yaml | 8 ++++----
  arch/arm64/boot/dts/apple/t8103-j274.dts             | 2 +-
  arch/arm64/boot/dts/apple/t8103.dtsi                 | 4 ++++
  3 files changed, 9 insertions(+), 5 deletions(-)

