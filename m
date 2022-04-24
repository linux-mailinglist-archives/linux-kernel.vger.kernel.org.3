Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6F550CEE3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbiDXD24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiDXD2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:28:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69136D95D5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 20:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650770755; x=1682306755;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n+MVa8U4qgyV3ArsQ7Zfw8u+BTkcXvZd1RU15lEbbeA=;
  b=FDy4qw/CtKWKp4K4zJnwNehdGo8bNG9i4njlXYKKRAhGsCywuT8wAHwV
   Cn8DSpm34N4sBTMkUFHNT1Fn/yE7Wwj5KSZKmga5qY2cHQ5d5C050drmu
   aE38fGTVCG5v4lj4+pnatSmSGq+tOTATcNro1KiAGL+xmwzeHcPfdSLYy
   w7mevy25vP7dxcg4ZErmBbHnRHg12zmlEZtez1OP0JyPOS5XxjSPfU0wM
   ci+Oj8u2vjdLiXC9GGeEegbbRl5vmT26EAKJ4s0glgwW4w3fp4C7/0Euo
   Xr5hpGrAEm+RXujQY9aKfxmAwNSrTAFk6eNosdQzRTmWAj3ol7mDIcabx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="327910027"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="327910027"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 20:25:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="578634921"
Received: from dafeixu-mobl1.ccr.corp.intel.com ([10.254.212.194])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 20:25:52 -0700
Message-ID: <bb4daddde2df1762dd0d6f2faac1d196a01d50be.camel@intel.com>
Subject: Re: [PATCH v3 1/7] mm: demotion: Fix demotion targets sharing among
 sources
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        aneesh.kumar@linux.ibm.com, shy828301@gmail.com,
        weixugc@google.com, gthelen@google.com, dan.j.williams@intel.com
Date:   Sun, 24 Apr 2022 11:25:50 +0800
In-Reply-To: <20220422195516.10769-2-jvgediya@linux.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
         <20220422195516.10769-2-jvgediya@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v3 1/7] mm: demotion: Fix demotion targets sharing among sources

IMHO, this patch doesn't fix some bugs in the original code.  Instead,
it just enhances the original code.  For example, the subject could be,

  mm: demotion: support to share demotion targets among sources

Best Regards,
Huang, Ying

[snip]


