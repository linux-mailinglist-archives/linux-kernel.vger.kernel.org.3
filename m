Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F9A4934E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 07:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351742AbiASGST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 01:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiASGSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 01:18:17 -0500
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B37C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 22:18:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A14D1268580;
        Wed, 19 Jan 2022 06:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1642573094; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=wRM67EIU2AyRE92xEs7W2+/TNxWTGS27ENje3MjFFyM=;
        b=SHG3SO39hzxluPIXzsFqgh6Pxg0uZrf2Vp+6yikjAFN3gBEz4vELZCr/MAEZ+JlhsRD981
        Hgj8qjU9ZjJLSnfbJuseVig5iuk1ubcdwm94UTu01ewTJGFnbgjpX8NzaaAV5iecKNpDtq
        KzV9o2eiIoCvAHm6eohyK9rRDgOareDQCQve/ir95R6Y6jP9XBTmkXXgv4yQPDxmpbvxAt
        qStOraNiqUQX6d9C3/Hgmt6gyXvmg6vcNif8GAq5CQvl9/aRfs0zCXgEKiL1k8tMrq4OJM
        PdQT1vTpsGECvGDJOq1lPzneVM35MtDzZyoI9ue+eF8xqkPF4vyqIlYOxTt72w==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Bluetooth: hci_h5: btrtl: Add support for RTL8822CS hci_ver 0x08
Date:   Wed, 19 Jan 2022 09:17:22 +0300
Message-Id: <20220119061723.2862683-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a variation of RTL8822CS with hci_ver = 0x08. This is fully similar to RTL8822CS with hci_ver = 0x0a
observed on the Tanix TX6 Android set-top box and JetHome JetHub H1.

The controller does not always start when the system starts up, so we do a forced reset via gpio during initialization.

Changes from v3:
- add has_msft_ext option
Changes from v2:
- align the patches for bluetooth-next
Changes from v1:
- remove Signed-off-by chbgdn <chbgdn@gmail.com> as not reachable

Vyacheslav Bocharov (2):
  Bluetooth: btrtl: Add support for RTL8822C hci_ver 0x08
  Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open

 drivers/bluetooth/btrtl.c  | 8 ++++++++
 drivers/bluetooth/hci_h5.c | 5 +++++
 2 files changed, 13 insertions(+)

-- 
2.30.2

