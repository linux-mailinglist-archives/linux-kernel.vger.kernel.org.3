Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A3D47BA0E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 07:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhLUGe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 01:34:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35844 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhLUGeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 01:34:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B64ADB81197
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4D1C36AE7;
        Tue, 21 Dec 2021 06:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640068463;
        bh=GqKv6SsDMyKQjlyuqv5ooOgCJHNhIUkebCCrAMLW5cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esqt9rPISh9ARptMMTKSJIn4DxJlXS8cfqNbruvlA1YFo3r99zqrwloD7dbJk5iLC
         vdc/IV9g4Tc2sK9YqSFNtTaDuB5zEhV9vTt2FcR0IV7aZXNQ/c9gjaPnYMFHW1JpXv
         5dP+d3VVn2CxdpQVO87kRI6fTWI9ZuKgbe/5NMM8=
Date:   Tue, 21 Dec 2021 07:34:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     linuxfancy@googlegroups.com,
        Forest Bond <forest@alittletooquiet.net>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: drop off byRxMode var in device.h
Message-ID: <YcF1baxVvP3j8Q/8@kroah.com>
References: <20211220202523.21805-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220202523.21805-1-tomm.merciai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 09:25:20PM +0100, Tommaso Merciai wrote:
> Drop off unused variable byRxMode in device.h, this fix following
> checkpatch.pl check:
> CHECK: Avoid CamelCase: <byRxMode>
> 131: FILE: drivers/staging/vt6655/device.h:131:
> unsigned char byRxMode

No need to line-wrap this.

But this "problem" is not the real thing you are fixing.  The real thing
is the issue that this variable is not needed at all.  Just say that, no
need to justify it with a checkpatch warning, right?

thanks,

greg k-h
