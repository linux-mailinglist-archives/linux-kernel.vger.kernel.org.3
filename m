Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847EB55CB4A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343904AbiF1KqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiF1Kp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:45:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E2331371;
        Tue, 28 Jun 2022 03:45:56 -0700 (PDT)
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MxUfn-1nhyxm1aHp-00xq4l; Tue, 28 Jun 2022 12:45:47 +0200
Message-ID: <0be5b3e4-8aed-8f38-e7bd-f00c2323f78d@vivier.eu>
Date:   Tue, 28 Jun 2022 12:45:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next v2] m68k: virt: platform: fix missing
 platform_device_unregister() on error in virt_platform_init()
Content-Language: fr
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Cc:     geert@linux-m68k.org
References: <20220628084903.3147123-1-yangyingliang@huawei.com>
From:   Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20220628084903.3147123-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:16N2p5BCoxXRnFIMT7blwU+msYe1BcV2uxPrkDvlCebuKsW1MvV
 HNYGK5RNBu00qBWVb8qLoAn/1MSQdek8bj4EIRigOZmBpakGpnP485vqySgU/hWGUzVjE1u
 9l0I7tZ9POk1ieUBEygXa619y3FVnq0ISCuH95j3pvX66WcA464HSra6kxf+8eFidh0Hpx4
 D+yrrej5eDWTl5d3mzMSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gL+oB0fIR4U=:QkeiBnIANig+DmoEvh6AIn
 R2fzBDd/8lFA0v6J98USj+bkLl4sI3UOh1kbal76H/BjXO1qTr7rrqdbRSCNi9WfQt7/7d476
 eBtRcV5HiF/0j7A459K8nRClyfL6VaxePKJSwQI68b4mGYwfEAt9xPx60DTD794208WTP7Ul2
 ozDq5eH5BZ7KpQFKnuewyrKaDmBzjdC1aharX5C6OGFXcdzXBXJAnrEEtmzz4nozCYUvBvKiy
 Q2b947A+iBP60q++vcSszM5W0TFN/6I9U84SvnulNSIRNqawu+MAGPEimExxZ153+2heaYYJ6
 Jj/+dVbKtj8UdARIg9JnUoqCLa8nr2HCoUkuWRRa/tyU1fwh3WRs5yDM71PzdMwfZ3wH9wKKO
 bylakCM0mFPVrz7nEhExDFo9D4vh1b5o2zgCyOjs6gXQ9SytgFNk6XVkEHTSeLZHobesspLn7
 jSxxcI9jj2+Bn33WoMZ6gfHpvlKgxcSa4tKnFjsVPo7TKXAgbGHpKhvesvLrY+xRFJ8t7yTvX
 shVpZ/ScU8/Org+XD5BYqpXMYevIv4B84U8v6wIDyEcKaN3iiBASgV7SZ1HJFsuhZtOu7ODjK
 6n+1V/K+lMK5oZyYA/wNl94er9a9LjoaqUwLhYmlHk9AdwRWyuKxWqpA7dvnKe1PpKYKi0S34
 Ft0slWTfmaMqKl4r5HRUNf8ecmuf4KxfhOaiL2dnBfz9SEO1hSeExVgq9C7VD0oLlJC7ybRfp
 elNrTplExWNVKhB4uQCcqO/LE4+ZjnZid2JyuQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 28/06/2022 à 10:49, Yang Yingliang a écrit :
