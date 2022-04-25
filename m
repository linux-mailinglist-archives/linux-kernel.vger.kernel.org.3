Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57C750DFC8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiDYMTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbiDYMSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:18:51 -0400
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25FC1A04A;
        Mon, 25 Apr 2022 05:15:45 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru C9C9520DF1ED
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] USB: serial: pl2303: add device id for HP LM930 Display
To:     Scott Chen <scott@labau.com.tw>
CC:     <young@labau.com.tw>, <roger@labau.com.tw>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220425072454.33126-1-scott@labau.com.tw>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <3e03878f-2930-20fb-1983-bc56f23e1dc8@omp.ru>
Date:   Mon, 25 Apr 2022 15:15:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220425072454.33126-1-scott@labau.com.tw>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 4/25/22 10:24 AM, Scott Chen wrote:

> Add the device id for the HPLM930Display which is a PL2303GC based device
> 
> Signed-off-by: Scott Chen <scott@labau.com.tw>

[...]
> diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
> index c5406452b774..9d8102639e16 100644
> --- a/drivers/usb/serial/pl2303.h
> +++ b/drivers/usb/serial/pl2303.h
> @@ -135,6 +135,7 @@
>  #define HP_TD620_PRODUCT_ID	0x0956
>  #define HP_LD960_PRODUCT_ID	0x0b39
>  #define HP_LD381_PRODUCT_ID	0x0f7f
> +#define HP_LM930_PRODUCT_ID     0x0f9b

  Indent with a tab please, like the entries above and below.

>  #define HP_LCM220_PRODUCT_ID	0x3139
>  #define HP_LCM960_PRODUCT_ID	0x3239
>  #define HP_LD220_PRODUCT_ID	0x3524

MBR, Sergey
