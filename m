Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047AC4B5504
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355938AbiBNPj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:39:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355908AbiBNPj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:39:56 -0500
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 07:39:48 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FADD606DD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:39:47 -0800 (PST)
Received: from photo-meter.com ([62.157.68.154]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mz9EL-1oEbbc0w3n-00wHhj for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022
 16:34:43 +0100
Received: from [192.168.100.109] (MICHA.fritz.box [192.168.100.109])
        by photo-meter.com (Postfix) with ESMTP id 80A3B3B08B7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:32:43 +0100 (CET)
Message-ID: <7da33ef9-67a4-343f-e97c-02d6bc40f2a9@photo-meter.com>
Date:   Mon, 14 Feb 2022 16:34:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Reply-To: anochin@photo-meter.com
Subject: Re: [PATCH 5.16 009/200] can: m_can: m_can_fifo_{read,write}: dont
 read or write from/to FIFO if length is 0
Content-Language: en-GB
To:     linux-kernel@vger.kernel.org
References: <20220131105233.561926043@linuxfoundation.org>
 <20220131105233.868161646@linuxfoundation.org>
From:   Michael Anochin <anochin@photo-meter.com>
Organization: Czibula und Grundmann GmbH
In-Reply-To: <20220131105233.868161646@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VahmHILKvtLozMpmCn4/yqTtVWIofz43e8vvUF3FTcqbUJTtyCi
 waqxShjNwhD3fyfPL0li5qyoodIemj+lFUuT4J0fzuZ8d98mizD66xfMGh2vphedLgd1YD/
 Ic0rxMtvj+d5iII8i+H+trPMLPbzo7nAiu1TctH/JX1HWWMq4/0vkz9cvp2xk+LKL998gRP
 3HBri9e5iWt074hb2uEAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ns1FS5/QL2E=:Vgfsgf4TxNL20J7JbIwsJs
 gv6eJy04w8N09TN1wNBs6RWqh8Uvjepc6xtrrl47JeJbrZa/5vpcw9qBNkkVTM4QQvdEWkzIw
 mtu3Gl5OrR4pB8gfPiiWuhKJrjgk3RO/aTejNgdQt1F5VReAyUVIu7lPwdzdORgbR/6ngo8Y7
 YpAj8TqNvH5yJTjHmc9mf699/zxSO1wOxw2fAkDw4hWbVoPWe0HiA0/WOWZr2lVvlMrMwTuL6
 caDmKsdWZfagRchD0Kwn2MzslwFcNYdeq3FAYJyDfsn0JGdvscOlW9Lqe2/aV871Y6V78wAed
 TMlTU3m4dQLMtbfJ6fvgBrVBDVGK961spnHxY70It0wWJz/Q3qrgjHzHCmuc9Eayb8AkGDoGu
 x0HCXFQzWxDa7kE/8ErIXysrRo/uWuN4KpiCp2NAkvChMnjNd+SJejzzfwdoElVGqYZibKfjA
 yrfef3YIxDW4aHoVwKsSUlpkj/+1xgy0Fred5FZE9Aw8pH8JQUXgZ0FGkVRGOV9wo9OxQmOL4
 ZWBNOA7I9GKtO1xcMzGqT6fsQF9H4VSboo2npNyVeauRSrZo2LbAUbFmZ6kOWMKbwFo2Onb51
 j5tIWpLR5P9HjzObjeDkP6YU4ovKkWRpreSme8dND+8mdRLdp+17L9G1kSAN7P06h9cO+B81x
 5xb8Tl4hfjKi4Qlfd4FfyxwF0s4OgMQ/aBDNOIoeIkYkq1Wbs76frXkE0GNVsLMqjfdhU0r8b
 W56xZYqv8xrAgQ8v
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There is no -22 error message now. Tested with "cansend can0 123#"

But now it floods continuous from __skb_queue_add_sort:

[ xxx.xxx] tcan4x5x spi0.0 can0: __skb_queue_add_sort: pos=0x000000, 
new=0x000000, diff= 0, queue_len=1

Only modprobe -r tcan4x5x or reboot helps


Hardware: RPI4 board with tcan4550 on spi0
Kernel 5.17.0-rc3-v7l+
from https://github.com/raspberrypi/linux/tree/rpi-5.17.y


Am 31.01.2022 um 11:54 schrieb Greg Kroah-Hartman:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> commit db72589c49fd260bfc99c7160c079675bc7417af upstream.
> 
> In order to optimize FIFO access, especially on m_can cores attached
> to slow busses like SPI, in patch
> 
> | e39381770ec9 ("can: m_can: Disable IRQs on FIFO bus errors")
> 
> bulk read/write support has been added to the m_can_fifo_{read,write}
> functions.
> 
> That change leads to the tcan driver to call
> regmap_bulk_{read,write}() with a length of 0 (for CAN frames with 0
> data length). regmap treats this as an error:
> 
> | tcan4x5x spi1.0 tcan4x5x0: FIFO write returned -22
> 
> This patch fixes the problem by not calling the
> cdev->ops->{read,write)_fifo() in case of a 0 length read/write.
> 
> Fixes: e39381770ec9 ("can: m_can: Disable IRQs on FIFO bus errors")
> Link: https://lore.kernel.org/all/20220114155751.2651888-1-mkl@pengutronix.de
> Cc: stable@vger.kernel.org
> Cc: Matt Kline <matt@bitbashing.io>
> Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>
> Reported-by: Michael Anochin <anochin@photo-meter.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/net/can/m_can/m_can.c |    6 ++++++
>   1 file changed, 6 insertions(+)
> 
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -336,6 +336,9 @@ m_can_fifo_read(struct m_can_classdev *c
>   	u32 addr_offset = cdev->mcfg[MRAM_RXF0].off + fgi * RXF0_ELEMENT_SIZE +
>   		offset;
>   
> +	if (val_count == 0)
> +		return 0;
> +
>   	return cdev->ops->read_fifo(cdev, addr_offset, val, val_count);
>   }
>   
> @@ -346,6 +349,9 @@ m_can_fifo_write(struct m_can_classdev *
>   	u32 addr_offset = cdev->mcfg[MRAM_TXB].off + fpi * TXB_ELEMENT_SIZE +
>   		offset;
>   
> +	if (val_count == 0)
> +		return 0;
> +
>   	return cdev->ops->write_fifo(cdev, addr_offset, val, val_count);
>   }
>   
> 
