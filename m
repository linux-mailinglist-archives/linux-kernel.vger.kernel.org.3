Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6425ACE21
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbiIEItz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238211AbiIEItt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:49:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A53BC0F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662367787; x=1693903787;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4D3RAQxQy6SFrkYw939qLRwPf9Fd7iF48Kn/A1uq7TQ=;
  b=jbIp+lk1S6psnyhybPOASQmaTmHTRXiAEobkyuPPTwb1RteE6Gko+uqw
   s3ZrEiZGuAVAP2JidrqHBaqudhkZSAOcdau+NgjGZwAe0YcAB3EeljCIc
   Q5cq2WlTYo/bIM2DFFNVwn5XPeKgvziUoPo4UXL5wgsZJHf3WpbtIuaH0
   rAvHJoYPSiiwWP37QZw4Ko+pfRv5tDYZH/qbkzYcEv7ggnC4U4RH4IGhZ
   f8zOtP+tXZNxy0CDKN2pwCSVXyJ1Mqp7R0NpORm8/WvbykOi83AiEUyBz
   1fnMWMTZtYPy9cqJmOfljJCa4i8Zvv05sBXgIl7dMR1d0hpN+O/71TREq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="382641441"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="382641441"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 01:49:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="675199754"
Received: from smaciag-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.57.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 01:49:44 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jingyu Wang <jingyuwang_vip@163.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        Joe Perches <joe@perches.com>
Cc:     Jingyu Wang <jingyuwang_vip@163.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/print: cleanup coding style in drm_print.h
In-Reply-To: <87wnaib45t.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220904203818.16775-1-jingyuwang_vip@163.com>
 <87wnaib45t.fsf@intel.com>
Date:   Mon, 05 Sep 2022 11:49:28 +0300
Message-ID: <87sfl6b3zb.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Sep 2022, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Mon, 05 Sep 2022, Jingyu Wang <jingyuwang_vip@163.com> wrote:
>> Fix everything checkpatch.pl complained about in drm_print.h

[...]

>>  static inline void
>> -drm_vprintf(struct drm_printer *p, const char *fmt, va_list *va)
>> +drm_vprintf(struct drm_printer *p, const char *fmt, va_list * va)
>
> Checkpatch is just confused here. Look at all the other params, why
> would you add an extra space here?

Joe, can you help me out here please, I can't figure out why checkpatch
is complaining here:

include/drm/drm_print.h:106: CHECK:SPACING: spaces preferred around that '*' (ctx:WxV)
#106: FILE: include/drm/drm_print.h:106:
+drm_vprintf(struct drm_printer *p, const char *fmt, va_list *va)


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
