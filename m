Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF01E592A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbiHOH77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiHOH76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:59:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499881DA73;
        Mon, 15 Aug 2022 00:59:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D157760EDA;
        Mon, 15 Aug 2022 07:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAFCC433D7;
        Mon, 15 Aug 2022 07:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660550396;
        bh=5EU6qs7xlXyiMpJOkGkhtfjVZtM9FQ/+Wly1q0cPMm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MHFbiOjb8yuYncVhkPi7blHRwdIutUGK0EZFdxmXvGqBbkcwOoxtSPziHArNrnIpG
         VJSO5oA3xAdebJTr7lWOSZmxq8aNeujOi+GseFS9wOuGLXdKjEXrWTRo7cfcR57Q4F
         uIfins+0BpUXz2GvaqftpRA3izAlknZrTTgNyeWI=
Date:   Mon, 15 Aug 2022 09:59:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
Message-ID: <Yvn89i6xXSnICxBB@kroah.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvn0o96K8j5gRaWM@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

I would recommend this, as you all have been talking about this for a
very long time now with no actual code submissions anywhere (which is
what actually matters).  Waiting even longer feels like you are just
delaying the real work that has to be done, and it prevents hardware
that people have now from ever being supported in the device's lifetime.

But hey, what do I know about getting code upstream :)

good luck!

greg k-h
