Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7099348082B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 11:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhL1KIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 05:08:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45638 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhL1KIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 05:08:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AE7561177
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 10:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F02AC36AE7;
        Tue, 28 Dec 2021 10:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640686090;
        bh=5s8yEnGlwuI1LjeAvXcEW4ovaxhBa2RiNj55iZi6VRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=khMmhgDS8aT/Uopf6/mxO54PrhyzI9HycVoKH6Y56hQRPYiihCNeKbngeAqG7jpp+
         TGi40Lh8bBNrgOSO0BZIoeXEwcuSHuvc1Bd0EHw5/8y4SjyKm/T6qqGsiPsIMyUCDs
         LFTIDm4wSWBAQQnigT+4t5vXYzz8EAe9uvfxUDbs=
Date:   Tue, 28 Dec 2021 11:08:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wedson Almeida Filho <wedsonaf@google.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kobject: remove kset from struct kset_uevent_ops
 callbacks
Message-ID: <YcriB2fJM2O5NQIZ@kroah.com>
References: <20211227163924.3970661-1-gregkh@linuxfoundation.org>
 <YcolAAn+fnXy05Cz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcolAAn+fnXy05Cz@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 08:41:36PM +0000, Wedson Almeida Filho wrote:
> On Mon, Dec 27, 2021 at 05:39:24PM +0100, Greg Kroah-Hartman wrote:
> > There is no need to pass the pointer to the kset in the struct
> > kset_uevent_ops callbacks as no one uses it, so just remove that pointer
> > entirely.
> 
> In the future, if someone needs the kset they can always find it by looking for
> the first non-null kset in the kobject or its parent chain, right? IOW, we're
> not losing any information by removing this.

Or even easier, we can add it back if needed :)

> > 
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Wedson Almeida Filho <wedsonaf@google.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Reviewed-by: Wedson Almeida Filho <wedsonaf@google.com>

Thanks for the review.

greg k-h
