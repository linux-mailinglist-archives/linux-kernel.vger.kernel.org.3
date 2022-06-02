Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A2A53BAB5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbiFBO1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiFBO1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:27:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D0012C97A;
        Thu,  2 Jun 2022 07:27:43 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k16so6699003wrg.7;
        Thu, 02 Jun 2022 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PU8lc3rqUKJ9fwYFMxTWZiWtxbKl/aHmbF7KgXVxdw8=;
        b=nTCCpeSYwfMZY+4KPdvMlazL72pUA9cf31ff5VpnywSiVU9k5w5t458nw6elFguljg
         OyVTJ6tj4p5kxFAUAVicDk6q903TOeCzEEX7UqisGtUPG8ui4J274meFJKWGwWzRorv5
         h5Y/xMsiRDKaMFfBWbUE9FlqYBqmZC0lnC6o170UwiLmvD1F4cIwmf7q6WKP+ypzmGfO
         fpHzIbIvQPob9eBzeY3t0iu0sV9vuWV98dAV+9s35Y3YBfLr2FiMHs3dQHaWnTqKjxYZ
         HtUvhV7aVJm+ZxGEJfifkYjdHnZJFL+muk90bFTjaLFdQ1KGsobxK1HtczYZDzorbLox
         rnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PU8lc3rqUKJ9fwYFMxTWZiWtxbKl/aHmbF7KgXVxdw8=;
        b=H+O+oW4rJdWcycYvIPSzOPvFbKm1WD7kLeHu/uTp5no0wDNTrWDeHmiRDlCkUIrPL0
         eCXnFxFkFjbUELMJ+rGKoYjbWTLRGVaL5OaQJOzULZZIfEpIkj8b8FsxJtOsM6oXaRAu
         OVDXky2cufMAmctA+4ZqFPWsjhyJvjXZu4rZdR0EGUjwXC7ixmK0muOLpM09ELpPo9t/
         yme/2Bcb1trgEcwqmbplt16QipdX0GBYikS//HN1ivf1iYEcKu1Zz/ftADYRM79babZ0
         hygVH4UHFKDQb28GOZ/Du/bwtcgmgcQCcbWmA4vIO9+ZFLl6daATloUIfOugiJHyYpBO
         QS1w==
X-Gm-Message-State: AOAM532DjcPVuSpKWpRUKBPoubouq0lyeEVxuSmL0nv7geI8zahfa62p
        pXyqbWFNc+cvYh4ql2fLvmo6h9bM+Z6SPA==
X-Google-Smtp-Source: ABdhPJwjC4sOY/AU32uEMgLGNEAI19FhBPDUP9arLJ7oiFGKBMRXEJZ7V09GeOEGnuHwTIckNIWbKQ==
X-Received: by 2002:a5d:5885:0:b0:20f:f390:c47e with SMTP id n5-20020a5d5885000000b0020ff390c47emr3997562wrf.133.1654180061203;
        Thu, 02 Jun 2022 07:27:41 -0700 (PDT)
Received: from [10.40.36.42] ([193.52.24.5])
        by smtp.gmail.com with ESMTPSA id ay1-20020a5d6f01000000b0020fee88d0f2sm5954781wrb.0.2022.06.02.07.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 07:27:38 -0700 (PDT)
Message-ID: <c5022150-a2b4-07b9-d8ec-789147134d85@gmail.com>
Date:   Thu, 2 Jun 2022 16:27:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 0/3] Support MediaTek devapc for MT8186
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        runyang.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220504115501.3490-1-rex-bc.chen@mediatek.com>
 <CAGXv+5E9s3c0j501fHZxhwsHSeK0vG+GEqLMhtZMvtvC=+etjQ@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAGXv+5E9s3c0j501fHZxhwsHSeK0vG+GEqLMhtZMvtvC=+etjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/06/2022 09:48, Chen-Yu Tsai wrote:
> On Wed, May 4, 2022 at 7:55 PM Rex-BC Chen <rex-bc.chen@mediatek.com> wrote:
>>
>> This series is for supporting devapc implementation in MT8186.
>>
>> V2:
>> - Add a patch to separate register offsets from mtk_devapc_data.
>>
>> V1:
>> - Add dt-binding and add devapc data for MT8186.
>>
>> Rex-BC Chen (3):
>>    dt-bindings: soc: mediatek: devapc: Add bindings for MT8186
>>    soc: mediatek: devapc: Separate register offsets from mtk_devapc_data
>>    soc: mediatek: devapc: Add support for MT8186
> 
> Applied this on next-20220602 (with a few fixes for other section mismatch
> errors), booted and got:
> 
> [    1.948483] mtk-devapc 10207000.devapc: Read Violation
> [    1.948488] mtk-devapc 10207000.devapc: Bus ID:0x100, Dom ID:0x0,
> Vio Addr:0x13000000
> [    1.948520] mtk-devapc 10207000.devapc: Read Violation
> [    1.948523] mtk-devapc 10207000.devapc: Bus ID:0x200, Dom ID:0x0,
> Vio Addr:0x140001a0
> [    1.948537] mtk-devapc 10207000.devapc: Read Violation
> [    1.948540] mtk-devapc 10207000.devapc: Bus ID:0x200, Dom ID:0x0,
> Vio Addr:0x140001a0
> [    1.948555] mtk-devapc 10207000.devapc: Read Violation
> [    1.948558] mtk-devapc 10207000.devapc: Bus ID:0x200, Dom ID:0x0,
> Vio Addr:0x14000100
> [    1.948573] mtk-devapc 10207000.devapc: Read Violation
> [    1.948576] mtk-devapc 10207000.devapc: Bus ID:0x200, Dom ID:0x0,
> Vio Addr:0x14000100
> [    1.948590] mtk-devapc 10207000.devapc: Read Violation
> [    1.948593] mtk-devapc 10207000.devapc: Bus ID:0x200, Dom ID:0x0,
> Vio Addr:0x14000100
> [    1.948607] mtk-devapc 10207000.devapc: Read Violation
> [    1.948610] mtk-devapc 10207000.devapc: Bus ID:0x200, Dom ID:0x0,
> Vio Addr:0x14000100
> [    1.948624] mtk-devapc 10207000.devapc: Read Violation
> [    1.948627] mtk-devapc 10207000.devapc: Bus ID:0x200, Dom ID:0x0,
> Vio Addr:0x14000100
> 
> during the boot process. So I think this works well. Manually reading a
> known secure address also triggers it:
> 
> root@hayato:~# busybox devmem 0x1000e000
> 0x00000000
> [  135.069121] mtk-devapc 10207000.devapc: Read Violation
> [  135.069132] mtk-devapc 10207000.devapc: Bus ID:0x482, Dom ID:0x0,
> Vio Addr:0x1000e000
> 
> So,
> 
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> 

Whole series applied to v5.19-next/soc

> BTW, looks like MT8186 support in mainline is shaping up real good.
> SCP firmware is still missing, so video codec stuff won't work.
