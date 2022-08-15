Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5E3592A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 09:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbiHOHSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241537AbiHOHRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:17:42 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDB11FCF4;
        Mon, 15 Aug 2022 00:16:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 62B604A8;
        Mon, 15 Aug 2022 09:16:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1660547763;
        bh=ICSDU9K7qwcViEnvudwhEwZPF+MenD3Ujks/vSlFlec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2KE1ujQqiX7tepqW60r5VPMd4B1x6CiQUXM93VmaWBYjT2o6dSyzWdSA1ruNB+oX
         lNDCa8I82CeD7uSqWO7f+0NFHtym43ZaxPmLRu+WAvPwk76ocYZModmAU2QNFAkEGy
         UOXldnQFEsgX/6DBhQlZBmeqpjZ/UfD+0XXh2d6A=
Date:   Mon, 15 Aug 2022 10:15:49 +0300
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
Message-ID: <YvnypQSy2NadLfo/@pendragon.ideasonboard.com>
References: <52c87d91-422d-fca0-4dd5-bbaa559c81b6@molgen.mpg.de>
 <YvUKLbv/pOfbbeL+@pendragon.ideasonboard.com>
 <YvUaEDMbZD70x+hD@kroah.com>
 <YvUbhx4HSxAAwIvv@pendragon.ideasonboard.com>
 <YvUghWZbXIUofg5A@kroah.com>
 <YvmqL6Wz7o77ukF5@google.com>
 <YvnpVmnROTsWWw0o@kroah.com>
 <YvnrJBI8599+E43T@google.com>
 <YvnvnL9pBAgWMgTk@kroah.com>
 <YvnwtN1SwQjilJ97@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvnwtN1SwQjilJ97@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 04:07:32PM +0900, Sergey Senozhatsky wrote:
> On (22/08/15 09:02), Greg KH wrote:
> [..]
> > > We haven't sent out KCAM for upstream review yet. It's open sourced,
> > > as of this moment [1], but we still need some time and wanted to convert
> > > one of the previous generations of IPU drivers (IPU3) to KCAM first to
> > > see if everything is working as we wanted it to.
> > 
> > That didn't answer my question on when you were planning to actually
> > submit this :)
> 
> Definitely not today. Someday, for sure :)
> 
> I don't want to promise any timelines. But we are certainly not
> talking "weeks", we are talking "months". Several months is a
> realistic timeline.

If I were to bet, I'd say no less than a year :-) And even then, as
stated separately, you'll have to convince the upstream community that
the API is suitable. It would be best to work with upstream today on a
proposal that please all parties, and not wait a year for a full
implementation to be ready, submitted, and rejected.

-- 
Regards,

Laurent Pinchart
