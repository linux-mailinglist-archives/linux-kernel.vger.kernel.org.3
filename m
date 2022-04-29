Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0085F514574
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356616AbiD2Jf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiD2JfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:35:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0663AC44EA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651224728; x=1682760728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kppcoXj5y75CTMRtENkNzbnrf3SLXeufYjqq0hRy8oc=;
  b=oC1Otlufe9xig8xuMIUgFGUBJ+D/HBC0iwIw0IuMoEBGa8Ufe82s9vv8
   f8k/EiRZqt5dA74ejmFeO1Jgv7XGbo1D5s+gRbQAyPXtsS5vAxYC8EuaM
   yqaZLo0G1KyjB1ULWLsbrxc3jnc4DHRugrITWJscVV/xSA4CQa5P4V5oI
   26X8VWTsL/smbUqrElTK22OW9gF9mf79C5iIbtP7uSOOzmJb3NubtzJyS
   8tly4OW2cQCw0KJQbs54iQUPe0aWfp5g6/KQOjJ6wfs69uywzOSyi2hgz
   CXM4IyO1RN9eVlAo4G05EFr3uDyja4OGNl1deY7gqh9jJJP5KO5XTfXFg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="246505689"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="246505689"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 02:32:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="662267242"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 02:32:04 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 29 Apr 2022 12:28:42 +0300
Date:   Fri, 29 Apr 2022 12:28:42 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Won Chung <wonchung@google.com>
Cc:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] thunderbolt: Link USB4 ports to their USB Type-C
 connectors
Message-ID: <Ymuvyujl+bwemc/I@lahna>
References: <20220418175932.1809770-1-wonchung@google.com>
 <Yl/l7gjRXj41a93q@lahna>
 <CAOvb9yidpOZ4jCjme+u1a4fPTRnLmxUHSTO3yHPPuYtDbe1V0g@mail.gmail.com>
 <YmDy/xEsyktRS6D+@lahna>
 <MW3PR11MB46517BE51D4DCBC02B463C0EEDF99@MW3PR11MB4651.namprd11.prod.outlook.com>
 <CAOvb9yhToxfT7cVzDX9cQhbRj0r2DXyuLJer64J8XSRJuUPcEg@mail.gmail.com>
 <CAOvb9yhPuNOM-HEb+fCfJPZ9kyxYZ9orT6u7BH_iiTU4XPWChg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOvb9yhPuNOM-HEb+fCfJPZ9kyxYZ9orT6u7BH_iiTU4XPWChg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 29, 2022 at 03:34:56AM +0900, Won Chung wrote:
> Hi Mika,
> 
> Tomas has given an ack on the first patch on MEI:
> https://lore.kernel.org/all/0136fcb26ca8433899593208af4351c9@intel.com/
> 
> Should I resend the patch with an additional "Acked-by" tag?
> Or could that be added as the patch is merged into the thunderbolt tree?

Both applied to thunderbolt.git/next, thanks!
