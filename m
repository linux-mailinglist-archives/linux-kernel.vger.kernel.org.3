Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8E850796C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357283AbiDSSwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357404AbiDSSwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:52:43 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4451BEA8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:49:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so2834286pjf.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZVIfCvJe76JPXouw6J0teDaTd4qb/xUX4pOTmZB88fc=;
        b=AhjTfur0oMD5aZaVQP//Sfl0Fp2JzFUPrB86dpbEjxYpUjdrkY0WBU+Ib/4x+Yxpo2
         2y5vzDnsAYqpITBwbq1KWHK8fwpGH5zJAZggDz+HPVakwestPT4QWiVSaBHcqQ5q4U+9
         JkrgZQoyBXsHzeQdQ/foC0Xwat/0ZJRmXG7Awi+5tcFVcqCv6IL7Yq7163VEYllUGL+8
         PgZkw+KC2q2CfaIp6WN7haigCmOm/CcuqZ6Iy7IUGw6YpAhs0w5c03ibHYLeqJkGhcpg
         +MWuMdCOGSSXR0qCpvzcaHKRljgVWyi1oRNpndyYmukBqEoSPbVks665VYyItFdEf/T7
         fTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZVIfCvJe76JPXouw6J0teDaTd4qb/xUX4pOTmZB88fc=;
        b=jiYBJA1WUCcl2PIgExAHyazTiq1Co77F4svW/5QZBMh0wxYaPfmeEKKZZpnBDGpfSz
         PScmUuEMmOCrYR3MxoE4HQuHH4yqbtmonBzQYgVBH8TwSx6BTW+A9EQ81po59uGdb8/0
         rpwGAUAeyHo85xRmPwW7zlvkdvbXqiu20yRjhNBWBRcHOARB/CUV//Q8UOEYfUu/xVNP
         efGS/PK4IKndypU9tm3ME5/sWUjCQmOvdtdR1D2EbtlF+xtxYchNBC2VSz4kbZlU7kIg
         jWeS5skfngZZXuNVfqvIZTBXBd9nZ6fqm+fJqjOh8vHlaDm3IrVmSfGBHbzX0cmiYuoH
         pd/w==
X-Gm-Message-State: AOAM533qXm7eTHfskeHBcOi5woy4UtgZedU6XnuG8ytG5rQ5vdoo1YHm
        NFV1RSkbjMNMRV3PuD67aXU=
X-Google-Smtp-Source: ABdhPJxDzlu8UYfooUXqBXloj+gfbMc5s1buTGWtpmuTq/orefNFW3FhiGxWE9zzN1N5thveY9ZBfg==
X-Received: by 2002:a17:902:ce02:b0:153:bd65:5c0e with SMTP id k2-20020a170902ce0200b00153bd655c0emr16932994plg.160.1650394198501;
        Tue, 19 Apr 2022 11:49:58 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id p12-20020a63ab0c000000b00381f7577a5csm16737697pgf.17.2022.04.19.11.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 11:49:57 -0700 (PDT)
Message-ID: <6d5d53d4-659d-b46e-55fd-2a05aabbeda4@gmail.com>
Date:   Tue, 19 Apr 2022 11:49:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drivers/bus/brcmstb_gisb.c : Remove the
 suppress_bind_attrs attribute of the driver
Content-Language: en-US
To:     lizhe <sensor1010@163.com>, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <20220320064529.12827-1-sensor1010@163.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220320064529.12827-1-sensor1010@163.com>
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



On 3/19/2022 11:45 PM, lizhe wrote:
> Even if platform_driver does not set suppress_bind_attrs attribute,
> when registering with platform_driver_probe,  the value of
> suppress_bind_attrs is still true, see __platform_driver_probe()
> 
> Signed-off-by: lizhe <sensor1010@163.com>

Applied with a revised subject, thanks!
-- 
Florian
