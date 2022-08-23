Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BD859D538
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 11:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241459AbiHWIiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 04:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347102AbiHWIgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:36:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F86C76753
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661242636; x=1692778636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FFUrJBNMDk4t826TIAG649CcdossiWD3s3+Wk/wmhH4=;
  b=PRMh7gJkry/Afvp1QLjCsrbIh/DPNl+OA/nwRPuxD5Qegn0jV0GohQ6v
   PTvzSPciN5D8WlWg1txrQXIvrEtMAaSxWh39dDtSYBBjtaYV0JTuwUyrQ
   zFMfYJ8jtia9IkiPtFm7/MsJ4kjNeF3ckdeqTGdwUXp8/rIq4z9qjJFTX
   odOkMBJHhO1vph2v8HitrbDIXG2YB0GK18jMnNaO3pymYMHC4S65VlM0h
   9rg/BAGvQaDYWv1JItqFFeuKtqfY5R/UPa2l3WJiG7HEvUxtYj0M1G6MY
   ES5E+cb7DiVRdaXJhzHALyedCz/23IfekpYtf1zqLRDXBXZqUE/sR6wd/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="291183216"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="291183216"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 01:17:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="751606026"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 23 Aug 2022 01:17:12 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 23 Aug 2022 11:17:12 +0300
Date:   Tue, 23 Aug 2022 11:17:12 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 3/4] platform/chrome: cros_ec_typec: Stash port driver
 info
Message-ID: <YwSNCFt48Q9Eo02I@kuha.fi.intel.com>
References: <20220819190807.1275937-1-pmalani@chromium.org>
 <20220819190807.1275937-4-pmalani@chromium.org>
 <YwRa/QxA/RRtxU3P@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwRa/QxA/RRtxU3P@google.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 04:43:41AM +0000, Tzung-Bi Shih wrote:
> On Fri, Aug 19, 2022 at 07:08:04PM +0000, Prashant Malani wrote:
> > Stash port number and a pointer to the driver-specific struct in the
> > local Type-C port struct.
> > 
> > These can be useful to the port driver to figure out how to communicate
> > with the ChromeOS EC when an altmode driver related callback is invoked
> > from the Type-C class code.
> 
> The patch looks good to me.  But I would suggest to send it in later series
> that uses the driver-specific struct (e.g. in altmode driver related callbacks)
> to make the usage clear.

I agree.

thanks,

-- 
heikki
