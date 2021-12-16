Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA390478015
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 23:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbhLPWpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 17:45:34 -0500
Received: from ms.lwn.net ([45.79.88.28]:50980 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230462AbhLPWpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 17:45:33 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9E1CC35F;
        Thu, 16 Dec 2021 22:45:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9E1CC35F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1639694732; bh=XY7ZgJNb2HIM6hjHEx7BEMsrnxXQvsBUlrBoqAdjCqQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iTRhPf9HBIPZkQGjHQHZLgWFij98QTdAdXQNd/RM4kzIwZbHjPTbonaAE5RwpwLkL
         9EzeXVj35vx5YnXQQ4LGhtLEiSCiZ7g186o4nPsvWSeCr910rne+X03xMtIU/PFxjg
         5I+6tsN9GG9jZjprxtiemeAicpJ8enJxvlUPZPxBBK5flP9PvtHHBTdwyn4RCChCVR
         UPM0cWZDNxEIyLL4McZsHRWMUgolOOesejtC2ceYBbpHy55UDAJ8RRh7ZSQmEETFoM
         C9TVLjmbummgikIzR/p/LirSIwGOhD2qEV1T0lu4mGGv5Ptsg3bvVq7ZrAL0DHo8UG
         mEPqqBWmsc75A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Remove mentions of the Trivial Patch Monkey
In-Reply-To: <20211214191415.GA19070@kernel.org>
References: <20211214191415.GA19070@kernel.org>
Date:   Thu, 16 Dec 2021 15:45:32 -0700
Message-ID: <87bl1gdv8z.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <ojeda@kernel.org> writes:

> Apparently, it was decided that trivial@kernel.org
> is no longer used.
>
> Link: https://lore.kernel.org/lkml/fe86efbd-4e03-76c8-55cf-dabd33e85823@infradead.org/
> Co-developed-by: Joe Perches <joe@perches.com>
> Signed-off-by: Joe Perches <joe@perches.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> Sending this before we forget about it...
>
> We may want to keep the definition of "trivial patch" somewhere else.
>
>  Documentation/process/submitting-patches.rst | 19 -------------------
>  MAINTAINERS                                  |  6 ------
>  2 files changed, 25 deletions(-)

It looks like the last pull from the trivial tree was bbf625990371 in
October 2020 so yes, this looks like a patch whose time has come.
Applied, thanks.

jon
