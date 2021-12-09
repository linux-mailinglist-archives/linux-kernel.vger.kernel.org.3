Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2593346E22D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 06:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhLIFyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 00:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhLIFyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 00:54:39 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9FAC061746;
        Wed,  8 Dec 2021 21:51:06 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C8D513FA67;
        Thu,  9 Dec 2021 05:51:01 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] Apple mailbox fixup: switch to generic compatibles
Date:   Thu,  9 Dec 2021 14:50:47 +0900
Message-Id: <20211209055049.99205-1-marcan@marcan.st>
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

Hector Martin (2):
  dt-bindings: mailbox: apple,mailbox: Add generic and t6000 compatibles
  mailbox: apple: Bind to generic compatibles

 .../devicetree/bindings/mailbox/apple,mailbox.yaml   | 12 +++++++++---
 drivers/mailbox/apple-mailbox.c                      |  4 ++--
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.33.0

