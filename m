Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0496049514B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376496AbiATPW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:22:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35434 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376454AbiATPW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:22:26 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 93AC21F4533C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642692145;
        bh=tmD9Ap67IuYriVCv/97S0mcNPV2hASP/2Y6hTEWnusU=;
        h=From:To:Cc:Subject:Date:From;
        b=DIBio5EAh+ORowXnC2CYWzxMS/1is6/7aBJqXc6kK8+VXLftr713xh39EfoQsKj7a
         QYW6LoCdr4QGBsCU8tLfiN1WcUpdjLB785cJohoLK6Vqz9SghmuEOu1IZbyAw/bmNQ
         QfjXshuip+/SgMOTXZ+W3RKTZDZUOn8M4Xp1fXuFTp1i9YxuxvmAjhJJ09mt9q0t3K
         J1IwEjPHu8rVlsD9xy+uxA5hpIA+yoXCSD6malMUi5eJpxfhZXtj7ZaBoJD9LYVYgb
         M4BOnmO5kUkbXrt0oY+f3JFAEuQ5THHg7oTkOeQHJONSHr/b3xPICN+mCVOqtKMFN0
         l8NpkFsZ54+5g==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 0/9] regulator: rpi-panel: Support official Raspberry Pi 7 inches touchscreen
Date:   Thu, 20 Jan 2022 10:21:41 -0500
Message-Id: <20220120152150.1952568-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset provides different fixes to the rpi-panel-attiny-regulator driver.

This is a preparation patchset for supporting the official Raspberry Pi 7
inches touchscreen.

It has been tested with a Raspberry Pi 4 B and the official Raspberry Pi 7
inches touchscreen.

Dave Stevenson (9):
  regulator: rpi-panel: Register with a unique backlight name
  regulator: rpi-panel: Handle I2C errors/timing to the Atmel
  regulator: rpi-panel: Serialise operations.
  regulator: rpi-panel: Ensure the backlight is off during probe.
  regulator: rpi-panel: Convert to drive lines directly
  regulator: rpi-panel: Add GPIO control for panel and touch resets
  regulator: rpi-panel: Remove get_brightness hook
  regulator/rpi-panel-attiny: Don't read the LCD power status
  regulator/rpi-panel-attiny: Use two transactions for I2C read

 .../regulator/rpi-panel-attiny-regulator.c    | 285 +++++++++++++++---
 1 file changed, 236 insertions(+), 49 deletions(-)

-- 
2.34.1

