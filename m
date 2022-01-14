Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7D048ED43
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242794AbiANPkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:40:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:65044 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229884AbiANPko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642174844; x=1673710844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EmTaqi0mb1+xAu+Z1chEH+YXcMOWdceEHA+qZobfcY8=;
  b=f3FL2sGOfuYQyw9kgF46IcC0yHFumrVj2dgTg003DdmOm9ADQqsY0AOF
   01RRmoLMEo/ptxqg4fxZ9r0Wo8Id8nEHXnlAxyRScfB7S4WCi3tqi9uhj
   oTV4oZQ7DonL1DF3MUWqiV9mCps/Z1/Ge1h8n1fpeB57/F9v8og3niTWm
   EIKql0Toh6TkaR4dzwu94nPpWwyEtbULLkxm/Gn09EREjvW1Dv9L2U6ep
   cD+7ukJJiDRcm9gIdpC8HsEvkA9BtnU0TZYD34Mb0pqvKKtebyY2yIQCz
   Abim3J2uTM8Fra2sNaHWn/RO1iaI8Ro2CRSTTffmNXnmSRFCgbLwAjYoX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="224250939"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="224250939"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 07:40:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="529368285"
Received: from alliang-mobl1.amr.corp.intel.com (HELO [10.212.42.120]) ([10.212.42.120])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 07:40:41 -0800
Message-ID: <037f9a23-6a90-bacb-5f9c-05f9a8be3be7@linux.intel.com>
Date:   Fri, 14 Jan 2022 15:40:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH][RESEND] i915: make array flex_regs static const
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220112223435.949071-1-colin.i.king@gmail.com>
 <87h7a86lf8.fsf@intel.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <87h7a86lf8.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/01/2022 09:21, Jani Nikula wrote:
> On Wed, 12 Jan 2022, Colin Ian King <colin.i.king@gmail.com> wrote:
>> Don't populate the read-only array flex_regs on the stack but
>> instead it static const. Also makes the object code a little smaller.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>>
>> ---
>>
>> RESEND: Use correct e-mail address for sign-off and From: in e-mail.
> 
> There are a number of things at play here:
> 
> - Our tooling checks for certain things, such as author/signed-off-by
>    match, after applying the patch.
> 
> - You have an entry in the kernel git .mailmap.
> 
> - The git log.mailmap config default has changed from false to true.
> 
> We apply the patch, and, with the default options, git show will display
> a different author than the signed-off-by.
> 
> We should use --no-use-mailmap when examining a commit to ensure the
> commit is internally consistent, regardless of .mailmap.

Yes that sounds like the right thing to do.

In the meantime I have pushed this patch.

Regards,

Tvrtko

