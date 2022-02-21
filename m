Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D94B4BDF78
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354057AbiBUP2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:28:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbiBUP2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:28:47 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8171EADC;
        Mon, 21 Feb 2022 07:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645457304; x=1676993304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JUcPsxukRA89Us88NA45JNRiX3MleJVSUnflr5fGvOA=;
  b=ECQo3OBu16j7krla/tOxzrft5QudNFBdcTpxlFLPtYAAetvuVc37f94S
   Y4SspKO2C14UV+WgEOT8dprVqV6fv4Jrix5slzT1HGq6+FQjqEBXsP8LQ
   st1Jv+ClWl2m/JbAoRBvr7NiqSE73FRG8flKghuiXDHmDFh9XWIzAVHgg
   G5M8RdBMgVnZJmHM41tIMxHwp/1w248EibXWvnUU8dnfbt5GUHKyV2JFY
   AVNFsJSXnI1mqyrpVZhfAhiwoo5oPKyjiUOsAb7vJ6AXKomqRxKqzpMQb
   dYlRzNUQV5J5Xzdh+dB6h4+gha0in/GLn9jHO2tZT0ygWtmk8gGVgjz4W
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="314789476"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="314789476"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 07:28:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="706288769"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 07:28:21 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 21 Feb 2022 17:28:19 +0200
Date:   Mon, 21 Feb 2022 17:28:19 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 3/4] pinctrl: alderlake: Add Intel Alder Lake-N pin
 controller support
Message-ID: <YhOvk13YNiZMXtPB@lahna>
References: <20220215152800.21104-1-andriy.shevchenko@linux.intel.com>
 <20220215152800.21104-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215152800.21104-3-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 05:27:59PM +0200, Andy Shevchenko wrote:
> This change driver adds pinctrl/GPIO support for Intel Alder Lake-N SoC. The
> GPIO controller is based on the next generation GPIO hardware but still
> compatible with the one supported by the Intel core pinctrl/GPIO driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
