Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5C454B7A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243223AbiFNRaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238047AbiFNRaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:30:08 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E018D3D1E0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:30:06 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y17so7062554ilj.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aSo5B7wxHruikT7i10mL2QJi9ruKuv2MIJIK2ELKKvQ=;
        b=YKoyf7NH8rTqqJlql8rCXPzZQKfg+dExryRIoaqgMhhpp3kgzWSnTAYFlzsTjibY9a
         BU21asQwL8ditAIxoOXHyATnCLEFjjvsZpYJDm6dyLRyPWiNfqvLUhZWzZsPF7v2epxs
         jrhv/G7m/dQfkgIVk368alJlXzLcXWcLX/o/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aSo5B7wxHruikT7i10mL2QJi9ruKuv2MIJIK2ELKKvQ=;
        b=vb2sS/c1P6vISKB6V23ZCVjsaCKQoxpG/0ecwb9/daTXTYY4nOB3ftaWzBNaozpii/
         laUgagGbD9xgMc0CapFG+W6GDsy/RuAOo160o+JFjwp3Fk3YoRM2Ma4hDZ+DneN6aL0l
         fBdcUTmLx1Et6DfKGyrOA+kwwd+lLBqi6RczrL4lxgXhjyO0C+92WdpyifGedan6S449
         xz0VybcbUVBHPX6OgEYhPkTGAXBYgOO7Vaoqcb/7hpBXd5yosMDo5mSv1FhGI895MNXQ
         ONePZGZ4qvxe/vu0YlNGJPpuZJVxJUsj4F617H3Jyx6WKDl5iBjLeeoSoj1umrsZn5xC
         cGBA==
X-Gm-Message-State: AJIora8UtJLPem5Ga+xOcz9P69iAdtLzIF7A+9qcalzuxMFu91sRkLyZ
        dm0tBSoiy+zc9clryUg4ssAe+w==
X-Google-Smtp-Source: AGRyM1st09tU6WIPog6ZcsfIOrj9H83BSjqzdkiMrUDy/mg5vbeZQkHTijSmV+dIzW2lR6nKJ7yR3A==
X-Received: by 2002:a05:6e02:20cc:b0:2d1:a5d6:b78c with SMTP id 12-20020a056e0220cc00b002d1a5d6b78cmr3563131ilq.160.1655227806288;
        Tue, 14 Jun 2022 10:30:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i6-20020a056e02054600b002d3de4c1ecbsm5668058ils.68.2022.06.14.10.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 10:30:06 -0700 (PDT)
Subject: Re: [PATCH] userfaultfd/selftests: Fix typo in comment
To:     Xiang wangx <wangxiang@cdjrlc.com>, akpm@linux-foundation.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220610071244.59679-1-wangxiang@cdjrlc.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3e3922c1-c6a7-ac60-2478-6b94defd1ead@linuxfoundation.org>
Date:   Tue, 14 Jun 2022 11:30:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220610071244.59679-1-wangxiang@cdjrlc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 1:12 AM, Xiang wangx wrote:
> Delete the redundant word 'in'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>   tools/testing/selftests/vm/userfaultfd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 0bdfc1955229..4bc24581760d 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -860,7 +860,7 @@ static int stress(struct uffd_stats *uffd_stats)
>   	/*
>   	 * Be strict and immediately zap area_src, the whole area has
>   	 * been transferred already by the background treads. The
> -	 * area_src could then be faulted in in a racy way by still
> +	 * area_src could then be faulted in a racy way by still
>   	 * running uffdio_threads reading zeropages after we zapped
>   	 * area_src (but they're guaranteed to get -EEXIST from
>   	 * UFFDIO_COPY without writing zero pages into area_dst
> 

Thank you. Applied to next Linux 5.20-rc1

thanks,
-- Shuah
