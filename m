Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3895B23CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiIHQnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiIHQnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:43:43 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F42122391
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:43:37 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id d15so900031qka.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 09:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=0XsbLIO6zVoDWhejmU39Vgqhd4Id8+NIThNM5fDQGJ8=;
        b=dkIclgXFiQcPf63niixCbV1YB5e+2rmvMam+EBVqIO1AxOXeaqrbCjSRsEk/6+vQTP
         3WOA1TsjypG9xgqrSg08UZM6fEE1Eh2eoFk9sd1p96MSvp0LkmnVuHrolbBlVFMhb6DI
         DmQST4dXAkhHDP/giELuIVyhMbCi1MWhYQRAWjeCN3nTsho87oOibbV9wEik2LnXjN3j
         8aNWwVhxEZXDPXi1xOaRZQnL57f5znNfqEZPEd/SXbKlvHt5I7cRyWlPYYvfu1k9nLVH
         guF5vd0UjRGSCorXoN9t1eZCWrnK16HBbLCWpZ4tdVtt4i+u6I/h7NuwEC5xKM6jRdxO
         pHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0XsbLIO6zVoDWhejmU39Vgqhd4Id8+NIThNM5fDQGJ8=;
        b=44116l3ugf9v7sgeWgIrURMfM4oS26tc1BUGe4yX6FUliDoWpwS+Tb01Ie4JpnIv1L
         pfhWCgMFBexi4QhhWNDrcYU8rX/mJ6On+ZIGqordcIWdek2sfj98jR7CoGqgo4u8avBg
         qW4HUB8SmyqX+mBQjXcKXVSzK55ksl5ZYwOETZV/XE13dtfDMpzm9odLjhdG/OTLUaeX
         lW5oYt0YTtIlmJzromfRF2DI/+HWCaLWOgHpukXYvtj+0NlfABgA9Nb5Nd7UT8FRxHxT
         lFOnwM+CYhJqEcUHWisegildb54ZfuogUmfeBu0mppmhTsiaUdf/w/QW8Y9TbRG23ye3
         gHUg==
X-Gm-Message-State: ACgBeo1DpeyscOLtmzOow+UxNURg8GIzUMmYysPKS4DkPCCYcDKgrwJo
        q+N3Tf+GpMmZJxZ9a+j2Byo=
X-Google-Smtp-Source: AA6agR7g3zVAk7I9S7IVnTFx/3++VjeSP7TWm1Mv2UB0P/n9uSMqp0mScOrZ9lRAtC/kZJW9Jz1X3g==
X-Received: by 2002:a05:620a:248f:b0:6bb:89d1:3e85 with SMTP id i15-20020a05620a248f00b006bb89d13e85mr7084450qkn.408.1662655416764;
        Thu, 08 Sep 2022 09:43:36 -0700 (PDT)
Received: from [192.168.1.102] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id hf9-20020a05622a608900b00342fb07944fsm13911957qtb.82.2022.09.08.09.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 09:43:36 -0700 (PDT)
Message-ID: <588be35f-9293-0d26-1e89-5ba3a0f9bbc5@gmail.com>
Date:   Thu, 8 Sep 2022 09:43:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: arm64: Kconfig.platforms: Re-organized Broadcom menu
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     anand.gore@broadcom.com, arnd@arndb.de,
        bcm-kernel-feedback-list@broadcom.com, catalin.marinas@arm.com,
        krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, soc@kernel.org, will@kernel.org,
        william.zhang@broadcom.com, anders.roxell@linaro.org,
        lkft@linaro.org
References: <20220712164235.40293-1-f.fainelli@gmail.com>
 <20220908110451.66564-1-naresh.kamboju@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220908110451.66564-1-naresh.kamboju@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2022 4:04 AM, Naresh Kamboju wrote:
> From: lkft@linaro.org
> 
> LKFT test farm found that Linux next-20220906 onwards the Broadcom DTB
> builds are not happening. And after bisecting we found this patch is
> the reason [1].
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> FYI, We have not changed any kernel configs.
> [1] http://ix.io/49Wq

Fixed with:

https://lore.kernel.org/all/20220906033957.4377-1-f.fainelli@gmail.com/

sorry about the breakage and thanks for reporting!
-- 
Florian
