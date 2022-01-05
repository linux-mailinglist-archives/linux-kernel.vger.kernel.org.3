Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB25C485320
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbiAEM7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbiAEM7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:59:34 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D172DC061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 04:59:33 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: wlozano)
        with ESMTPSA id DADDD1F44882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641387572;
        bh=lq7iV/TsLUggKJX+Ubg+u0mQpThFvP22cJtIctEiXiU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=otquMosLKJS6FctIj2oCug/sh/Jdj4diN/HJS9WQkEovSsBh7cthzPjH9MyT5SXy9
         tmvEUnDPYfJLCabTWkfmjgoUDo2xLlKCJwl9NUtGHMY4NsZOgR6eQ1O+r0BJgisjO8
         5GH0sFEV/eLC4ACGYZOCt/9L/LPCIscEAvx8SQbj+7UlR7He3CJJOCK2tAn3h5gjXX
         Lf17O99CIYaZ+f5p8TI/g+/jcPZVSebMYtSm9ed+b+6aofTHHVMfsuDCyeQcfU/BVo
         HUDCFTSnKBsvbWYhHLMWoCtMyUaV8s34/NhEwpEsaFf4JWQMlvfdgC9UJMYg2DI1Tw
         cjO3UgdZaePTg==
Message-ID: <5c9b8e61-1158-1004-8280-04cc3c921ad1@collabora.com>
Date:   Wed, 5 Jan 2022 09:59:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Occasional hung with UM after enable VMAP_STACK
Content-Language: en-US
To:     Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sjoerd Simons <sjoerd.simons@collabora.com>,
        ritesh sarraf <ritesh.sarraf@collabora.com>
References: <be290dc3-db9c-2940-91bb-c91bf42fd8f6@collabora.com>
 <d80e4e760171de3813895e3cbfcadf96aa6c8fb6.camel@sipsolutions.net>
 <8c26a869-0cbe-a38c-8a8d-9f3f171f7e72@collabora.com>
 <94613ccb-ab4d-851d-01d0-dfa72b73fdb0@kot-begemot.co.uk>
From:   Walter Lozano <walter.lozano@collabora.com>
In-Reply-To: <94613ccb-ab4d-851d-01d0-dfa72b73fdb0@kot-begemot.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

On 1/4/22 18:39, Anton Ivanov wrote:
> On 04/01/2022 19:26, Walter Lozano wrote:
>> Hi Johannes,
>>
>> On 1/4/22 16:04, Johannes Berg wrote:
>>> On Tue, 2022-01-04 at 15:10 -0300, Walter Lozano wrote:
>>>> Hi all,
>>>>
>>>> I noticed that after "um: enable VMAP_STACK" [1] I experienced some
>>>> occasional hung in my Gitlab CI jobs that use user-mode-linux to build
>>>> distro images.
>>>>
>>> Did you actually *enable* VMAP_STACK in the config as well? The commit
>>> just makes it *possible* to enable it, you still have to set it
>>> yourself. So you should be able to easily check with/without that
>>> setting.
>>
>> Thank you for your quick response. The Debian configuration on 
>> package user-mode-linux have these settings
>>
>> CONFIG_HAVE_ARCH_VMAP_STACK=y
>> CONFIG_VMAP_STACK=y
>>
>>
>> as you can see in [1]. I did run some tests disabling those settings, 
>> which passed without any hung.
>>
>> Unfortunately the "occasional" behavior makes this issue a bit tricky 
>> to debug.
>>
>> Regards,
>>
>> Walter
>>
>> [1] 
>> https://salsa.debian.org/uml-team/user-mode-linux/-/blob/master/config.amd64#L321 
>>
>>
>
> Just to narrow things down - 64 bit or 32 bit?
>
Thank you for commenting on this thread. All my tests were done with 64 
bits.

Regards,

-- 
Walter Lozano
Collabora Ltd.

