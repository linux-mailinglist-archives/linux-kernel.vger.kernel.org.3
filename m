Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CED485278
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240028AbiAEMbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:31:24 -0500
Received: from m12-14.163.com ([220.181.12.14]:53121 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231857AbiAEMbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=QlYCT
        R6UDr5CDBVSQl2bSnVcDalgsUO6BAbkJ+ro+m0=; b=jvhM0XBkZXt0LanB9IZZe
        +DSEZbTprZtHrbDfH5ebRwHZm0P8ajxkrHtirRChooLM10FeniVbYvTMHZUwCe5X
        xZpZClUHgi83acNGQ/yU7SsDzYuRdNXUe6/pkDGfSS+DRSRionVgwUyvOgMrW4PJ
        QvVaNGVe4yo301AWqyGlFQ=
Received: from [192.168.31.101] (unknown [183.194.153.98])
        by smtp10 (Coremail) with SMTP id DsCowADXZQImj9VhELkWGQ--.4490S2;
        Wed, 05 Jan 2022 20:29:27 +0800 (CST)
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Legion Y9000X 2020
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        Elia Devito <eliadevito@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220105034103.12484-1-fbl718@163.com>
 <s5ha6gak2qf.wl-tiwai@suse.de> <YdV5MNWOwgrtH2UC@kroah.com>
 <757a4402-1067-e3c8-8ca3-43ee62047ebe@163.com> <YdWElRjkZ0lybrMJ@kroah.com>
From:   Baole Fang <fbl718@163.com>
Message-ID: <6bf35d26-73d4-ba14-f931-8d379c623482@163.com>
Date:   Wed, 5 Jan 2022 20:29:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YdWElRjkZ0lybrMJ@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: DsCowADXZQImj9VhELkWGQ--.4490S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw45uFWDCryUuw47Wry7Awb_yoWftwcEyr
        4q9F9rC3WDGFWIyay3JrsI9rWxGFW7ZrZ8ZrW5tr1qqr1UWFWkGFnYkF93Xw4Fqr409FZ8
        Ar1kZFWqywnxZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb-B_UUUUUU==
X-Originating-IP: [183.194.153.98]
X-CM-SenderInfo: 5ieoliqy6rljoofrz/1tbiTRJ-6Vc7U0cIjQABs1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your explanation! I shouldn't have written that line and I 
supposed it can be ignored. Is there anything else I could do?

Best Regards,

Baole Fang

On 2022/1/5 下午7:44, Greg Kroah-Hartman wrote:
> On Wed, Jan 05, 2022 at 07:39:33PM +0800, Baole Fang wrote:
>> Sorry, this is my first time to submit patch to Linux, so I'm not quite
>> familiar with the convention. Since I was changing based on v5.15.12 and I
>> saw others mentioning their upstream commit, I included the that commit id.
> Those commits were coming from the stable backports only, they were not
> done by the original author.
>
>> Please forgive me and tell me what is supposed to be done if possible. I
>> still have a lot to learn.
> Please take a look at the "first kernel patch" tutorial on the
> kernelnewbies.org site for a good example of how to do all of this.
>
> Also the Documentation/SubmittingPatches file in the kernel source tree
> should help out.
>
> thanks,
>
> greg k-h

