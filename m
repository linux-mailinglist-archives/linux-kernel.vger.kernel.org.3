Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86A958FED3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbiHKPJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKPJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:09:11 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E576F549;
        Thu, 11 Aug 2022 08:09:10 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CD53E49C;
        Thu, 11 Aug 2022 17:09:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1660230548;
        bh=9KDwvbHDtDSz0ZfcYcpfHO4/RJaEHreHeeodbjYv1Ek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ew2BMaPPNoYfojHV48Gl46DCVC8jrL5AuY8W/eimNln4QTqr6MIrREknhwhd0Niua
         zGBqq8sIOyGjDoLFlswIxkRlkjY00GKQj9FTc8ERYd3165+NKuR95+91/xW6pd/F3z
         j9HZfpZnY8i4N1jAVPpddp+BAByWBsv4iYKzpxw4=
Date:   Thu, 11 Aug 2022 18:08:55 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Wang Yating <yating.wang@intel.com>,
        Christoph Jechlitschek <christoph.jechlitschek@intel.com>,
        Hao Yao <hao.yao@intel.com>, Andy Yeh <andy.yeh@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-media@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>,
        Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christian Schaller <cschalle@redhat.com>,
        Wouter Bolsterlee <wouter@bolsterl.ee>,
        Miguel Palhas <mpalhas@gmail.com>, it+linux-media@molgen.mpg.de
Subject: Re: Missing MIPI IPU6 camera driver for Intel Alder Lake laptops
Message-ID: <YvUbhx4HSxAAwIvv@pendragon.ideasonboard.com>
References: <52c87d91-422d-fca0-4dd5-bbaa559c81b6@molgen.mpg.de>
 <YvUKLbv/pOfbbeL+@pendragon.ideasonboard.com>
 <YvUaEDMbZD70x+hD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvUaEDMbZD70x+hD@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 05:02:40PM +0200, Greg KH wrote:
> On Thu, Aug 11, 2022 at 04:54:53PM +0300, Laurent Pinchart wrote:
> > For the time being, I agree with your recommendation to not buy these
> > devices if you care about camera support.
> 
> I second this, don't buy these devices if the vendor is not willing to
> get their drivers upstreamed properly.

"Not willing" may be a bit too harsh here. I wouldn't just blame Intel
for not upstreaming a driver if it turns out that the V4L2 API isn't a
good match and we have no proposal to provide an alternative.

This being said, I agree it's the vendor's responsibility to at least
engage with the upstream community to find a solution, and collaborate
on the implementation. I'm sure there have been way more private
discussions than I'm aware of, maybe now is the right time to extend
this to a wider audience and create a realistic plan on how to move
forward. You all know my e-mail address :-)

-- 
Regards,

Laurent Pinchart
