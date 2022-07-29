Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3677584F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbiG2Kxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiG2Kxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:53:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03FB86892
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:53:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j22so7882443ejs.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QRmlG7Kah6+nPLbRIbE/bMazy67fLBmeuPjei7pVd1w=;
        b=50n6H9v2TyDGnIKq+3OjkfEGUqvYAyhxcvhMe7Htkr5lVe+HKN2qBS0T3rZQ2K6Cpx
         1nvdtr8YwT1MbtBddU/oA8Dm+RTKQcPj+PAatB2zkkcuwEuuVNKEK+FM0Ets9DLKUELg
         8Yvi8FjOvzWHw7tK8gI9k+Lud8le86QUbKDqyt0yreW2+chupexrf1U2A3G4jy8oSO/F
         Da/gn3Z607VbYvKn3IF6zDq58BPSmZRlbnZyltSRtlqIa4xVbXjKex24txIaogauwb2m
         TVMjCVWl8IJWb/MqqOBFNJbJOHu1gIwrwnosr610LUz9HoLgL+kbosxoflZ6PEFsOujC
         FP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QRmlG7Kah6+nPLbRIbE/bMazy67fLBmeuPjei7pVd1w=;
        b=UG0m97PKea8PV62QWlRqrbv/C2h5GIoEfnswUmgHU4MSmruwZnZjBqG6PgRI2SW4vw
         t6ES3hUqa2nbvZ8BnScfStSf8jMhx9KBzlO5Ei2Rtg/JR5DTCU5sFAj6ele+s/2OJZxG
         bcU6xFSNLYM9bpIVvw+zVWMResGPmAb/v8kxprvMhnsAT/IKq9NJnBk8Vo1wIQUjpjey
         5NzYQ2LGunYzTyLgFLz8vPcfACQhxPnNdKMEkmiThGSfHcxuw1RbUCyjKMJPwPF6Pxm9
         kLXRkC0CB3vESOKhND0SthJoUPpM8Xu/F6qrWiw1K0eJu10MQVeHOKC8k9n1kuZbQIbw
         iVEg==
X-Gm-Message-State: AJIora+k0YCiRVSqxjQAaJDtzstL7HfRPTRKNI2SmMraKMsRQ4FY3LYN
        QMWiEZp2Vfavn6h98UApXs8h0KQLjo+NsQ==
X-Google-Smtp-Source: AGRyM1vT4qriQAWlIFkT9Y42K0I5WJWG2DRqDUmugHrQjn6KRn71W5ZQHRYr6iASf8Bn+3mctRcjcA==
X-Received: by 2002:a17:906:dc92:b0:72f:da9b:7702 with SMTP id cs18-20020a170906dc9200b0072fda9b7702mr2444852ejc.383.1659092019298;
        Fri, 29 Jul 2022 03:53:39 -0700 (PDT)
Received: from ?IPV6:2a02:768:2307:40d6::f9e? ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709063d2100b0072f0a9a8e6dsm1536455ejf.194.2022.07.29.03.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 03:53:38 -0700 (PDT)
Message-ID: <f506b9f3-0b1d-3e76-4619-b514cfbf93ce@monstr.eu>
Date:   Fri, 29 Jul 2022 12:53:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] microblaze: Fix some typos in comment
Content-Language: en-US
To:     Slark Xiao <slark_xiao@163.com>, mail@conchuod.ie
Cc:     linux-kernel@vger.kernel.org
References: <20220721071520.48384-1-slark_xiao@163.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <20220721071520.48384-1-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/22 09:15, Slark Xiao wrote:
> Replace 'the the' with 'like the' in the comment.
> Replace 'an' with 'a'.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>   arch/microblaze/kernel/entry.S | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
> index b179f8f6d287..d875a0c01032 100644
> --- a/arch/microblaze/kernel/entry.S
> +++ b/arch/microblaze/kernel/entry.S
> @@ -456,7 +456,7 @@ TRAP_return:		/* Make global symbol for debugging */
>   
>   
>   /* This the initial entry point for a new child thread, with an appropriate
> -   stack in place that makes it look the the child is in the middle of an
> +   stack in place that makes it look like the child is in the middle of a
>      syscall.  This function is actually `returned to' from switch_thread
>      (copy_thread makes ret_from_fork the return address in each new thread's
>      saved context).  */

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

