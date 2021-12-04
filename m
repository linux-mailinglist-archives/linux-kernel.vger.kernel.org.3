Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939EA4685EF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 16:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344961AbhLDPcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 10:32:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:28706 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232182AbhLDPcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 10:32:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="261147408"
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="261147408"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 07:28:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="610754836"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Dec 2021 07:28:53 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtWy4-000J8Y-Fv; Sat, 04 Dec 2021 15:28:52 +0000
Date:   Sat, 4 Dec 2021 23:28:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH t-kristo-pm] HID: bpf: hid_bpf_add_report() can be static
Message-ID: <20211204152814.GA74975@f51396ba56c0>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/hid/hid-bpf.c:229:23: warning: symbol 'hid_bpf_add_report' was not declared. Should it be static?
drivers/hid/hid-bpf.c:257:6: warning: symbol 'hid_bpf_free_reports' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 hid-bpf.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-bpf.c b/drivers/hid/hid-bpf.c
index b46b68d54ea80..6b39c48d3d85c 100644
--- a/drivers/hid/hid-bpf.c
+++ b/drivers/hid/hid-bpf.c
@@ -226,9 +226,9 @@ struct hid_bpf_parser_and_data {
 	struct hid_bpf_report_enum report_enum[HID_REPORT_TYPES];
 };
 
-struct hid_bpf_report *hid_bpf_add_report(struct hid_bpf_parser_and_data *data,
-					  unsigned int type, unsigned int id,
-					  unsigned int application)
+static struct hid_bpf_report *hid_bpf_add_report(struct hid_bpf_parser_and_data *data,
+						 unsigned int type, unsigned int id,
+						 unsigned int application)
 {
 	struct hid_bpf_report_enum *report_enum = data->report_enum + type;
 	struct hid_bpf_report *report;
@@ -254,7 +254,7 @@ struct hid_bpf_report *hid_bpf_add_report(struct hid_bpf_parser_and_data *data,
 	return report;
 }
 
-void hid_bpf_free_reports(struct hid_bpf_parser_and_data *data)
+static void hid_bpf_free_reports(struct hid_bpf_parser_and_data *data)
 {
 	unsigned i, j;
 
