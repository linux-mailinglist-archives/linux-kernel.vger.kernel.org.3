Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148DB596AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiHQIJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiHQIJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:09:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972635246A;
        Wed, 17 Aug 2022 01:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660723763; x=1692259763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7V2eAuQLIZcUCjDa/C2tJLH5YdOup83v75Dbe0aJXCY=;
  b=beaC+GwRqHz/UkUX21z1AV2cuLmSVqkmTZcxL2/bcm8yVOfGMKUM22eF
   hPCuVrGspQZWMHSST28jwVIjPmREI7H5uFpNrQD+s3R9jiq5AM5Meqx7R
   HfYUH2iq9JP1qrnbj5n8DMUwXQg2REnroPFki/7N0RChU6+HGyxCTez0g
   xtlEWmEi3N+OyPtAl0cGtbCv3EsHesSOA5n1yp80qRyIQOg9asAYRqNXB
   teF7hGLM5pgcENPSIQqysntAhPHzg+VPk7zXRpei0yYa7nz6W4lXMHoeY
   xeQEnizuLr2BBD8miw6Y+KRSeF2agvGqQRISlaYcNV7rJoPztzjhiGaUd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="272826696"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="272826696"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:09:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="710459028"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:09:18 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 1954D2012E;
        Wed, 17 Aug 2022 11:09:16 +0300 (EEST)
Date:   Wed, 17 Aug 2022 08:09:16 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
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
        Miguel Palhas <mpalhas@gmail.com>,
        it+linux-media@molgen.mpg.de, "Hu, Jerry W" <jerry.w.hu@intel.com>
Subject: Re: Missing MIPI IPU6 camera driver for Intel Alder Lake laptops
Message-ID: <YvyiLHBgRQ9XsTrW@paasikivi.fi.intel.com>
References: <YvUKLbv/pOfbbeL+@pendragon.ideasonboard.com>
 <YvUaEDMbZD70x+hD@kroah.com>
 <YvUbhx4HSxAAwIvv@pendragon.ideasonboard.com>
 <YvUghWZbXIUofg5A@kroah.com>
 <YvmqL6Wz7o77ukF5@google.com>
 <YvnpVmnROTsWWw0o@kroah.com>
 <YvnrJBI8599+E43T@google.com>
 <YvnvnL9pBAgWMgTk@kroah.com>
 <YvnwtN1SwQjilJ97@google.com>
 <YvnybHVFmpUJs4qi@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvnybHVFmpUJs4qi@kroah.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Aug 15, 2022 at 09:14:52AM +0200, Greg KH wrote:
> On Mon, Aug 15, 2022 at 04:07:32PM +0900, Sergey Senozhatsky wrote:
> > On (22/08/15 09:02), Greg KH wrote:
> > [..]
> > > > We haven't sent out KCAM for upstream review yet. It's open sourced,
> > > > as of this moment [1], but we still need some time and wanted to convert
> > > > one of the previous generations of IPU drivers (IPU3) to KCAM first to
> > > > see if everything is working as we wanted it to.
> > > 
> > > That didn't answer my question on when you were planning to actually
> > > submit this :)
> > 
> > Definitely not today. Someday, for sure :)
> > 
> > I don't want to promise any timelines. But we are certainly not
> > talking "weeks", we are talking "months". Several months is a
> > realistic timeline.
> 
> Ok, so getting this merged is a good year out at the best, realisticly 2
> years given that once you submit the first version for review, the real
> work will start happening.
> 
> So I'll stick with my original statement, don't buy this hardware as the
> vendors don't seem to want to upstream the drivers any time soon :(

Do note that USB webcams in Alder Lake laptops still work as usual, with
the uvcvideo driver.

V4L2 + MC are not great APIs for supporting hardware such as IPU6 and
coming up with an alternative is a major and risky endeavour. I expect many
developers of drivers for similar hardware are in the same situation.

The hardware is getting increasingly complex and while there is some
standardisation in the industry, it's mainly focussed on interoperatibility
on hardware level rather than control interfaces or defining how a given
feature is to be implemented.

As the camera is no longer a single, integrated device in this context but
multiple devices from different vendors, there still remains a larger
requirement for interoperability between, at the very least, cameras and
CSI-2 receivers --- that in turn increasingly often are integrated in Image
Signal Processors such as IPU6. This further raises the bar for an
interface that would better support these devices.

This of course does not help the owners of such hardware but perhaps
explains the current state of affairs a little. Eventually we will need a
new kernel interface for this but at this point I can't tell whether it
will be based on KCAM Sergey mentioned, or not.

-- 
Regards,

Sakari Ailus
