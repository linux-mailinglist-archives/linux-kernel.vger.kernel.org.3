Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D652A590599
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbiHKRQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbiHKRPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:15:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2BB1C101
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660237491; x=1691773491;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nAXhLbzrsFPh1m0Zu3UXRzk4Pk/kGQ7KFSAs+r9EtBU=;
  b=nZhZnFO8i0PIM2LWbFAsKQV229ynDGER9LhRgWob4eugVxI905nVRv31
   /vjTpRImhfkqMZ1q4dHvaDOI1dHxnGbP3FOfR2HBuES3O+sHE6N8e0cV4
   zj+oueOkrX0+O8prfEKJjms3qLSBrG82JhPQ1idKvVYDKiv1T+SBtKkVo
   vBX0qfloFqDZGc3dPAeK2zCFb7S3AeShMz6QkYQU2AUIKCdFCRCIw8BC7
   hSNH6iccGyPJ1/O/XvMb89OUbsJRN+c7lz5PT00z69qRxMnY6273IWJ59
   AeMyH5jDG4gRjz3X5ADqsws76sCP9iHAguVayCInbk6mO+q18T4duiFcx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="290161796"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="290161796"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 10:04:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="602234613"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.35.150])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 10:04:26 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] perf tools: Fix missing guest option documentation
Date:   Thu, 11 Aug 2022 20:04:08 +0300
Message-Id: <20220811170411.84154-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are a couple of small documentation fixes and subsequent corresponding
tidy-up.


Adrian Hunter (3):
      perf script: Fix missing guest option documentation
      perf inject: Fix missing guestmount option documentation
      perf tools: Tidy guest option documentation

 tools/perf/Documentation/guest-files.txt | 16 ++++++++++++++++
 tools/perf/Documentation/guestmount.txt  | 11 +++++++++++
 tools/perf/Documentation/perf-inject.txt |  4 ++++
 tools/perf/Documentation/perf-kvm.txt    | 25 +++++--------------------
 tools/perf/Documentation/perf-script.txt |  6 +++---
 5 files changed, 39 insertions(+), 23 deletions(-)
 create mode 100644 tools/perf/Documentation/guest-files.txt
 create mode 100644 tools/perf/Documentation/guestmount.txt


Regards
Adrian
