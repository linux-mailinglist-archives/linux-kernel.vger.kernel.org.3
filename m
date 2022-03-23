Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66D24E5211
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240560AbiCWMU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239152AbiCWMU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:20:26 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C2154BEB;
        Wed, 23 Mar 2022 05:18:56 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e5so1349191pls.4;
        Wed, 23 Mar 2022 05:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KrOAEwdJIBQHysyGTc8MR/8Fl2/7DHu459R4bzhCCXA=;
        b=Hdb6LUVmMLHMFB88LZalE3YlqGQFxKn6StXKfCNcLnwedSffq63vc6GYAt9VDEudgW
         U7LP1G1pCHI7ry++xhqOpzqeUq2i6jQwoTHyDpcwAgP7FUHuGDY+7BgO/jfbzER6azb/
         GEAo6mV9cRiZbV2EIl47yJ7Atbautj78Q/UO8eDu93NEQSJ0YUxBsnytJbhnT6vt6Kzv
         wiIqBQKxOw34GwA5QaalOHQlAGdURXxpJ2ksWvnJxbO6maeGcCaomkm4zMkGiiN+M1uG
         7hmmCNsDpl5T6BOzDsT8OhJE12qDoFQuZbO2X4nAa2Y1KhwZJmuhUHdcMaf5DqyUspR1
         TCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KrOAEwdJIBQHysyGTc8MR/8Fl2/7DHu459R4bzhCCXA=;
        b=JKa4N7ngEmnCiKSCO+dqptPzLB3QODGWsW9pPA/ngmFF0B/wuvo9MFKnlG+9bHjMUI
         b64HDO0sMrCxRc4AMo8ja79Eld27u14RMIryMZwOYiOyjqqA9Oo2LFF0Y2DdEz1JgY5K
         ZX3dmHNB+2gobIK+ihVfp7CmuMWpAo3CNGZJ0GL5+Ud77qr7PSeuRt8gGpx77cXON54D
         sUB3FAdFOvDdSU6w285Facp5Ro8jz529D0JmcakHoJvRtGmyCSbMmaYUxxdAgQJh/OZl
         /kiJ2fuOYwzvevhnACH4mOcwN8eDX6wsgFXMtWwCzWgbzj1Rx+PKa1N8KQz+wAiuCsTt
         cSRQ==
X-Gm-Message-State: AOAM533Mq9WQnRUITkdrfXTlecNg8foWNJZwnL+0Z5CaBWN3HcUHSPX2
        biqmh1vlk7JY7emb3v+DckA=
X-Google-Smtp-Source: ABdhPJz9rNauBjyC7mJiIiMRzgRY+obTufzebjU3xVXY8Ra1/1jftU2jnwN/KdizwnMASycF5/p+gw==
X-Received: by 2002:a17:90b:1b12:b0:1c7:6f5d:d7e8 with SMTP id nu18-20020a17090b1b1200b001c76f5dd7e8mr7499891pjb.154.1648037935572;
        Wed, 23 Mar 2022 05:18:55 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-71.three.co.id. [180.214.233.71])
        by smtp.gmail.com with ESMTPSA id e6-20020a63aa06000000b00380c8bed5a6sm21451042pgf.46.2022.03.23.05.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 05:18:54 -0700 (PDT)
Message-ID: <e1ea44f5-de48-e5ff-6feb-5f6ee7a68828@gmail.com>
Date:   Wed, 23 Mar 2022 19:18:51 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [ammarfaizi2-block:palmer/linux/riscv-pmu 13/15]
 drivers/perf/riscv_pmu_sbi.c:498: warning: This comment starts with '/**',
 but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org, gwml@vger.gnuweeb.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <mhng-cc3dade0-37d7-4832-bb05-c23669599378@palmer-ri-x1c9>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <mhng-cc3dade0-37d7-4832-bb05-c23669599378@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/22 05.06, Palmer Dabbelt wrote:
>> All warnings (new ones prefixed by >>):
>>
>>    drivers/perf/riscv_pmu_sbi.c:42: warning: cannot understand function prototype: 'union sbi_pmu_ctr_info *pmu_ctr_list; '
> 
> Looks like that's just fallout from the ** comments.
> 
>>>> drivers/perf/riscv_pmu_sbi.c:498: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> I sent a fix for this one, there were a handful of them.  Sorry I missed that.
> 

I have already sent the fix for vcpu_sbi.c at [1], but forgot to
Cc: lkp@intel.com (I put it on To: instead), can you please pick it up?

[1]: https://lore.kernel.org/linux-doc/20220320081810.405589-1-bagasdotme@gmail.com/

-- 
An old man doll... just what I always wanted! - Clara
