Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472B2490C45
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbiAQQNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240855AbiAQQN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:13:29 -0500
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [IPv6:2001:67c:2050:1::465:111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DA3C061574;
        Mon, 17 Jan 2022 08:13:29 -0800 (PST)
Received: from smtp202.mailbox.org (unknown [91.198.250.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4Jcxlq0fntzQkgh;
        Mon, 17 Jan 2022 17:13:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1642436005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o74IafmFWO8eacIxV9jc9ZxTyomdrZz0JkyFBZA0YbY=;
        b=eq08YXyhHyj+COl6RVLumv/aKYbgO63methE8Vgg/ZWESZuEpOxBKawT9NpSWP+4L3WAWM
        jisLlSdDmRJ1/4CuMRvRVkpF8UGzbMVe9opRnQw711+95ymnULUC+LgIO+jgcBpG5zwV1V
        OUaxSh+jUuTBIW3D6Un5gVgethWVP1k9Wuu4zLpMhJ8BHv1P4O63Gh/q/QQu/W0ZZzJr1t
        vTcIlM8YGRxrrXwGSVE3MqIJ9+0ex+ZocJSgZZqkS+ufZ2LTwxOFxy22YP1l+NtnvzkyIW
        WGNmDoDdlqtk3X4Mb17BwkTToOsjyq/XPBPTkXV2i6xIm6bkhRaHdPj1w2vuKQ==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] Support bcm6123 Bus Converter
Date:   Mon, 17 Jan 2022 17:12:46 +0100
Message-Id: <cover.1642434222.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds support for BCM6123 Bus Converter from Vicor
Corporation.

Marcello Sylvester Bauer (3):
  dt-bindings: vendor-prefixes: add Vicor Corporation
  dt-bindings: hwmon/pmbus: Add vicor,bcm6123 Bus Converter
  pmbus: remove trailing whitespaces

Patrick Rudolph (1):
  pmbus: Add support for bcm6123 Bus Converter

 .../bindings/hwmon/pmbus/vicor,bcm6123.yaml   | 41 +++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 drivers/hwmon/pmbus/Kconfig                   | 13 ++-
 drivers/hwmon/pmbus/Makefile                  |  1 +
 drivers/hwmon/pmbus/bcm6123.c                 | 90 +++++++++++++++++++
 5 files changed, 145 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/vicor,bcm6123.yaml
 create mode 100644 drivers/hwmon/pmbus/bcm6123.c

-- 
2.33.1

