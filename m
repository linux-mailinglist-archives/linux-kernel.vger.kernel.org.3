Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD544A03D3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351748AbiA1WjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:39:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:44576 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232883AbiA1WjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643409554; x=1674945554;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=gsm2aOwb6oqC7RGmhI4aSaKffhQjcyGMmnJkDgTe5zs=;
  b=eG5qFqAxx/M62TWoJn5RsNSMae+FxiWdIHVzeJAmjXthZifkJYQK4C5T
   0n5gv6jGoT+JmrNcHHqZ/gZh3/CppAXgjqomiwXtitvtqLde1O4ZeEMDB
   ECmuuDi2bIczbnoyfA99XVAejStRZyI42KhVH5Gl3QnK02Ff8Ny3Ed6AD
   XBOEZ07gB25ucY2JjvUXkHvigOlnQo31ZnrfS1IQeI/2gZrtV2FLxk7qe
   jdDRavfF9Oh2RqT9GX1UO/mB9WAkuavyk7pvSFSlmCsmwofJKwC5h/Iq4
   YMAJdZNWqs4hGInJK4hpniVG/B0A4WN9H2OnaB1DJRm4JFOE21c2X+43n
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="244809915"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="244809915"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 14:39:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="697238834"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 14:39:13 -0800
Message-ID: <6d6866d3-fd1b-c232-0e4f-72dd9845026b@intel.com>
Date:   Fri, 28 Jan 2022 14:39:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.2
Content-Language: en-US
To:     ira.weiny@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-3-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 02/44] Documentation/protection-keys: Clean up
 documentation for User Space pkeys
In-Reply-To: <20220127175505.851391-3-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 09:54, ira.weiny@intel.com wrote:
> +PKeys Userspace (PKU) is a feature which is found on Intel's Skylake "Scalable
> +Processor" Server CPUs and later.  And it will be available in future
> +non-server Intel parts and future AMD processors.

The non-server parts are quite available these days.  I'm typing on one
right now:

	model name	: 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz

This can probably say:

Protection Keys for Userspace (PKU) can be found on:
 * Intel server CPUs, Skylake and later
 * Intel client CPUs, Tiger Lake (11th Gen Core) and later
 * Future AMD CPUs

It would be great if the AMD folks can elaborate on that a bit, but I
understand it might not be possible if the CPUs aren't out yet.
