Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A9B510507
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353972AbiDZRQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353841AbiDZRNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:13:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDB115248E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:09:41 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u7so15472892plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=3pRtFB0OyQWIloF6gVvfP70/y+ZKfPUHmGKRZFCdpzo=;
        b=JdywYSebpgqCQp5y9FZgv57z+A7W8Eo1jzjvEsSt6memkwrAmjIt5BN3J0vvkEFjLQ
         CilG4xKw1gD6YlXJbKWcId/C0g08ICrJmYp+U0c5gJ0T/WFa06NeyDxZPijIy0k/esRA
         kMPwEpjXPj2SruWZQ54bdvAgOdDC03eHVRj3agVSEwPiixeOT394a0v0EXXgvER6+ghL
         /ps/RyeJ5BAbbWHUXWym2H3TX3UwVgxmZVsVJxZqx2cWM8xwiHsFG+F0nMUAdllVsmP/
         VYUh3rgcjD/tknCPummvhBUkfu9Sl4CKW0IyYkTZjYyxbsjra/UF8vdGw9Od5U26EpSg
         2Wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3pRtFB0OyQWIloF6gVvfP70/y+ZKfPUHmGKRZFCdpzo=;
        b=QkHoMeXMhfdAiQL5p3XtKPMjj0AkRRRsBrh+sWoncQik8x8adjQtGUwxbiyUC1YXm0
         3ZPt0Nj5j6syYL431SsVts2tUlXQdb3HHRa9VdJFmdBvnZT39pc6pStQXoQXe2fbKW5Z
         L15PVcyzZT26n6d4FAjlWUlxACFJ+uKVirUB2L5Ty7cjvxiPck2btf6U+UFcGjIVIEV8
         L0hsDmGh/SH9jUePCWPCVuxh0oh6qQbNLTRQgPj3mofQApyWhb3M1xXMdnFLw7EFOH5J
         nuEbGRUkCW3QQ37ctHSTc27LUg4UqBy7RvOcoQxzV/aIXWvVIeQdTPmL+X0cNDg9d1Ne
         AC0A==
X-Gm-Message-State: AOAM530eTNVzjgwIrJK8N7QQUZxiHAodxe8gn1ScBnb/iQ/CGoU3ZU53
        UhP9w6e5r3ronjeUzZVQLMU=
X-Google-Smtp-Source: ABdhPJxJkedSaboL6wP3INkBD/Gyh5Gw4Jxkq/TBnmVzgAaoyuEgyilnXqr2KGFt56efnHgstZK7Pg==
X-Received: by 2002:a17:902:7e06:b0:159:6c1:ea2b with SMTP id b6-20020a1709027e0600b0015906c1ea2bmr24043348plm.105.1650992960672;
        Tue, 26 Apr 2022 10:09:20 -0700 (PDT)
Received: from [172.30.1.9] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id d18-20020a056a0010d200b004fa2e13ce80sm17099742pfu.76.2022.04.26.10.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 10:09:20 -0700 (PDT)
Message-ID: <6f07e65b-339a-1ff7-1959-9ea4758d5244@gmail.com>
Date:   Wed, 27 Apr 2022 02:09:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] extcon: modify extcon device to be created after driver
 data is set
Content-Language: en-US
To:     bumwoo lee <bw365.lee@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
References: <CGME20220331030336epcas1p3b8bf7b1841d4b246030b57b668312169@epcas1p3.samsung.com>
 <20220331030324.42621-1-bw365.lee@samsung.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220331030324.42621-1-bw365.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bumwoo,

Firstly, I'm sorry for late replay.

