Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D9B494222
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244126AbiASU4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:56:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:8898 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbiASU4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642625770; x=1674161770;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=y1cV4Lb9fxtwCX9YG0G8GKSznGdZtvMh/DK8DOsgMe4=;
  b=GDZbAqY21W2f/xSlZ7gYyy3fvtPXVTinV8sF5pF0LmsIdQhNysmhIWig
   8Y7xTYlejvLKWhRQStcEWFbfM5CqLvWKC3pHSccWWI1ZlpuCP9Rhjr/Vf
   CaaXwA8rbEvzoLvV1u9tLy/D/2iWx9Npc37iCpfdNUkKj41or94p+QWYV
   fQ8QZuivICUzE7qwSVmZahFM7lGkMYdITg3w32PDaumuJx57/jhbhRwwL
   YNqf0ytoldxxk635lCHn+ureneb8AUr1UA1xOVT50nAO8/LSVXPCC1pFE
   nQg7/Z2Zy9eOUhdZrddf+XLESLk27XOcbkZjv3Rtgd8eOQM4QbTCBu6hs
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="225169853"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="225169853"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 12:56:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="475281851"
Received: from rbschuch-mobl.amr.corp.intel.com (HELO [10.212.238.54]) ([10.212.238.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 12:56:09 -0800
Subject: Re: [PATCH] x86/sgx: Add poison handling to reclaimer
To:     Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
        dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <ef74bd9548df61f77e802e7505affcfb5159c48c.1642545829.git.reinette.chatre@intel.com>
 <9cefa244-9830-c158-6112-b2c61a464632@intel.com>
 <effafec4-affc-297b-4b0e-aeca1884fa4f@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Message-ID: <6548bb1e-ba03-6526-0d1b-87ff5e1a8170@intel.com>
Date:   Wed, 19 Jan 2022 12:56:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <effafec4-affc-297b-4b0e-aeca1884fa4f@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/22 12:47 PM, Reinette Chatre wrote:
> Thank you very much for the detailed analysis. Should I resend with
> an improved commit message that contains your scenario description
> and summary?

Sure, that would be great.
