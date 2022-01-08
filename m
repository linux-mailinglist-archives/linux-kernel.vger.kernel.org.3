Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D05B48816B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 06:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiAHFNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 00:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiAHFNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 00:13:54 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EA4C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 21:13:54 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id CFED641982;
        Sat,  8 Jan 2022 05:13:51 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
Subject: [GIT PULL] Apple SoC MAINTAINERS updates for 5.17
To:     SoC Team <soc@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <24ae6871-3e67-5c7f-2060-28048db439a2@marcan.st>
Date:   Sat, 8 Jan 2022 14:13:49 +0900
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

Please merge this trivial MAINTAINERS change for 5.17.

This commit was waiting on the watchdog driver to be merged, but I only
just now realized that it silently did. Sorry for the last-minute pull.
If this can't make it into the 5.17 merge window, it can be added as a
fix later instead.

The branch is based on asahi-soc-dt-5.17-v2 to avoid a merge conflict
with other changes that happened there.

-Hector

The following changes since commit 301f651614c3396d711a8cc3f92f6fb95b12f5c5:

  dt-bindings: mailbox: apple,mailbox: Add power-domains property
(2021-12-15 20:20:38 +0900)

are available in the Git repository at:

  https://github.com/AsahiLinux/linux.git tags/asahi-soc-maintainers-5.17

for you to fetch changes up to 6dc701ee9fabfc929cae2d7acc957bf38e4c3264:

  MAINTAINERS: Add Apple watchdog to ARM/APPLE MACHINE SUPPORT
(2022-01-08 14:10:03 +0900)

----------------------------------------------------------------
Apple SoC MAINTAINERS updates for 5.17.

Adds the watchdog driver MAINTAINERS changes. The driver itself is
already merged.

This branch is based on asahi-soc-dt-5.17-v2 to avoid a merge conflict.

----------------------------------------------------------------
Sven Peter (1):
      MAINTAINERS: Add Apple watchdog to ARM/APPLE MACHINE SUPPORT

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

