Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533104F6496
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiDFP70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237626AbiDFP6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:58:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3F81DAFAE;
        Wed,  6 Apr 2022 06:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649251618; x=1680787618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WF1HvcsVVqyktKdAryVugil0ulYIc/PoWyEBOj0iOIw=;
  b=ePk+eMQz3LB9B2gHljZ6P93TFVbQOFKURh5yYIsv0LvJtxdYW08dOTi+
   +DUMK3ot5kZEqohpfge9H6zNwmgKeLVqQWzja/RfKHFg6b8j+1VKe69v5
   YyJZPHGou0ZnyWHu2mzuzHIhJlGDBIxomLpA6u77b8SZOPb2TBp3/xkEY
   G1rBeAIU1GI8nn8uDaRL4ReuvGcG8Vy8mYfAyFLaBZe+uE1aSuNAvEeUx
   nBWUACz8Ojf9xocQEkmLzRWG7ARfeNu5k54RTFIpF80bpyl6vmVDh5KBZ
   GBDeJd6hOTnqFbxmXoXqnADXzcJbE/wlhval2RA5jKJj9mh4mPAsBbcqg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="240973919"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="240973919"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:26:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="549542879"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:26:52 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 9E71020371;
        Wed,  6 Apr 2022 16:26:49 +0300 (EEST)
Date:   Wed, 6 Apr 2022 16:26:49 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v5 2/4] device property: Introduce
 fwnode_for_each_parent_node()
Message-ID: <Yk2VGaBVgMbvAgt6@paasikivi.fi.intel.com>
References: <20220406130552.30930-1-andriy.shevchenko@linux.intel.com>
 <20220406130552.30930-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406130552.30930-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Apr 06, 2022 at 04:05:50PM +0300, Andy Shevchenko wrote:
> In a few cases the functionality of fwnode_for_each_parent_node()
> is already in use. Introduce a common helper macro for it.
> 
> It may be used by others as well in the future.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Until patch 4:

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
