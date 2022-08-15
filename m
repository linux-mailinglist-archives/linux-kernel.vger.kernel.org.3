Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F0D592AD1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiHOHk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240918AbiHOHkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:40:42 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1005E5F72;
        Mon, 15 Aug 2022 00:40:41 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1100348F;
        Mon, 15 Aug 2022 09:40:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1660549239;
        bh=re86Dl7l8xNna/q8VWonpSa51oBqjSbd45pb7M9d+nE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KfwIFaB9bQBr8WqZKH8yhx2WJOkjnZJ9Rl7bccom6jlIb5oJrY09fysur4L5sAIvH
         siQrw6Qi1c4UThTbcjZTuB/EUwf+RWGrdu/9PgR44yOLKkOIxs5Q7bSjqIXHmsmQRV
         GRDBKSc6Z2TUbs7IC0uSXmXCmJdycuC4SvxXfQ14=
Date:   Mon, 15 Aug 2022 10:40:26 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Wang Yating <yating.wang@intel.com>,
        Christoph Jechlitschek <christoph.jechlitschek@intel.com>,
        Hao Yao <hao.yao@intel.com>, Andy Yeh <andy.yeh@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
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
Message-ID: <Yvn4aiVLzFMneZCc@pendragon.ideasonboard.com>
References: <YvUaEDMbZD70x+hD@kroah.com>
 <YvUbhx4HSxAAwIvv@pendragon.ideasonboard.com>
 <YvUghWZbXIUofg5A@kroah.com>
 <YvmqL6Wz7o77ukF5@google.com>
 <YvnpVmnROTsWWw0o@kroah.com>
 <YvnrJBI8599+E43T@google.com>
 <YvnvnL9pBAgWMgTk@kroah.com>
 <YvnwtN1SwQjilJ97@google.com>
 <YvnybHVFmpUJs4qi@kroah.com>
 <Yvn0o96K8j5gRaWM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yvn0o96K8j5gRaWM@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 04:24:19PM +0900, Sergey Senozhatsky wrote:
> On (22/08/15 09:14), Greg KH wrote:
> > > Definitely not today. Someday, for sure :)
> > > 
> > > I don't want to promise any timelines. But we are certainly not
> > > talking "weeks", we are talking "months". Several months is a
> > > realistic timeline.
> > 
> > Ok, so getting this merged is a good year out at the best, realisticly 2
> > years given that once you submit the first version for review, the real
> > work will start happening.
> 
> Well, nothing is really set in stone here. We may revisit our strategy,
> say turn it upside down, and hit upstream mailing list as soon as possible
> instead.
> 
> > So I'll stick with my original statement, don't buy this hardware
>   ... if you plan on running vanilla kernel. Otherwise do buy :)

If you want to run a proprietary OS.

-- 
Regards,

Laurent Pinchart
