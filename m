Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F50E5A67CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiH3P5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiH3P5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:57:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C097B6D70;
        Tue, 30 Aug 2022 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661875036; x=1693411036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nyO3eXpBciEJYkjPPepKRjcZ/w25Y4N/Ho+bxQPdMgU=;
  b=HVAiyw3OSK0shxnPWsNOmHWfLJ48EqFUWhcWqIHsSToWNhlSaVwLPU2I
   7FZ3U2rS3KRIxLl/OU3DTtbt7Cut63sO6ZcbMBW/P+QHmh2DzyHLKZT8o
   XeiUcfjuXhf+MlSS/D+nVzsPd/UqQYG697PX2U2mKm+gkobwC0MzCVzC8
   ckyLeWKLIKOHk+KZ1IqLzsJ4/8dU6eZpsP3flBol+uQpK4l8siWMEFgtI
   zQjXPrzVfQ++4HniD//YBGA7Zh0xbDcD+jxfN6QqyzolAUWS5vDYGjNzU
   pxcNt4DMftG8gt0Fwk+9Kj4R7rVbxTstKOAFOxAnCFOz0lFh8DwNEZv/w
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="282185430"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="282185430"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 08:57:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="672920904"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Aug 2022 08:57:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C86B2AD; Tue, 30 Aug 2022 18:57:28 +0300 (EEST)
Date:   Tue, 30 Aug 2022 18:57:28 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/2] ACPI: PMIC: Use sizeof() instead of hard coded
 value
Message-ID: <Yw4zaBJu81SvkFMM@black.fi.intel.com>
References: <20220830135532.28992-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830135532.28992-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 04:55:31PM +0300, Andy Shevchenko wrote:
> It's better to use sizeof() of a given buffer than spreading
> a hard coded value.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
