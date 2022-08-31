Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D215A75E4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiHaFok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiHaFof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:44:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0EBBA178;
        Tue, 30 Aug 2022 22:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661924674; x=1693460674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+b7Je6W8R4JcwKP8mHBHdpgIhO4wKzEYlnSQfOTz9bg=;
  b=JVQ3k1dF4pgq6fBeO0q1w/9dp7LwL9+1mO8lLsM7WooAFEzYEcHER0Pq
   /l8I0Em2n1o9+VOWqjzHWtXOpB3JC1VaC/zQ1eQCuaaAMCQ+QO6dXkcS9
   fsN6SjCcQfQGam9vq/KT38kXsPgvGTTYSVPMgx9T6bwZLYSTNm/z6DKBW
   MvBfxu35nXMcFStw9Jzw2M6tbZKf9+/EBRgy6qW6c37UOQdXdfUVv3Idj
   z57yclBFk6d/my6nfc03j7egx11VXkWyIoNaQXzlMtq4ZkCetRTQAlmh1
   NPSH8weNHs2J72O2znXA6w0tZYAw/j11MxuyzEcftOOBRyfG0rD0x/YH+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="321516084"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="321516084"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 22:44:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="940321779"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2022 22:44:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 53AECAD; Wed, 31 Aug 2022 08:44:47 +0300 (EEST)
Date:   Wed, 31 Aug 2022 08:44:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 3/3] ACPI: PMIC: Convert pr_*() to dev_*() printing
 macros
Message-ID: <Yw71T5OjE9+PmY2s@black.fi.intel.com>
References: <20220830171155.42962-1-andriy.shevchenko@linux.intel.com>
 <20220830171155.42962-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830171155.42962-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 08:11:55PM +0300, Andy Shevchenko wrote:
> Since we have a device pointer in the regmap, use it for
> error messages.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
