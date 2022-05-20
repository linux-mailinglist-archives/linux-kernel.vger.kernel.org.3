Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F39552E875
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347556AbiETJN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbiETJN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:13:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD98118030;
        Fri, 20 May 2022 02:13:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kq17so14466104ejb.4;
        Fri, 20 May 2022 02:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=iyT30uEszkCa+aZ/40TmGWuqHZ6hjBWjF8lNdivRYyU=;
        b=j1eEm5wAAhrGavm6iYgNIUuBrWMqSrHfuYo8a+CV5AlZZjzPg617WjsleXaZfH7SMy
         xhZkeDF0n/HN8yMLKgPJPAzxik46vpDPMDjpf7erwURC5cNlFyqxVxdGQDvaAK/mot/+
         ba+HlzZYXXqzn5LycNlZwiMSCLgLH4P8+nFGHJcfaiJ1cG25dOcjlWus/4+k9bliau2D
         q3ByGbPCKfzBo9s15M4O+R2AxgWwUodWRti94ETgo1bMyrEAyOy6c/lG3rkjNISPPQz0
         MgqnDhoEHDscENkcreEw9cIvIH4SB10d+zCs3CsK3zW9YtjFKdfXSGYhoeMIpFIRQzNq
         W9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=iyT30uEszkCa+aZ/40TmGWuqHZ6hjBWjF8lNdivRYyU=;
        b=3fW9WC1Ss5TzRqngzVnBtUvh1qKTfyvmhvWp0hIGNDtrW3nm9ImzAG6dVIZP984hJH
         Ia4yLOt/vn9b1IMdOcKja4HQ0Wf753J0icgzDcFbgQMCGqaj7nUbNHgJAaaw/NTT3nCq
         awBgvi4MjHBy8TK+FIWlvhXfpWbeCQHz0Tkm9VdjgMIwIVCF9LbbCzN2Qa2p46EqTeCV
         pjqECeaa3tx10NNtc8Kv4RCVODzdSIwtZdPtQGu/JV8mm9yak4WH21FZOvIHFaDW8stY
         TTa8QFkVv5uUDpdiJbBMXIFaZVq1webaUv1fEJOs9TIfV4LUM5r+uA7fPIPcjD9RbpZh
         8nug==
X-Gm-Message-State: AOAM533/HvfMg/a2KwFtSeHsmV84TGMf/A7mK9E4faFd/Bb48EUT++WQ
        ci6Up3FOk81/h4DrRgBYBGA=
X-Google-Smtp-Source: ABdhPJzCxtK3/GDoGEo87WoOjtFl4CjJllOA3nui2brjs9JDd5jLcwgf560M6dUvKBhp4qeVfEjvzw==
X-Received: by 2002:a17:906:49d4:b0:6d6:e5ec:9a23 with SMTP id w20-20020a17090649d400b006d6e5ec9a23mr8030721ejv.79.1653038001094;
        Fri, 20 May 2022 02:13:21 -0700 (PDT)
Received: from [192.168.151.247] ([138.199.7.159])
        by smtp.gmail.com with ESMTPSA id eb22-20020a170907281600b006f4c557b7d2sm697876ejc.203.2022.05.20.02.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 02:13:20 -0700 (PDT)
Date:   Fri, 20 May 2022 13:13:05 +0400
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: reset: Add MT6735 reset bindings
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh@kernel.org>
Message-Id: <T9C6CR.ZDXJ22Q377EZ1@gmail.com>
In-Reply-To: <d54ea1d3-903f-0b2a-3db4-99f1adfadce0@collabora.com>
References: <20220519142211.458336-1-y.oudjana@protonmail.com>
        <20220519142211.458336-3-y.oudjana@protonmail.com>
        <d54ea1d3-903f-0b2a-3db4-99f1adfadce0@collabora.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, May 20 2022 at 10:55:24 +0200, AngeloGioacchino Del Regno 
