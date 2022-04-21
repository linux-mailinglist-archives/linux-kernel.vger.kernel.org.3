Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042BA50973B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384615AbiDUGQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348136AbiDUGQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:16:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D408D13CF7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650521612; x=1682057612;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bPy112I2qKfmRbUBQ7cTMQX6EYgFATh9vK03t+Q3nnY=;
  b=fLMDqCRd1JqOyzt2OJrhgdz+55XGuvh6Yyyx3UO5OtvFx+/mgGRcy3y7
   I0wiLYB1x68K/O0XIsDJDtfIrSz0U+O4chESBXYr5k48OKD89MucTWXSB
   F3LZqGnSA3TEGEhYtVV5nVPZl0rgDev7aIDo2msxDy3D4I7rtX3JFW/nS
   4Lr46kZMnQS+2kpwvjDGZVGEPZL0HGajuuvrzxhTfk2Jq1e9+LvJlq83O
   INFpqsY49MGsaBDXHLQt/0Pe8aX5rtW7RV3uLxxkkXfqiUCw4WIIaSrfR
   cdiT3oHaGJ80oCo3juFlITYDAxcOahr+lVJP424nNru/YMvcWNDXezyCS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="324693147"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="324693147"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:13:32 -0700
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="555597936"
Received: from hanyulon-mobl1.ccr.corp.intel.com ([10.254.214.143])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:13:30 -0700
Message-ID: <36fbefd663b2956f99fb60eaa0e8318819dffeb5.camel@intel.com>
Subject: Re: [PATCH v2 1/5] mm: demotion: Set demotion list differently
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com
Date:   Thu, 21 Apr 2022 14:13:27 +0800
In-Reply-To: <20220413092206.73974-2-jvgediya@linux.ibm.com>
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
         <20220413092206.73974-2-jvgediya@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [PATCH v2 1/5] mm: demotion: Set demotion list differently

I think the subject of the patch isn't good.  It's too general, let's be
more specific.  For example, supoort to share demotion targets among
sources, etc.

Best Regards,
Huang, Ying


