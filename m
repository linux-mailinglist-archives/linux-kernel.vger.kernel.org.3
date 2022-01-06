Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD4548652B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239544AbiAFNVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:21:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41670 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239480AbiAFNUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:20:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A500861BFA;
        Thu,  6 Jan 2022 13:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF13EC36AED;
        Thu,  6 Jan 2022 13:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641475253;
        bh=nuTm14Clbi5xaTQDIqoEoE2Q4u4z4busb03ewz3lhfo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=L6irDWSKi9Kqk5pNMOoU+qfWBwCX9xYz3a9mi/gWk7TpHHhqEBs2qDJtM/Tb3jdDv
         Ul9BKeJ4dGkgXjZCJ+5Bku6kJDxsXGkMGEmqnpM+2eyMEYS56ot+hT7/PgJgMcr8j6
         yQfsAwMamH2giUgi2lwusAME195velAM5J8hYzP2qfH/7TDejHfq3IvRhHXfTRfccq
         s/xW4Go1IPfJL+hMYppAGlmnF4tiVY7BbtQnys6KLFR5qlW0e3EaB4fQ+H93Fnk//6
         bL5SgQN+P9eEoewNGRISCxuKjEB9/zo4Q35R5szJwDLZjXXphcI3nFoVzKdwN4XLSB
         IBjOgTCtsMYpw==
Date:   Thu, 6 Jan 2022 14:20:49 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
cc:     srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] HID: intel-ish-hid: ishtp-fw-loader: Fix a kernel-doc
 formatting issue
In-Reply-To: <20211216040146.89075-1-yang.lee@linux.alibaba.com>
Message-ID: <nycvar.YFH.7.76.2201061420430.16505@cbobk.fhfr.pm>
References: <20211216040146.89075-1-yang.lee@linux.alibaba.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021, Yang Li wrote:

> This function had kernel-doc that not used a hash to separate
> the function name from the one line description.
> 
> The warning was found by running scripts/kernel-doc, which is
> caused by using 'make W=1'.
> 
> drivers/hid/intel-ish-hid/ishtp-fw-loader.c:271: warning: This comment
> starts with '/**', but isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

