Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892D3489F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbiAJSXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:23:03 -0500
Received: from aposti.net ([89.234.176.197]:35260 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238949AbiAJSXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:23:02 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, list@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 0/2] hwmon: Add "label" attribute v3
Date:   Mon, 10 Jan 2022 18:22:54 +0000
Message-Id: <20220110182256.30763-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean, Guenter,

A V3 of my patchset which allows specifying a hwmon device's label from
Device Tree. When the "label" device property is present, its value is
exported to the userspace via the "label" sysfs attribute.

This is useful for userspace to be able to identify an individual device
when multiple individual chips are present in the system.

Note that this mechanism already exists in IIO.

Patch [1/2] documents the ABI change.
Patch [2/2] adds the change to the core drivers/hwmon/hwmon.c file.

Changes from v2:
- Move the code setting the label around in the probe function to fix
  error handling issue.

Cheers,
-Paul


Paul Cercueil (2):
  ABI: hwmon: Document "label" sysfs attribute
  hwmon: Add "label" attribute

 Documentation/ABI/testing/sysfs-class-hwmon |  8 +++++
 Documentation/hwmon/sysfs-interface.rst     |  4 +++
 drivers/hwmon/hwmon.c                       | 34 +++++++++++++++++++--
 3 files changed, 43 insertions(+), 3 deletions(-)

-- 
2.34.1

