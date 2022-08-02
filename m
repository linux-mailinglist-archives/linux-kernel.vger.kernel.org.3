Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B15358819D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbiHBSDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbiHBSDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:03:21 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB4CE62
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 11:03:20 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id c185so17369259oia.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 11:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=GNoHkmqZpKx9Pktw11GIbNQ2bhjivWnkaFbnDxeXjko=;
        b=Udpqm0u/iKCRrsXn0zwaQsyNbevqIDy0JDzIIAcMh0IK1K/IwgtExogFGRWKiWTGtI
         uFfjjNke+0eMux5masDyDxE8wI85IacWFitHG7istD/kZT4u5nGWrNT2MsvqaPsjeDeE
         oDj1nrKjgBWFF5lT0nE8EDsaoMJeW5ouqZ1zlDb2KbDmKyj0sUtFb2nZ2T4GFw2aIrya
         apox241/J0FPpHvJKf4/USJnw37uXh1wPG3DnsrVXW3FuIUREHbbI6THvb/sQwxE1o+9
         A5/zD3/7GUypSEJVUVocU/5eWQgDnt5c4gtSzgAIBNCIL0r5kPKkpyVqAtnU+wFqiJf6
         R0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=GNoHkmqZpKx9Pktw11GIbNQ2bhjivWnkaFbnDxeXjko=;
        b=1Iaiauz8uisChbSv7DCpFsn4u4WiEpWwiAbJObFOev06s9dkR1HFBDlRhzV5iYhvTr
         BXvObZK6i9AikAqipEyxUwg5+8L3H3xEVen0UbCeCQuPCY5xqDIYvSUXLDR+umYM6Gsf
         tDJ1SFg6/LCDo1wGO/jZ0xmUb+sbuDrIlY8/ECnoiVUJHhwocZooHetHuslfSHyuABvm
         k7eg2rpZk1sXRPE0u6baK3bq4uFDJQNlUXvrGECOhaCt95fvU9SE51pSXVhb9eCY1UzW
         0qcgburDlH5Dx+R3OOblKGKRlOgrS3Uod+DKt9zDZWPkobm6nn6RQcOPLzt0Jr6knzjz
         OQ1A==
X-Gm-Message-State: ACgBeo3GeXa2m6WfDSQbPZCnwYeZid924jmjdKQJp3rR2A1YC1YNeO89
        WICQW5RdYft+RXMMKZhGK0U=
X-Google-Smtp-Source: AA6agR6tKINKcuOaNVqYuLToWlaaeWaMIPBLG88vYHrun7FOyb6H5HO1ZUxOuFlhlSi5vMZ/8Pw79A==
X-Received: by 2002:a05:6808:bca:b0:33b:2275:27b8 with SMTP id o10-20020a0568080bca00b0033b227527b8mr290247oik.180.1659463399472;
        Tue, 02 Aug 2022 11:03:19 -0700 (PDT)
Received: from [192.168.1.108] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id d13-20020a9d5e0d000000b006359cd3e3b0sm836323oti.77.2022.08.02.11.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 11:03:18 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <a94b833a-2f3c-a5ba-f2e4-7c7ef0d1e862@lwfinger.net>
Date:   Tue, 2 Aug 2022 13:03:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: add firmware dependency
Content-Language: en-US
To:     Grzegorz Szymaszek <gszymaszek@short.pl>, Greg KH <greg@kroah.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <YukkBu3TNODO3or9@nx64de-df6d00> <YukvnVWuhUeOgRyZ@kroah.com>
 <Yukx8KEEOhKTJ7HQ@nx64de-df6d00>
 <c82114b6-1003-bfb5-0550-98dcbf1a3761@lwfinger.net>
 <YulcdKfhA8dPQ78s@nx64de-df6d00>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <YulcdKfhA8dPQ78s@nx64de-df6d00>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/22 12:18, Grzegorz Szymaszek wrote:
> The old rtl8188eu module, removed in commit 55dfa29b43d2 ("staging:
> rtl8188eu: remove rtl8188eu driver from staging dir") (Linux kernel
> v5.15-rc1), required (through a MODULE_FIRMWARE call()) the
> rtlwifi/rtl8188eufw.bin firmware file, which the new r8188eu driver no
> longer requires.
> 
> I have tested a few RTL8188EUS-based Wi-Fi cards and, while supported by
> both drivers, they do not work when using the new one and the firmware
> wasn't manually loaded. According to Larry Finger, the module
> maintainer, all such cards need the firmware and the driver should
> depend on it (see the linked mails).
> 
> Add a proper MODULE_FIRMWARE() call, like it was done in the old driver.
> 
> Thanks to Greg Kroah-Hartman and Larry Finger for quick responses to my
> questions.
> 
> Link: https://answers.launchpad.net/ubuntu/+source/linux-meta-hwe-5.15/+question/702611
> Link: https://lore.kernel.org/lkml/YukkBu3TNODO3or9@nx64de-df6d00/
> Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
> ---
>   drivers/staging/r8188eu/os_dep/os_intfs.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index 891c85b088ca..5bd3022e4b40 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -18,6 +18,7 @@ MODULE_LICENSE("GPL");
>   MODULE_DESCRIPTION("Realtek Wireless Lan Driver");
>   MODULE_AUTHOR("Realtek Semiconductor Corp.");
>   MODULE_VERSION(DRIVERVERSION);
> +MODULE_FIRMWARE("rtlwifi/rtl8188eufw.bin");
>   
>   #define CONFIG_BR_EXT_BRNAME "br0"
>   #define RTW_NOTCH_FILTER 0 /* 0:Disable, 1:Enable, */

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks,

Larry

