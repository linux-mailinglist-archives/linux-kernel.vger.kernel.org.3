Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1994812C8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 13:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbhL2MnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 07:43:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:45144 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233041AbhL2MnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 07:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640781788; x=1672317788;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FBeOiiXbo9xt2uvSuadtwYzq7Tas/R4x4QpB8J5b8cs=;
  b=OzNLwWluFH7hgP6RCx8a06+dh58r3pH722e1T5zQVIeGcPTHf/lk0jHS
   CxcoBw6LoX351Hfph0ISFINSX1ukMWKSdf/y8ZRy9QW33kvQHG7ENUcU+
   nxjPoGfu6l/+2aohzq9tqFNVD/7i9ncMDIUrE7ddDNisdtwwuDm6MttJa
   443g4LJbVYCRhR+vOWdt0sXkBrUDRCTaAGDwgUK8AE3stGoSfEK/uhnGK
   g8ZpwAOho/jBRx30juiI3vm2oak02i8tX6b/wlU8oOxi0mUV41oH2W8O3
   94Cj5S1isud7QWrj+oSz58s7yD4/GrgS65+2sKDBVMFiseh7MybegYaxb
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="221510210"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="221510210"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 04:43:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="524810862"
Received: from mylly.fi.intel.com (HELO [10.237.72.50]) ([10.237.72.50])
  by fmsmga007.fm.intel.com with ESMTP; 29 Dec 2021 04:43:05 -0800
Message-ID: <937ea94e-c80d-5feb-b03d-1c4d1cfc5f31@linux.intel.com>
Date:   Wed, 29 Dec 2021 14:43:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH v2 08/23] counter: intel-qep: Convert to counter_priv()
 wrapper
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Felipe Balbi (Intel)" <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-9-u.kleine-koenig@pengutronix.de>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20211227094526.698714-9-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 11:45, Uwe Kleine-König wrote:
> This is a straight forward conversion to the new counter_priv() wrapper.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/counter/intel-qep.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
