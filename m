Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA137467C75
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353083AbhLCR2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbhLCR2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:28:20 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7423C061751;
        Fri,  3 Dec 2021 09:24:55 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mtCIn-0003QH-7t; Fri, 03 Dec 2021 18:24:53 +0100
Message-ID: <e03ddc81-c60b-bd28-b959-0602142f0efc@leemhuis.info>
Date:   Fri, 3 Dec 2021 18:24:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Regression: plugging in USB scanner breaks all USB functionality
 #forregzbot
Content-Language: en-BS
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <35f7428b39f996c793f5b4a6a314772681c73d7a.camel@apache.org>
 <3eb9c3f8-6bca-da08-47ec-af2a02d6a485@leemhuis.info>
To:     regressions@lists.linux.dev
In-Reply-To: <3eb9c3f8-6bca-da08-47ec-af2a02d6a485@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1638552295;ea523916;
X-HE-SMSGID: 1mtCIn-0003QH-7t
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.12.21 16:13, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker speaking.
> 
> Thanks for the report.
> 
> Top-posting for once, to make this easy accessible to everyone.
> 
> FWIW, 5.14 is EOL, so it might not be fixed there. As the problem is in
> newer kernels as well, I suspect that it was a change applies to 5.15 or
> 5.16 that got backported. Maybe one of the developers might have an idea
> which commit causes it. If that's not the case you likely should try a
> bisection to find the culprit. Performing one between v5.14.11..v5.14.14
> is likely the easiest and quickest way to find it.
> 
> To be sure this issue doesn't fall through the cracks unnoticed, I'm
> adding it to regzbot, my Linux kernel regression tracking bot:
> 
> #regzbot ^introduced v5.14.11..v5.14.14
> #regzbot title usb: plugging in USB scanner breaks all USB functionality
> [regression present in 5.15.2 und 5.16-rc3, too]
> #regzbot ignore-activity

#regzbot introduced ff0e50d3564f
#regzbot fixed-by 385b5b09c3546c87cfb730b76abe5f8d73c579a2

Ciao, Thorsten, your Linux kernel regression tracker

P.S.: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.



