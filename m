Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FD34B21D4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344411AbiBKJZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:25:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239926AbiBKJZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:25:48 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1351E1037
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:25:47 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u1so360939wrg.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=4qiy8OktVHN84+DezGt6YRpvDHUjWHm3on5bxfkbXJc=;
        b=wULt7FnqXC/L4Gymc0ykI6+i6dld8vhiMJC6kasAgaVpr7g05GdtAQYYGnfgMit6u3
         UsUIV9yYXffSXYgnktHeR5hfAEE9UktvD41UwWzVJ4lzTFtjE9kTG3ff2raX6l5JTHKZ
         91THXqClC5iSMitmw+CC42Q5y26YGeLstWWVzusgJnXVivNQaiKRszSwXbdaZnexaj2T
         FsW/JwOpzaHfOJNoq5Yl/2yKJowJO9udUZ296Q0qzYgkteEKyByRo4vqgHtbX6z46ZsO
         kGPb99U4AFHUtIuN3Zk/LJK9EzuEN/sjUh2Eknw5b+duiYvsjZ1iMjjux3H+cgVshUzu
         CNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=4qiy8OktVHN84+DezGt6YRpvDHUjWHm3on5bxfkbXJc=;
        b=PGzTOPcvd66W8Iw9Zk5DAXuprAdMP4X7i941RNU2RsIt22ntFsfZcBeTlRfKPCoa9d
         BN6LQ8oEzpsNigUO+H+nrxitvMFmIdhoXdYxBPBIr9/HpLdQyhmWq7MZE6NooJO2G73f
         4Sg0ploKjaLG7axnTr6Gsy341iZyIqpfli/dZR1F6PcGPY5A1WFX5um3wmoth00wn4NX
         bZdfqJi30fe5LkGYh1ufAgPeVWV1mqy2nm7aO4PTHiis/djyU684vxrUHvM/5UM42QUS
         8jTzl1/6oT4JGJZ9Jb2cqQCQ/2mXWWQxxYNcbIAWM9HmfgfTPGSarc/+UZ3Qf56Om66s
         Jwzg==
X-Gm-Message-State: AOAM533WnyxiPOV62TL/b+AqtupM7sYLrEuJIcNPukaOQ3LAmSg9IxXA
        Rkl1AGPehplGEMGjVwjds2oQ/w==
X-Google-Smtp-Source: ABdhPJyJ2RPqgxI850laIYOe6nBW3XeOqT6BrIDWIDnkrILMP7eMkagxLXlCgFu9hgRup9F7qpWfmQ==
X-Received: by 2002:adf:f904:: with SMTP id b4mr597776wrr.183.1644571545371;
        Fri, 11 Feb 2022 01:25:45 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:97e4:3830:c79:136e? ([2001:861:44c0:66c0:97e4:3830:c79:136e])
        by smtp.gmail.com with ESMTPSA id 2sm23666644wrz.59.2022.02.11.01.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 01:25:44 -0800 (PST)
Message-ID: <3a60384a-b26f-3591-fca9-b10764bd2b24@baylibre.com>
Date:   Fri, 11 Feb 2022 10:25:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] arm64: dts: meson: remove CPU opps below 1GHz for
 SM1 boards
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220210100638.19130-1-christianshewitt@gmail.com>
 <20220210100638.19130-3-christianshewitt@gmail.com>
 <8211344a481dd40f260106bdd3f03bfb@kernel.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <8211344a481dd40f260106bdd3f03bfb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 10/02/2022 11:36, Marc Zyngier wrote:
> On 2022-02-10 10:06, Christian Hewitt wrote:
>> Amlogic SM1 devices experience CPU stalls and random board wedges when
>> the system idles and CPU cores clock down to lower opp points. Recent
>> vendor kernels include a change to remove 100-250MHz and other distro
>> sources also remove the 500/667MHz points. Unless all 100-667Mhz opps
>> are removed or the CPU governor forced to performance stalls are still
>> observed, so let's remove them to improve stability and uptime.
>>
>> Fixes: 3d9e76483049 ("arm64: dts: meson-sm1-sei610: enable DVFS")
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 20 --------------------
>>  1 file changed, 20 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> index 3c07a89bfd27..80737731af3f 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> @@ -95,26 +95,6 @@
>>          compatible = "operating-points-v2";
>>          opp-shared;
>>
>> -        opp-100000000 {
>> -            opp-hz = /bits/ 64 <100000000>;
>> -            opp-microvolt = <730000>;
>> -        };
>> -
>> -        opp-250000000 {
>> -            opp-hz = /bits/ 64 <250000000>;
>> -            opp-microvolt = <730000>;
>> -        };
>> -
>> -        opp-500000000 {
>> -            opp-hz = /bits/ 64 <500000000>;
>> -            opp-microvolt = <730000>;
>> -        };
>> -
>> -        opp-667000000 {
>> -            opp-hz = /bits/ 64 <666666666>;
>> -            opp-microvolt = <750000>;
>> -        };
>> -
>>          opp-1000000000 {
>>              opp-hz = /bits/ 64 <1000000000>;
>>              opp-microvolt = <770000>;
> 
> That's not nearly enough. If that's an actual issue, the driver
> should be updated not to use these OPPs, and you can't assume
> that people will just update their DT (mine comes from u-boot,
> and it is unlikely I will update it anytime soon).

The driver is the generic cpufreq and a generic clock driver, we do not
filter out the possible OPP frequencies because the possible freq
is large and depends on the die revision.

I don't see why we should filter out these frequencies so far.

Neil

> 
> Thanks,
> 
>          M.

