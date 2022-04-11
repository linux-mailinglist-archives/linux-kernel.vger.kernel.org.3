Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C754FB7F6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344692AbiDKJsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344782AbiDKJsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:48:10 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2F03B555
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:45:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k22so3584203wrd.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=b198qKsCSPH7gfzfy4u2xyvLQAEiRiVMpS7bpZx+ZSY=;
        b=M9qpF7g3cWBcjHdulSQYqLsv06hF4R0iYCQJJX0pkjMFCXhA4luKWRawmUycgMrvX9
         mtEGikRv4pcZj6KrQHU8V4zTNqqYQHNnRguM/U6uMQRFE8dLmM7GhHMi2XNs9kZyoGBe
         A57W2slA1xmXVYstxt2IeRfzzPt0ANQJg1vGpUYbczjLERHh5WXlDCr/lXkDajg13opX
         R0PS3l8/MgFGHpS+Av2vwwEDCHWGkOHB/0854XB7aqkxrvwnBWCF/i2IQBzEwju2A32f
         wRm6f6A1+mqOvweF1OWt3SKtK/mWSa2vBwAsxDktRLQZHh2wokgftvQagHj1egEtsbqt
         omQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b198qKsCSPH7gfzfy4u2xyvLQAEiRiVMpS7bpZx+ZSY=;
        b=G1XawOz05LvFXkwYSx13VulNLhUdsKNvrFWG2t/pE0rmHexCBO6PdWWwoE/1BSFXPw
         PYMNykzloa0acqdKCx1zRQgtxqXdYKmKBMGZo8SyaWK4htICL+z8lhqmRkpvJQUQCnuX
         FgK3lLPHVPEkkbY6p4BPMZ/rDMUnEjQrVaytBGei7rZeDz4+s1kCXhUvLeRt9aP7+e+N
         2phcxhzmSJkM31Jbg/B/e/1jR8K2sAo2Wn2BMkkzNfzFT9dTbtnLByrOauEEhQJPV/Li
         epT80PYSroxQctkO0J/dnoBu0IydOqQOtN6C6lMDmFyQiWO7ZUWbtSRv20tp4gYwEkPg
         we9g==
X-Gm-Message-State: AOAM5323IscGzSP4vCRhwp6DlXsgnSqLTJ1iQ5nelBXsS7MVD3Rcc6Nv
        EfZAVtfw4oFrckogwWOVYQKV4PNyGMpX9A==
X-Google-Smtp-Source: ABdhPJzkysCMQKH2AW06DpYoYdftSbMItpy/7K4EcBy9BwM+dIOakJTfvnbTDNO+5DO5ZE5DJ+FWzg==
X-Received: by 2002:adf:f981:0:b0:205:c3e1:9eba with SMTP id f1-20020adff981000000b00205c3e19ebamr24699249wrr.244.1649670355449;
        Mon, 11 Apr 2022 02:45:55 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id v15-20020a056000144f00b002079acb2349sm7618565wrx.1.2022.04.11.02.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 02:45:54 -0700 (PDT)
Message-ID: <e6343890-2c8c-ea83-636a-61230a1e1759@linaro.org>
Date:   Mon, 11 Apr 2022 10:45:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] nvmem: add driver handling U-Boot environment
 variables
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tom Rini <trini@konsulko.com>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220411085926.10925-1-miquel.raynal@bootlin.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220411085926.10925-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/04/2022 09:59, Miquel Raynal wrote:
> On Wed, 2022-04-06 at 14:32:25 UTC, =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> U-Boot stores its setup as environment variables. It's a list of
>> key-value pairs stored on flash device with a custom header.
>>
>> This commit adds an NVMEM driver that:
>> 1. Provides NVMEM access to environment vars binary data
>> 2. Extracts variables as NVMEM cells
>>
>> It can be used for:
>> 1. Accessing env variables from user-space
>> 2. Reading NVMEM cells by Linux drivers
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Hi Miquel,

Any reason why this nvmem driver is taken via mtd tree?

This is going to conflict with other nvmem patches that are touching 
KConfig and Makefile


--srini
> 
> Miquel
