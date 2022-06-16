Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B29754E7FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378390AbiFPQqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiFPQqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:46:34 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3FF50E3B;
        Thu, 16 Jun 2022 09:45:30 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n11so2057488iod.4;
        Thu, 16 Jun 2022 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2nZIbA02OXNIyOJXo7QF5v3mB7RiS92/ilxeBqv2VfA=;
        b=AM9RhXBt+LsVNDi+BD7JqxRyoFeds10ltwQAurvIK++eeWSRboWL2CudUwDRxaQW5Z
         RCG1QYnkiqHPVunNNiioVe9/MaAS5TyGvz/yNjFf201p/y1TBPUZVdAVBgm8zPQ5TtBS
         iaUvX/3DpCIIDj4FDt8cB/gr0R5i/yfx309bLUl1BUcAf7DCqiSbfXVZB29oY68waMIz
         waNbvxOTYszbjEwe6zUwGzPKgnkoLvRGG5y4DXbGokBWao2defVOX6ElDFHf0pmlBQWh
         JfjaYWRkj4lfVm2cZrcKIi/YZ1MD/5L1Dbl+WrOtw8rD0VMuO3khgMd4K0yqcSopGyUg
         GOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2nZIbA02OXNIyOJXo7QF5v3mB7RiS92/ilxeBqv2VfA=;
        b=pKOGhjMlo5bONcXDt1/9NFrJdV79iraY+oWZGdwVsueDpPkG836aPnkY9P4BX1rM4o
         QeAAvHs4wAqCw/G5+FNVvJRkV0VHZoCIQzCmTgvG8Yju2EsizIHEJxKI9vJAyPrmQbtm
         v1ZR8m+zuPct7MIDR/9jPmhTjbhSgu7wp4Xaaq2YvMuxUvEte35zOi3sEzhuBP7+S0qK
         R2vxQQwgCNbdoXEh0s66mCwTXkov08iOXwmgs41OEO002NhGCnlCHhUQ1LatydoPUxS2
         0t1l96SdxqLqhSSGVRQLLgP4rUUi+aiUv/JzW6L5mUl81QI22lChsilBbeCOhQgCzqWH
         9F8Q==
X-Gm-Message-State: AJIora+dqGsIGXQwwE8BQGwP1mvXXM2pz5IIZWaMfFSgazBhzAH/I9/I
        /QkPS904qinZVY0PHGzfqiA=
X-Google-Smtp-Source: AGRyM1tQ0Ty3qcwovZ4LFfcBf4Rj32abjfMSZ7jnhkPVz/YfOFNN3/WAGJtf7QB/DzEom5KAK2LLcg==
X-Received: by 2002:a05:6638:3291:b0:331:7589:677 with SMTP id f17-20020a056638329100b0033175890677mr3194294jav.96.1655397920307;
        Thu, 16 Jun 2022 09:45:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:7c5a:aa57:ff5:df70? ([2600:1700:2442:6db0:7c5a:aa57:ff5:df70])
        by smtp.gmail.com with ESMTPSA id g2-20020a925202000000b002d5199dab1fsm1184668ilb.42.2022.06.16.09.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 09:45:19 -0700 (PDT)
Message-ID: <afea990a-9378-e684-2129-e24393b60b4b@gmail.com>
Date:   Thu, 16 Jun 2022 11:45:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Default async probing for DT based systems
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <CAGETcx8z4dn1j05Za6nfDeC3v4r1yo30Nqu=1K2BEsvLcqqybQ@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAGETcx8z4dn1j05Za6nfDeC3v4r1yo30Nqu=1K2BEsvLcqqybQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

You failed to include me in the distribution.  Adding myself now...

-Frank

On 6/15/22 23:24, Saravana Kannan wrote:
> Hi,
> 
> TL;DR: I want to improve boot times by enabling async probing by
> default for DT based systems. Can you give it a shot please?
> 
> Why do you think it might work when async probing has been a pain before?
> ==========================================================
> Since fw_devlink=on is the default behavior and fw_devlink understands
> approximately 24 DT bindings, it should capture most of the device
> dependencies and ensure proper probe ordering. For example, on a Pixel
> 6, fw_devlink figures out 325 dependencies that it uses to enforce
> probe ordering.
> 
> You can find all the dependencies under /sys/class/devlink.
> 
> Fine! What do you want me to try?
> ==========================
> With the patches that have landed in 5.19-rc1, we can now enable
> default async probing for all built-in drivers by adding the following
> to the kernel command line:
> 
> driver_async_probe=*
> 
> I'd really appreciate it if folks can try adding driver_async_probe=*
> to their kernel command line and report any boot time
> improvements/regression or boot/probe failures it causes.
> 
> (* insert cat begging pic *)
> Can I haz some reports pleez?!
> 
> Tips:
> ====
> One easy way to check for devices probe failures is to compare the
> output of this command with/without the commandline changes:
> 
> # find /sys/devices -name driver
> 
> Btw, if you need to force sync probing for a few drivers so that your
> rootfs mounts properly, you can set the flag in the driver, or you can
> list them as exceptions following the * in the command line option.
> For example:
> driver_async_probe=*,my_flash_driver,my_sdio_driver
> 
> Report these too.
> 
> Known issues:
> ===========
> fw_devlink doesn't yet support phy-handle and mdio-parent DT bindings.
> They have some tricky issues I need to resolve first and I need to add
> both of them together -- I'm working on it. If there are other DT
> bindings that are missing support, do let me know. Most of them are
> easy to add.
> 
> The driver_async_probe=* won't have any useful impact for modules
> without adding <module_name>.async_probe to the commandline or
> async_probe as a module option when loading it. This is because
> modules intentionally force sync before they exit. There's a patch for
> a global flag for modules too [1], but it can never be set by default
> for userspace reasons[2].
> 
> [1] - https://lore.kernel.org/lkml/20220604010101.719508-1-saravanak@google.com/
> [2] - https://lore.kernel.org/lkml/CA+55aFxV40V2WvNtJY3EC0F-B9wPk8CV2o1TTTyoF4CoWH7rhQ@mail.gmail.com/
> 
> Thanks,
> Saravana
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

