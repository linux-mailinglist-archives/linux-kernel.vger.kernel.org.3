Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C53F4DE944
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 17:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243617AbiCSQU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 12:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiCSQUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 12:20:54 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB064AE3E;
        Sat, 19 Mar 2022 09:19:33 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m3so6519393lfj.11;
        Sat, 19 Mar 2022 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=ct+HgVnZ/DFBJCX61R8Guizdh+l3aPUH9SqipyA1mHI=;
        b=ZWg/BmDEkQSnAiS0lpydrPlsLOpEDaJ8CZamwCuiRuP4nCID1hWmmmWwRgYQUCP+Tq
         qTxJ3smazlVoUK1FG66NfWeWi/Dv93Gxv1KYFxIDir8WlKZPww8Z3Y0ovvs5HlKNsRE8
         9cAxYuqVtzOeQCnbZhE/kZSh70U44whnA/jogOup+RaCoxup0PnLh2vZR61ocb2GSiGH
         Fj21bynlD37Ow1pWts12ofo0x1pjy3N2gVubV7P+b6RiHExI69HBniyTwg1BWNa7Y7+M
         2OHBwu3yfKdvBG0JHToaBiS5iKQ5D1pcZeFUpTvHYNDhUMo+THyL2T8zR59uO6Ok2Fu1
         pCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=ct+HgVnZ/DFBJCX61R8Guizdh+l3aPUH9SqipyA1mHI=;
        b=wsk4QwiP+Q3Axcrzd1viD5chzYyUttduV+Z718+9cuhFevU4lTfKOo6I7zsw+1wj7R
         xr+8r9S+pcqsYg08c8/mUTLfxWWcwPVpU9aNknENvoaGS2It5DOg7jYFQ/C6qY0Y/qal
         ZIxj2LUwTdZWsabOkeUfsvjUnQiRDft3pp6ykgxDYnGPGCOx8tewsN6cfORO03C8yL/X
         8LZU4RAeRwa6kuTzet8FJ6SYfR764DZ8sQD9Rx9hzEGvdjY7Bca+uKGU6oHJCJHSQmGM
         LfKULdjT0z6eSIv5BkT8gwp2Vbq8nNZVg9obXKPS1ZJ1xeoetpOMePdPsQm4jTpPYUdd
         iX2A==
X-Gm-Message-State: AOAM532nSTEvRN7ms30RPikGWPxcC9xGslTezihPNqgIWREigZJ2rF7F
        i5Hqq7JFztTtLfL4xHIoioU=
X-Google-Smtp-Source: ABdhPJyKC1LgYBMv8tvEtRuDpQDzC9Nf0Co3eazwI+hgReffiOi/JI8deLnjpPwrXBEL3TOB8jAakg==
X-Received: by 2002:ac2:560e:0:b0:448:816f:1434 with SMTP id v14-20020ac2560e000000b00448816f1434mr9325675lfd.625.1647706771522;
        Sat, 19 Mar 2022 09:19:31 -0700 (PDT)
Received: from [192.168.2.145] (109-252-136-171.dynamic.spd-mgts.ru. [109.252.136.171])
        by smtp.googlemail.com with ESMTPSA id q11-20020a2e914b000000b00244c6c98416sm1578667ljg.76.2022.03.19.09.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 09:19:31 -0700 (PDT)
Message-ID: <78a48790-f97c-9897-821b-7f9af0b041bd@gmail.com>
Date:   Sat, 19 Mar 2022 19:19:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Ashish Mhetre <amhetre@nvidia.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
 <fc8f35f8-ccc5-e847-e988-c4b882e53a44@gmail.com>
In-Reply-To: <fc8f35f8-ccc5-e847-e988-c4b882e53a44@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.03.2022 18:50, Dmitry Osipenko пишет:
>> +	mc_has_channels = mc->soc->num_channels && mc->soc->get_int_channel;
>> +	if (mc_has_channels) {
>> +		int err;
>> +
>> +		err = mc->soc->get_int_channel(mc, &channel);
>> +		if (err < 0)
>> +			return IRQ_NONE;
>> +
>> +		/* mask all interrupts to avoid flooding */
>> +		status = mc_ch_readl(mc, channel, MC_INTSTATUS) & mc->soc->intmask;
>> +	} else {
>> +		status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
>> +	}
> So if mc_has_channels=false, while it should be true, then you're going
> to handle interrupt incorrectly?

I see now that num_channels and get_int_channel are const, so I don't
see why mc_has_channels variable is needed. Use mc->soc->num_channels.

if (mc->soc->num_channels) {
