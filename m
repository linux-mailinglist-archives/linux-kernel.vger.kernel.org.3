Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF53846ACFA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351740AbhLFWuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358270AbhLFWt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:49:59 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A50C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 14:46:30 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-184-96.tukw.qwest.net [174.21.184.96])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id C8FBD5B1;
        Mon,  6 Dec 2021 14:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1638830789;
        bh=amRvBLsiULS9hr5YoeVDU7p2guRPjNiBr1vyo6KyC2g=;
        h=From:To:Cc:Subject:Date:From;
        b=XJqEpZJy3uGxzF6XDUgLqYquKO6sJtw9CWKoo7p2e6dYXBDxlvdTcKsVgleVfq4N/
         UPRPIaRoaK+hh9BgOc44om6qci3vgEWfTXEiXRLoGaB2CcloGSD8cOwA2Z48IiW816
         +bbt6BxOx9nN9wEVGHgG7a8DysmAuLS3PqCLgR2I=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Zev Weiss <zev@bewilderbeest.net>
Subject: [PATCH 0/2] hwmon: Add driver for Delta AHE-50DC fan control module
Date:   Mon,  6 Dec 2021 14:44:16 -0800
Message-Id: <20211206224419.15736-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

These patches add a hwmon driver for the integrated fan control module
in the Delta AHE-50DC Open19 power shelf.  I don't know of a datasheet
any proper documentation for it; the register layout information came
from an existing GPL driver [0] in a code release from LinkedIn.


Thanks,
Zev Weiss

[0] https://github.com/linkedin/o19-bmc-firmware/blob/master/meta-openbmc/meta-linkedin/meta-deltapower/recipes-kernel/fancontrol-mod/files/fancontrol.c

Zev Weiss (2):
  hwmon: add Delta AHE-50DC fan control module driver
  dt-bindings: add Delta AHE-50DC fan control module

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/delta-ahe50dc-fan.c             | 265 ++++++++++++++++++
 5 files changed, 285 insertions(+)
 create mode 100644 drivers/hwmon/delta-ahe50dc-fan.c

-- 
2.34.1

