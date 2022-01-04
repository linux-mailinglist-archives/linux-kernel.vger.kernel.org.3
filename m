Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99744849FB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiADVjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:39:31 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:36378 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbiADVj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:39:28 -0500
Received: from [192.168.18.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1n4rWa-0000cY-He; Tue, 04 Jan 2022 21:39:24 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1n4rWW-001pwP-7x; Tue, 04 Jan 2022 21:39:18 +0000
Subject: Re: Occasional hung with UM after enable VMAP_STACK
To:     Walter Lozano <walter.lozano@collabora.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sjoerd Simons <sjoerd.simons@collabora.com>,
        ritesh sarraf <ritesh.sarraf@collabora.com>
References: <be290dc3-db9c-2940-91bb-c91bf42fd8f6@collabora.com>
 <d80e4e760171de3813895e3cbfcadf96aa6c8fb6.camel@sipsolutions.net>
 <8c26a869-0cbe-a38c-8a8d-9f3f171f7e72@collabora.com>
From:   Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <94613ccb-ab4d-851d-01d0-dfa72b73fdb0@kot-begemot.co.uk>
Date:   Tue, 4 Jan 2022 21:39:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8c26a869-0cbe-a38c-8a8d-9f3f171f7e72@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2022 19:26, Walter Lozano wrote:
> Hi Johannes,
> 
> On 1/4/22 16:04, Johannes Berg wrote:
>> On Tue, 2022-01-04 at 15:10 -0300, Walter Lozano wrote:
>>> Hi all,
>>>
>>> I noticed that after "um: enable VMAP_STACK" [1] I experienced some
>>> occasional hung in my Gitlab CI jobs that use user-mode-linux to build
>>> distro images.
>>>
>> Did you actually *enable* VMAP_STACK in the config as well? The commit
>> just makes it *possible* to enable it, you still have to set it
>> yourself. So you should be able to easily check with/without that
>> setting.
> 
> Thank you for your quick response. The Debian configuration on package 
> user-mode-linux have these settings
> 
> CONFIG_HAVE_ARCH_VMAP_STACK=y
> CONFIG_VMAP_STACK=y
> 
> 
> as you can see in [1]. I did run some tests disabling those settings, 
> which passed without any hung.
> 
> Unfortunately the "occasional" behavior makes this issue a bit tricky to 
> debug.
> 
> Regards,
> 
> Walter
> 
> [1] 
> https://salsa.debian.org/uml-team/user-mode-linux/-/blob/master/config.amd64#L321 
> 
> 

Just to narrow things down - 64 bit or 32 bit?

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/
