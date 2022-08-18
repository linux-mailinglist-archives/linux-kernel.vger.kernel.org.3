Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A2759845E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245171AbiHRNkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244598AbiHRNjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:39:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC715A3ED;
        Thu, 18 Aug 2022 06:39:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C154C616C3;
        Thu, 18 Aug 2022 13:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3615C43154;
        Thu, 18 Aug 2022 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660829947;
        bh=Zo7h93fUJVJst6f9rgBv/W2cFjyN/CWBieAeHFz2d+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H4jzaZLYB9GJXkRH6fE7kFydsWBSUwOCze8DUBT8ymFjdeXX4P5RaWbCnv4+XhnVP
         zGhwOVPPwiQFbKzKRjKiRyMhRkkFkp6qyhZwKDPjvH9CuxwP9JfRWZbt7CFCf72NFu
         EpoPJFseUDZjtGVfhJL2O1knNfk1tCKTyhmeee2aEekD0lPXaRIL/tLSjCNpEyC0lo
         s686XpJpxMPCkqlv78SyE+uUnrfGX9qURPXMrH7gR7f+GXbX6CxmwJGHaOHb2fn3PP
         DEGCqXM1aZietCQQxvm+B6ck2uP5wcnUE6CwcYlZRbwers0ZVSalSzf38gIPKDvW9j
         yminwNu7fZPkA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oOfjl-00AY7l-HV;
        Thu, 18 Aug 2022 15:39:05 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>, corbet@lwn.net
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@in.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] ABI: sysfs-bus-nvdimm: fix a doc build warning
Date:   Thu, 18 Aug 2022 15:38:55 +0200
Message-Id: <1d576ae406d6183321320ffceb9c63a09fa095d3.1660829433.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660829433.git.mchehab@kernel.org>
References: <cover.1660829433.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "::" tag requires a blank line after it, as otherwise, it won't be
processed.

Fix this warning:

	Documentation/ABI/testing/sysfs-bus-nvdimm:11: WARNING: Unexpected indentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/13] at: https://lore.kernel.org/all/cover.1660829433.git.mchehab@kernel.org/

 Documentation/ABI/testing/sysfs-bus-nvdimm | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
index 1c1f5acbf53d..eeabba807e4b 100644
--- a/Documentation/ABI/testing/sysfs-bus-nvdimm
+++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
@@ -18,9 +18,11 @@ Description:	(RO) Attribute group to describe the magic bits
 		Each attribute under this group defines a bit range of the
 		perf_event_attr.config. Supported attribute is listed
 		below::
+
 		  event  = "config:0-4"  - event ID
 
 		For example::
+
 			ctl_res_cnt = "event=0x1"
 
 What:           /sys/bus/event_source/devices/nmemX/events
-- 
2.37.1