On 22. 3. 31. 12:03, bumwoo lee wrote:
> Currently, someone can invoke the sysfs such as state_show()
> intermittently before set_drvdata() is done.
> And it can be a cause of kernel Oops because of edev is Null at that time.
> So modified the driver registration to after setting drviver data.
> 
> - Oops's backtrace.
> 
> Backtrace:
> [<c067865c>] (state_show) from [<c05222e8>] (dev_attr_show)
> [<c05222c0>] (dev_attr_show) from [<c02c66e0>] (sysfs_kf_seq_show)
> [<c02c6648>] (sysfs_kf_seq_show) from [<c02c496c>] (kernfs_seq_show)
> [<c02c4938>] (kernfs_seq_show) from [<c025e2a0>] (seq_read)
> [<c025e11c>] (seq_read) from [<c02c50a0>] (kernfs_fop_read)
> [<c02c5064>] (kernfs_fop_read) from [<c0231cac>] (__vfs_read)
> [<c0231c5c>] (__vfs_read) from [<c0231ee0>] (vfs_read)
> [<c0231e34>] (vfs_read) from [<c0232464>] (ksys_read)
> [<c02323f0>] (ksys_read) from [<c02324fc>] (sys_read)
> [<c02324e4>] (sys_read) from [<c00091d0>] (__sys_trace_return)
> 
> Signed-off-by: bumwoo lee <bw365.lee@samsung.com>
> ---
>   drivers/extcon/extcon.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index d27cd9f88f86..74fee04bd764 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1224,18 +1224,13 @@ int extcon_dev_register(struct extcon_dev *edev)
>   		edev->dev.type = &edev->extcon_dev_type;
>   	}
>   
> -	ret = device_register(&edev->dev);
> -	if (ret) {
> -		put_device(&edev->dev);
> -		goto err_dev;
> -	}
> +	device_initialize(&edev->dev);
>   
>   	spin_lock_init(&edev->lock);
>   	edev->nh = devm_kcalloc(&edev->dev, edev->max_supported,
>   				sizeof(*edev->nh), GFP_KERNEL);

Actually, I'm not sure that it is proper to use 'edev->dev'
by devm_kcalloc before device_add. When error happen
between device_initialize and device_add, I think that
it is not properly handled such as free the allocated memory
automatically.

>   	if (!edev->nh) {
>   		ret = -ENOMEM;
> -		device_unregister(&edev->dev);
>   		goto err_dev;
>   	}
>   
> @@ -1251,9 +1246,14 @@ int extcon_dev_register(struct extcon_dev *edev)
>   	list_add(&edev->entry, &extcon_dev_list);
>   	mutex_unlock(&extcon_dev_list_lock);
>   
> +	ret = device_add(&edev->dev);
> +	if (ret)
> +		goto err_dev;

On this case, need to delete entry from extcon_dev_list
by using list_del.

> +
>   	return 0;
>   
>   err_dev:
> +	put_device(&edev->dev);
>   	if (edev->max_supported)
>   		kfree(edev->extcon_dev_type.groups);
>   err_alloc_groups:


I recommend that move device_register() position after dev_set_drvdata.
And then use kcalloc instead of devm_kcalloc as following:


diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index d27cd9f88f86..80e5bfec1131 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1224,19 +1224,11 @@ int extcon_dev_register(struct extcon_dev *edev)
                 edev->dev.type = &edev->extcon_dev_type;
         }

-       ret = device_register(&edev->dev);
-       if (ret) {
-               put_device(&edev->dev);
-               goto err_dev;
-       }
-
         spin_lock_init(&edev->lock);
-       edev->nh = devm_kcalloc(&edev->dev, edev->max_supported,
-                               sizeof(*edev->nh), GFP_KERNEL);
+       edev->nh = kcalloc(edev->max_supported, sizeof(*edev->nh), 
GFP_KERNEL);
         if (!edev->nh) {
                 ret = -ENOMEM;
-               device_unregister(&edev->dev);
-               goto err_dev;
+               goto err_alloc_nh;
         }

         for (index = 0; index < edev->max_supported; index++)
@@ -1247,6 +1239,12 @@ int extcon_dev_register(struct extcon_dev *edev)
         dev_set_drvdata(&edev->dev, edev);
         edev->state = 0;

+       ret = device_register(&edev->dev);
+       if (ret) {
+               put_device(&edev->dev);
+               goto err_dev;
+       }
+
         mutex_lock(&extcon_dev_list_lock);
         list_add(&edev->entry, &extcon_dev_list);
         mutex_unlock(&extcon_dev_list_lock);
@@ -1254,6 +1252,9 @@ int extcon_dev_register(struct extcon_dev *edev)
         return 0;

  err_dev:
+       if (edev->max_supported)
+               kfree(edev->nh);
+err_alloc_nh:
         if (edev->max_supported)
                 kfree(edev->extcon_dev_type.groups);
  err_alloc_groups:
@@ -1314,6 +1315,7 @@ void extcon_dev_unregister(struct extcon_dev *edev)
         if (edev->max_supported) {
                 kfree(edev->extcon_dev_type.groups);
                 kfree(edev->cables);
+               kfree(edev->nh);
         }

         put_device(&edev->dev);



-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
