Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9554C858B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiCAHxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiCAHxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:53:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8DF3E0FD;
        Mon, 28 Feb 2022 23:52:36 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id p9so18993671wra.12;
        Mon, 28 Feb 2022 23:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QgCQToL8Lxm+3TwetMYVdeOe6DqGsRMNEoAu1Q0sX+Q=;
        b=Msr+Hdu9PMBLEomg31EkVjWkx3w3yOPysT2gAqSsy1Q8nTjFwVq5fEbEWtj3XQfw3Z
         wMwbYkeUhIY4R3e6edyqcz31O0ayYBQBeTF9mfI0KdFDK4ix/14+r91r9UN2lMhMgIUo
         tDRCl2FLV/pL+h6THIresY/D+6F9qhrlKH9j+cwyWurGztms0gn39cBZKr2FJ0hC6JqC
         JYlnREcZjjSoUNB+nTruURcr8p4TR3yf18qqtGf7vf/VdB/OHqtftki4oYuae8/SztBA
         SFPvyV2QxBecnvHvAvu9Uunxik32gNB5/6isELdv+ooSqK8z2SLFe0d9Sr9bpY4QBiu7
         31Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QgCQToL8Lxm+3TwetMYVdeOe6DqGsRMNEoAu1Q0sX+Q=;
        b=yurCVAHy7QY3Eya/sgx2LpQjIHNNHon9gP5cRrokAZKba2D4e6jgEPrNwetYD1Hrzx
         9IXDVyXaKe5gKOBgHSXIPiLwJjKPMgfejkn7rX/MhIBQq1t1cjUCk9VG3VtZ6iSMMzyD
         Sb9Apzm9RnLqtzTT8kNvSHRvLWQC1uC4iX7wKcyNorUXSAxiy9myIY+9kxtC+gKEhwuW
         tRH53UVsMvi/WVLZpTg0ocujX3EqbfDV63Y+/Vkp8CDIte5WUWA36ugqSuv/hGe5PCxr
         T4nApqFPusEoqtw66rz19zaxxi4dhtn/+o45A0kz7g0LkRGj6nwRfNCITxc64hQTkLJO
         EyBw==
X-Gm-Message-State: AOAM531BoLvZIWPVsDyejONcVMyljBxnTPOAQg4oOJYLsjHeujIHvYb0
        UGhh7aVUSv6O0gE+FANS5lc=
X-Google-Smtp-Source: ABdhPJzVpzmSMCRiuFoBWFG4z44NNPbssCQl1YdBpK/b+IG5izDPFtRvAM2Rl+lb0blw3AIeZ7Vk3Q==
X-Received: by 2002:a05:6000:8d:b0:1ed:9ed7:c915 with SMTP id m13-20020a056000008d00b001ed9ed7c915mr18482884wrx.543.1646121154834;
        Mon, 28 Feb 2022 23:52:34 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d598a000000b001efab095615sm7602985wri.29.2022.02.28.23.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 23:52:34 -0800 (PST)
Message-ID: <95f33dbd-4388-20ec-1e4c-ac323de9d18a@gmail.com>
Date:   Tue, 1 Mar 2022 08:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 0/2] Add PMIC wrapper support for Mediatek MT8186 SoC
 IC
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, robh+dt@kernel.org
Cc:     angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220207083034.15327-1-johnson.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220207083034.15327-1-johnson.wang@mediatek.com>
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



On 07/02/2022 09:30, Johnson Wang wrote:
> This series add PMIC wrapper support for Mediatek MT8186 SoC IC
> 
> Changes since v2:
> - Replace meaningless suffix _V2 with _MT8186 because
>    these IPs are only for MT8186 SoC.
> - Remove not used capability PWRAP_CAP_MONITOR_V2.
> 
> Changes since v1:
> - Fix the conditional logic in pwrap_probe() function.
> 
> Johnson Wang (2):
>    soc: mediatek: pwrap: add pwrap driver for MT8186 SoC
>    dt-bindings: mediatek: add compatible for MT8186 pwrap
> 
>   .../bindings/soc/mediatek/pwrap.txt           |  1 +
>   drivers/soc/mediatek/mtk-pmic-wrap.c          | 71 +++++++++++++++++++
>   2 files changed, 72 insertions(+)
> 

Series applied, thanks!
