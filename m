Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3090B50BBD0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiDVPnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbiDVPlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:41:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCC35AECC;
        Fri, 22 Apr 2022 08:38:22 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w4so11572877wrg.12;
        Fri, 22 Apr 2022 08:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QhhufdrYma19zmloa3Gp0l15zXYz5cGKva41oCbR3Xc=;
        b=VwcNRCjNTLZgGgF6a7zs6SLC8e1Xv586fn+wjvq3TTPpmV+shP9HPJi5h6yUPCbwUK
         3F9n/vsgWGU93PQyM6GTS4ITbpqdx9PXgccgj4YpPZHYLFzLu8/XqVILvxvySsen7wy9
         IYvgp25XLH4bNcDTDpL7yXmHQx+Z0SLzzc11ukpsjHjNIDV9WkKeiTYIxN06pb4XSAGU
         HyRVJO2hLsbARNvu5nbXV/j8UVKHd0Iv45Wy6sNNjD/2cIe4Jn9+YYhX11p0WHML0J/2
         9tuWnhUtj562PqPlhLfsE6UERyqEG8RV8PRExY/uOl//sbWDVh+x78lrTi9xxgNMwOD7
         CyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QhhufdrYma19zmloa3Gp0l15zXYz5cGKva41oCbR3Xc=;
        b=O6aUL9p51Ck4gH6xiYU1U641kc+8430pg8mSoloyXmdCetjt9CJnlsv9B4kShArrf9
         sOK35DOdku+ZB113fKMjGzM3tXsEHFqEeWbE/qGQD7H2Ioe7zN7wF/sa495xOu1hXNOF
         JiONd803P1bno+UVH5Q2d5g5jm3s7CJqpOyr9IBPZw7eNr4e/zoZy2mu+YUeMbYiW43s
         i55DV0HKu7RGjXtqLmsmPSwUuIC3QFYmbdvj/Ol7UNUbmpryXwKeBMoB5EVAofVftjJU
         051TTRVy9FeBeXvBYZTXe6ab5y17x008syIO7oo1FpVAnKjfgis4AMYBp0Dq+V+GVCNI
         GbGQ==
X-Gm-Message-State: AOAM5336wFC0h0njnGlpDqVpOn8wwoiYTFwNEXHxif3HMLQWZxzBHdg1
        yQbBq79XqaDXRQcLEpd06a8=
X-Google-Smtp-Source: ABdhPJzs5IwZfxCuSmdATaN96kg4oNBC54s3d8Tgbg0QBR1dz79ohwaqNoQd0Mthn411pnQJu33AOg==
X-Received: by 2002:a05:6000:136b:b0:20a:c416:e914 with SMTP id q11-20020a056000136b00b0020ac416e914mr4342554wrz.167.1650641900962;
        Fri, 22 Apr 2022 08:38:20 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id w4-20020a7bc104000000b0038eba17a797sm4687044wmi.31.2022.04.22.08.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 08:38:20 -0700 (PDT)
Message-ID: <ca127f7f-0620-1c03-4f39-206945b0e612@gmail.com>
Date:   Fri, 22 Apr 2022 17:38:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v24 0/7] soc: mediatek: SVS: introduce MTK SVS
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>
References: <20220420102044.10832-1-roger.lu@mediatek.com>
 <7hczhbe3wn.fsf@baylibre.com>
 <3d463c8b099fdb1c9a0df9e615a8ca1d8a034120.camel@mediatek.com>
 <7hsfq6ql4v.fsf@baylibre.com>
 <d67d5f4f2ec96ade2398e7c0897dbb16bf5fb145.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <d67d5f4f2ec96ade2398e7c0897dbb16bf5fb145.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/04/2022 04:24, Roger Lu wrote:
> Hi Kevin,
> 
> On Thu, 2022-04-21 at 12:41 -0700, Kevin Hilman wrote:
>> Hi Roger,
>>
>> Roger Lu <roger.lu@mediatek.com> writes:
>>
>>> On Wed, 2022-04-20 at 16:22 -0700, Kevin Hilman wrote:
>>
>> [...]
>>
>>>> That being said, it would be really nice to see an integration tree
>>>> where this was all tested on mainline (e.g. v5.17, or v5.18-rc)
>>>>
>>>> For example, I can apply this to v5.18-rc2 and boot on my mt8183-pumpkin
>>>> board, it fails to probe[1] because there is no CCI node in the upstream
>>>> mt8183.dtsi.
>>>>
>>>> I'm assuming this series is also not very useful without the CPUfreq
>>>> series from Rex, so being able to test this, CCI and CPUfreq together on
>>>> MT8183 on a mainline kernel would be very helpful.
>>>>
>>>> Kevin
>>>>
>>>> [1]
>>>> [    0.573332] mtk-svs 1100b000.svs: cannot find cci node
>>>> [    0.574061] mtk-svs 1100b000.svs: error -ENODEV: svs platform probe
>>>> fail
>>>
>>> Just share. I've tested this series on below two platforms and it works as
>>> expected.
>>> - mt8183-Krane (kernel-v5.10)
>>> - mt8192-Hayato (kernel-v5.4)
>>
>> Unfortunately testing on v5.4 and v5.10 with lots of other additional
>> out-of-tree patches does not give much confidence that this series works
>> with upstream, especially when I've given a few reasons why it will not
>> work uptream.
>>
>> The examples I gave above for CCI and CPUs/cluster disable are good
>> examples, but another one I forgot to mention is the dependency on Mali.
>> The SVS driver will never probe because it also depens on a "mali" node,
>> which doesn't exist upstream either (but panfrost does, and acutually
>> loads/probes fine on v5.17/v5.18) so this should be fixed to work with
>> upstream panfrost.
>>
>> IMO, in order for this to be merged upstream, it should at least have
>> some basic validation with upstream, and so far I have not even been
>> able to make it successfuly probe.  To do that, you will need to either
>> provide a list of the dependencies for testing this with mainline
>> (e.g. CCI series, CPUfreq series, any DT changes), or even better, an
>> integration tree based on recent mainline (e.g. v5.17 stable, or
>> v5.18-rc) which shows all the patches (in addition to this series) used
>> to validate this on mainline.
> 
> No problem. We'll find a machine that can be run correctly with recent mainline
> (e.g. v5.17 stable, or v5.18-rc) and add patches (CCI series + CPUfreq series +
> any DT changes) to test this SVS series. Thanks very much.
> 

Thanks Roger. I'll wait until this got tested with upstream Linux, before I will 
apply all the patches.

Regards,
Matthias
