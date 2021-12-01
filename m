Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C63E4649E9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbhLAIpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:45:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41774 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbhLAIou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:44:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E04AB81E04;
        Wed,  1 Dec 2021 08:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B864C53FAD;
        Wed,  1 Dec 2021 08:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638348087;
        bh=dqdvLjyoOUa1sngUFu49cqxJu8V+OCGrT79b+MUdVIM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n6Yc0wgn7PMYwpmhoqox6qEZK/4Z8AbMv1EAVzPCMDleSlypRwU5C4sJQTOYFufUZ
         zW+mji2cNR2rWrNqeVML0GnL5uJaEzUEDK/VXGdq0CSq05l+ez9SboCCPuKBZuysq3
         1j1lS85MbUHuWa+qinezYxUNPlS2/GIBITGeuSmgaSjbMZpszsVfc/U3BDlrZKKpn/
         D0Tl2X+t0oXJUMZ9pmMf5/hQVS7/Z0Ys8N83Q096xQVn+59qzpvPJ6Q/TK5fcu5dbV
         ulzl/yy9w90W98oCiWy1y61EA/oYSU7SZ73N9ir3O7fGpk+bgEk54ZhSlC6ItaWXBW
         pM9DPnoueZVjg==
Date:   Wed, 1 Dec 2021 09:41:22 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 0/1] Docs: use RTD dark mode if available
Message-ID: <20211201094122.1c6fd83d@coco.lan>
In-Reply-To: <cover.1638346585.git.mchehab+huawei@kernel.org>
References: <cover.1638346585.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed,  1 Dec 2021 09:22:02 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Hi Jon,
> 
> As we're analyzing some theme alternatives, one of the things that annoys
> me more at our theme is that it doesn't come with a dark mode.
> 
> At least here, I strongly prefer dark themes, as it seems to be a lot more
> comfortable to my eyes, specially in the morning.
> 
> There's an extension to the RTD theme that allows building the docs with a
> dark theme, with a button to select normal mode.
> 
> As this comes almost for free, optionally enable the dark mode extension if
> such theme is installed at the machine.

Too good to be true... It won't work properly, as:

1. Some of the css custom configs at sphinx-static define colors;
2. It sounds that this overlay to RTD theme is missing some classes,
   as, at least here, function prototypes from driver-api/media/v4l2-async.html
   are written with a black color over a dark gray background.

I'll do more tests. If I find a solution, I'll submit another version.

Thanks,
Mauro
