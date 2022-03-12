Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E8F4D710C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 22:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiCLVoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 16:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiCLVoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 16:44:20 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5513EB82
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 13:43:12 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g17so20910930lfh.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 13:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gkrxwfNAo+wqaPPhsyYAGfR02IOHUYddLvZA6FjMTBI=;
        b=FxJI0HFe2HmQgNZiUkdK9qEcNJJeSgk4FpoWUuXVXhAG8PE6Z/+Wb1cQUhO8D8Oltz
         gpa3xaJ5I7fTr48Jxvxm8vFopvlo5SnVkTZk5zQA3NjrSol6HjXqCryzaIJ+Jt3TBQqn
         IePtH5560IjsGAuL0JrBmszuiytvSoJTC8hZ2cjUzx+qYnybpYijooYq5UH7JkZo/pjM
         broSIP1ct1Rz7ddFtS/rUhUxLtIwPjZ810pO3bERK2Bv+jNzNuq9R4IKkAFOG59hXOyt
         DYPiwdT6WPd4flHWLoEc+CxIAUC8YdNFHxBIHNBbAQY1+OFU/mp5dFWNMOc6RL0VuJDH
         IWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gkrxwfNAo+wqaPPhsyYAGfR02IOHUYddLvZA6FjMTBI=;
        b=29pxryeeFtD5K0nOiP7KrSa0TN1CYUDfDvIZMc1okUjvQUtQuWNeIyqA9T45BCWHT8
         BPBdfgVSTKJui+HY4lUQFqklKKLJczbk1DbtwFm/p+Kc5NwYQx2/Hbyx+CoyjGjbHFDY
         Sy76vzkyIbn1D0vItmzTK8nCczgZkG7rdSB8cFi5Q1u5b7EH5qiig5e9YcAMKtmjabNr
         5zS7lemXhx6idONoif86I/QLlG4hQn/lscE5pi2UXMwyzl3JV55jUuIuEi/BLwdgH5ar
         mrvrX4Fg3XpiDTuk/eZe9vyxUXtbMdfcDcThyL/jehQMAf6KpODxZxh6bGjiv0WaWlpS
         QN1g==
X-Gm-Message-State: AOAM533M5gKF9+5NzrxyOQI39KstROgGmZlt6PlapH81W7noyDLhzWkh
        oJoEacqtVf/yw3NecC/ge1uwCY983E0=
X-Google-Smtp-Source: ABdhPJyU1EdFdwFwd3jDaeaQazah7k5dV1l8H1XNs9zkmyWxayD1F82B8UB6lKU9gFsSZO5K14fjiQ==
X-Received: by 2002:a05:6512:2316:b0:446:a84a:173e with SMTP id o22-20020a056512231600b00446a84a173emr8994713lfu.73.1647121390992;
        Sat, 12 Mar 2022 13:43:10 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.107])
        by smtp.gmail.com with ESMTPSA id b1-20020ac247e1000000b0044842b76861sm2377192lfp.140.2022.03.12.13.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 13:43:10 -0800 (PST)
Message-ID: <303ed0c8-8e2c-51a4-a4da-be973a25cdec@gmail.com>
Date:   Sun, 13 Mar 2022 00:43:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] staging: android: ashmem: Declared file operation with
 const keyword Warning found by checkpatch.pl script.
Content-Language: en-US
To:     shaikh kamal <shaikhkamal2012@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20220312204128.3942-1-shaikhkamal2012@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220312204128.3942-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaikh,

On 3/12/22 23:41, shaikh kamal wrote:
> Signed-off-by: shaikh kamal <shaikhkamal2012@gmail.com>
> ---
>   drivers/staging/android/ashmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index ddbde3f8430e..4c6b420fbf4d 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -377,7 +377,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>   
>   static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>   {
> -	static struct file_operations vmfile_fops;
> +	static const struct file_operations vmfile_fops;
>   	struct ashmem_area *asma = file->private_data;
>   	int ret = 0;
>   

Are you sure this patch compiles? vmfile_fops is overrided few lines below

odd checkpatch.pl warning...




With regards,
Pavel Skripkin
