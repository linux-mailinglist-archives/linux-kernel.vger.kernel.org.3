Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACE8518D65
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239444AbiECTtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242086AbiECTte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:49:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED262E6BB;
        Tue,  3 May 2022 12:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651607161; x=1683143161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GNXzg6lz5FwL3/2NW3SeM/C8p33Q44jpG3a64BmETtg=;
  b=QZChQDjyj6MjmEQVn1EIvvjoojizTxmxtZjbVMWF6CfQ725LKp46q/rr
   bPPeJgcaB13/w50qWyLGdIgN13TrqUICiWOL3gUiOmk4Khy+vilEHGUwG
   iUPWMuGEc9fb93OdSgIOSdDkFUlyDjYWYHw8jw7aJXQurwd6sLcKiSAw2
   9G5X1Lmvl/Eze7awQFicv7pYvk4DnY5zSuZ6CWTgwGbY8ajyGyGNO78GC
   P9EQnb0b6/1AXgib2qRkcjq7WUJdZOw8tadK8r0lfMGFagwDvG0ZouGKD
   cZAEpRWjfphjIoO2K1ptIt8pamRW+1S/llqG69Cn8BfXtviF7HjuY3qwq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248114161"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="248114161"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 12:46:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="584345939"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 12:45:59 -0700
From:   matthew.gerlach@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v2 2/3] dt-bindings: intel: add binding for Intel n6000
Date:   Tue,  3 May 2022 12:45:45 -0700
Message-Id: <20220503194546.1287679-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503194546.1287679-1-matthew.gerlach@linux.intel.com>
References: <20220503194546.1287679-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add the binding string for the Agilex based Intel n6000 board.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
index 6e043459fcd5..61a454a40e87 100644
--- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
+++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
@@ -18,6 +18,7 @@ properties:
         items:
           - enum:
               - intel,n5x-socdk
+              - intel,socfpga-agilex-n6000
               - intel,socfpga-agilex-socdk
           - const: intel,socfpga-agilex
 
-- 
2.25.1

