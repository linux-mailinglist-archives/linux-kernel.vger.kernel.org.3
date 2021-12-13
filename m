Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310854724CB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhLMJif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:38:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:13602 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234830AbhLMJhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:37:04 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="324966583"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="324966583"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 01:34:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="464555913"
Received: from ppolasze-mobl.ger.corp.intel.com (HELO localhost) ([10.252.20.7])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 01:34:12 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-hardening@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH] drm/dp: Actually read Adjust Request Post Cursor2 register
In-Reply-To: <202112100853.FDB294B86@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211203084354.3105253-1-keescook@chromium.org>
 <87o85r4a4f.fsf@intel.com> <202112082220.81ECDC63D@keescook>
 <2b7d760c-9ab8-b607-efc6-1ed276d67668@amd.com>
 <202112091539.6B349AC@keescook> <87a6h83hb7.fsf@intel.com>
 <202112100853.FDB294B86@keescook>
Date:   Mon, 13 Dec 2021 11:34:09 +0200
Message-ID: <87y24o7sry.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Dec 10, 2021 at 12:06:20PM +0200, Jani Nikula wrote:
>> Post Cursor2 was completely optional for the transmitter even before it
>> was deprecated.
>> 
>> And now we'd be adding 5 bytes extra to all link status reads. To fix
>> the only user of drm_dp_get_adjust_request_post_cursor() that apparently
>> has never worked as intended. I'm just not convinced.
>> 
>> I was trying to look through the implications of DP_LINK_STATUS_SIZE
>> increase, and at least drm_dp_dpcd_read_phy_link_status() comes across
>> as something probably needing attention.
>
> Okay, it sounds like you'd prefer the "make it tegra-specific" patch I
> proposed. I will work that up as a proper patch and send it.

Yes. Of course, I'd like to hear Thierry's view as well.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
