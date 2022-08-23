Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F25A59E3E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244641AbiHWMly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 08:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239933AbiHWMlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 08:41:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0383C10811D;
        Tue, 23 Aug 2022 02:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661248287; x=1692784287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wPCmb9o2zkDw2O64LDEPwhduQ0IzSE9YH9BV2angffA=;
  b=gxB6jm8AsbPD1kW+GleoZWYAWBRye96lJYjjRUvT44ezjht/oYn8Ts/C
   hmLoqgd4jo39PGbrx5CSQ5jYkPYf/znmjODoBdU06rFuAYfn2XGEGZGxf
   47qexogo8T7O0Sz27NrWdNcqkkPdUCV5Vt+MALiLXHzdEgLE+V9IS3Vn/
   JdEKHHjl8nsTc21efrWsa7K9o/ZlPaTHAiWz5KMuSDqyKyA2xkVDLNdF4
   wy8y+3m/XbkPIddLNOLk5s7vhWji/pdiF55pHWLOpivnwFTc9W+1tuAy2
   u7/p0R/0zhMl7n3rT7Bu90+Vyjr7H/m7yaOuTAVAWdGArlIV6BWzfuf0R
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="294432733"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="294432733"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 02:50:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="937399830"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 23 Aug 2022 02:50:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C6681AD; Tue, 23 Aug 2022 12:50:49 +0300 (EEST)
Date:   Tue, 23 Aug 2022 12:50:49 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/thunderbolt: fix repeated words in comments
Message-ID: <YwSi+abTNFSg1ZPV@black.fi.intel.com>
References: <20220822122921.26437-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822122921.26437-1-yuanjilin@cdjrlc.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 22, 2022 at 08:29:21PM +0800, Jilin Yuan wrote:
>  Delete the redundant word 'the'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

This is already fixed by 34b9715b7cae ("thunderbolt: Fix typo in comment").
