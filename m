Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA3A46E3B1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhLIIIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:08:50 -0500
Received: from muru.com ([72.249.23.125]:36448 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhLIIIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:08:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7C6D380A3;
        Thu,  9 Dec 2021 08:05:56 +0000 (UTC)
Date:   Thu, 9 Dec 2021 10:05:13 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Yongqin Liu <yongqin.liu@linaro.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gowtham Tammana <g-tammana@ti.com>,
        Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v2 1/1] ARM: dts: dra7: add entry for bb2d module
Message-ID: <YbG4ufDete8PrWNx@atomide.com>
References: <20210921071807.30978-1-narmstrong@baylibre.com>
 <20210921071807.30978-2-narmstrong@baylibre.com>
 <YV1UdSVOrZ3B9pq/@atomide.com>
 <CAMSo37UN78k=WE0CwRyNNV3P9kau+JzVZ7mHOMMvh5Bn=+=jAQ@mail.gmail.com>
 <78b51650-0e32-e81f-0191-2222580e7343@baylibre.com>
 <CAMSo37X1BA1cYYxwjWBo_dhjpGYuYD2KK00+3ZWAwNeJq8UfxQ@mail.gmail.com>
 <YbGrWGuIWdMNqNqU@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbGrWGuIWdMNqNqU@atomide.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [211209 07:08]:
> Sounds like your out of tree SGX patches also tinker with the BB2D module.
> 
> To me it sounds like you can just tag the new target-module@59000000 added
> by this patch with status = "disabled" in your SGX patch until you have
> updated the driver code.

The above still applies..

> I'm adding this patch into omap-for-v5.17/dt as for 2D acceleration there
> is the etnaviv driver in the mainline kernel that should be usable to
> some extent.

..but looks like we already merged this patch earlier so no need to
reapply :) Sorry I still had the patch tagged in my inbox.

Regards,

Tony
