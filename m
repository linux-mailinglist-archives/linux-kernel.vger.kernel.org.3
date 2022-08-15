Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C140C592CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiHOJsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiHOJsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:48:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808411928A;
        Mon, 15 Aug 2022 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660556883; x=1692092883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5HKCH4O0bBjUQ4CJMFr5S9IVFYJeJKt+nQHJ005r+KE=;
  b=EL5x6lFawp4ulq8jsNWnRwlpuCsp2COsPdjBp3cgq2sWzBwq8rCY1wqO
   C0I+midTm69eYheBME+D8mNkGS1trtu0VJyiQM0flQMSH27XWxouabOf3
   wc6Z6bzyXdVyYC8Q3164KIXnX1WW11fTzD16QvlFBr8BNFcmHhlcVGq/n
   a3NFED9er9H7xhTaPJeJQ2gYzBpulElcVr5oP+oSDtdfAESIfIqoeupQT
   1lTxaF+Fl9M1kFEA/h1BxDJYSP5ljULKVNBYlFRslksUKSC9/apAcFs+P
   kpTyq/XEyhJrsticTBMa7xPmZqw5fk5m5xU93gZVXNQ6NnwEkqDr1M7SX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="378216538"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="378216538"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 02:48:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="557232506"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 02:47:57 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id A1C802017A;
        Mon, 15 Aug 2022 12:47:55 +0300 (EEST)
Date:   Mon, 15 Aug 2022 09:47:55 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Wang Yating <yating.wang@intel.com>,
        Christoph Jechlitschek <christoph.jechlitschek@intel.com>,
        Hao Yao <hao.yao@intel.com>, Andy Yeh <andy.yeh@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-media@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>,
        Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@google.com>,
        Andy Whitcroft <apw@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christian Schaller <cschalle@redhat.com>,
        Wouter Bolsterlee <wouter@bolsterl.ee>,
        Miguel Palhas <mpalhas@gmail.com>, it+linux-media@molgen.mpg.de
Subject: Re: Missing MIPI IPU6 camera driver for Intel Alder Lake laptops
Message-ID: <YvoWSyWmmLvbW4Mr@paasikivi.fi.intel.com>
References: <52c87d91-422d-fca0-4dd5-bbaa559c81b6@molgen.mpg.de>
 <YvUKLbv/pOfbbeL+@pendragon.ideasonboard.com>
 <YvUaEDMbZD70x+hD@kroah.com>
 <YvUbhx4HSxAAwIvv@pendragon.ideasonboard.com>
 <YvUghWZbXIUofg5A@kroah.com>
 <YvmqL6Wz7o77ukF5@google.com>
 <YvnpVmnROTsWWw0o@kroah.com>
 <YvnrJBI8599+E43T@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvnrJBI8599+E43T@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Mon, Aug 15, 2022 at 03:43:48PM +0900, Sergey Senozhatsky wrote:
> On (22/08/15 08:36), Greg KH wrote:
> > On Mon, Aug 15, 2022 at 11:06:39AM +0900, Sergey Senozhatsky wrote:
> > > On (22/08/11 17:30), Greg KH wrote:
> > > > On Thu, Aug 11, 2022 at 06:08:55PM +0300, Laurent Pinchart wrote:
> > > > > On Thu, Aug 11, 2022 at 05:02:40PM +0200, Greg KH wrote:
> > > > > > On Thu, Aug 11, 2022 at 04:54:53PM +0300, Laurent Pinchart wrote:
> > > > > > > For the time being, I agree with your recommendation to not buy these
> > > > > > > devices if you care about camera support.
> > > > > > 
> > > > > > I second this, don't buy these devices if the vendor is not willing to
> > > > > > get their drivers upstreamed properly.
> > > > > 
> > > > > "Not willing" may be a bit too harsh here. I wouldn't just blame Intel
> > > > > for not upstreaming a driver if it turns out that the V4L2 API isn't a
> > > > > good match and we have no proposal to provide an alternative.
> > > > 
> > > > Did they propose an alternative?  From what I saw here they didn't even
> > > > attempt it, or did I miss that?
> > > 
> > > The plan here is to land CAM kernel API first and then switch IPU
> > > (driver and user-space) to it so that upstreaming for Intel will
> > > be easier.
> > 
> > And what is the timeframe on the plan?  Where will these changes be sent
> > to for review?  I'm guessing they are already in a shipping device so
> > what's the delay?
> 
> We haven't sent out KCAM for upstream review yet. It's open sourced,
> as of this moment [1], but we still need some time and wanted to convert
> one of the previous generations of IPU drivers (IPU3) to KCAM first to
> see if everything is working as we wanted it to.
> 
> [1] For everyone who is curious, our first public KCAM version can
> be found here:
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3668500/

Thanks for the URL.

Looking at the code, I wouldn't have guessed this is an API for cameras if
I hadn't been told so. I expect changes, possibly major changes, in the API
as well as the underlying framework will be needed for upstreaming. The
exact API toward user space that is required to make use of the camera
related hardware doesn't seem to be there, nor there seem to be any
in-kernel API for exchanging information between drivers.

Having said that, I don't want to judge this too harshly (e.g. without
documentation that supposedly will be written?) at this point as it is not
meant for upstream review yet. Drivers for actual hardware would tell more,
too.

-- 
Regards,

Sakari Ailus
