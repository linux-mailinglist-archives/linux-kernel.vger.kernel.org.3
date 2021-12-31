Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBC148249C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 16:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhLaPhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 10:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhLaPhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 10:37:53 -0500
X-Greylist: delayed 150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 31 Dec 2021 07:37:52 PST
Received: from resqmta-c1p-024063.sys.comcast.net (resqmta-c1p-024063.sys.comcast.net [IPv6:2001:558:fd00:56::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2F3C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 07:37:52 -0800 (PST)
Received: from resomta-c1p-023266.sys.comcast.net ([96.102.18.234])
        by resqmta-c1p-024063.sys.comcast.net with ESMTP
        id 3IdUn4OqyfM8u3Jw8nH1mc; Fri, 31 Dec 2021 15:35:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1640964920;
        bh=X0PGbkm5AYY94s+W5+NodReCIEluZYxv8imWvsSK3Yg=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=lrG9yRykucutvG4COdOTKS2ljnqSJx1dY4+1RNkIeDResSE/fPL73nCyPoSb5H344
         7HIz6NBypH47lmOgL2pTWjfgjX6bNANx53pa7WvCP2YER3KERj8MMtlPpvJKTkUeud
         fIHAKMyQkMcPnWqXUbT8UWKQ76uwKgWtNsPTUGLD0pk66Ke2X+dCX4COuRqMLlFwhY
         2YS13qD5QLWStI7JwdUdU8oqEy/nEnU5L1mul7Ix/eNtWMN8DtYTXb9Pf4aUn6g+b2
         wXpAAopM+2/lKPjjbO2OTTaQKgFSoeC4k/E+0QxZoQCU1X3L55kLOVe+SmNONEzs3t
         cVd0+5GpnYLJA==
Received: from [IPv6:2601:647:4700:284:9d56:573c:4e75:fa6c]
 ([IPv6:2601:647:4700:284:9d56:573c:4e75:fa6c])
        by resomta-c1p-023266.sys.comcast.net with ESMTPSA
        id 3Jw2nnMYa4rcW3Jw3nrhvk; Fri, 31 Dec 2021 15:35:17 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
Subject: Re: [PATCH] riscv: dts: sifive unmatched: Add gpio poweroff
To:     James Clarke <jrtc27@jrtc27.com>
Cc:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211231061110.89403-1-w6rz@comcast.net>
 <73F7FAE3-5113-48DD-B0F5-0EEAA0A8B0C1@jrtc27.com>
From:   Ron Economos <w6rz@comcast.net>
Message-ID: <99ac0009-b49a-f618-1b96-7896d6d155ae@comcast.net>
Date:   Fri, 31 Dec 2021 07:35:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <73F7FAE3-5113-48DD-B0F5-0EEAA0A8B0C1@jrtc27.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/21 10:58 PM, James Clarke wrote:
> On 31 Dec 2021, at 06:11, Ron Economos <w6rz@comcast.net> wrote:
>> This patch is required for the following commit to work.
>>
>> commit f2928e224d85 ("riscv: set default pm_power_off to NULL")
>>
>> Signed-off-by: Ron Economos <w6rz@comcast.net>
>> ---
>> arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 5 +++++
>> 1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
>> index 6bfa1f24d3de..c4ed9efdff03 100644
>> --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
>> +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
>> @@ -39,6 +39,11 @@ rtcclk: rtcclk {
>>         clock-frequency = <RTCCLK_FREQ>;
>>         clock-output-names = "rtcclk";
>>     };
>> +
>> +    gpio-poweroff {
>> +        compatible = "gpio-poweroff";
>> +        gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
>> +    };
> Why? It’s abstracted by firmware, which works.
>
> Jess
>
I didn't realize that OpenSBI 1.0 had been released last week. Please 
disregard this patch.

Ron


