Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0909E5B1CAC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiIHMVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiIHMV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:21:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C6A11C15E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:21:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f11so13409359lfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=VgEQBzw8CkYfD0tP7q7CxKLDwxdimyf08wYdm+SsNM4=;
        b=JE1lwkLdwJjyylYh6CyMucqBmO10IDxKkLskdbPjbV+hFAmyhcGhrysugJC6gpLh3u
         UTjlfGQAm7CSZn2UzNfKJVwXpJvcGAvEUY37GR+a6TUpZZkwgJT9mBWjD6xrnW4+DnET
         G6Afz4SSXRiSPgRR4TEe6LPng8N/rCbJ1ApYoKI+YhEMlgOctkYIxY4V5n//tIhS5z6U
         DDVnctzdgoGGro8KojCs+YWeobRoImK/yNmoCr3m5H22ikFRXBgtpXlLlT+Pvz2W3ZCn
         dP7saY7lfj0IreSJ/AWm1thwoiLK027MbbAAyg1nk083yGLgzomJOF783aGxsl8Yval/
         pUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VgEQBzw8CkYfD0tP7q7CxKLDwxdimyf08wYdm+SsNM4=;
        b=2xkhVWZZXE4um7iuYqxzakOrlWInaLXhOqXzkdlb5GdIUWA77/h9k130Hj/z0qa5qF
         mqxd9yCI1s1QgGxVMESXJKdr0kr6e5Rqb0EkBTKqgdLcZLNjTmY35xWV1Lrx33m8M0ql
         z1Vw/NsDRWSe6p6E6U+mrx0jArb1stAQsWr/HVH2MPOMEUkv47xkoNR9GQzYTyM6Xbog
         IlLjx1Irhycr2Ydr6z4EGYRVLbnuNYwIt7OoHItbh9RtjNS3JLue/s8FHIX0xl8qq7EN
         VfKjgTWN4QpqtJF1qEACDHcsb2MEcwbo7WLCwAu1rEsESm85CzG2xCPftMsfbZaHLitV
         zaaQ==
X-Gm-Message-State: ACgBeo3wleAZ5VjDAAfqrRaN1ZnrXZhhSbxilJMojo4Ptt3hNt5Xr1NL
        4rVEvU47WD32e5iQFSf5cz7aDZg6on9Zlg==
X-Google-Smtp-Source: AA6agR4tuDhl0ADnXwL3Hle5HBL36tuaPl5fK8SbbKt05XtYQZiLpAzFF+LyOp31cFAZNVH2s6NpaA==
X-Received: by 2002:a05:6512:2391:b0:494:7f90:ac04 with SMTP id c17-20020a056512239100b004947f90ac04mr2624366lfv.521.1662639685495;
        Thu, 08 Sep 2022 05:21:25 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bg37-20020a05651c0ba500b0026acc9edecdsm1060276ljb.47.2022.09.08.05.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 05:21:24 -0700 (PDT)
Message-ID: <f89cede6-f312-3500-c900-0468200a4464@linaro.org>
Date:   Thu, 8 Sep 2022 14:21:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 14/20] dt-bindings: mtd: relax the nvmem compatible
 string
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20220901221857.2600340-1-michael@walle.cc>
 <20220901221857.2600340-15-michael@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901221857.2600340-15-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2022 00:18, Michael Walle wrote:
> The "user-otp" and "factory-otp" compatible string just depicts a
> generic NVMEM device. But an actual device tree node might as well
> contain a more specific compatible string. Make it possible to add
> more specific binding elsewhere and just match part of the compatibles
> here.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v1:
>  - fix typo in commit message


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
