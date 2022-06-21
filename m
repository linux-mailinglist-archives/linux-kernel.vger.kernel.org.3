Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17851552A15
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbiFUEMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 00:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiFUEMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 00:12:52 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C35D19019;
        Mon, 20 Jun 2022 21:12:50 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CB03632004F8;
        Tue, 21 Jun 2022 00:12:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 21 Jun 2022 00:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1655784768; x=
        1655871168; bh=YFC9enACBq9N/iDDvL+ELyNOFTG6bJu/nZay/ScaEg4=; b=C
        1M85zd3eSzPbPbrqJLqJf9XGPjCp5qspTW0Pb2G5upYU2zzPTmqd1H/GkSDF4R2h
        jTVkPgJvlPCbUT6D66cr5MOagfZp8/qJ7gT7m6CH/IPz1QgwP5kmuhn2pcMJ+Bjq
        wF3m6DwBEx8ZkjB9ljR1S07Y371FLj2Rk4NejXkBpjEyR1qdIpmSmNNV/St6FPaX
        Axq3ihYYd9b+xHhWwlk4BM9Ze4n+fNrYaOeJYCXxsgDruW8N2Niew1cwoZ7I6oOe
        ZmRbDc5CSGn+GXqrjbz/U4POJ0yx9yl+FXAEafjH5TgkODpPrvBLIzxVO3B5T9mK
        mnzQnlTfPmlOth79Drw5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655784768; x=
        1655871168; bh=YFC9enACBq9N/iDDvL+ELyNOFTG6bJu/nZay/ScaEg4=; b=O
        eb/c7KAsWiuQnepLqcYmFDJjhF1toXYwtArej8zdAYFOE4m6yXPYTKUgH8DFUAXT
        CBCYQPUEnqhlY9h1iOeG4lFU8VqoZAYJxlU7Jwkwkangi5r3GhyuXcvc3bhvgydU
        mEodnq47L0sIIQoNhDYj9+sLqkfddMBdepKvDioqFEr/DwquVHV9bQr55sUgy3YQ
        d7U/L0jmpEC4IUz0LR/iiWEp+ZahM5L7hGyFEk1uB6mC4kkJPZ0fC4MUanPnu48s
        TROyoixs26PBdxrFpylGlkzEiwvXMr0HmCLvWfVor5suPMHuhfpg/NFBxmvb0SUu
        hnuE4vdC8TYCbD8YSqzXA==
X-ME-Sender: <xms:P0WxYjYjZ3ggPBjDznWxsI_xY88tokEBwsrabMSJZbYDlkUfkHjB_A>
    <xme:P0WxYiaeSn9xZHM91Omj9O1gEj1CeUlw5Cuo0NzXTt25cdmRtiwHvXnk406dSw7cn
    QmbkPp8P_YOomyrMw>
X-ME-Received: <xmr:P0WxYl_SQ_N1Ya67JdJFmg_rf_xGTABdGNn7CMC8qhixECYKAfFfJkvMhccd-js5zOaVINHxk5Hz_cVuzOKI1qZUC1w3ocUErsyvNebn47IxdQZUMxleYYhEmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefvddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:P0WxYppYWRlEAXkE22DXCaxNCPu73OOgNvnNwi2VBHxTiY3YPJpGlQ>
    <xmx:P0WxYurZ4IZK3fxEpNCPDQwbYfqJ8qv1cVEohuIkX23OpSkliM2ADA>
    <xmx:P0WxYvSgI8J-br5kRUO6Z23iXeq7YmrJ52h-uo2E3zH7WsIDnIGfyg>
    <xmx:QEWxYqcQmHZbcl19fcgCPek4ZOHVkFaKzIR8XNo3U8HDxpcmdvJ9AQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jun 2022 00:12:47 -0400 (EDT)
Subject: Re: [PATCH v4 2/4] Input: pinephone-keyboard - Add PinePhone keyboard
 driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Jirman <x@xff.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev
References: <20220618165747.55709-1-samuel@sholland.org>
 <20220618165747.55709-3-samuel@sholland.org>
 <CAHp75VcXNTxusT5N_8JvYWMhUyY_sAUzTcT3h0hz2bAawv6ThQ@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <2e6499b8-d8f4-b63a-689b-1e93aca7c210@sholland.org>
Date:   Mon, 20 Jun 2022 23:12:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcXNTxusT5N_8JvYWMhUyY_sAUzTcT3h0hz2bAawv6ThQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/22 6:43 AM, Andy Shevchenko wrote:
> On Sat, Jun 18, 2022 at 7:10 PM Samuel Holland <samuel@sholland.org> wrote:
>>
>> The official Pine64 PinePhone keyboard case contains a matrix keypad and
>> a MCU which runs a libre firmware. Add support for its I2C interface.
> 
> ...
> 
>> +#include <linux/crc8.h>
>> +#include <linux/i2c.h>
>> +#include <linux/input/matrix_keypad.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/regulator/consumer.h>
> 
> Missed
> types.h
> 
> ...
> 
>> +#define PPKB_ROWS                      6
>> +#define PPKB_COLS                      12
> 
> ...
> 
>> +       for (col = 0; col < PPKB_COLS; ++col) {
>> +               u8 old = old_buf[1 + col];
>> +               u8 new = new_buf[1 + col];
>> +               u8 changed = old ^ new;
>> +
>> +               if (!changed)
>> +                       continue;
>> +
>> +               for (row = 0; row < PPKB_ROWS; ++row) {
>> +                       u8 mask = BIT(row);
>> +                       u8 value = new & mask;
>> +                       unsigned short code;
>> +                       bool fn_state;
>> +
>> +                       if (!(changed & mask))
>> +                               continue;
>> +
>> +                       /*
>> +                        * Save off the FN key state when the key was pressed,
>> +                        * and use that to determine the code during a release.
>> +                        */
>> +                       fn_state = value ? ppkb->fn_pressed : ppkb->fn_state[col] & mask;
>> +                       if (fn_state)
>> +                               ppkb->fn_state[col] ^= mask;
> 
> Can't it be converted to use bitmap APIs?

This is a 2D matrix, with one byte per column, and one bit per row. There are
only 6 rows, so two bits per byte are unused. Converting this to the bitmap API
would unnecessarily complicate things.

>> +               }
>> +       }
> 
> ...
> 
>> +static int ppkb_set_scan(struct i2c_client *client, bool enable)
>> +{
>> +       struct device *dev = &client->dev;
>> +       int ret, val;
>> +
>> +       ret = i2c_smbus_read_byte_data(client, PPKB_SYS_CONFIG);
>> +       if (ret < 0) {
>> +               dev_err(dev, "Failed to read config: %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       if (enable)
>> +               val = ret & ~PPKB_SYS_CONFIG_DISABLE_SCAN;
>> +       else
>> +               val = ret | PPKB_SYS_CONFIG_DISABLE_SCAN;
>> +       ret = i2c_smbus_write_byte_data(client, PPKB_SYS_CONFIG, val);
>> +       if (ret) {
>> +               dev_err(dev, "Failed to write config: %d\n", ret);
> 
>> +               return ret;
>> +       }
>> +
>> +       return 0;
> 
> return ret;

The "return 0" pattern is idiomatic, and more diff-friendly when adding error
handling or more operations. But I don't have that strong of an opinion on it.

Regards,
Samuel
