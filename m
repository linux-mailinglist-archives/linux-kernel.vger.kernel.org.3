Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1037474D33
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 22:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhLNVY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 16:24:28 -0500
Received: from mail.wizzup.org ([95.217.97.174]:44248 "EHLO wizzup.org"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230268AbhLNVY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 16:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizzup.org;
        s=mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YX4B08ESa94+Iaa9Jp1XsOVPlzoB8Xs3oRhGovuVVxQ=; b=UPxFsPeATxS6jqjypXTzp/K7ff
        6OCm8ulBqtoCof4XLgxkYgEJAAo8cmyVmg5KiRzCOT8R6Kq3T0/31cYDoPuPwnv88jxuZavBSbIHF
        HvEeeawC1r0SR1nlDb9FILF7LwZaV8iUZKh/39S7L12CnL7TTN+kbckRRW59Cw6JidQbgX39caDua
        DVY86KLzwRt4rrd/EvJgSCnTiVcwUZYNemcMGz/p1PQS0Glk5JIvLAA6lzRrqRV1jgHGiKRhcmsoP
        2DZlRJMaqAf7gvogC7MXE45eGpBG2MK/ZAQwkL04vmVVFZwtNn10f+Atr93UrUctTvCuwnAHjFcX+
        OgxU7nXQ==;
Received: from [45.83.235.159] (helo=[0.0.0.0])
        by wizzup.org with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <merlijn@wizzup.org>)
        id 1mxFHY-0003El-KN; Tue, 14 Dec 2021 21:24:20 +0000
Subject: Re: [RFC PATCH 2/2] Droid3: add initial DTS
To:     Tony Lindgren <tony@atomide.com>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Dev Null <devnull@uvos.xyz>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211212230459.13579-1-merlijn@wizzup.org>
 <20211212230459.13579-3-merlijn@wizzup.org> <Ybbhpahp20tlwEdH@atomide.com>
From:   Merlijn Wajer <merlijn@wizzup.org>
Message-ID: <42bb0134-1b5d-4bba-5f91-413007ba6eef@wizzup.org>
Date:   Tue, 14 Dec 2021 22:30:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <Ybbhpahp20tlwEdH@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 13/12/2021 07:01, Tony Lindgren wrote:
> * Merlijn Wajer <merlijn@wizzup.org> [211212 23:00]:
>> @@ -35,7 +35,7 @@ reserved-memory {
>>  		 * first 512K of that and just overwrite the rest and configure
>>  		 * only 384K instead of 2M.
>>  		 */
>> -		ramoops@a0080000 {
>> +		ramoops0: ramoops@a0080000 {
>>  			compatible = "ramoops";
>>  			reg = <0xa0080000 0x60000>;
>>  			record-size = <0x20000>;
> 
> The stock kernel ramoops range might be different here because of less
> memory. If the stock kernel has it, it should be in the platform data
> somewhere in the stock kernel sources. Probably best to just leave it
> out for now.

Understood -- I didn't see it in the stock kernel, so perhaps ramoops is
not available on this device.

>> +// Do don't know if pstore is supported, but the current config causes panics,
>> +// so delete the node for now
>> +/delete-node/ &ramoops0;
> 
> Just leave this out too, I don't think we have the ramoops configured in
> the mainline kernel.

Oops, yeah.

> Otherwise looks good to me.

Thanks for review!

Regards,
Merlijn
