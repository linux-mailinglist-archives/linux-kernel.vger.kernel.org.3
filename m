Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95109483507
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbiACQnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:43:02 -0500
Received: from mout-y-209.mailbox.org ([91.198.250.237]:13556 "EHLO
        mout-y-209.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiACQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:42:54 -0500
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4JSLtm4pcLzQkm3;
        Mon,  3 Jan 2022 17:34:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1641227678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RO2yaGVn76qLu0Ta5p2QgD+mNSF76oZ7lBBtNjROBas=;
        b=KmuilCw+G2TfVGgq2ZGdCY2W1hT7Qun5LIZtWTkQMIJK2pSEKbKinWMMOR0jXUGfg+uZq1
        u5vC70ic+BLmXDL5gUXh8V572U/EmPQXe1EBQzycz3ZDoktOAi0gSH3RcKjkrW5OQJ3s/2
        HsyPAFb0+hMcMlzDPD8BCgCpHtD6HUT9IDfjyPKM1wUg6aycE47Rh7hqkwiS5VouwOz61b
        oZtmb83fphg8dHH4QmijE/FBLE2BwDLbbU/vq6a4ii/9dM5+Wmr4TgGtLeoJuY7+94kLPK
        i4PBOPanfUA4ehczFNEPsnkYqVRffMxMU9uCFauOvbqtwl6gY9q6aC5MYp82wg==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] Add max6639 regulator and devicetree support
Date:   Mon,  3 Jan 2022 17:33:45 +0100
Message-Id: <cover.1641224715.git.sylv@sylv.io>
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

