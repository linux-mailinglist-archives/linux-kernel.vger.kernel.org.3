Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0539453D785
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 17:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237849AbiFDPlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 11:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiFDPlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 11:41:52 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2EFC72
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 08:41:49 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id xVuMnyqaXdl7zxVuNnoGaF; Sat, 04 Jun 2022 17:41:47 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 04 Jun 2022 17:41:47 +0200
X-ME-IP: 90.11.190.129
Message-ID: <a08c5dd0-279d-724a-4836-6e66bfa183e8@wanadoo.fr>
Date:   Sat, 4 Jun 2022 17:41:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] regulator: mp5416: alphabetically sort header
 includes
Content-Language: fr
To:     Robert Marko <robimarko@gmail.com>, sravanhome@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220604145624.47326-1-robimarko@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220604145624.47326-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 04/06/2022 à 16:56, Robert Marko a écrit :
> Sort the header include list alphabetically.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>   drivers/regulator/mp5416.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/regulator/mp5416.c b/drivers/regulator/mp5416.c
> index 39cebec0edb6..d8245080df03 100644
> --- a/drivers/regulator/mp5416.c
> +++ b/drivers/regulator/mp5416.c
> @@ -6,14 +6,14 @@
>   //
>   // Author: Saravanan Sekar <sravanhome@gmail.com>
>   
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
>   #include <linux/kernel.h>

Nitpick: it seems that kernel.h is not needed here. (at least it compile 
without it).

CJ

>   #include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/err.h>
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
>   #include <linux/regulator/driver.h>
> -#include <linux/i2c.h>
>   
>   #define MP5416_REG_CTL0			0x00
>   #define MP5416_REG_CTL1			0x01

