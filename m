Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4B0482FA6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 10:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiACJuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 04:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiACJuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 04:50:54 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABEAC061784;
        Mon,  3 Jan 2022 01:50:54 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1n4JzP-0003R8-UV; Mon, 03 Jan 2022 10:50:51 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [RFC PATCH v1 0/2] docs: add a document dedicated to regressions
Date:   Mon,  3 Jan 2022 10:50:49 +0100
Message-Id: <cover.1641203216.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1641203454;75434bdf;
X-HE-SMSGID: 1n4JzP-0003R8-UV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'We don't cause regressions' might be the first rule of kernel development, but
it and other aspects of regressions nevertheless are hardly described in the
Linux kernel's documentation. These patches change this by creating a document
dedicated to the topic.

The second patch could easily be folded into the first one, but I kept it
separate, as it might be a bit controversial. This also allows the patch
description to explain some backgrounds for this part of the text. Additionally,
ACKs and Reviewed-by tags can be collected separately this way.

v1/RFC:
- initial version

Thorsten Leemhuis (2):
  docs: add a document about regression handling
  docs: regressions.rst: rules of thumb for handling regressions

 Documentation/admin-guide/index.rst       |   1 +
 Documentation/admin-guide/regressions.rst | 947 ++++++++++++++++++++++
 MAINTAINERS                               |   1 +
 3 files changed, 949 insertions(+)
 create mode 100644 Documentation/admin-guide/regressions.rst


base-commit: b36064425a18e29a3bad9c007b4dd1223f8aadc5
-- 
2.31.1

