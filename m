Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC2348F36B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiAOAQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:16:44 -0500
Received: from mga14.intel.com ([192.55.52.115]:30457 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbiAOAQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642205803; x=1673741803;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gO65WH3EChowIEEBX2A6ESaaBVLKawqo07SeQFnjy/Y=;
  b=OUIE+rf0Ucp6WDVieI3+KWpnW+CEJPEHeqU8GPdWshLq5y3fwF9KEzu4
   HuGblH8O65pm8rBgfoU8SBXllC3B7KX2jwp0k1ManTXzCSqbEubnAVJUv
   EWTGcAc9nDYsnh0vVjr9y0bQmvYtm+fz7G5eAbp+gxV8QealTNh1kEWoW
   QGtDiyAUnbi7zMhb+LgbnHy3GHOaxJH5KXKwsHdstaxIgiJ7FHBKEkIYn
   GAAATccnZcN+2F06wFkxkSxPEsd9IAIXlHilh9uoLMk9FihPeOUWYLetx
   WTCgPP2zV6kx/0kp2e4RqUOXFGcWv3wRgzLqQg8h92jFLjDpJS1BNv3mV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="244555143"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="244555143"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 16:16:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="491693791"
Received: from richasha-mobl.amr.corp.intel.com (HELO [10.251.12.158]) ([10.251.12.158])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 16:16:42 -0800
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
References: <20220107181618.6597-1-kristen@linux.intel.com>
 <20220107181618.6597-3-kristen@linux.intel.com> <Ydm2Qk8JFwgdueZa@iki.fi>
 <fda3bb7bd557a37112a4f7c6c205871addda1bd3.camel@linux.intel.com>
 <ed190b80-75cb-3137-1d64-1a87e1ac930e@intel.com> <YeIN1RQydD1juJGA@iki.fi>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 2/2] x86/sgx: account backing pages
Message-ID: <087852d2-e325-7cb9-dec2-e4cdf7aa5729@intel.com>
Date:   Fri, 14 Jan 2022 16:16:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YeIN1RQydD1juJGA@iki.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/22 3:57 PM, Jarkko Sakkinen wrote:
> Would it be a too big tretch to add these and make the whole scheme
> fully legit? Does not sound like an extremely huge stretch and there is now
> a full cycle amount of time make it happen before 5.18 merge window.

No, it's not a big stretch.  If anyone wants it for 5.18 (or whatever)
just send the patch.
