Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206E747059B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbhLJQ34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhLJQ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:29:55 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E59C061746;
        Fri, 10 Dec 2021 08:26:20 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bi37so19041185lfb.5;
        Fri, 10 Dec 2021 08:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dW//pQ14dQ1neJjGOt42iXxni2fzAcbg0k81zdgp73Y=;
        b=eSud5R9akWmbTEfdL7A6s+3p+ryMAKG/sfOxkfpbVJzjJL/Aq/jHNZnbhoS3XSfuvE
         D/3sm6183CkqZ/6H8uD9SKNH69dvZ1TpP6f8G0rLoVIPXawaWOVEJQwam5ewY+w1SSEF
         PbW9ivtB54N5dcIIhJlgHJidL3akAAUjUANbReZoqHhIRHieZd9RmIljBrjhTe6Zbmzy
         eSDvIy7//CPL5ti0q8L0unk6vuccgOwpxLfoci4DHqd7gyT60qk9EJKVoWUrtgv3Lq7B
         ab+fUaU7EggaDrexZyAHd1BkHMSbRC1fHm4oUfUfmx/9S2S/2orp2pNBXBBoiGAbk7Xm
         KmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dW//pQ14dQ1neJjGOt42iXxni2fzAcbg0k81zdgp73Y=;
        b=Vr/+NQMrVeyYJoqlnudn2GQ37DZBhfoLoomIRMyoX8HF0h8+KwqBk3uNuacs0+WZQQ
         S90DhrR3PLRhc7hojlgbHhfZ0vWpBwhUHHhdBiikK0SFHDoucnIzf3kFCi6WQKVIOTmw
         IyykL6ZNXXgF/2vACmVGnyetnGKhYZbfqgKi0MkxVgY1B0dcMzyFuXzgYbkdguT+2CjR
         d8l+LLpSRNIC0/BaBwq9jkWpj43I0JoHyQWFSbUhigV796AG1XJ/XdahbsngDZ5UVBqw
         NGJPFcpdX3X/wPdvobGxTijANoHdhnw8ufbfKdQegaqit1kxW7O7XUqiQnw+uaOFRQrh
         YyAg==
X-Gm-Message-State: AOAM530RRAwDNECol1/yw0eSyWZUcCwp3fkNmhXuhdcPEGz0WAGd7cFm
        uijuN52i2/H2hvpTYRDZsTVWb6MNBmU=
X-Google-Smtp-Source: ABdhPJzT/Df5+k6cta9cAqQTJP6CH13OgF3rJyFR0ZVS+3uqQtuTTCy9/XPqtLZ668nUXnYhYM7ccw==
X-Received: by 2002:a05:6512:1194:: with SMTP id g20mr12780423lfr.58.1639153578243;
        Fri, 10 Dec 2021 08:26:18 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id i18sm352419lfe.186.2021.12.10.08.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 08:26:17 -0800 (PST)
Subject: Re: [PATCH v5 03/24] ARM: tegra: Add labels to tegra30.dtsi
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
 <20211208173609.4064-4-digetx@gmail.com> <YbNwpWpEW4EKHd2R@orome>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5a684edd-aaa4-f96e-a72b-bb6d388e6b30@gmail.com>
Date:   Fri, 10 Dec 2021 19:26:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbNwpWpEW4EKHd2R@orome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2021 18:22, Thierry Reding пишет:
> On Wed, Dec 08, 2021 at 08:35:48PM +0300, Dmitry Osipenko wrote:
>> From: Michał Mirosław <mirq-linux@rere.qmqm.pl>
>>
>> Add phandle names for memory/I2C/SPI/USB/SDMMC controller nodes to allow
>> for cleaner device descriptions.
>>
>> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
>> ---
>>  arch/arm/boot/dts/tegra30.dtsi | 36 +++++++++++++++++-----------------
>>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> We typically only add those when they are really needed. These are
> technically harmless because without a reference, DTC won't actually
> create a phandle property, but dangling labels are the kind of thing
> that some janitor may at some point want to remove with some scripts,
> so I'm hesitant to apply this because it'll likely cause churn in the
> future.

The plan is to add labels for T20 and switch all DTs to use those
phandles consistently, but that's the plan for the next kernel release.

Those labels are practically useful when you porting something from old
downstream kernel because it uses those human-readable names instead of
the addresses.
