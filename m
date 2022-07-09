Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C142E56C8DA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiGIKJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiGIKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:07:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE9D4B0DB;
        Sat,  9 Jul 2022 03:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 444C9B819D6;
        Sat,  9 Jul 2022 10:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64035C341D0;
        Sat,  9 Jul 2022 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657361258;
        bh=Ix9TaeoHO5faJo9weCjOecaRhyb1RB5jwjX8jAZ0dJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B39OsEtnUNWREm4npQzQPcw3E1TUCMWfYE/5Tdh6apqS6oZu5ze+TBprGP91QiDcZ
         5XXJ245dmQ/E+xVGWyGJyjhWtpaT54zxfwV+ERt0rPhOsR9EE4CjfadyIBzgLGlO68
         0ADsparZMiItL+WofTRbk6OAPZvdEjS72VRhrH//5cc3X+BeiEWhX3YmDqWnmSJ9+p
         kMCWFBPcs3AhXTBiclvIiGQXaGadwu1SHVpknTzQdOMo4MAGksqgokBusfKOBsNimW
         AxoDB+OS996GlJJz0kEcdv7mlhNAbHni0+Qe53sX7qjp0GweOuabGAdB/L3/NJvQ9P
         +9JKC1IjZYOXA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oA7N9-004EHP-OI;
        Sat, 09 Jul 2022 11:07:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@in.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/21] docs: ABI: sysfs-bus-nvdimm
Date:   Sat,  9 Jul 2022 11:07:32 +0100
Message-Id: <30144c21b82f4b1bb80e4e7af8a6fe9b9e26ad42.1657360984.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657360984.git.mchehab@kernel.org>
References: <cover.1657360984.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add blank lines, as this is required by code-block markup syntax.

Fix this warning:
	Documentation/ABI/testing/sysfs-bus-nvdimm:11: WARNING: Unexpected indentation.

Reviewed-By: Kajol Jain<kjain@linux.ibm.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/21] at: https://lore.kernel.org/all/cover.1657360984.git.mchehab@kernel.org/

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
2.36.1

