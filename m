Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE404CBC08
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiCCLB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiCCLB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:01:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4CC1786B7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:00:41 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d3so7231174wrf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 03:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/TgIBjHQi7r7WHKCasRkN2aOlr4vraq88325rI9u3hg=;
        b=sJ2HpbTIaSDXarONqtC1kx7iU09mROR+Y1ql1Og5YiL5QIuHHYwigYAcp15XE1Qob2
         Yk7EjLnjdOKnIWydzO8/jmCEtj9xC2JCDeHE323taLayQ3Geqvj1PFmuMxob8qJ4ua9E
         LBpppiYiCDuxWrNUh1Hdsmpm/TGafy8GCah2fEvoBSSK0beLiK+ql2XFHHBFZ+pRiLwB
         Bb6dz7DgATYbhYukQI1jJZo40jmtMu3/6h2anA05rpZwBTBizYSFIy54w3FyZVY1kBFr
         k8iI1Hi+yABmbpfl8/EHdHh86VUmt8Ybmbko+lDGrMZVaTV3OvzTLEwloa5l7XoUcy2Z
         m4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/TgIBjHQi7r7WHKCasRkN2aOlr4vraq88325rI9u3hg=;
        b=kbV3IWyxaBHfNRhFn5dTUfM/dH4G+TKThgDOiRpiFfixC34cLXoPqpvRjm5beyRJLw
         qeuh/b93FHi2ThphsYytJ1uJaC0ZBNO8LYIbyTYOn2L0tURaTkW37LwzL9Au3TCdv4dk
         lfEqNV8ego7OQGJas3r2zhtZ0kfW+HhZwwRAyEyVL+h3OjuAx2d29m4AEEhVxXMKASeL
         w22dZj0g+TupDeeUITPJOl409tiP8XOhbcrFnN0Mbz2YtpwYAcEMqk2ImP+J7b+KSfxm
         aGDgcUcosWwcOMgJIFy6LkJHef7lWt+tTrf/KX4F8FgCNvqEEPks+yfQjQure82Uk7b6
         ZXEQ==
X-Gm-Message-State: AOAM530n0DCHIoChIAK0BVjEhs9Wryw0vAv6mQMtDNdOXXxnamiWVL6J
        5H6qg6K0r9eWn4Ftwnw2EZxINQ==
X-Google-Smtp-Source: ABdhPJwj6ojZKa6m7KAHwOvCGqv5fGE65DExmg5fopUMCQDCtIM9GUrgtcwOeg7kJlp1WsQ9ALSE7g==
X-Received: by 2002:adf:e98c:0:b0:1f0:2f5c:2e9 with SMTP id h12-20020adfe98c000000b001f02f5c02e9mr5191247wrm.356.1646305240498;
        Thu, 03 Mar 2022 03:00:40 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm6755282wmg.7.2022.03.03.03.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 03:00:40 -0800 (PST)
Message-ID: <ef2bdf6e-37f8-46d8-fdd3-4e548104b52f@linaro.org>
Date:   Thu, 3 Mar 2022 11:00:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: linux-next: build failure after merge of the soundwire tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220303215930.014e72f8@canb.auug.org.au>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220303215930.014e72f8@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen,

On 03/03/2022 10:59, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the soundwire tree, today's linux-next build (s390
> allmodconfig) failed like this:
> 
> drivers/soundwire/qcom.c:1460:12: error: 'swrm_runtime_resume' defined but not used [-Werror=unused-function]
> 
> Caused by commit
> 
>    74e79da9fd46 ("soundwire: qcom: add runtime pm support")

Fix patch is on the way.

--srini
> 
