Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909124AF48C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbiBIO4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiBIO4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:56:51 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AB2C06157B;
        Wed,  9 Feb 2022 06:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644418611; x=1675954611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gZVp1SFXDmzojOdSJLCC3hkHGqXR/geiUebczXiCVhk=;
  b=bn1JM14fbj0Sw0Ji+O5aOgfl4Vfszri5BvV3U/vuK24r+R6JPhOgQiO/
   8H//LOfMWaMZl5O1gLYEZneYA1dXwFkoWMpk+W/311EHPD+gUZJC2RKpW
   VYuQrACmlv9HmyCNk2QnBwoB+0383Tl/U3quHk9kQEGzo677kRtXA/dZr
   C4zeeGG/zWMsiXrB/MuEXsgXZ4Rewh3XPAgb4VEwd9knAbo+xyxklYrxi
   M2MmvHJ0f6nyge4TJlGXkltokLBY4IRciUN+o9uaiNIDr6hVEbavbGnN9
   UMbdoOxpX1QiecjMFhyyH5RjexjL9wpBD6eq36pMf5ZCmN02qtq0+0hD8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="249168374"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="249168374"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 06:56:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="678617764"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 09 Feb 2022 06:56:47 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 09 Feb 2022 16:56:46 +0200
Date:   Wed, 9 Feb 2022 16:56:46 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org,
        cy_huang@richtek.com, will_lin@richtek.com, th_chuang@richtek.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add Richtek RT1719 USBPD controller support
Message-ID: <YgPWLselefw3nGb8@kuha.fi.intel.com>
References: <1644415355-24490-1-git-send-email-u0084500@gmail.com>
 <YgPOz6pfpFcPmHms@kroah.com>
 <YgPQgtcO22W3vZDw@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgPQgtcO22W3vZDw@kuha.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 04:32:38PM +0200, Heikki Krogerus wrote:
> On Wed, Feb 09, 2022 at 03:25:19PM +0100, Greg KH wrote:
> > On Wed, Feb 09, 2022 at 10:02:33PM +0800, cy_huang wrote:
> > > 3. Change MODULE_LICENSE from 'GPL v2' to 'GPL'.
> > 
> > Why?  Either is fine, any specific reason you changed this?
> 
> Because I proposed it. I believe everything scripts/checkpatch.pl
> tells me.

It looks like the preference on "GPL" is pretty resent. Check commit
bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
bogosity").

thanks,

-- 
heikki
