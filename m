Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3444351DF69
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389280AbiEFTB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiEFTBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:01:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC4535840;
        Fri,  6 May 2022 11:57:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so7622341pjm.1;
        Fri, 06 May 2022 11:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5dIUR/9OXHaQsKnUQAHcXzPBR02zvSDjZjPrNBgbY9g=;
        b=DaeLIIPtkaJwU2ohwvQwOr2wNsG1sQaw7AS57MJTXBgPqvfNufTSm+3mgl+5whqVHY
         LF3OCd7rcRp2Hgi1/MOmOJUl6J2nYDETr/Sf3NJPSoJmy8zVUp+YQOFrAFgHHG2uYRtM
         lIpagkR7Qe3Z983zssmXonzy3CJ7pvhunuxShrdNbjsbROJJFDs+NBdPzI2frJkVzyV0
         sE8WNgIBCSlhOovX1BYMC1hdUJf/gt/q7/GORKm31Bxmk0EIk2lTRRm1So2Ac+dVW6ja
         b6XIMliP0fLhrUKVwYaDP+pfE4vRXy5vaPjKhHSTLQPwj2X224N8hYJI/u5ymK3yv8zu
         L6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5dIUR/9OXHaQsKnUQAHcXzPBR02zvSDjZjPrNBgbY9g=;
        b=dHNR73nNL6bsAYXHYN70BkMBwK/WOyJ3drBFiNzmMMN1RUI6rMw+7ZX5jS3OZqgCN1
         Aq0d18A5gwUO/HeOUBHnfdYFSeSntxDxEL4f/7fp5GoxHSEsr+YIFufbroGPC6t1WeB/
         jllgF6SOBWzM4ijiLE+T7RbLOxh84DGJNuZVb+20eb65ddfmzLXENRkcbkO8gyLqCtbO
         c5n2G3pemE/Yk/Z3f1ekSjU8XvG5B2QLFGzBb8EZ0qg57SWjFZ4M8j7WGDSP9J6tqdnJ
         C6h7k2otf2NqeysAiQ0Kvx24EiyHX8vrYe7jgJXcV7TMdK7F+coZqtaOtMDmibcNijyf
         EMwA==
X-Gm-Message-State: AOAM533bbMXfAAhaEesDwTlail1kMwsZKKoRaX5aTmyKNYmnDkyEcuDw
        chFQMsglzDTv1RolGlbhSHo=
X-Google-Smtp-Source: ABdhPJwO9azZKG2bTIvQhKP+wtX/+CwAnPeV5w1hcVnkdo01SGMmgOolv2xkl/VupuzuRn0jDb7hdQ==
X-Received: by 2002:a17:902:ec8c:b0:15e:a371:ad89 with SMTP id x12-20020a170902ec8c00b0015ea371ad89mr5098775plg.157.1651863461060;
        Fri, 06 May 2022 11:57:41 -0700 (PDT)
Received: from [172.30.1.41] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id y4-20020aa79e04000000b0050dc762814fsm3756790pfq.41.2022.05.06.11.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 11:57:40 -0700 (PDT)
Message-ID: <0846a062-2ea2-e6d4-03c8-992c2f2e24a0@gmail.com>
Date:   Sat, 7 May 2022 03:57:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/2] PM / devfreq: mediatek: Introduce MediaTek CCI
 devfreq driver
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, cw00.choi@samsung.com,
        krzk+dt@kernel.org, robh+dt@kernel.org, kyungmin.park@samsung.com
Cc:     khilman@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220425125546.4129-1-johnson.wang@mediatek.com>
 <20220425125546.4129-3-johnson.wang@mediatek.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220425125546.4129-3-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johnson,


On 22. 4. 25. 21:55, Johnson Wang wrote:
> We introduce a devfreq driver for the MediaTek Cache Coherent Interconnect
> (CCI) used by some MediaTek SoCs.
> 
> In this driver, we use the passive devfreq driver to get target frequencies
> and adjust voltages accordingly. In MT8183 and MT8186, the MediaTek CCI
> is supplied by the same regulators with the little core CPUs.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> ---
> This patch depends on "devfreq-testing"[1].
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing
> ---
>   drivers/devfreq/Kconfig           |  10 +
>   drivers/devfreq/Makefile          |   1 +
>   drivers/devfreq/mtk-cci-devfreq.c | 474 ++++++++++++++++++++++++++++++
>   3 files changed, 485 insertions(+)
>   create mode 100644 drivers/devfreq/mtk-cci-devfreq.c
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

I updated the passive governor on devfreq-testing[1] branch
[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing

Could you please test your patches based on devfreq-testing[1] branch?


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
