Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CF248488A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiADT1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:27:06 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35198 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiADT1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:27:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: wlozano)
        with ESMTPSA id 730EA1F43E84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641324423;
        bh=WSCws4xugrtB3xTdTMljaj7UwH9jRRYjD8tRGShP9iU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=okNT3I8rGUMJFKHP7zai7Yu9xp/yHT7jw1+GsOI88TXc7aOVCWfUyrUhHuXfA2azw
         yzfKLkCEfGZQvrNoXBgaQ13H+suYV3aPTBDlMVK7xDSW+xCjPwBRKrl7YJyCQlYhYC
         pQdT1+xdLp8rsH0vGOfVpuSy/3QrieaImNDA/ErFJaUZuXjfbjxABmrLR3dmUJz/aD
         tfkP/7TF2E0hmOFf+Lko9L2eQsz39f+hbu44msAz/B+AIlzW2VFFQXx4z3vSyug4vv
         BfyvQ6N7LgVWMSYHsnk1c6+7iyclITcVN+kAjSEthB1UVg8hCPOo8rFd6B7weMnrSK
         6zpnsbYMJeYVw==
Message-ID: <8c26a869-0cbe-a38c-8a8d-9f3f171f7e72@collabora.com>
Date:   Tue, 4 Jan 2022 16:26:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Occasional hung with UM after enable VMAP_STACK
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sjoerd Simons <sjoerd.simons@collabora.com>,
        ritesh sarraf <ritesh.sarraf@collabora.com>
References: <be290dc3-db9c-2940-91bb-c91bf42fd8f6@collabora.com>
 <d80e4e760171de3813895e3cbfcadf96aa6c8fb6.camel@sipsolutions.net>
From:   Walter Lozano <walter.lozano@collabora.com>
In-Reply-To: <d80e4e760171de3813895e3cbfcadf96aa6c8fb6.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On 1/4/22 16:04, Johannes Berg wrote:
> On Tue, 2022-01-04 at 15:10 -0300, Walter Lozano wrote:
>> Hi all,
>>
>> I noticed that after "um: enable VMAP_STACK" [1] I experienced some
>> occasional hung in my Gitlab CI jobs that use user-mode-linux to build
>> distro images.
>>
> Did you actually *enable* VMAP_STACK in the config as well? The commit
> just makes it *possible* to enable it, you still have to set it
> yourself. So you should be able to easily check with/without that
> setting.

Thank you for your quick response. The Debian configuration on package 
user-mode-linux have these settings

CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y


as you can see in [1]. I did run some tests disabling those settings, 
which passed without any hung.

Unfortunately the "occasional" behavior makes this issue a bit tricky to 
debug.

Regards,

Walter

[1] 
https://salsa.debian.org/uml-team/user-mode-linux/-/blob/master/config.amd64#L321 


-- 
Walter Lozano
Collabora Ltd.

