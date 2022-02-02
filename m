Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7AD4A71B5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344377AbiBBNkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiBBNkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:40:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB81C061714;
        Wed,  2 Feb 2022 05:40:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21D9EB82FDD;
        Wed,  2 Feb 2022 13:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EFCC004E1;
        Wed,  2 Feb 2022 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643809217;
        bh=uqlgSWB1fXNOD3jiBiSCYNWp2ABp5Qyvc8zIPcxCmII=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=sfQiysi6EwLbKVW5ZHfzzcTXqnuYmwWXbONYt20afH4k4PJBlNdf/FP8TXAkilWzb
         NIADC2xYATQy6p+9UP82nRRUKk4ZXaIrYWeQsy/cpUN8fXnVeJ+eHwciGow9WbzLSV
         Mgv8cArJvyzv+Tey0VnhJAtl5j6JBfZJ9Vfx1FUjpZDAZoZ9HgA42UJ54H7Ba9E0pj
         JPD45iDVL218fF3BUWy+E5bHNgW6ieU7tjKdr8cHpboJSeGGz3EQdEkfCqLU9Vv2oF
         5W4rzCyTk4nim76YDoYgfHJKJDm/VvOBgbBGkSXC4RiOcN/QqFVehe/YVHVTP89+DA
         kKN4qJ7WWq2bg==
Date:   Wed, 2 Feb 2022 14:40:00 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Aditya Garg <gargaditya08@live.com>
cc:     "alexhenrie24@gmail.com" <alexhenrie24@gmail.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/3] HID: apple: Add support for keyboard backlight
 on certain T2 Macs.
In-Reply-To: <9B28205B-24B2-449F-A6B9-BE87C1B9A39E@live.com>
Message-ID: <nycvar.YFH.7.76.2202021439120.11721@cbobk.fhfr.pm>
References: <67E7EA8B-CF21-4794-B7B4-96873EE70EF6@live.com> <9B28205B-24B2-449F-A6B9-BE87C1B9A39E@live.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022, Aditya Garg wrote:

> It has been a week since I have sent this series of patches, but I 
> haven't got a reply yet. Before that, I had sent a v1 of the same, on 
> which I wasn't contacted as well. May I have an update on this series. 
> No reply for a long time is something which doesn't sound good.

A week during merge window and -rc1 phase is not that horrible, please be 
a little bit more patient.

The patchset hasn't been lost, it's on my radar and I'll process it this 
week still.

Thanks,

-- 
Jiri Kosina
SUSE Labs

