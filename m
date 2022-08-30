Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746335A67EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiH3QIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiH3QIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:08:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9BFF7B07;
        Tue, 30 Aug 2022 09:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661875694; x=1693411694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z0/Ubngx7Rd7BOFwF6Nv7y8NUPvSEx2rhy2J3cUSUqk=;
  b=icGeuF+GCrIT6iD5/50/L9kqm/z1O+EApORnk9e5VBue5dJ+a/eM8OZg
   YebevJNym6yXKQwjRzT9fWTCAr+RV1bf4LQi4oJFuY2VA84E0iVzdgOHq
   QZgBqasWV6uY5ucAyTLfAnZ3yoWI+fqst+wzSm7mb/TxAF4xFvGKrmyX4
   6Tzzszh1glmEGC1J0HM93b8n6FXTEynbD/BbDpzWjFONUvLYjPQLPkNss
   c/10YQ8w8GHck7j1iSBzcN0jRGqRXJscykc1f7GkzZYU4o4Un+iKsiFjJ
   tdJd3L4IM2UmMxBydc1JlUPBU6I2PEzdzxzRpHapI6U4eaxqJFBbPf8Tt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="295218911"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="295218911"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 09:05:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="680087910"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2022 09:05:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 13D11AD; Tue, 30 Aug 2022 19:06:02 +0300 (EEST)
Date:   Tue, 30 Aug 2022 19:06:02 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 2/2] ACPI: PMIC: Replace open coded be16_to_cpu()
Message-ID: <Yw41ai0mYHIgtgs4@black.fi.intel.com>
References: <20220830135532.28992-1-andriy.shevchenko@linux.intel.com>
 <20220830135532.28992-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830135532.28992-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 30, 2022 at 04:55:32PM +0300, Andy Shevchenko wrote:
> +
> +#include <asm/byteorder.h>

Isn't there <linux/byteorder/*> as well? Is there something that
prevents using it?

Otherwise looks good to me.
