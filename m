Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79794470608
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243840AbhLJQp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhLJQp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:45:57 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4935EC061746;
        Fri, 10 Dec 2021 08:42:22 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id l7so14606138lja.2;
        Fri, 10 Dec 2021 08:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BC/L7vVuNDkh73jj1Fuq2gM9M7ljyOtwslTzE8DRGoQ=;
        b=mvoAyCn9E01//c0/y5s5TBzFGh5kY4+YTNw72sUhsuQiyvb9ZPLBhfwzb/+eTUPcHy
         QmczqDg/BXfaBBSHhd4RVBU6ff3ZZDe/OeT/yXT9IJB5fBDoCHWLsnmQrmPW1utD95i+
         LzMfBlRAQ0Nq6OqyX3alhp3YodKSlBQ72pJ7O1yuOOhZmdxpipOYRmoK9vW39PaGpUOe
         IpLcAyMv1v45CkVFoW+9vT0Yz5746VVjVahxiLWEBe8wByvvdU/iC5Tnr/7mYSApV4W2
         gTzxbijTE0eIex/MyCx4xG/dnKBlc8g5MwDAatlNDzoPJK2TvX7wcc109pZbxO/YZtl9
         Bnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BC/L7vVuNDkh73jj1Fuq2gM9M7ljyOtwslTzE8DRGoQ=;
        b=M+fOKQ2UDCtpp7yu46akN3Ayp91RYcdwbAMmTuPiwa02c5+NjDx7k1rn5uQFzELXOS
         +vPzEKGZ9yaSlj7zIEd16WczzwlTLUs4G3ZVvV/6euRmf27pbeYUu8VMfN6lDhRgENOW
         RHhqh5LZ6ITHtnbg8l3OAX0geePslAJtpkD3tMBpyLZ2Spu4tSYC+oK78ZnaeGH4cby3
         H3ZLv5Cyy3tqPRl7l4QYjl4nv+K8p2rgTu2QEqAQzw+YXJrFiUhHgaxgcKtSsJYW7+1G
         LNQa3VnCru0Q9LPYdhML0NbczCD2KGM5Bkil6htKGq/HpGQ0YMxQmHMfafyDA+6nQPYH
         Qvug==
X-Gm-Message-State: AOAM530NAomCVOHYjXjt5VpDcITta9Ii7iYEBgyaRZWS9yoj5sz1NTn7
        I4YJqswy5uI4FgzzqvXNmU7r161rDjw=
X-Google-Smtp-Source: ABdhPJwu3DcAVYNwIcEKca3KZ2zcyLebU8uEWtzgECrRNCMdAgDG0N0fUJ+XoG9nSjVvzeV+RShtGw==
X-Received: by 2002:a2e:b5d2:: with SMTP id g18mr13605489ljn.354.1639154540414;
        Fri, 10 Dec 2021 08:42:20 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id y18sm359551lfk.17.2021.12.10.08.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 08:42:20 -0800 (PST)
Subject: Re: [PATCH v5 05/24] ARM: tegra: Add device-tree for ASUS Transformer
 EeePad TF101
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211208173609.4064-1-digetx@gmail.com>
 <20211208173609.4064-6-digetx@gmail.com> <YbN2T5guOfIRLXg1@orome>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <de357dd7-ad4b-758c-f041-b3385d164b98@gmail.com>
Date:   Fri, 10 Dec 2021 19:42:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbN2T5guOfIRLXg1@orome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2021 18:46, Thierry Reding пишет:
...
>> +	gpio@6000d000 {
>> +		charging-enable-hog {
>> +			gpio-hog;
>> +			gpios = <TEGRA_GPIO(R, 6) GPIO_ACTIVE_HIGH>;
>> +			output-low;
>> +		};
>> +	};
> 
> Isn't this something that we may want to change at some point? My
> understanding is that GPIO hogs are permanent, so it won't be possible
> to grab GPIO R.6 and change this.
> 
> Are there any plans to allow setting this at runtime?

I'm not aware about plans to change that charging hog.

It's not a problem to remove the hog. I don't understand why you're
saying that it's permanent. We have such hogs in Nexus7 DT for the 3G
modem pins. If we'll ever have a driver for that modem, then we will
remove those hogs, not a problem.

> [...]
>> +	i2c2: i2c@7000c400 {
>> +		status = "okay";
>> +		clock-frequency = <100000>;
>> +	};
>> +
>> +	i2cmux {
> 
> This doesn't belong here. The ordering is by unit-address and everything
> without unit-address needs to move after the nodes with unit-addresses
> and be sorted alphabetically.

Logically it belongs here, since mux uses i2c2. All other DTs do the same.

...
>> +	memory-controller@7000f400 {
>> +		nvidia,use-ram-code;
>> +
>> +		emc-tables@3 {
>> +			reg = <0x3>;
>> +
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			lpddr2 {
>> +				compatible = "elpida,B8132B2PB-6D-F", "jedec,lpddr2-s4";
>> +				revision-id1 = <1>;
>> +				density = <2048>;
>> +				io-width = <16>;
>> +			};
>> +
>> +			emc-table@25000 {
> 
> Ugh... looking at the bindings for this the naming here is rather
> unfortunate. emc-tables@3 and emc-table@*... the top-level emc-tables
> are really tables, but the emc-table@* are really entries or rows in
> that table, not tables themselves. It's also rather unfortunate that we
> duplicate the frequency in both the "reg" and "clock-frequency"
> properties. One of them would've been enough.

It's emc-tables@3 here because initially there were other tables that I
removed during preparation of the DT for upstream. Those tables were
untested and looked questionable to me.

> Anyway, looks like this has basically been like this since forever, so
> not much that can be done about it.
> 
> Again, the memory-controller node needs to be sorted differently. There
> are other occurrences of this throughout the file.

Please feel free to reorder it.
