Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7321758511C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbiG2NvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbiG2NvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:51:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DB34E61E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:51:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7673C61F5B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8F1C433D6;
        Fri, 29 Jul 2022 13:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659102659;
        bh=IwvVpuGzmpujh0W6rRT+/Kr7v0ZN242P+UO+ZSURpDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wZVJ8wgrmjx65QWipukHfWz4wpWTgVbMSFRi/iJJjcjOAZC56O+r+YhCSeEitNMGA
         318yfjRTzoo+Q7uF9fyGNxfDc+OElI1H/MqSc24jl5o/7dBpm8ovH0TZxZODGbfx4q
         6xFtzyfmRvUqh/NMhpaK/astWrKDINqFjc3PdS5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     alsa-devel@alsa-project.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] soundwire: sysfs: remove unneeded ATTRIBUTE_GROUPS() comments
Date:   Fri, 29 Jul 2022 15:50:41 +0200
Message-Id: <20220729135041.2285908-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409; i=gregkh@linuxfoundation.org; h=from:subject; bh=IwvVpuGzmpujh0W6rRT+/Kr7v0ZN242P+UO+ZSURpDM=; b=owGbwMvMwCRo6H6F97bub03G02pJDEmPn25QXj3nyzudMMbWJ8GyYqkvAhI3ak9oOpfhuF3BXalT KdGzI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACbyZhrDgkkTV0/Y6bNmtnpxwvvV4s qcBizFuxgWdJa9T3LOq2N+U9x192PHotTtV56oAwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we manually created our own attribute group list, the outdated
ATTRIBUTE_GROUPS() comments can be removed as they are not needed at
all.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soundwire/sysfs_slave.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
index 070e0d84be94..5b7666d27722 100644
--- a/drivers/soundwire/sysfs_slave.c
+++ b/drivers/soundwire/sysfs_slave.c
@@ -129,10 +129,6 @@ static struct attribute *slave_dev_attrs[] = {
 	NULL,
 };
 
-/*
- * we don't use ATTRIBUTES_GROUP here since we want to add a subdirectory
- * for device-level properties
- */
 static const struct attribute_group sdw_slave_dev_attr_group = {
 	.attrs	= slave_dev_attrs,
 	.name = "dev-properties",
@@ -194,10 +190,6 @@ static struct attribute *dp0_attrs[] = {
 	NULL,
 };
 
-/*
- * we don't use ATTRIBUTES_GROUP here since we want to add a subdirectory
- * for dp0-level properties
- */
 static const struct attribute_group dp0_group = {
 	.attrs = dp0_attrs,
 	.is_visible = dp0_is_visible,
-- 
2.37.1

