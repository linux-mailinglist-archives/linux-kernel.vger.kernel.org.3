Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836375375C9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiE3Hrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbiE3Hrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:47:35 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C8C231;
        Mon, 30 May 2022 00:47:33 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U754Gl030968;
        Mon, 30 May 2022 09:47:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=UBWQwj9S3yGVaktZPncCoGFJIIU7PVRDqaQkLPdqAMw=;
 b=veMvXMzPG9H0DTZ8eQWoZPR1ZXgcgfpmLftnzevsnkenHv0c17Z3b46MEE6Ndr8GPBgN
 nutc9doqf8hxiQuXCqxLufe/3xq8XdZDKo+iB9d6FpFLivxIlPCb50TQQcBBIu2IGAv1
 9Vgi7oqH7MKBlOiZsM03jzzYWlD6Vfb+Wo2z6u2ww6NiQuSRJlPHmKWRmWnrw/OP7JND
 aokeYFo6Ex5JaI549U1+8tXm3a8V5yDOumk1jUwx6w8P4eiK+A5UV/Y/j9PZKtpkqt38
 /KNh7PjWWOmotXe73vDLnmdhrB/na0m1McJCkSbqxMe5nHHEZPeGp+os0YXqaZx9HDFQ hw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gbc5084mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 May 2022 09:47:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AE23610002A;
        Mon, 30 May 2022 09:47:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 944AC2171DE;
        Mon, 30 May 2022 09:47:12 +0200 (CEST)
Received: from [10.251.21.188] (10.75.127.44) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 30 May
 2022 09:47:11 +0200
Message-ID: <85932bcc-cd9c-f804-7bde-39a1c48cf0ee@foss.st.com>
Date:   Mon, 30 May 2022 09:47:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] serial: st-asc: remove include of pm_runtime.h
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220525133733.1051714-1-claudiu.beznea@microchip.com>
 <20220525133733.1051714-4-claudiu.beznea@microchip.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20220525133733.1051714-4-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-30_02,2022-05-27_01,2022-02-23_01
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu

On 5/25/22 15:37, Claudiu Beznea wrote:
> st-asc driver doesn't use helpers from pm_runtime.h thus remove its
> include.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/tty/serial/st-asc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index 1b0da603ab54..cce42f4c9bc2 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -17,7 +17,6 @@
>  #include <linux/tty_flip.h>
>  #include <linux/delay.h>
>  #include <linux/spinlock.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/serial_core.h>


Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
