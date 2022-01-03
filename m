Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5EA4833D4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiACO7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbiACO7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:59:36 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3040EC061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 06:59:36 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q16so70425943wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 06:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5H8+sBp3xMqm86KdM4FfbpDukKAPfJggOz8BlfBh0A0=;
        b=RK8OFVPMmrUeM0KlR68rRcYWwzcq++PFtk4HPYE1VFCR7hcKJSxFeMJx9CYY3LVv4I
         moBWkIUB72yHyKJzb2tn80RFoo86sQotegnN4jkRGGTW0Y4M0uZhxBZdy+u24t1Anoui
         /yJk3zR/e+rzYVKwvYlku68nmAQEar/7dnpjR5pZCJpefR3UKfUw6Pjb94+xF0DwR4gU
         1WReOYWVG/AforOPDCdbrmc5/ETwXyc/S7xV4ulG90KG2TPZtBvGYnyo1WOi/3nKCvx+
         n1mPYTvy+sogfJnANtKI8K4sP2rIQ/34MMESO830pup8bsreJRkgnWCfu+kyJlNAktOT
         6TVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5H8+sBp3xMqm86KdM4FfbpDukKAPfJggOz8BlfBh0A0=;
        b=jLpdvQdkckNKPtKuAXvSeTgiZXNjR3nAeJC6RCauD/amOpSYEJAJZ9oU2QewcxwURm
         +B3Y69frfNdRO1Q8YC+OKSHffxgYMfzfNDHDm2b4E8RI/Llkl5jd3n3WScTJEnd13kcS
         sqdY+RpD8alby6GgMo6okdfQSTai3ljD7POQRvthLzwbabGQehZGJLm7y0hukASNAucz
         ul/4r4Oc235mPHeFUIyzE6oUmfiujsptE0JdffJZxXF3TEQEnJJxopvuBX2pphcib2no
         NfPzEBvPTGNJkWabAeBNG07meBZjDZGO3cijCvX8kRca2dKB9+uwRyUiGns0zeO1Nhht
         uM6A==
X-Gm-Message-State: AOAM530w4cbtPVvDaCeK46YdsE+riS6CXGKH1MMzJi+fo6RALjOVhxsM
        IeudlcpuJ9+5gV1DmvZ/r1dljw==
X-Google-Smtp-Source: ABdhPJzNfggYHG8TJY3E0zgdGOK7eTg4snQBM1YrXj6DPHwN8T5t2nQ4pLz3K5gTZi3Kb1NO8LzQmQ==
X-Received: by 2002:a5d:5847:: with SMTP id i7mr24397911wrf.450.1641221974698;
        Mon, 03 Jan 2022 06:59:34 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:7c9d:a967:38e2:5220? ([2001:861:44c0:66c0:7c9d:a967:38e2:5220])
        by smtp.gmail.com with ESMTPSA id w21sm30063985wmi.19.2022.01.03.06.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 06:59:34 -0800 (PST)
Subject: Re: [PATCH V3 1/6] tty: serial: meson: Drop the legacy compatible
 strings and clock code
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
References: <20211230102110.3861-1-yu.tu@amlogic.com>
 <20211230102110.3861-2-yu.tu@amlogic.com>
 <CAFBinCCwjS36ss_4sU+o9m8gEprFsVZbqcxgpQxczTNohZqFdA@mail.gmail.com>
 <a296e666-368b-4cd5-427e-30fc66a15b49@amlogic.com>
 <CAFBinCA2V=sx95Q=+4nLDXFK1Os11XVWtK8KauxixVwYXLUz1Q@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <3865f01c-83f7-a69d-6835-c26f662629b7@baylibre.com>
Date:   Mon, 3 Jan 2022 15:59:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCA2V=sx95Q=+4nLDXFK1Os11XVWtK8KauxixVwYXLUz1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Martin just saw this patch was applied, but the serie wasn't reviewed enough and it will break
earlycon support on the ARMv7 Amlogic SoCs fore 5.17.

Anyway, I'll push the corresponding DT fixes for 5.17-rc1.

Would it be possible we also receive the notification when those patches are applied ?
Maybe a MAINTAINERS entry is missing so we can receive them ?

It would help me track those TTY and USB patches more easily.

Thanks !

Neil

On 31/12/2021 16:35, Martin Blumenstingl wrote:
> On Fri, Dec 31, 2021 at 11:27 AM Yu Tu <yu.tu@amlogic.com> wrote:
> [...]
>>>> -/* Legacy bindings, should be removed when no more used */
>>>> -OF_EARLYCON_DECLARE(meson, "amlogic,meson-uart",
>>>> -                   meson_serial_early_console_setup);
>>> This part is still needed as long as above series is not merged yet.
>>> If we remove this then earlycon will stop working on the 32-bit SoCs
>>> unless [0] is merged.
>>>
>>> All other code below - except the of_device_id entry - can still be
>>> removed since meson8.dtsi and meson8b.dtsi are using the non-legacy
>>> clocks already.
>>>
>>> Sorry for only noticing this now.
>>>
>> I will add it back in the next patch and delete it after your submission
>> is merged.
> I have just seen that Greg has already added this patch to the tty-next tree [1]
> In this case there's nothing to do on your end - I'll simply ask Neil
> to also queue my 32-bit SoC UART .dts fixes [0] for 5.17
> 
> 
> Best regards,
> Martin
> 
> 
> [0] https://patchwork.kernel.org/project/linux-amlogic/cover/20211227180026.4068352-1-martin.blumenstingl@googlemail.com/
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-next&id=ad234e2bac274a43c9fa540bde8cd9f0c627b71f
> 

