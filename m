Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A06535252
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343623AbiEZQvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241110AbiEZQvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:51:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5494F9FD
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653583865; x=1685119865;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mQPnuXv9tALR0ECrlzjh5MSqyCQW8UBhNXylVFWVC38=;
  b=lvp3VMXOWuMoll9UqkYM63Cdi/uQNBT6vbnnv48upi/WuIFQsxeOd4ls
   A2GUiq9Df4GNQNbjnNqJb1m4KnN5HFmoVS45OTtKeVUqFljSVic9Aa4YC
   z9uCJtn5WjXCjYruiJ58wlpFD6IJ62fUAabviqqQYVtmxqSPCDGlGsvBo
   nmERbHG5Fx/qQ4dWde96Cqc0O4br2E+fD4dFQ06lntFPmNouVR+99hGfS
   XqJeCaCWUUO43C8sPrNKl25ogMAW4NuG5KsQb4t2cod6mvikMLnjhJE0A
   ZgXgR9lyTB83ExidvwOKgZGbKqSsxnxT/AtHRSwq1ZSKXjUrFfRkhouZF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="256281884"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="256281884"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 09:50:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="603206838"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 26 May 2022 09:50:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 26 May 2022 09:50:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 26 May 2022 09:50:47 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Thu, 26 May 2022 09:50:47 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Brown, Len" <len.brown@intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>
CC:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [FYI PATCH 1/1] tools arch x86: Sync the msr-index.h copy with
 the kernel sources
Thread-Topic: [FYI PATCH 1/1] tools arch x86: Sync the msr-index.h copy with
 the kernel sources
Thread-Index: AQHYcRkSevqWeQnD2UOqxPYnudWbfq0xXtZA
Date:   Thu, 26 May 2022 16:50:47 +0000
Message-ID: <1b985724110640719b4073e1bbec07d5@intel.com>
References: <Yo+i/j5+UtE9dcix@kernel.org>
In-Reply-To: <Yo+i/j5+UtE9dcix@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for being part of the problem with this getting out of sync.

But, remind me again why tools has *copies* of this and other files.

Seems like pointless work to keep them in sync.

-Tony
