Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B514EAB05
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiC2KI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiC2KIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:08:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0C2127589;
        Tue, 29 Mar 2022 03:06:42 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so949563wmb.4;
        Tue, 29 Mar 2022 03:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gJYdJOur1iY6XbbeGXFj0ECGEHoJkzCeSnRWw+1akAE=;
        b=g1SGsbd/jLtCfDq6yzASjQLg1D1Di4TRzjMb5UiIfrE9WiDmnp4ps8sIblZUNtYLhl
         BEYp/E3cwcQ3Zx0+p3QoptHL3A/ppqsLefEG80tXSSwr+mpdP4i1AcDwb/671KD/V7Or
         SrBc47ULMLUb19cniOzsSHJIDLc2hutPluz+X07qok/90+UjDzhv6DSHFkWqgCReRafg
         8hQGGxrcX5P2AlRlhAUeG7o275fLN5UY/luSiQ/PippZc5scePfD88DWfB5YY4mbajP2
         /wEv07hBPdodolgvcwPf/ryO4mcjf2pm6CqHleQKRp4LwbU9hZS+Lg1pg+jJITwfzWUK
         5rMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gJYdJOur1iY6XbbeGXFj0ECGEHoJkzCeSnRWw+1akAE=;
        b=tJUfPXpB3D2Xr+ifPFHavkeZNEPQfTtJn/OUXgNNdDNK7IJJvF28uxxd3HaUo5EoVl
         DU3BecZu54cfnnrUnz4gbwCDeYy475OG/I5eEv1ayFd8Mx/EX4N966VkSRN6OYQ3qMZL
         huOOgIHooNwpXcdJO3lzCWKt6VjlC675C9CDeICyDrvWVZfFonlA16xSs7Gd40B6sVTo
         OL7W0l+nS77jrGDwSJ6U7XlgmaeVhBHZssjRicRpVvjCMTCnrYv6JkjBdU+ld5L4QBYN
         WF4KkMsSnfX0T3+GHWOxQabWecMGtPSvmCXWLaMfGf/wNx5cgnsBkMgl9g+8Q2TfX6tp
         CI3A==
X-Gm-Message-State: AOAM533VsGwlnV6P5hUppzwI4BcK6mAItODsRNu2yon+FtI4iBdCf5Kb
        /TM+8NycYzU1/kB4h6W7Tgk=
X-Google-Smtp-Source: ABdhPJw/yl37bo84CH0/pwnTrqSkLHICdBHbZfyNAKleJ5pkLbBWcMtajlzC2TVgbnU7tHyn6wt30Q==
X-Received: by 2002:a05:600c:a47:b0:37c:965:2b6f with SMTP id c7-20020a05600c0a4700b0037c09652b6fmr5636166wmq.31.1648548400811;
        Tue, 29 Mar 2022 03:06:40 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d456b000000b0020406ce0e06sm14201716wrc.94.2022.03.29.03.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 03:06:39 -0700 (PDT)
Message-ID: <6dafde7d-17c6-bd25-dbe8-7f7acf80fd91@gmail.com>
Date:   Tue, 29 Mar 2022 12:06:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Palmer <daniel@0x0f.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-actions@lists.infradead.org, linux-sunxi@lists.linux.dev,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel@axis.com, linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        chrome-platform@lists.linux.dev,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org,
        linux-tegra <linux-tegra@vger.kernel.org>, linux-oxnas@groups.io,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-unisoc@lists.infradead.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-realtek-soc@lists.infradead.org
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <CAFr9PXkgrRe-=E=GhNnZ4w1x_FMb97-_RmX6ND1vEd74_TbZSw@mail.gmail.com>
 <YkK691VG6ON/6Ysn@atomide.com>
 <CAMuHMdXDDNTgBdJTa8+H1H5v1gAarp07xxWu_E1JL8mXS8HPMg@mail.gmail.com>
 <YkLXTWdZ3zASxr4H@atomide.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <YkLXTWdZ3zASxr4H@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/03/2022 11:54, Tony Lindgren wrote:
> * Geert Uytterhoeven <geert@linux-m68k.org> [220329 09:02]:
>> On Tue, Mar 29, 2022 at 10:03 AM Tony Lindgren <tony@atomide.com> wrote:
>>> For example, I have a pile of pending omap clock clean-up dts patches
>>> posted and tested waiting for v5.19-rc1 to apply. I'd rather not start
>>> redoing or fixing up the patches with sed :)
>>
>> Git merge/rebase/cherry-pick should handle renames fine?
> 
> Possibly.. Not sure I'd count on that based on my earlier experiences
> though :)
> 

Yes. If this could be split up in per silicon-vendor patches, the maintainer 
could take them. Although it might be a pain to soc maintainers to resolve small 
conflicts when merging that branches.

Just my 5 cents.

Matthias
