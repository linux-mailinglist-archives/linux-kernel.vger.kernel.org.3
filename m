Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548C4500D79
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243122AbiDNMdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbiDNMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:33:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DF1275E2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649939439; x=1681475439;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HRKFubKrtd5FTv5YNfXCxGA3hC7nrwE2jmGRUJNoEfs=;
  b=VkSIhxbqImI4MG8VND6Ri/KLZJ1hHwzEbP55zwZqwiQHk8ZiNBxdf5Tc
   UdU2XijSuaZGWHfDUhHLY0JqcQT4VsugY5Iv3tDdbwBqZvpAlaaYl5fZC
   1CMSouvnSFpjrPtPudNDp2fDJ/K1pkv4bs1051tQk9Squ1+ZxSoQBDQJa
   ZsokaSL4K5r4E9yqmqk5N0VoLV9+rmIt0j7ePsqssoHdYrcF3/aSMrF09
   kmlWOXEfi4Z7IIt50bqZrJWVEkBbUSzN3RZgRhaScfkJIA5K0jtZj/ewY
   u5/BwDCJ7FdWj37Imu9T8cxOroiC+cEOsB8XwYj08aS+XkE88oltomG31
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323362145"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="323362145"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 05:30:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="552662557"
Received: from nplaweck-mobl.ger.corp.intel.com (HELO localhost) ([10.249.149.236])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 05:30:36 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        jani.nikula@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 0/1] add support for enum module parameters
Date:   Thu, 14 Apr 2022 15:30:32 +0300
Message-Id: <20220414123033.654198-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, I've sent this before, ages ago, but haven't really followed
through with it. I still think it would be useful for many scenarios
where a plain number is a clumsy interface for a module param.

Thoughts?


BR,
Jani.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>

Jani Nikula (1):
  module: add enum module parameter type to map names to values

 include/linux/moduleparam.h | 64 +++++++++++++++++++++++++++++++++++++
 kernel/params.c             | 41 ++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

-- 
2.30.2

