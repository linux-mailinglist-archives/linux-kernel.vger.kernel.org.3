Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91E7472E45
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbhLMN50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:57:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53486 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbhLMN5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:57:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65EA7B80EDA;
        Mon, 13 Dec 2021 13:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6666C34601;
        Mon, 13 Dec 2021 13:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639403843;
        bh=uc7ff8Hn/mIN2KD8gQ8R8F4i+r16CAJPxpK3YrEF8DY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AS9YYf8Zl53jEKRfD1e/37/b7kd9FWyYjku2I757Csb/hxla6JyKhXTrLUTHOXbwn
         CCUogiDmXwa1vjqazi9vIBzZHs9QrjBzzz7ijsHyC/hmMGwELgc7gvdBQRP9Z4HsGc
         Wf/rQ3nRnOyYfa3LYFZVLFJyOc6otJKJGId3vZ4U=
Date:   Mon, 13 Dec 2021 14:57:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
Subject: Re: [PATCH v3] usb: host: xhci-plat: Set XHCI_SKIP_PHY_INIT quirk
 for DWC3 controller
Message-ID: <YbdRQP6B9Ypee5va@kroah.com>
References: <1638339338-6731-1-git-send-email-quic_c_sanm@quicinc.com>
 <1638339338-6731-2-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638339338-6731-2-git-send-email-quic_c_sanm@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:45:38AM +0530, Sandeep Maheswaram wrote:
> Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
> Runtime suspend of phy drivers was failing from DWC3 driver as
> runtime usage value is 2 because the phy is initialized from
> DWC3 core and HCD core.
> DWC3 manages phy in their core drivers.
> Set this quirk to avoid phy initialization in HCD core.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
>  drivers/usb/host/xhci-plat.c | 3 +++
>  1 file changed, 3 insertions(+)

What changed from previous versions of this patch?  That goes below the
--- line always, right?

Please fix up and send a v4.

thanks,

greg k-h
