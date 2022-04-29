Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20610514820
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358433AbiD2LbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358506AbiD2Laq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:30:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94430C6F1D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 04:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651231630; x=1682767630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3It1xK2fTiwxEih1Y0ZeBxu8tknG9TCjTzJzz5j6Qvg=;
  b=K7LMxY78aLtLx9wyj1GgpxJVmps73WXav4eDIujrvVSCLObt0MOegF+k
   +vjytdwrTT+rQD2UZt9epntm2e7S0l7hRsambfoyAZAt35WS+zWAPC6aq
   YGWUceqEovZd1rH0BMPa33R8khN5mFxDn3NVfI2pcbX3XUGYNYRtKpqR+
   wO5j19Vgu6llBWYNUhG1au6CJ0CbZY5feQwguvvCpgNuLYrfsUimqLGK4
   I0dRHthSTgve180SpQpxBGQO0HTwzqwZIfug6dWnNsrLS/aQCROA3OTDF
   KqFav5g3IoPXKp6C1rNtuVA+mBeBVxm9z0S0ln4BWRACE7IwoCiFBux4L
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="254001593"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="254001593"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 04:27:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="732018090"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 04:27:08 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 2F1E5200F1;
        Fri, 29 Apr 2022 14:27:06 +0300 (EEST)
Date:   Fri, 29 Apr 2022 14:27:06 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [sailus-media-tree:master 55/60] drivers/media/i2c/adv7180.c:573
 adv7180_test_pattern() error: uninitialized symbol 'reg'.
Message-ID: <YmvLio/xAD4OSgeY@paasikivi.fi.intel.com>
References: <202204290610.SVJgr8qV-lkp@intel.com>
 <CAOMZO5A-ZbMUM-17n2JPN2+w+DWLL9fnGwo2SrS=O024M4v0MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5A-ZbMUM-17n2JPN2+w+DWLL9fnGwo2SrS=O024M4v0MQ@mail.gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 07:57:41AM -0300, Fabio Estevam wrote:
> Hi Dan,
> 
> On Fri, Apr 29, 2022 at 7:30 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > tree:   git://linuxtv.org/sailus/media_tree.git master
> > head:   ea1280040a678f38a4ce6f1817933c04cfe74552
> > commit: f3b4b140d87dc7f256229f20a8d70429a7549aca [55/60] media: i2c: adv7180: Add support for the test patterns
> > config: microblaze-randconfig-m031-20220427 (https://download.01.org/0day-ci/archive/20220429/202204290610.SVJgr8qV-lkp@intel.com/config)
> > compiler: microblaze-linux-gcc (GCC) 11.3.0
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > smatch warnings:
> > drivers/media/i2c/adv7180.c:573 adv7180_test_pattern() error: uninitialized symbol 'reg'.
> 
> Thanks for the report.
> 
> This problem has been resolved in v3:
> 
> https://patchwork.linuxtv.org/project/linux-media/patch/20220427135025.3036234-1-festevam@gmail.com/

Yeah, my bad. I accidentally took v2. That's fixed now.

-- 
Sakari Ailus
