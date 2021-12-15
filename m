Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18686475B01
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbhLOOt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:49:27 -0500
Received: from marcansoft.com ([212.63.210.85]:36252 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhLOOtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:49:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 88DE1419BC;
        Wed, 15 Dec 2021 14:49:21 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
Subject: [GIT PULL] Apple SoC PMGR driver updates for 5.17 (v2)
To:     SoC Team <soc@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <660f6f7f-0857-b54c-c415-79bcb93f0e02@marcan.st>
Date:   Wed, 15 Dec 2021 23:49:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi SoC folks,

Please merge these additional fixes for the PMGR driver for 5.17.

This just adds a new feature needed for DCP devices, and disables module
builds which were broken anyway (and didn't make much sense; thanks to
the kernel test robot for catching that one!)

-Hector

The following changes since commit 6df9d38f9146e83b473f0c9e57fb5fdf3fcc93e2:

  soc: apple: Add driver for Apple PMGR power state controls (2021-12-07 13:13:13 +0900)

are available in the Git repository at:

  https://github.com/AsahiLinux/linux.git tags/asahi-soc-pmgr-5.17-v2

for you to fetch changes up to 8e136c5ea43ae08c5d672deb1c3f494782a4392a:

  soc: apple: apple-pmgr-pwrstate: Do not build as a module (2021-12-15 20:36:05 +0900)

----------------------------------------------------------------
Apple SoC PMGR driver updates for 5.17

* Adds an auto-PM feature that is necessary for a single device
* Disables module builds, which were broken anyway

----------------------------------------------------------------
Hector Martin (2):
      soc: apple: apple-pmgr-pwrstate: Add auto-PM min level support
      soc: apple: apple-pmgr-pwrstate: Do not build as a module

 drivers/soc/apple/Kconfig               | 2 +-
 drivers/soc/apple/apple-pmgr-pwrstate.c | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

