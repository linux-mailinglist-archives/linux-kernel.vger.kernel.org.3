Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1A246FEEA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 11:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbhLJKtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 05:49:11 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:34752 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbhLJKtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 05:49:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9850ECE2A74;
        Fri, 10 Dec 2021 10:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FADC00446;
        Fri, 10 Dec 2021 10:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639133131;
        bh=QuYWR3uX/ECWfu+ygs6k08ECNlcn3Z9H/GCcuArN908=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o0EvC7mo/d0yjjrI+kaTgtOyypAjDjWI1DPyz5HwQVlV9LKsGqLr1uYjvprdbzuWW
         OKf2h8tuyfz7lLvdQfEVG9B1G1EiMTTxDkp6lWzjhnyEOQMwMK33n8YFxiL6/Dl+bh
         sd0V529EoYohUCFopia3vF1wPgFiLUpAixLloHBU=
Date:   Fri, 10 Dec 2021 11:45:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        Thinh.Nguyen@synopsys.com, mathias.nyman@linux.intel.com,
        stern@rowland.harvard.edu, rajatja@google.com,
        chris.chiu@canonical.com, linux-usb@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] HID: usbhid: enable remote wakeup function for
 usbhid device
Message-ID: <YbMvyK111M/ZVRJG@kroah.com>
References: <1638956391-20149-1-git-send-email-zhuyinbo@loongson.cn>
 <YbCdTaGSKak1cdSh@kroah.com>
 <cc535d3d-6dcd-e69c-24e7-df54ce63c381@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc535d3d-6dcd-e69c-24e7-df54ce63c381@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:54:33PM +0800, zhuyinbo wrote:
> 
> 
> 在 2021/12/8 下午7:55, Greg Kroah-Hartman 写道:
> > On Wed, Dec 08, 2021 at 05:39:50PM +0800, Yinbo Zhu wrote:
> > > The remote wake-up function is a regular function on usb hid device
> > > and I think keeping it enabled by default will make usb application
> > > more convenient. This patch is to enable remote wakeup function for
> > > usb hid device.
> > 
> > How many devices did you test this on?
> > 
> > As Oliver said, this will cause problems, there's a reason no operating
> > system does this :(
> > 
> > sorry,
> > 
> > greg k-h
> Hi greg,
> 
> About that oliver said that I had expained, and I add this change was
> according that usb device whether support remote wakeup and if it support
> wakeup then to enabled it so I think it should be okay for all hid device.

Again, what devices did you test this on?

And look at other operating systems, as I said, there is a reason that
no one does this.

thanks,

greg k-h
