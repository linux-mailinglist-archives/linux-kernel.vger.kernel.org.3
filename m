Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BE446D2D1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhLHL7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:59:38 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52936 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhLHL7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:59:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4EA56CE2139;
        Wed,  8 Dec 2021 11:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEE9C00446;
        Wed,  8 Dec 2021 11:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638964560;
        bh=dtGHTgWZlbuMm61YrhQo6+ddJ3mmWftzhKp82GbBfAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uY1GcQC8yCidx5FgBs+Hi0PYwSpmbut7uuRlMn8SKivKgmEpzPvct7+9iDIIYyM+a
         c6JL73VXqy5S7OnG9bfKUm7pLv8SWe2gdpW0dsu/OTDcmNyZuP7Q7O66Z74QYkLOo1
         8RvlItxxeMWAHlhm/pgQsufIbSvCBo5MBcH1VVpg=
Date:   Wed, 8 Dec 2021 12:55:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@google.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] HID: usbhid: enable remote wakeup function for
 usbhid device
Message-ID: <YbCdTaGSKak1cdSh@kroah.com>
References: <1638956391-20149-1-git-send-email-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638956391-20149-1-git-send-email-zhuyinbo@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 05:39:50PM +0800, Yinbo Zhu wrote:
> The remote wake-up function is a regular function on usb hid device
> and I think keeping it enabled by default will make usb application
> more convenient. This patch is to enable remote wakeup function for
> usb hid device.

How many devices did you test this on?

As Oliver said, this will cause problems, there's a reason no operating
system does this :(

sorry,

greg k-h
