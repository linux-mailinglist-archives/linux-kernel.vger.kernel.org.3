Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BFA4E22D2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345571AbiCUJD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345657AbiCUJDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:03:12 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506E088799;
        Mon, 21 Mar 2022 02:01:47 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id o10so9655025ejd.1;
        Mon, 21 Mar 2022 02:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=E8Qau+0wzq+mozrZXVdR8i7saP5ro63onX2XCKgGjPo=;
        b=n7Rdh5KO4xeTQqS8Gj1dPqbv3rXvEDAjk44t8iGhGd4uBOIC2V2iQYqpuez23BHzh+
         BVuajzaAy2WnshqVynMyOs/0mUogP2TCFmYVgpKcCfaYjstaUsQugqlSgPj9xAIoIeSt
         gE9lkxAHTi/HF3QgzgUSxb9BN7kEknPkt23cEHN5xdYe8oAHf29+sRdxFOvVboYo6pCm
         pOTVzUPTP1yStMdD3vgGKIdIFBxMsboQ5d/FGZStmcdZxKuiP5b7NDpTHuouo8IBrxtK
         EDbsS2wGfdCImFagCxF+Ta/E6iZmBQ5cgekm6xSBUngkeQut8WQoNkgaWbYKC8HoNNK0
         TzTg==
X-Gm-Message-State: AOAM531sb8j5XxmZqvrr8XE9PsOPB6ZPEE9Vrbeoi00W40y5EmjspI64
        qrXGwpkwEPjOvN2eNxWAiGI=
X-Google-Smtp-Source: ABdhPJyJtCs/QTnBz7Ahos9m7nuLWKArBgZLNjJtOZ1N8f3LU6ZRxI7xIaWvq1/XpCIdIM3IOBEmiw==
X-Received: by 2002:a17:907:d0f:b0:6df:d55c:a9a5 with SMTP id gn15-20020a1709070d0f00b006dfd55ca9a5mr8939068ejc.447.1647853305846;
        Mon, 21 Mar 2022 02:01:45 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm6540726eje.183.2022.03.21.02.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 02:01:45 -0700 (PDT)
Message-ID: <ef173db6-4635-8a77-c3e3-d96b0c2fa7a3@kernel.org>
Date:   Mon, 21 Mar 2022 10:01:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 2/2] mmc: Add mmc driver for Sunplus SP7021
Content-Language: en-US
To:     =?UTF-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lhjeff911@gmail.com" <lhjeff911@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Cc:     =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?UTF-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
References: <cover.1647652688.git.tonyhuang.sunplus@gmail.com>
 <f954fb1c0d1c4950b71a8fc360c78edcca9954de.1647652688.git.tonyhuang.sunplus@gmail.com>
 <e5426768-1dd0-0bef-25e8-2ab494f7723d@kernel.org>
 <c6ecbe40dc234454b41bcbc0bf073084@sphcmbx02.sunplus.com.tw>
In-Reply-To: <c6ecbe40dc234454b41bcbc0bf073084@sphcmbx02.sunplus.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 05:55, Tony Huang 黃懷厚 wrote:
> Dear Krzysztof:
>>
>>> +	int dma_int_threshold;
>>> +	struct sg_mapping_iter sg_miter; /* for pio mode to access sglist */
>>> +	int dma_use_int; /* should raise irq when dma done */
>>> +	struct spmmc_tuning_info emmc_tuning_info;
>>> +	struct spsdc_tuning_info sd_tuning_info;
>>> +	int restore_4bit_sdio_bus;
>>> +	const struct spmmc_compatible *dev_comp; };
>>> +
>>> +struct spsdc_host {
>>
>> Where is this used?
>>
> 
> struct spmmc_host{} for emmc.			
> struct spsdc_host{} for SD card.			
> The register base address and offset address of emmc and sd cards are different.			
> eMMC and sdcard are their respective hardware settings.


This is a weird answer. I asked where is this used (struct spsdc_host).
There is no single reference of this type. Your answer does not cover it
all. I know that eMMC and SD are different. That was not the question.
The question is: point me to the code which uses this type.


Best regards,
Krzysztof
