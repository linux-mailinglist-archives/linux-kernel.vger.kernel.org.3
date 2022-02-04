Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBA94A9336
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 06:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiBDFH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 00:07:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:6046 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229887AbiBDFH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643951247; x=1675487247;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XecETcGGUIGkGEBT0bXd2PfTLwYCR9f3aPR9kUgy8ws=;
  b=ILwFxDcttwToX0i4Gl/3Jy8LKRrbIyDM/CjUx7HPNpPpdEYAcQGLAP3C
   3O9iP9uj3H/WMdxgWMs+e1yLP4VK0LGN7TQnT7+8k5OKg+BiadYzcdq58
   cG/kNSeCYe7MlfrX4r2AgBhheRNFtO8sVmZKZidktE8uUIXyQLk2C3ftq
   q+ZPI3wLkBFlbmxIkifTZ9NG/JrWd2JeshYLN5oZzQ/aRNthEgA3BA96+
   8u/VOInjrDqBdwculF1/eSKgRkNbfTwkS8212tTOz7H3m874nLyew2YJo
   +DxjOEYXHXsLxxXtQHmnTXxJ+2mc5JPK3A1ij2ERFMqr0CYRan82hvQtC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="228282948"
X-IronPort-AV: E=Sophos;i="5.88,341,1635231600"; 
   d="scan'208";a="228282948"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 21:07:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,341,1635231600"; 
   d="scan'208";a="699569434"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 03 Feb 2022 21:07:25 -0800
Received: from christi2-mobl.amr.corp.intel.com (unknown [10.212.180.188])
        by linux.intel.com (Postfix) with ESMTP id 2050558090D;
        Thu,  3 Feb 2022 21:07:25 -0800 (PST)
Message-ID: <1c14e0ce7d2a84f3b7f51abc22f140d6ea69b724.camel@linux.intel.com>
Subject: Re: [PATCH 1/3] platform/x86: Add Intel Software Defined Silicon
 driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hdegoede@redhat.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Date:   Thu, 03 Feb 2022 21:07:24 -0800
In-Reply-To: <Yfjz/CRUxeVGKaaQ@kroah.com>
References: <20220201030424.1068816-1-david.e.box@linux.intel.com>
         <20220201030424.1068816-2-david.e.box@linux.intel.com>
         <Yfjz/CRUxeVGKaaQ@kroah.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-01 at 09:49 +0100, Greg KH wrote:
> On Mon, Jan 31, 2022 at 07:04:22PM -0800, David E. Box wrote:
> > +static struct bin_attribute bin_attr_provision_akc;
> > +static struct bin_attribute bin_attr_provision_cap;
> 
> <snip>
> 
> > +static BIN_ATTR_WO(provision_akc, SDSI_SIZE_WRITE_MSG);
> 
> You the structure twice, why?

Will drop. There's no longer a reference to these attributes before they're
defined.

David

> 

