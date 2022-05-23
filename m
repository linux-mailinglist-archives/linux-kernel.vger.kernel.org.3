Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF99530C23
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiEWIyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbiEWIyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:54:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133F82458B;
        Mon, 23 May 2022 01:54:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6B8AB1F40045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653296046;
        bh=5Rz9++MofB5VX7lCcC6PcfJLnooPHyGb9BzFs4NR7Ek=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rn7uMyAi++FEAgt9YN7b/3tJ3AyEoknlpGFy5UppiR9PQ/BDoqeBZkqbUVnUbAed6
         NjJy5gaiUIJIZZ8CArLqSbazTfkgLTogGuGIZwwlPqG8yhPt1lcgydXm+5TR23u87R
         5vo89AurSnCoWq8uiUNwHI6UMCHlh0gp+Tt+KJ3wC7QOXLFCyNK83icA7BI/WAO27q
         u+xklQ48YrIEK5V3UrEOaFQj9MPaQc2FuXxyOCfJQBEuBMRlUCIvoqsmryN+TJn7UR
         e+s01xunyBMzTCLytsLirGxbkzT+HAngUpUrFI3LjKqTGqT5/bJRLZ19dv/Nh1SoZG
         9Tt4jqO/WA/kw==
Message-ID: <56598535-5aa4-020e-25fd-295416f4d979@collabora.com>
Date:   Mon, 23 May 2022 10:54:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/5] Input: mtk-pmic-keys - Add kerneldoc to driver
 structures
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     matthias.bgg@gmail.com, mkorpershoek@baylibre.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220520125132.229191-1-angelogioacchino.delregno@collabora.com>
 <20220520125132.229191-2-angelogioacchino.delregno@collabora.com>
 <YosOsgPwMGuLk9dv@google.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YosOsgPwMGuLk9dv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/05/22 06:33, Dmitry Torokhov ha scritto:
> Hi AngeloGioacchino,
> 
> On Fri, May 20, 2022 at 02:51:28PM +0200, AngeloGioacchino Del Regno wrote:
>> To enhance human readability, add kerneldoc to all driver structs.
> 
> I am doubtful that this is useful. The reason is that I believe
> kerneldoc format is only useful for documenting cross-subsystem APIs.
> Kerneldoc for driver-private data and functions simply pollutes API
> docs.
> 
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/input/keyboard/mtk-pmic-keys.c | 30 +++++++++++++++++++++++++-
>>   1 file changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
>> index c31ab4368388..8e4fa7cd16e6 100644
>> --- a/drivers/input/keyboard/mtk-pmic-keys.c
>> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
>> @@ -34,6 +34,13 @@
>>   #define MTK_PMIC_HOMEKEY_INDEX	1
>>   #define MTK_PMIC_MAX_KEY_COUNT	2
>>   
>> +/**
>> + * struct mtk_pmic_keys_regs - PMIC keys per-key registers
>> + * @deb_reg:             Debounced key status register
>> + * @deb_mask:            Bitmask of this key in status register
>> + * @intsel_reg:          Interrupt selector register
>> + * @intsel_mask:         Bitmask of this key in interrupt selector
>> + */
>>   struct mtk_pmic_keys_regs {
>>   	u32 deb_reg;
>>   	u32 deb_mask;
>> @@ -50,6 +57,11 @@ struct mtk_pmic_keys_regs {
>>   	.intsel_mask		= _intsel_mask,		\
>>   }
>>   
>> +/**
>> + * struct mtk_pmic_regs - PMIC Keys registers
>> + * @keys_regs:           Specific key registers
> 
> This new description of the structure and of the keys_regs does not add
> any information for me.
> 
>> + * @pmic_rst_reg:        PMIC Keys reset register
>> + */
>>   struct mtk_pmic_regs {
>>   	const struct mtk_pmic_keys_regs keys_regs[MTK_PMIC_MAX_KEY_COUNT];
>>   	u32 pmic_rst_reg;
>> @@ -85,15 +97,31 @@ static const struct mtk_pmic_regs mt6358_regs = {
>>   	.pmic_rst_reg = MT6358_TOP_RST_MISC,
>>   };
>>   
>> +/**
>> + * struct mtk_pmic_keys_info - PMIC Keys per-key params
>> + * @keys:                Pointer to main driver structure
> 
> That is obvious from the field definition.
> 
>> + * @regs:                Register offsets/masks for this key
> 
> Ditto.
> 
>> + * @keycode:             Key code for this key
> 
> Yep.
> 
>> + * @irq:                 Keypress or press/release interrupt
>> + * @irq_r:               Key release interrupt (optional)
>> + * @wakeup:              Indicates whether to use this key as a wakeup source
>> + */
>>   struct mtk_pmic_keys_info {
>>   	struct mtk_pmic_keys *keys;
>>   	const struct mtk_pmic_keys_regs *regs;
>>   	unsigned int keycode;
>>   	int irq;
>> -	int irq_r; /* optional: release irq if different */
>> +	int irq_r;
>>   	bool wakeup:1;
>>   };
>>   
>> +/**
>> + * struct mtk_pmic_keys - Main driver structure
>> + * @input_dev:           Input device pointer
> 
> I do not find this helpful.
> 
>> + * @dev:                 Device pointer
> 
> And neither this.
> 
>> + * @regmap:              Regmap handle
> 
> Nor this.
> 
>> + * @keys:                Per-key parameters
>> + */
>>   struct mtk_pmic_keys {
>>   	struct input_dev *input_dev;
>>   	struct device *dev;
>> -- 
>> 2.35.1
>>
> 
> In the end we ended up with something that now has a chance of
> introducing warning when someone changes code, for very little benefit,
> if any at all.
> 
> For driver-private data and functions we should rely on expressive
> variable and function names and only use comments for something that
> might be unclear or requires additional qualification.
> 

Hello Dmitry,

it's been very helpful for me to see kerneldoc documentation in the various
drivers across the kernel - helped me understanding what was going on in an
easier, more immediate way, especially when looking at drivers having some
kind of "complicated" flow.
About introducing warnings when someone changes code, I believe that this
may also be helpful (for a developer) in some *corner* cases, but I agree
that this is unnecessarily tedious in some others... in the end, it's all
about personal opinions...

Of course, some of the documentation being obvious is unavoidable when it
comes to kerneldoc as you either document 'em all, or nothing.

In any case, if you really dislike having this kind of documentation, I can
drop these commits and eventually add in-line comments to some variables to
make them perfectly understandable, or I can avoid documenting at all (even
though I am strongly for documenting things clearly).

Regards,
Angelo

> Thanks.
> 
