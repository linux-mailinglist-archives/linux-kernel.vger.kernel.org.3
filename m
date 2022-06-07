Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F8A53F9ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbiFGJgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbiFGJfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:35:10 -0400
X-Greylist: delayed 191 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 02:35:06 PDT
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85AEE64D7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:35:05 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from [127.0.0.1] (unknown[60.213.227.6])
        by rmsmtp-lg-appmail-13-12002 (RichMail) with SMTP id 2ee2629f1affaed-e6591;
        Tue, 07 Jun 2022 17:31:44 +0800 (CST)
X-RM-TRANSID: 2ee2629f1affaed-e6591
Message-ID: <a3a9d315-3b40-832a-8901-9adcbca1016a@139.com>
Date:   Tue, 7 Jun 2022 17:31:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/1] MIPS: Loongson-3: fix compile mips cpu_hwmon as a
 module build error.
To:     Yupeng Li <liyupeng@zbhlos.com>, chenhc@lemote.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        caizp2008@163.com
References: <20220607021702.3224369-1-liyupeng@zbhlos.com>
From:   HU Zeyuan <huzeyuan139@139.com>
In-Reply-To: <20220607021702.3224369-1-liyupeng@zbhlos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

If you want to submit patches,please send the email to the correct 
maintainer(s),and CC the correct mailing list(s).

Zeyuan

在 2022/6/7 10:17, Yupeng Li 写道:
>    set cpu_hwmon as a module build with loongson_sysconf, loongson_chiptemp
>    undefined error,fix cpu_hwmon compile options to be bool.Some kernel
>    compilation error information is as follows:
> 
>    Checking missing-syscalls for N32
>    CALL    scripts/checksyscalls.sh
>    Checking missing-syscalls for O32
>    CALL    scripts/checksyscalls.sh
>    CALL    scripts/checksyscalls.sh
>    CHK     include/generated/compile.h
>    CC [M]  drivers/platform/mips/cpu_hwmon.o
>    Building modules, stage 2.
>    MODPOST 200 modules
> ERROR: "loongson_sysconf" [drivers/platform/mips/cpu_hwmon.ko] undefined!
> ERROR: "loongson_chiptemp" [drivers/platform/mips/cpu_hwmon.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:92：__modpost] 错误 1
> make: *** [Makefile:1261：modules] 错误 2
> 
> Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
> ---
>   drivers/platform/mips/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
> index b3ae30a4c67b..c2f1ede1caca 100644
> --- a/drivers/platform/mips/Kconfig
> +++ b/drivers/platform/mips/Kconfig
> @@ -16,7 +16,7 @@ menuconfig MIPS_PLATFORM_DEVICES
>   if MIPS_PLATFORM_DEVICES
>   
>   config CPU_HWMON
> -	tristate "Loongson CPU HWMon Driver"
> +	bool "Loongson CPU HWMon Driver"
>   	depends on LOONGSON_MACH3X
>   	select HWMON
>   	default y

