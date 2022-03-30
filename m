Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9CE4EBD44
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244601AbiC3JLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiC3JLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:11:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5031D8331
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:09:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p26-20020a05600c1d9a00b0038ccbff1951so376689wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=pF/hvrI7qLDjIFK1PZiWN5svxVn5RrF/RKLGWeqqmq0=;
        b=YwlT6ooY5LZVCud47hjD3kjq5J2PtJRsbEtQHc6vflzUEeEpN8odscB+zjLMBN7stW
         hYn47ImQM/UY4YJ1Ru6twpC8LiFoOQ8LprNtUBavXaqVWHgOHFlbzCx756jylJNV3Yp9
         6/9t/A3XxA9qdzKF5+nCdP5aHR6tEF5+2GcZZVgmxJOEDmnwspBqLlcncg6zkL5ilwWr
         b8vlsb4NIVa9svDY8Wdm1gBQxnVAyl5MhAotSnIYqI7Rl+CvQLVQwExfQ3/PiXBnqQzn
         T//pXYch9DcznS2bDu+JjS2n2XbBY2N86LVJfZG6+M4SUbkHIk7q/1YDNmFmMZKmzNZj
         1oFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=pF/hvrI7qLDjIFK1PZiWN5svxVn5RrF/RKLGWeqqmq0=;
        b=QKTJQ76R2lD9gGQRfI/by8tpiBNF4mwslnKz4UcWWJ7XqQoJQJND5u1F6LGPhOzmIJ
         RsyLXIxMPRtotMhK0WruhqzzX8C9DZ8uCYkgJzAqvfiEJbbCkw4Pc+0bbDbcVzSumY+j
         QtWBtB9w+4tNCDWlJRUA9XrP0RQfMd9Q1/qHQdCbQixuVZN8gwSdy+6aI8ymVf6rn5px
         GPSo+M+WdQg1wiFgPfW9ZM4v70JJBov3OI0cFCzs7Gdk+NfyjSIiW25bQ41la8nphxqu
         w4GEDhS++M1QzYSIJU7aRtIBUfd0NmUxhncrH9DOB71I4AM4xcZ9eQmE4p3qhwl4aCvB
         hGlA==
X-Gm-Message-State: AOAM532e5XjWtbEuPna4HZM/4Ea5KoUffvIDaHGN2i/n98zHFsUM+NQD
        y1k4SLNQsz4vbiUtANdWOcRbYg==
X-Google-Smtp-Source: ABdhPJziTOza5+DSVLs+SpPhhmrhW5VtbyiLFPjGbJGLbqWH/uguopC9MkTPv25t1gHAv/kwvQCSyg==
X-Received: by 2002:a7b:c778:0:b0:38c:9064:89fc with SMTP id x24-20020a7bc778000000b0038c906489fcmr3396059wmk.175.1648631353152;
        Wed, 30 Mar 2022 02:09:13 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:e47f:3cdb:5811:cee8? ([2001:861:44c0:66c0:e47f:3cdb:5811:cee8])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d5988000000b00203d5f1f3e4sm18249681wri.105.2022.03.30.02.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 02:09:12 -0700 (PDT)
Message-ID: <1b0bc704-a740-ea15-1e90-166905be27d0@baylibre.com>
Date:   Wed, 30 Mar 2022 11:09:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 09/13] pinctrl: meson: Rename REG_* to MREG_*
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com>
 <20220329152926.50958-10-andriy.shevchenko@linux.intel.com>
 <94e888fe-d8fc-5379-302f-66d64f2ae10b@baylibre.com>
 <YkM22GwhxV+YKl8l@smile.fi.intel.com>
 <CAMuHMdWVA834tkeag=WOnHFGuhwZ93PkrgO24OV69Fye1hruLw@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <CAMuHMdWVA834tkeag=WOnHFGuhwZ93PkrgO24OV69Fye1hruLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2022 10:54, Geert Uytterhoeven wrote:
> Hi Andy,
> 
> On Tue, Mar 29, 2022 at 6:47 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> On Tue, Mar 29, 2022 at 06:13:19PM +0200, Neil Armstrong wrote:
>>> On 29/03/2022 17:29, Andy Shevchenko wrote:
>>>> Rename REG_* to * as a prerequisite for enabling COMPILE_TEST.
>>>
>>> What error do you hit ?
>>
>> arch/x86/include/asm/arch_hweight.h:9:17: error: expected identifier before string constant
>> 9 | #define REG_OUT "a"
>>    |                 ^~~
> 
> Perhaps REG_{OUT,IN} in arch/x86/include/asm/arch_hweight.h should be
> renamed instead, as this is a generic header file that can be included
> anywhere, while the REG_{OUT,IN} definitions are only used locally,
> in the header file?

Even better, those REG_OUT/REG_IN should be undefined at the end of the header since only
used in the headers inline functions:
==============><==================================
diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index ba88edd0d58b..139a4b0a2a14 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -52,4 +52,7 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
  }
  #endif /* CONFIG_X86_32 */

+#undef REG_IN
+#undef REG_OUT
+
  #endif
==============><==================================

Neil

> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds

