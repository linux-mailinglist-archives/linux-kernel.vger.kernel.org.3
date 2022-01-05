Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B7B4851F5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbiAELlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:41:24 -0500
Received: from m12-14.163.com ([220.181.12.14]:25894 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235184AbiAELlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=50E5P
        fEps/AfLktgJnd6K+0Rx0UsvbbOTVRSINxFENk=; b=lQAXCfiD6c0tSihnwmMfn
        VjIpLyDj+16vaZayPuASxuCLQlZKz52kGWQRis/CmXOwTN3x0naX2FzZ10X6SHt5
        Y7N+MSu0Ead214qIe6EM7KXnVCCDAWvtp9Yy+7xz63xAHZLR+dP2baXXIw3A/gGa
        AmJYtMmB6b4iKYzps6NXLY=
Received: from [192.168.31.101] (unknown [183.194.153.98])
        by smtp10 (Coremail) with SMTP id DsCowABXNsZ1g9Vh4MoPGQ--.2421S2;
        Wed, 05 Jan 2022 19:39:34 +0800 (CST)
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Legion Y9000X 2020
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        Elia Devito <eliadevito@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220105034103.12484-1-fbl718@163.com>
 <s5ha6gak2qf.wl-tiwai@suse.de> <YdV5MNWOwgrtH2UC@kroah.com>
From:   Baole Fang <fbl718@163.com>
Message-ID: <757a4402-1067-e3c8-8ca3-43ee62047ebe@163.com>
Date:   Wed, 5 Jan 2022 19:39:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YdV5MNWOwgrtH2UC@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: DsCowABXNsZ1g9Vh4MoPGQ--.2421S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw4ruFy5XF4ruw15CF1xKrg_yoW8Jw1fpa
        40y3WSkFs8JrWfCw1Iy3ZYvFy5Gan3JFWFqF1rt345AFZ0yr4fWr4fKw4a9F9rW340yay5
        XF1DKFy3tw1DuaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6E_iUUUUU=
X-Originating-IP: [183.194.153.98]
X-CM-SenderInfo: 5ieoliqy6rljoofrz/1tbipRJ-6VUMihC3AgAAsX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this is my first time to submit patch to Linux, so I'm not quite 
familiar with the convention. Since I was changing based on v5.15.12 and 
I saw others mentioning their upstream commit, I included the that 
commit id.

Please forgive me and tell me what is supposed to be done if possible. I 
still have a lot to learn.

Best Regards,

Baole Fang

On 2022/1/5 下午6:55, Greg Kroah-Hartman wrote:
> On Wed, Jan 05, 2022 at 09:26:16AM +0100, Takashi Iwai wrote:
>> On Wed, 05 Jan 2022 04:41:01 +0100,
>> Baole Fang wrote:
>>> commit 25960cafa06e6fcd830e6c792e6a7de68c1e25ed upstream.
>> I couldn't find this commit.  Is this a bogus information?
>>
>>> Legion Y9000X 2020 has a speaker, but the speaker doesn't work.
>>> This can be fixed by applying alc285_fixup_ideapad_s740_coef
>>>   to fix the speaker's coefficients.
>>> Besides, to support the transition between the speaker and the headphone,
>>> alc287_fixup_legion_15imhg05_speakers needs to be run.
>>>
>>> Signed-off-by: Baole Fang <fbl718@163.com>
>> The code change itself looks fine, so I'd apply it if the line above
>> can be omitted.
> That commit id comes from 5.15.12, and it is the commit id of the
> release commit:
> 	25960cafa06e ("Linux 5.15.12")
> which makes no sense at all.
>
> Baole, why did you add this line?
>
> confused,
>
> greg k-h