> Add the missing platform_device_unregister() before return
> from virt_platform_init() in the error handling case.
> 
> Fixes: 05d51e42df06 ("m68k: Introduce a virtual m68k machine")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v2:
>    change for loop to while at lable err_unregister_rtc_virtio.
> ---
>   arch/m68k/virt/platform.c | 58 ++++++++++++++++++++++-----------------
>   1 file changed, 33 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/m68k/virt/platform.c b/arch/m68k/virt/platform.c
> index cb820f19a221..1560c4140ab9 100644
> --- a/arch/m68k/virt/platform.c
> +++ b/arch/m68k/virt/platform.c
> @@ -8,20 +8,15 @@
>   
>   #define VIRTIO_BUS_NB	128
>   
> -static int __init virt_virtio_init(unsigned int id)
> +static struct platform_device * __init virt_virtio_init(unsigned int id)
>   {
>   	const struct resource res[] = {
>   		DEFINE_RES_MEM(virt_bi_data.virtio.mmio + id * 0x200, 0x200),
>   		DEFINE_RES_IRQ(virt_bi_data.virtio.irq + id),
>   	};
> -	struct platform_device *pdev;
>   
> -	pdev = platform_device_register_simple("virtio-mmio", id,
> +	return platform_device_register_simple("virtio-mmio", id,
>   					       res, ARRAY_SIZE(res));
> -	if (IS_ERR(pdev))
> -		return PTR_ERR(pdev);
> -
> -	return 0;
>   }
>   
>   static int __init virt_platform_init(void)
> @@ -35,8 +30,10 @@ static int __init virt_platform_init(void)
>   		DEFINE_RES_MEM(virt_bi_data.rtc.mmio + 0x1000, 0x1000),
>   		DEFINE_RES_IRQ(virt_bi_data.rtc.irq + 1),
>   	};
> -	struct platform_device *pdev;
> +	struct platform_device *pdev1, *pdev2;
> +	struct platform_device *pdevs[VIRTIO_BUS_NB];
>   	unsigned int i;
> +	int ret = 0;
>   
>   	if (!MACH_IS_VIRT)
>   		return -ENODEV;
> @@ -44,29 +41,40 @@ static int __init virt_platform_init(void)
>   	/* We need this to have DMA'able memory provided to goldfish-tty */
>   	min_low_pfn = 0;
>   
> -	pdev = platform_device_register_simple("goldfish_tty",
> -					       PLATFORM_DEVID_NONE,
> -					       goldfish_tty_res,
> -					       ARRAY_SIZE(goldfish_tty_res));
> -	if (IS_ERR(pdev))
> -		return PTR_ERR(pdev);
> +	pdev1 = platform_device_register_simple("goldfish_tty",
> +						PLATFORM_DEVID_NONE,
> +						goldfish_tty_res,
> +						ARRAY_SIZE(goldfish_tty_res));
> +	if (IS_ERR(pdev1))
> +		return PTR_ERR(pdev1);
>   
> -	pdev = platform_device_register_simple("goldfish_rtc",
> -					       PLATFORM_DEVID_NONE,
> -					       goldfish_rtc_res,
> -					       ARRAY_SIZE(goldfish_rtc_res));
> -	if (IS_ERR(pdev))
> -		return PTR_ERR(pdev);
> +	pdev2 = platform_device_register_simple("goldfish_rtc",
> +						PLATFORM_DEVID_NONE,
> +						goldfish_rtc_res,
> +						ARRAY_SIZE(goldfish_rtc_res));
> +	if (IS_ERR(pdev2)) {
> +		ret = PTR_ERR(pdev2);
> +		goto err_unregister_tty;
> +	}
>   
>   	for (i = 0; i < VIRTIO_BUS_NB; i++) {
> -		int err;
> -
> -		err = virt_virtio_init(i);
> -		if (err)
> -			return err;
> +		pdevs[i] = virt_virtio_init(i);
> +		if (IS_ERR(pdevs[i])) {
> +			ret = PTR_ERR(pdevs[i]);
> +			goto err_unregister_rtc_virtio;
> +		}
>   	}
>   
>   	return 0;
> +
> +err_unregister_rtc_virtio:
> +	while (i > 0)
> +		platform_device_unregister(pdevs[--i]);
> +	platform_device_unregister(pdev2);
> +err_unregister_tty:
> +	platform_device_unregister(pdev1);
> +
> +	return ret;
>   }
>   
>   arch_initcall(virt_platform_init);

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

