Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A8B564758
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 15:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiGCNF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 09:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiGCNFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 09:05:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CA06267;
        Sun,  3 Jul 2022 06:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656853524; x=1688389524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tDEYZVNK58vag7/t2fMmvEE5umcqKdMa6tRmoZ19LPI=;
  b=nId1j/kyxtRNtTz1oztL5Jf8m8MflGi1jun9PoA5PP2thFByuKOlRBX5
   AjatN4F2C5zGwzstsy++30PHvcoCzEdXRR1JNuJRg0bOQu9CovsCIeTDH
   NsKV03V0r/qYDMuuBLRS3rlgwCpq1bnc/9UMkERAmWQb0xpfx8YgWNgbu
   2RbwwpccIujy561LkUEZgNBMVDcagZCsc6W4x1UhZxZwF7hkqakPYLBuN
   8zo0r2iUni4w29OwF0RgKAjhqgMxShSl3wOtLV7e4oZ7Yfqo4sq+JPf0s
   4zQgpDdBcgUQ2QIR2ySbAsJrM4API5Oc0SkvX84RCe1ZZooDDg9Wkbp3M
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="284054694"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="284054694"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 06:05:23 -0700
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="768953536"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 06:05:21 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id DD761203EB;
        Sun,  3 Jul 2022 16:05:18 +0300 (EEST)
Date:   Sun, 3 Jul 2022 16:05:18 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, ezequiel@vanguardiasur.com.ar,
        arnd@arndb.de, ribalda@chromium.org, andrzej.p@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] media: v4l: Use memset_after() helper
Message-ID: <YsGUDq3nTzwsO3A3@paasikivi.fi.intel.com>
References: <20220613130845.89220-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613130845.89220-1-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 09:08:45PM +0800, Xiu Jianfeng wrote:
> The CLEAR_AFTER_FIELD defined here is functionally the same as
> memset_after() helper, so replace it with memset_after() to simplify the
> code, no functional change in this patch.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Thanks!

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
