Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A5C475C69
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244281AbhLOP4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:56:01 -0500
Received: from marcansoft.com ([212.63.210.85]:52852 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244274AbhLOP4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:56:00 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 60115419BC;
        Wed, 15 Dec 2021 15:55:56 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] Apple mailbox fixup: switch to generic compatibles
Date:   Thu, 16 Dec 2021 00:55:25 +0900
Message-Id: <20211215155527.36775-1-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Just a quick fix for the Apple mailbox compatible. Similar to [1], we
intend to use SoC-specific compatibles only for potential quirks, and
rely on a generic compatible to allow for forward-compatibility as long
as things don't break.

Since this isn't instantiated in any upstream DT yet, I think we can
afford the compatibility break now.

This also goes ahead and adds the compatible for the new t600x SoCs.

[1] https://lore.kernel.org/linux-arm-kernel/20211121171545.27402-3-j@jannau.net/

Changes since v1:
 - Changed the compatibles to reflect the generic mailbox versions
   Apple uses.

Hector Martin (2):
  dt-bindings: mailbox: apple,mailbox: Add generic and t6000 compatibles
  mailbox: apple: Bind to generic compatibles

 .../devicetree/bindings/mailbox/apple,mailbox.yaml   | 12 +++++++++---
 drivers/mailbox/apple-mailbox.c                      |  4 ++--
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.33.0

