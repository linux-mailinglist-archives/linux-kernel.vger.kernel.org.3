Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0014662B4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346595AbhLBLwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:52:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35046 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346444AbhLBLwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:52:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D931B82219;
        Thu,  2 Dec 2021 11:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A374C00446;
        Thu,  2 Dec 2021 11:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638445735;
        bh=3OK9lQqhE4ja8XLvy9A3QXANA8lGZ+D97DPx60FVvhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cow/1JKZu3tc7qIA3kBtCa6CT78Nrx0cxOdoWwwvrdLMUG0G5r0Iac8M9zBYkdQrM
         4ErrcRCU9t4gWipvcMVkszk/TzYxEqSjgidiRZDhlYbHOaeVyGB63C9WnSpT3/7aBR
         6b6BGEeT+fdbnQPXBU6UcUyJId+ZIjbquBFcQuO8=
Date:   Thu, 2 Dec 2021 12:48:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] HID: followup of uhid crashes, and couple of core
Message-ID: <YaiypPqBRtHDjmMs@kroah.com>
References: <20211202095334.14399-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202095334.14399-1-benjamin.tissoires@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 10:53:30AM +0100, Benjamin Tissoires wrote:
> Hi,
> 
> this is a followup of Greg's series[0].
> hid-sony is having a wrong error path leading to unreleased
> hidraw nodes, and bigbenff is having a crash when used with
> a wrong report descriptor in uhid.
> 
> Those 2 first patches should IMO go into 5.16.
> 
> The 2 others are some core changes I had locally stacked and
> which should be ready to go now. They can be scheduled for 5.16
> or 5.17, there is no rush for them.
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
