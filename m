Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2F3483504
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiACQm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:42:57 -0500
Received: from mout-y-209.mailbox.org ([91.198.250.237]:13552 "EHLO
        mout-y-209.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiACQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:42:54 -0500
Received: from smtp202.mailbox.org (unknown [91.198.250.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4JSLv73wtLzQl9k;
        Mon,  3 Jan 2022 17:34:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1641227699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RO2yaGVn76qLu0Ta5p2QgD+mNSF76oZ7lBBtNjROBas=;
        b=RXLYnZxMIJlnnou2g1RloT+jtoNa14Zbs0RhxWHBPL/xhWaA4QakNO+CAq/qh3ug9jgnqU
        rhuFEmyf1eJwz53jCIdNQ616V70/UF1E9Q9T4D0E9Rwjg9vTO5szPwREs2Wpq0aDwmQd6+
        Opr+lxV2ODAQn9mRGgYFbOAjfBsW+5Hx5HiCwXTDdr1etfHNV8fB9JGdQkNifS3NN/bWw9
        GXkIy2SBuLquiThBHuw6eKyRc3K2VblRGs9MNHtQ2wVK0NtSYQAmnnAR1XsZea8VuJI/CB
        HrYhv6gfLOkcZrXBFyRjOxFy2dn3Mob2YPhLjWBm7ZzPSskmCAFkR0GC6YS2tw==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] Add max6639 regulator and devicetree support
Date:   Mon,  3 Jan 2022 17:33:50 +0100
Message-Id: <cover.1641224715.git.sylv@sylv.io>
In-Reply-To: <cover.1641224715.git.sylv@sylv.io>
References: <cover.1641224715.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

these patches add devicetree support for the Maxim MAX6639.
In addition, it includes optional regulator support for the fan-supply and
updates the URL to the datasheet.

Marcello Sylvester Bauer (4):
  hwmon: (max6639) Update Datasheet URL
  hwmon: (max6639) Add regulator support
  dt-bindings: hwmon: Add binding for max6639
  hwmon: (max6639) Add devicetree support

 .../bindings/hwmon/maxim,max6639.yaml         |  71 ++++++++++
 Documentation/hwmon/max6639.rst               |   2 +-
 drivers/hwmon/max6639.c                       | 122 ++++++++++++++++--
 3 files changed, 186 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml

-- 
2.33.1

