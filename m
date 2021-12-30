Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475F7481F03
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241617AbhL3SGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:06:18 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:33352 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241595AbhL3SGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:06:17 -0500
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:a9e6:6f2a:78f1:2f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 248D528A0E5;
        Thu, 30 Dec 2021 19:06:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640887576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hr+RIrYGlc+BfROx8Zd0QRK1lPcxYrVTiLGdePNUfcQ=;
        b=cx2IzqzZxZtR9q5tL/ixyMEjMCicoq270SKpoZ+Nip6vvNA8k4E9LG42KMXK0JYBHKPUlo
        wK6K5mDvlGW0+lnthBwRM1iviWYoNkoe0rCjy+i0Wlsn7JYdBXkudObqgs1dI3EzHnIfj7
        VRYRu1j5KS51jdfcJl7OGsXXxmNq3vQFas6o2sXXbSUsqQ8nGQ1uawBsS0JKQ3fLtJWmtF
        bRWFOhZAuGaMgR5h3qUkof7Gc19Ad0ycywp0QFfz3chWV1W22LkbOTeiOsCWpuI06myPe3
        r9p0+FQ8D708j5V2CNf4OxVoIXD3mEAk7SK2C3nQhdvfafEqoardL7S6Q4GMfQ==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [RFC PATCH v1 0/3] convert gpio-restart bindings to yaml
Date:   Thu, 30 Dec 2021 19:06:00 +0100
Message-Id: <cover.1640887456.git.sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series first converts the gpio-restart bindings to the schema
format, so device descriptions can be verified against the binding.  Two
smaller patches then follow: one to fix the documentation, and a one to add
suffixes to values with implied units.

Open questions:
- Who should I add as maintainer for the binding, if not myself (patch 1)
- Should properties with names that don't match the guidelines be updated, or
  can the original names be kept? (patch 2, 3)
- Since the "priority" property is a Linux kernel specific thing, should it
  just deprecated entirely? (patch 3)

Sander Vanheule (3):
  dt-bindings: power: reset: Convert gpio-restart binding to schema
  dt-bindings: power: reset: gpio-restart: Add -ms suffix to delays
  dt-bindings: power: reset: gpio-restart: Correct default priority

 .../bindings/power/reset/gpio-restart.txt     |  54 ----------
 .../bindings/power/reset/gpio-restart.yaml    | 101 ++++++++++++++++++
 2 files changed, 101 insertions(+), 54 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/gpio-restart.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/gpio-restart.yaml

-- 
2.33.1