<angelogioacchino.delregno@collabora.com> wrote:
> Il 19/05/22 16:22, Yassine Oudjana ha scritto:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>> Add reset definitions for Mediatek MT6735 resets provided by
>> infracfg and pericfg.
>> 
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>   MAINTAINERS                                   |  2 ++
>>   .../reset/mediatek,mt6735-infracfg.h          | 31 
>> +++++++++++++++++++
>>   .../reset/mediatek,mt6735-pericfg.h           | 31 
>> +++++++++++++++++++
>>   3 files changed, 64 insertions(+)
>>   create mode 100644 
>> include/dt-bindings/reset/mediatek,mt6735-infracfg.h
>>   create mode 100644 
>> include/dt-bindings/reset/mediatek,mt6735-pericfg.h
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a59069263cfb..1c0af554a7b6 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12503,6 +12503,8 @@ 
>> F:	include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
>>   F:	include/dt-bindings/clock/mediatek,mt6735-infracfg.h
>>   F:	include/dt-bindings/clock/mediatek,mt6735-pericfg.h
>>   F:	include/dt-bindings/clock/mediatek,mt6735-topckgen.h
>> +F:	include/dt-bindings/reset/mediatek,mt6735-infracfg.h
>> +F:	include/dt-bindings/reset/mediatek,mt6735-pericfg.h
>>     MEDIATEK MT76 WIRELESS LAN DRIVER
>>   M:	Felix Fietkau <nbd@nbd.name>
> 
> ..snip..
> 
>> diff --git a/include/dt-bindings/reset/mediatek,mt6735-pericfg.h 
>> b/include/dt-bindings/reset/mediatek,mt6735-pericfg.h
>> new file mode 100644
>> index 000000000000..6cdfaa7ddadf
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/mediatek,mt6735-pericfg.h
>> @@ -0,0 +1,31 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +
>> +#ifndef _DT_BINDINGS_RST_MT6735_PERICFG_H
>> +#define _DT_BINDINGS_RST_MT6735_PERICFG_H
>> +
>> +#define UART0_SW_RST			0
>> +#define UART1_SW_RST			1
>> +#define UART2_SW_RST			2
>> +#define UART3_SW_RST			3
>> +#define UART4_SW_RST			4
> 
> where's number 5?
> 
>> +#define BTIF_SW_RST			6
>> +#define DISP_PWM_SW_RST			7
>> +#define PWM_SW_RST			8
> 
> ...and where's 9?
> 
>> +#define AUXADC_SW_RST			10
>> +#define DMA_SW_RST			11
>> +#define IRDA_SW_RST			12
>> +#define IRTX_SW_RST			13
> 
> and 14, 15?
> 
>> +#define THERM_SW_RST			16
>> +#define MSDC2_SW_RST			17
>> +#define MSDC3_SW_RST			17
> 
> MSDC 2 and 3 are both 17?! :-)
> 
>> +#define MSDC0_SW_RST			19
>> +#define MSDC1_SW_RST			20
> 
> 21?
> 
>> +#define I2C0_SW_RST			22
>> +#define I2C1_SW_RST			23
>> +#define I2C2_SW_RST			24
>> +#define I2C3_SW_RST			25
>> +#define USB_SW_RST			28
>> +
> 
> and 29-32?
> 
>> +#define SPI0_SW_RST			33
>> +
>> +#endif
> 
> I have a hunch that you've misunderstood the changes in the resets...
> 
> What Rex-BC has done in his reset cleanup is exactly to stop directly
> mapping these to the actual bits that we're using... so the 
> definitions
> in there will simply be sequential, and the actual mapping is done in
> your clk-mt6735-pericfg.c driver.

I did notice that, but reading the documentation in reset.h:

 * @rst_idx_map:Pointer to an array containing ids if input argument is 
index.
 *		This array is not necessary if our input argument does not mean 
index.

I thought that it wasn't necessary to use it. Thinking
about it now however, I guess that was to maintain compatibility
with old device trees. I'll change it next time.
Maybe a note should be put there to avoid confusion
in the future.

Thanks,
Yassine



