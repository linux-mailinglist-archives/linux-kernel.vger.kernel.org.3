Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8390531400
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbiEWPlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbiEWPlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:41:05 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C65BEA;
        Mon, 23 May 2022 08:41:01 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h186so14011907pgc.3;
        Mon, 23 May 2022 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0YD67E57Qb/IhZOVhYDq1CM3zL4yutpuxXEgEr4gyrQ=;
        b=kWjUSzqOOHO+g+CiVUfbBgvcgYAr8bTNivTObbe3srRtBWXtUrKLRfhydDSw9pk+hM
         fLX3rXbYLfybH4Xt/XJyFh2W9UEtwgSQKe92iTVV5in55zSnR4RLHenZM8u/s32kvfuX
         uMnSkXA7JIN4QbUGt2n0wgh0WWmxIC9hlp3vzyDFYUp5tgK8GVEwg1xvKMvzUMCYTWgE
         Cuk/p/TBf5FI74Kcnk7gv7jA4h2mWeg0RAZLFMx+atU1GWHfag+KvebbSWNGUdx/afCz
         IxDH3PL4qgt4/JJ58o1KmExionsrbvcOjYEJh/ytTeWsyjmmfbXevVN/9FN7sE93i1Fi
         KCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0YD67E57Qb/IhZOVhYDq1CM3zL4yutpuxXEgEr4gyrQ=;
        b=gAQFxqHCRYw/zw+mRgKJTiBgm+Tj2lDUZU5+wxyqkdxbeBkIJBo1xv8MKtaIbDbjNf
         GJpFMG7yAMkSASneSbvQ6Wtu7lSz/ElH37NKemrM6SiSkmvhZ6Y3HuTJqnGVxmhnQt6T
         TIl+3P67KFc6NiH4ernK9+K9c0wkaG7dGJQd6THAej5U/pdd0iWH2BuqczAmbyMJIfwx
         hnjJJCbG/6zEHmcmVCOgcY7WalsP+TTS+e9tIRQD/3tAAMIZ5dtYACM1wb5JkS9hqcTq
         iLXf57CYWk9QKmNGt5FaUEJp+WOt+HSMU/XW/0YeVr/CM9PnODgLYtlJiC30NtgKgKk3
         pIAw==
X-Gm-Message-State: AOAM531h3qIsnxK5nDet7CSo+RiwuNk35XsD7fmAE1E4dMTAsbE0eXac
        SbF1nu16wFzG1yc7NRMsqwDJLrvOvJY=
X-Google-Smtp-Source: ABdhPJzLJrHJyFuqgXp/lCM5wrTiqNtbJRZ7PVsr8F8p99eVQyyOe80gdg1IFmhD0yUgunH1JeMpCg==
X-Received: by 2002:a63:e24d:0:b0:3fa:1e2e:b992 with SMTP id y13-20020a63e24d000000b003fa1e2eb992mr7889491pgj.595.1653320461383;
        Mon, 23 May 2022 08:41:01 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id a8-20020a654188000000b003db580384d6sm4890602pgq.60.2022.05.23.08.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 08:41:00 -0700 (PDT)
Message-ID: <72c52318-9cf8-1bf1-27f3-001abc164408@gmail.com>
Date:   Mon, 23 May 2022 08:40:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1] MIPS: bmips: Fix compiler warning observed on W=1
 build
Content-Language: en-US
To:     Jim Quinlan <jim2101024@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM BMIPS MIPS ARCHITECTURE" 
        <linux-mips@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220523121639.16521-1-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220523121639.16521-1-jim2101024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/2022 5:16 AM, Jim Quinlan wrote:
> The function arch_sync_dma_for_cpu_all() was used but was
> missing a prototype declaration.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
