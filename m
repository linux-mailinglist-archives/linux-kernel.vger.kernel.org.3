Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BE55ABD84
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 08:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiICGs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 02:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiICGsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 02:48:55 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CF46A59BD;
        Fri,  2 Sep 2022 23:48:53 -0700 (PDT)
Received: from [192.168.100.8] (unknown [112.20.110.237])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnmvO+BJj3VsQAA--.55696S3;
        Sat, 03 Sep 2022 14:48:47 +0800 (CST)
Message-ID: <f05f2c68-70cf-60b7-49a9-f531f329de5c@loongson.cn>
Date:   Sat, 3 Sep 2022 14:48:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] counter: Realign counter_comp comment block to 80
 characters
To:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220902120839.4260-1-william.gray@linaro.org>
From:   YanTeng Si <siyanteng@loongson.cn>
In-Reply-To: <20220902120839.4260-1-william.gray@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxnmvO+BJj3VsQAA--.55696S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtFW5Zr1xZr4UKr48Gw48JFb_yoW7trW5pF
        Wq9rs8Cw1293W8Z3sFyw48X3W5Gw4FvF43Ca9Fga4UArnFk3s5WFyDKr10qw4UJanYyFyD
        A3W8X34UXa18GaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
        9x07bwQ6XUUUUU=
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/2 20:08, William Breathitt Gray 写道:
> The member documentation comment lines for struct counter_comp extend
> past the 80-characters column boundary due to extra identation at the
> start of each section. This patch realigns the comment block within the
> 80-characters boundary by removing these superfluous indents.
>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>   include/linux/counter.h | 40 ++++++++++++++++++++--------------------
>   1 file changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index 1fe17f5adb09..a81234bc8ea8 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -38,64 +38,64 @@ enum counter_comp_type {
>    * @type:		Counter component data type
>    * @name:		device-specific component name
>    * @priv:		component-relevant data
> - * @action_read:		Synapse action mode read callback. The read value of the
> + * @action_read:	Synapse action mode read callback. The read value of the
>    *			respective Synapse action mode should be passed back via
>    *			the action parameter.
> - * @device_u8_read:		Device u8 component read callback. The read value of the
> + * @device_u8_read:	Device u8 component read callback. The read value of the
>    *			respective Device u8 component should be passed back via
>    *			the val parameter.
> - * @count_u8_read:		Count u8 component read callback. The read value of the
> + * @count_u8_read:	Count u8 component read callback. The read value of the
>    *			respective Count u8 component should be passed back via
>    *			the val parameter.
> - * @signal_u8_read:		Signal u8 component read callback. The read value of the
> + * @signal_u8_read:	Signal u8 component read callback. The read value of the
>    *			respective Signal u8 component should be passed back via
>    *			the val parameter.
> - * @device_u32_read:		Device u32 component read callback. The read value of
> + * @device_u32_read:	Device u32 component read callback. The read value of
>    *			the respective Device u32 component should be passed
>    *			back via the val parameter.
> - * @count_u32_read:		Count u32 component read callback. The read value of the
> + * @count_u32_read:	Count u32 component read callback. The read value of the
>    *			respective Count u32 component should be passed back via
>    *			the val parameter.
> - * @signal_u32_read:		Signal u32 component read callback. The read value of
> + * @signal_u32_read:	Signal u32 component read callback. The read value of
>    *			the respective Signal u32 component should be passed
>    *			back via the val parameter.
> - * @device_u64_read:		Device u64 component read callback. The read value of
> + * @device_u64_read:	Device u64 component read callback. The read value of
>    *			the respective Device u64 component should be passed
>    *			back via the val parameter.
> - * @count_u64_read:		Count u64 component read callback. The read value of the
> + * @count_u64_read:	Count u64 component read callback. The read value of the
>    *			respective Count u64 component should be passed back via
>    *			the val parameter.
> - * @signal_u64_read:		Signal u64 component read callback. The read value of
> + * @signal_u64_read:	Signal u64 component read callback. The read value of
>    *			the respective Signal u64 component should be passed
>    *			back via the val parameter.
> - * @action_write:		Synapse action mode write callback. The write value of
> + * @action_write:	Synapse action mode write callback. The write value of
>    *			the respective Synapse action mode is passed via the
>    *			action parameter.
> - * @device_u8_write:		Device u8 component write callback. The write value of
> + * @device_u8_write:	Device u8 component write callback. The write value of
>    *			the respective Device u8 component is passed via the val
>    *			parameter.
> - * @count_u8_write:		Count u8 component write callback. The write value of
> + * @count_u8_write:	Count u8 component write callback. The write value of
>    *			the respective Count u8 component is passed via the val
>    *			parameter.
> - * @signal_u8_write:		Signal u8 component write callback. The write value of
> + * @signal_u8_write:	Signal u8 component write callback. The write value of
>    *			the respective Signal u8 component is passed via the val
>    *			parameter.
> - * @device_u32_write:		Device u32 component write callback. The write value of
> + * @device_u32_write:	Device u32 component write callback. The write value of
>    *			the respective Device u32 component is passed via the
>    *			val parameter.
> - * @count_u32_write:		Count u32 component write callback. The write value of
> + * @count_u32_write:	Count u32 component write callback. The write value of
>    *			the respective Count u32 component is passed via the val
>    *			parameter.
> - * @signal_u32_write:		Signal u32 component write callback. The write value of
> + * @signal_u32_write:	Signal u32 component write callback. The write value of
>    *			the respective Signal u32 component is passed via the
>    *			val parameter.
> - * @device_u64_write:		Device u64 component write callback. The write value of
> + * @device_u64_write:	Device u64 component write callback. The write value of
>    *			the respective Device u64 component is passed via the
>    *			val parameter.
> - * @count_u64_write:		Count u64 component write callback. The write value of
> + * @count_u64_write:	Count u64 component write callback. The write value of
>    *			the respective Count u64 component is passed via the val
>    *			parameter.
> - * @signal_u64_write:		Signal u64 component write callback. The write value of
> + * @signal_u64_write:	Signal u64 component write callback. The write value of
>    *			the respective Signal u64 component is passed via the
>    *			val parameter.
>    */
>
> base-commit: a12224997bec72d231a8dd642876e6364decdc45

