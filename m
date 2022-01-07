Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3400F4878D3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347765AbiAGOVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347627AbiAGOVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:21:07 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EDBC06173E;
        Fri,  7 Jan 2022 06:21:06 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1n5q75-0007s5-SL; Fri, 07 Jan 2022 15:21:03 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [RFC PATCH v2 0/2] docs: add a text about regressions to the Linux kernel's documentation
Date:   Fri,  7 Jan 2022 15:21:00 +0100
Message-Id: <cover.1641565030.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1641565266;60e5e95e;
X-HE-SMSGID: 1n5q75-0007s5-SL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'We don't cause regressions' might be the first rule of Linux kernel
development, but it and other aspects of regressions nevertheless are hardly
described in the Linux kernel's documentation. The following two patches change
this by creating a document dedicated to the topic.

The second patch could easily be folded into the first one, but was kept
separate, as it might be a bit controversial. This also allows the patch
description to explain some backgrounds for this part of the document.
Additionally, ACKs and Reviewed-by tags can be collected separately this way.

v2/RFC:
- a lot of small fixes, most are for spelling mistakes and grammar
  errors/problems pointed out in the review feedback I got so far
- add ACK for the series from Greg

v1/RFC (https://lore.kernel.org/linux-doc/cover.1641203216.git.linux@leemhuis.info/):
- initial version

---

Hi! Here is a quick update to the patches I sent a few days with a lot of fixes,
in case anyone has some spare cycles and looks for something to read over the
weekend.

Ciao, Thorsten

Thorsten Leemhuis (2):
  docs: add a document about regression handling
  docs: regressions.rst: rules of thumb for handling regressions

 Documentation/admin-guide/index.rst       |   1 +
 Documentation/admin-guide/regressions.rst | 965 ++++++++++++++++++++++
 MAINTAINERS                               |   1 +
 3 files changed, 967 insertions(+)
 create mode 100644 Documentation/admin-guide/regressions.rst


base-commit: 82ca67321f55a8d1da6ac3ed611da3c32818bb37
-- 
2.31.1

