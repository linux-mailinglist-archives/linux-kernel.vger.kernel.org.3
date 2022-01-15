Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF59948F68A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 12:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiAOLcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 06:32:11 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:49863 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiAOLcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 06:32:10 -0500
Received: from apollo.. (unknown [IPv6:2a02:810b:4340:43bf:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4FE4A22246;
        Sat, 15 Jan 2022 12:32:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642246328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PfCO0m1JXR5eRFHO1Bc0CPN6WuzbcI2sGeYMVOMBSFg=;
        b=to7uyS9pQqOKMKOZG0AxbTWf1Ou9dfZNuQIB919HKRZg1daYTmyxPoaMIDeUXaOKP8p/kE
        Dg+GdcL/NfYJ7CyZ/VVN6jnkdcalRjKBO/751oU42nuVAwPdYttd18vJmvZSqX0uE4h2/j
        ekQu6nOizHILm7quaoerZ0HXkLO/rjM=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] of: base: add parameter doc to of_parse_phandle_with_optional_args()
Date:   Sat, 15 Jan 2022 12:31:56 +0100
Message-Id: <20220115113156.435037-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

htmldocs produces warnings about the missing documentation. Add them.
While at it, fix the typo in the referenced function name.

Fixes: 952c4865d27a ("of: base: add of_parse_phandle_with_optional_args()")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 include/linux/of.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index eeb2910b51da..062a0d899403 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1021,9 +1021,14 @@ static inline int of_parse_phandle_with_fixed_args(const struct device_node *np,
 
 /**
  * of_parse_phandle_with_optional_args() - Find a node pointed by phandle in a list
+ * @np:		pointer to a device tree node containing a list
+ * @list_name:	property name that contains a list
+ * @cells_name:	property name that specifies phandles' arguments count
+ * @index:	index of a phandle to parse out
+ * @out_args:	optional pointer to output arguments structure (will be filled)
  *
- * Same as of_parse_phandle_args() except that if the cells_name property is
- * not found, cell_count of 0 is assumed.
+ * Same as of_parse_phandle_with_args() except that if the cells_name property
+ * is not found, cell_count of 0 is assumed.
  *
  * This is used to useful, if you have a phandle which didn't have arguments
  * before and thus doesn't have a '#*-cells' property but is now migrated to
-- 
2.30.2

