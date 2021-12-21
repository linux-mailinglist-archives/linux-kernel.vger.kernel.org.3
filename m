Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A2847C56A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbhLURul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:50:41 -0500
Received: from aposti.net ([89.234.176.197]:39324 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234272AbhLURuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:50:40 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/2] hwmon: Add "label" attribute
Date:   Tue, 21 Dec 2021 17:50:27 +0000
Message-Id: <20211221175029.144906-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean, Guenter, Rob,

This patchset adds support for specifying a hwmon device's label from
Device Tree. When the "label" device property is present, its value is
exported to the userspace via the "label" sysfs attribute.

This is useful for userspace to be able to identify an individual device
when multiple individual chips are present in the system.

Note that this mechanism already exists in IIO.

Patch [1/2] adds the "label" property to a new
dt-bindings/hwmon/common.yaml file.

Patch [2/2] adds the change to the core drivers/hwmon/hwmon.c file.

Cheers,
-Paul

Paul Cercueil (2):
  dt-bindings: hwmon: Introduce common properties
  hwmon: Add "label" attribute

 .../devicetree/bindings/hwmon/common.yaml     | 31 +++++++++++++++++++
 drivers/hwmon/hwmon.c                         | 22 ++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/common.yaml

-- 
2.34.1

