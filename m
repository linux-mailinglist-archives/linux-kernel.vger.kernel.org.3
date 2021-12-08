Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85BA46D687
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhLHPPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:15:03 -0500
Received: from smtp1.axis.com ([195.60.68.17]:16745 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235715AbhLHPO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1638976287;
  x=1670512287;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UZZSnYnw4jLTax4OpDkIeMinE4hBxCFUR/CU9ldPodg=;
  b=l6LQ8GeyOgWAZZ/d+GqtJBMxsIx766+VzmaEL66TsN823P7fFskS76/w
   /INCZJ4FsqZb8s0W56WSrqqKE3PRKR8vbWe5O8lhayuBS+3zSuepM6JA3
   SiYoP9bYQXs/4/njtKVHBqgbiE5xLFFH1DFF0R4gzEYPHxRo8KYXtoWhB
   7Nj8NYwJPUbELiAy9WKhMDmuZDtntpUN0L0wPSRD4NUQCQ6XIZdeJ2yk1
   mKhro/QTNliDH32xflXmwqlDHiMXd7L9/uZXK5IAf3mDcCTamYz0dwqlc
   89S25RXj3Pus6H23FfEqDBFg0PVLpm9ZXfzF6MEAnQ4iPocgsERJoJ3xp
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <jdike@addtoit.com>, <richard@nod.at>,
        <anton.ivanov@cambridgegreys.com>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <linux-um@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 0/2] Devicetree support for UML
Date:   Wed, 8 Dec 2021 16:11:21 +0100
Message-ID: <20211208151123.29313-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add support for passing a devicetree blob to UML.  It can be used
for testing device drivers.

Vincent Whitchurch (2):
  um: Extract load file helper from initrd.c
  um: Add devicetree support

 arch/um/Kconfig            |  1 +
 arch/um/kernel/Makefile    |  2 ++
 arch/um/kernel/dtb.c       | 41 +++++++++++++++++++++++++
 arch/um/kernel/initrd.c    | 48 ++++--------------------------
 arch/um/kernel/load_file.c | 61 ++++++++++++++++++++++++++++++++++++++
 arch/um/kernel/um_arch.c   |  3 ++
 arch/um/kernel/um_arch.h   | 14 +++++++++
 7 files changed, 127 insertions(+), 43 deletions(-)
 create mode 100644 arch/um/kernel/dtb.c
 create mode 100644 arch/um/kernel/load_file.c
 create mode 100644 arch/um/kernel/um_arch.h

-- 
2.33.1

