Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9D6481B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhL3K0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:26:36 -0500
Received: from mga18.intel.com ([134.134.136.126]:49652 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231364AbhL3K0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640859994; x=1672395994;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nyIsod2gagapgELPeOcoGSSTv+FHCkLMzWoTvb3wU5U=;
  b=WqvWZxvIjK9it5R+JkRMmcsPYH/b7eVO5Z8/gsv7lq5dTi7nA4Kd0uhx
   lmzTMdTu5LHO52kT4jkvlmrRjeOx4h+wOJLRbQb4FCA+luh4rleQh9SZs
   n5I76EYPYwYR4lIH0CN11VFmoGGUkWXf3bkeQ7fPNngGpFI0l9ZT1ZU8K
   AbQk9cjAG9r8jUIFTIEhzpz7+/IVUpC6k3QXE6sMQ9FRPDmAT0PIOKmP7
   bJ4pbzy38W7GoFpEHatB2FgVW8IPzqT50uqZ9O692xOGnRbpijMTFkjwi
   gRGYKEIr/cb4KwstmsLHu5kWfKw6zcoZKFu2e27GlcH+lGDSMqjO86k6f
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="228478821"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="228478821"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 02:26:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="468775369"
Received: from mylly.fi.intel.com (HELO [10.237.72.50]) ([10.237.72.50])
  by orsmga003.jf.intel.com with ESMTP; 30 Dec 2021 02:26:31 -0800
Message-ID: <177da95c-32d5-4a14-4ec8-0462e63219a3@linux.intel.com>
Date:   Thu, 30 Dec 2021 12:26:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH v3 08/23] counter: intel-qep: Convert to counter_priv()
 wrapper
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
 <20211229154441.38045-9-u.kleine-koenig@pengutronix.de>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20211229154441.38045-9-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/21 17:44, Uwe Kleine-König wrote:
> This is a straight forward conversion to the new counter_priv() wrapper.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/counter/intel-qep.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
