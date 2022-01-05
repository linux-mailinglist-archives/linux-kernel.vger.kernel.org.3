Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8975C485316
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiAEM4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:56:31 -0500
Received: from m12-14.163.com ([220.181.12.14]:2133 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbiAEM43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=8JL+5
        tV0OySHqWZPF4qHORWko9npkfbM3ji3E/RcwN8=; b=poHHO9asTjYHqcf7RngaT
        PEav9gXE49h6m/TZkBsSRcWs3CJ7u0BVm2hkrsQUPvNzNExPwUdudNLJUgj5ka2S
        wsaDHe2XA87izUCSG9RFoO8aXFbllADtJVEiPzyj7SZy+sQpQqtBv0VUnq0mfZ8Y
        aGHaMQjnMXnGBRuLHh9xhk=
Received: from [192.168.31.101] (unknown [183.194.153.98])
        by smtp10 (Coremail) with SMTP id DsCowADXSM7nlNVhfw4aGQ--.47504S2;
        Wed, 05 Jan 2022 20:53:59 +0800 (CST)
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
 <6bf35d26-73d4-ba14-f931-8d379c623482@163.com> <YdWQLOtV8Tz8ArrH@kroah.com>
From:   Baole Fang <fbl718@163.com>
Message-ID: <7de9fab1-589f-a737-c00e-f98812a23c71@163.com>
Date:   Wed, 5 Jan 2022 20:53:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YdWQLOtV8Tz8ArrH@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: DsCowADXSM7nlNVhfw4aGQ--.47504S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUYQ6JUUUUU
X-Originating-IP: [183.194.153.98]
X-CM-SenderInfo: 5ieoliqy6rljoofrz/1tbiYwh-6VaEGamGPAAAsl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/5 下午8:33, Greg Kroah-Hartman wrote:
> We can not just "ignore" it, you need to fix your change up and resend
> it in a proper format so that it can be applied.
>
> As-is, it is not acceptable, sorry.

Thank you, I'm going to resend the patch.

Best Regards,

Baole Fang

