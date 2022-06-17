Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5DB54FB6A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383484AbiFQQtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383479AbiFQQtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:49:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06245220F9;
        Fri, 17 Jun 2022 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655484531; x=1687020531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MtLDdBEc43w3sm9z5M+xLkoPIkB8qA0q3ITj0OvDROI=;
  b=L3225C35wUvmZCpdWYBmZy0X7nlD3UOEhUP3807/UUvKIy7NTmVploNd
   3BSUyrgMxD6cuJTu+WJA+VnC2/7jANe4KzaCkiqmQq2OMwgDaNfr0a1bm
   4VfoHb2DuRC5f4s1pEJUnbFGxRMeN1i0ljHSYnHE7+0Vwy2gVmYTVW9tX
   pc0dRTUYQTEP+fJsB/zW/6qIuyxF8dkdpoPh//nYUhMiYiGMYSK0idDWg
   /O4wSSZ63hDaTERKyyfhC2Avx0kCLV1LqKEzmr6dM2ZRzSN5v+wCxbHSy
   5rUoqSI1qLX4/XaONfh+LLmczQLtpcKwYepQRLM0J8PRLr/y1kDGNDPdE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="304937938"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="304937938"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 08:20:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="728375111"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 08:20:32 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 17 Jun 2022 18:20:29 +0300
Date:   Fri, 17 Jun 2022 18:20:29 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Fix typo in comment
Message-ID: <Yqybve7rtj+xcdqN@lahna>
References: <20220616163830.11366-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616163830.11366-1-wangxiang@cdjrlc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 12:38:30AM +0800, Xiang wangx wrote:
> Delete the redundant word 'the'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Applied, thanks!
