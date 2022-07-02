Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EE2563FA8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 13:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiGBLIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 07:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiGBLHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 07:07:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F1215A2B;
        Sat,  2 Jul 2022 04:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E11B60C8B;
        Sat,  2 Jul 2022 11:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B9CC385A5;
        Sat,  2 Jul 2022 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656760068;
        bh=+yAOlbX8A26J9WzbSfl3wRbCKpuFUrq8Fa9yBKYeicw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VM1iCrW2XRikhJ2c+5H0XB/XAM6njzsGfDa5VPbbv/nDcUSOzEdchhTP2fLP7TRDu
         0bf+VKznG6405a8D01YjHbaJNj1bpyCu3UO+gZBaoxYRG/av5n/B+4GbDh0dr5i6Ka
         E/8WxANuARzjiM53c0gOOUbEAz4LLYP/ZbpPCFn423cZJh5/qp8hUGIQlNicjwgp6R
         AGkrHobGl2OvC+xLH+gkBP1xT2oP0E6T5yhCD5WEeF3EA2BKE3x6vHENGMuRYYDjoS
         HSq1vgnBbUR0vWMXJ2Aihrq5Vm2RKdsXyosq3SsvxJIuMrcq9CPISGNWP1T335C0vz
         By2b6k1dt4wAA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7ayX-007gs9-O4;
        Sat, 02 Jul 2022 12:07:45 +0100
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
Subject: [PATCH 07/12] docs: ABI: sysfs-bus-nvdimm
Date:   Sat,  2 Jul 2022 12:07:39 +0100
Message-Id: <38a59ea8cc8581a3009d269c9f1cd4cf07b347dc.1656759989.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656759988.git.mchehab@kernel.org>
References: <cover.1656759988.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/12] at: https://lore.kernel.org/all/cover.1656759988.git.mchehab@kernel.org/

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

