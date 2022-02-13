Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4C34B3E21
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbiBMWiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:38:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiBMWiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:38:07 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA5A54BCC;
        Sun, 13 Feb 2022 14:38:01 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b14so56840ede.9;
        Sun, 13 Feb 2022 14:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cEXqdohr4G9+8GbA7KQx27qyEW3APoDzbf1L0D0YWH8=;
        b=ffxsUMJtJAYyqcnlW20M2+b/TfBJ8V39bIEF3KCE580o77o6LZmQCS/y4WWWVKhaet
         PZf3lmLFTY5ZJvWRspWfYeiYvut0nvTcRd2LRAGAWvHqlyFtow5XfabfMHRNQGfdWt19
         uKF8eAWo27i4oXe8k/ENNR9iSuZxXXXdd631n3UghpS6SVSV3J77RsrbF1UchTUFhkf8
         xN2/Tik05F2ygZVzeMHwXw8rXCnBIj4+2tkRvBrN7c4r1L73fYUswKommSkkjFSEyBIn
         bYR9q0sJAyUvH4Yaz2OhwlgXx6h89RyrB87Dg27Fe1c6AizjXrrCxiDZd/cLBJl2EV7c
         lzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cEXqdohr4G9+8GbA7KQx27qyEW3APoDzbf1L0D0YWH8=;
        b=Nru4uPtNf3++5qF1Yl/2Tn5YkzraF1VWcLSVcIAyUfN6FpngPeTknazctu0ykEd4aG
         FTsfzGYdF+k/J6E3QuNFDXAZ7eH5N+Rz59ErG5XvQJa/VjIRyBf8W5IAB/QgYvusLDFB
         8jIn8suNrUW0lN+5Cjop567JMjBkbg/0aYxu6Q8KY764Ik+bzdeMdK9pbv7NLIZtR532
         EL5uy+8IKBp+nU8vQgfvOyzXdkbHkK1RS7da9l78tPigkb+QsdJ20xQMamUDXsjKAFhl
         J2/pRsIFbbMV5opUcHCT77q0gncXE8FytuR3F4DsHaqPadV8N+ZSKCzrrw7xv/YiAc05
         Rr6w==
X-Gm-Message-State: AOAM533DJaa6YYGMZMNUhJSR9f2v+TYkJo88d1kPCvKG/NK6McDEswW0
        7srKzUsTlTT/MdcPrHFKCtpSTDJCqyJQnw==
X-Google-Smtp-Source: ABdhPJyIZ+hHn+p2OPrMqebzhRMDtiUoxNbGmGCTjygFoEoLxQHFg4MN0PBxc+cflZCb/RxHSjN18w==
X-Received: by 2002:a05:6402:5113:: with SMTP id m19mr12526413edd.325.1644791879954;
        Sun, 13 Feb 2022 14:37:59 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j19sm1210807ejo.202.2022.02.13.14.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Feb 2022 14:37:59 -0800 (PST)
Message-ID: <ce20d22f-c42b-81af-4e02-c120be62e958@gmail.com>
Date:   Sun, 13 Feb 2022 23:37:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] dt-bindings: crypto: convert rockchip-crypto to yaml
Content-Language: en-US
To:     LABBE Corentin <clabbe@baylibre.com>, heiko@sntech.de,
        robh+dt@kernel.org
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20220211115925.3382735-1-clabbe@baylibre.com>
 <dba5684a-1e5f-a4d4-604b-651751636cf3@gmail.com> <Yga9d5C2f1ubOok8@Red>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <Yga9d5C2f1ubOok8@Red>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/22 20:48, LABBE Corentin wrote:
> Le Fri, Feb 11, 2022 at 02:13:00PM +0100, Johan Jonker a écrit :
>>
>>
>> On 2/11/22 12:59, Corentin Labbe wrote:
>>> Convert rockchip-crypto to yaml
>>>
>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>> ---
>>> Changes since v1:
>>> - fixed example
>>> - renamed to a new name
>>> - fixed some maxItems
>>>
>>> Change since v2:
>>> - Fixed maintainers section
>>>
>>>  .../crypto/rockchip,rk3288-crypto.yaml        | 66 +++++++++++++++++++
>>>  .../bindings/crypto/rockchip-crypto.txt       | 28 --------
>>>  2 files changed, 66 insertions(+), 28 deletions(-)
>>
>>>  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
>>
>> There's more possible to this document:
>>
>> dt-bindings: crypto: rockchip: add support for px30
>> https://github.com/rockchip-linux/kernel/commit/3655df1bc6114bda2a6417f39772a3cb008084ea
>>
>> crypto: rockchip - add px30 crypto aes/des support
>> https://github.com/rockchip-linux/kernel/commit/ee082ae4f609f3b48f768420b31d8600448bd35a
>>
> 

> Hello
> 
> The great advantage of out of tree code is that we can ignore it.

See comment below.
This is not about code, but about reusing the (generic) binding for more
SoCs then just rk3288 that happened to have Linux support.
See spi-rockchip.yaml rockchip-dw-mshc.yaml etc.

> Anyway, if one day this code goes upstream, I think the new compatible should be in a new driver/module, both v1 and v2 are too different for me to be shared in the same driver.
> 
> But before upstreaming this code, the one in mainline should be fixed first, it fail self tests. (I have some patch partialy fixing it in progress)
> 

Success! Send us lots of patches...
Is it possible to keep portability (to U-boot) in mind for multiple
Rockchip SoC types.

> Regards
> 

Although DT and bindings are hosted in the Linux tree they are separate
things. DT files and bindings can be used elsewhere. There's no need for
(full) Linux driver support. For Rockchip crypto nodes this is mostly
done in the Manufacturer U-boot tree.

https://github.com/rockchip-linux/u-boot/blob/next-dev/drivers/crypto/rockchip/crypto_v1.c

https://github.com/rockchip-linux/u-boot/blame/next-dev/drivers/crypto/rockchip/crypto_v2.c

Given Krzysztof's comment:

> file name: rockchip,crypto.yaml or rockchip,rk3288-crypto.yaml.
> Kind of depends whether there is another binding possible for newer
> Crypto blocks from Rockchip.

For U-boot the Rockchip dtsi files are synced from the Linux tree,
so it may well be possible that someone add them here and use them
elsewhere if needed.

From the links to the files above we can expect:
crypto v1:
	{ .compatible = "rockchip,rk312x-crypto" },
	{ .compatible = "rockchip,rk322x-crypto" },
	{ .compatible = "rockchip,rk3288-crypto" },
	{ .compatible = "rockchip,rk3328-crypto" },
	{ .compatible = "rockchip,rk3368-crypto" },
	{ .compatible = "rockchip,rk3399-crypto" },

crypto v2:
	{ .compatible = "rockchip,px30-crypto" },
	{ .compatible = "rockchip,rk1808-crypto" },
	{ .compatible = "rockchip,rk3308-crypto" },
	{ .compatible = "rockchip,rv1126-crypto" },
	{ .compatible = "rockchip,rk3568-crypto" },
	{ .compatible = "rockchip,rk3588-crypto" },

With only small nodes differences for clocks we reuse the "generic"
binding and NOT a (rk3288) SoC orientated one.

Johan



