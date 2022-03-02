Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0F74CA160
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240711AbiCBJxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236809AbiCBJxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:53:21 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B1D647D;
        Wed,  2 Mar 2022 01:52:38 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id c14so1104861ioa.12;
        Wed, 02 Mar 2022 01:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I2o/pswz8CsOqeDuAgZ3eqxvNrxBejX6LZSzFbSCbBI=;
        b=abAWMduWTWfXPuvZrFhTxtXcEPYwnj6f4Ci3G04BEBi+KJl8ExHkzPtTRFq+47JkDQ
         5z0/nK7IoBhR3UkQDlA2XFmYaNx/ysabtceP5FE/7Y2OIq5Sc53pFN1WxZcA1obFvdCB
         7mrXffryFR+ro5wY2W1T4ol+p5vCNze0gHUVwCkSy0WbrWX4ft3E9WBYRu/LQ8i5kcbY
         ry/4wpzVF5kPO8No4mialbJXofkLN4pFyDWm3eILEpJHclOSuHBvD1LnSdG5EtBPQS12
         cSweC8SUpH0b2xOyPcJjmosm28l5ehtjN8QHj/u4Wg1wZxGhZnsJaFiIUcu5HeHUtnP+
         9Qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I2o/pswz8CsOqeDuAgZ3eqxvNrxBejX6LZSzFbSCbBI=;
        b=fMsOiYQ2ULpkymIIo8rlBdrfGkxWt4mXbQ0TgoyldsHLSQarBywnUGq1OOxK2yKQEq
         Qxu0KCZr33geAdGOzww8tE1SfsU6D8SBnuS2GKSXMRIblE23vnhnnkRLeX/74LtGQaN5
         KYJ4KWMzp8i2m1aXkcpVEAFwQJbhHo00K+ivzbZFrw3PkR12XhWQK1F3moKwEHYEqFni
         5yZvGkfbLQ926nG1gyaLlWC+0Ei65NqNSNmNH1j4UhRls7u2TqqFCHzvD4ID2H7/Z6j4
         O/as4Q6P776Vbr7EO3eFJT2rbbF0He5zECxhhXlYvkJZo+zPKpC1UAl3R725/Wr5FnGN
         eh/A==
X-Gm-Message-State: AOAM533ns7sedgOVFDevXt1Z3IreSnyX/MTzHv1w3a+6rLNeAmLZ8DXH
        p2loiFX11ZSkVfxWnoO910E=
X-Google-Smtp-Source: ABdhPJxFUXHHlld8SYitQpMlLWzDb6yrh0+mgCsz4nYJ4ZwRLkJ46kYwKsSY3aR4w/38eHCPUL69vQ==
X-Received: by 2002:a02:cb5b:0:b0:311:c0a0:9e1c with SMTP id k27-20020a02cb5b000000b00311c0a09e1cmr25177577jap.5.1646214757768;
        Wed, 02 Mar 2022 01:52:37 -0800 (PST)
Received: from [192.168.0.14] (static-63-182-85-188.ipcom.comunitel.net. [188.85.182.63])
        by smtp.gmail.com with ESMTPSA id v11-20020a056e02164b00b002c4a2d3d080sm1721804ilu.28.2022.03.02.01.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 01:52:37 -0800 (PST)
Message-ID: <33a65b94-9e99-2cf8-0b62-95127916ce79@gmail.com>
Date:   Wed, 2 Mar 2022 10:52:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: linux-next: build failure after merge of the arm-soc tree
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220302095008.27b6c6a9@canb.auug.org.au>
 <CAK8P3a0Quh+PqfBWe-LqzoSgs=ROzu6-8Nq=qceeHRwj8k7uYQ@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAK8P3a0Quh+PqfBWe-LqzoSgs=ROzu6-8Nq=qceeHRwj8k7uYQ@mail.gmail.com>
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

Hi Arnd,

On 02/03/2022 08:45, Arnd Bergmann wrote:
> On Tue, Mar 1, 2022 at 11:50 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> After merging the arm-soc tree, today's linux-next build (arm
>> multi_v7_defconfig) failed like this:
>>
>> drivers/soc/mediatek/mtk-mmsys.c:64:10: error: 'const struct mtk_mmsys_driver_data' has no member named 'sw0_rst_offset'
>>     64 |         .sw0_rst_offset = MT8186_MMSYS_SW0_RST_B,
>>        |          ^~~~~~~~~~~~~~
>> In file included from drivers/soc/mediatek/mtk-mmsys.c:18:
>> drivers/soc/mediatek/mt8186-mmsys.h:55:57: warning: excess elements in struct initializer
>>     55 | #define MT8186_MMSYS_SW0_RST_B                          0x160
>>        |                                                         ^~~~~
>> drivers/soc/mediatek/mtk-mmsys.c:64:27: note: in expansion of macro 'MT8186_MMSYS_SW0_RST_B'
>>     64 |         .sw0_rst_offset = MT8186_MMSYS_SW0_RST_B,
>>        |                           ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/soc/mediatek/mt8186-mmsys.h:55:57: note: (near initialization for 'mt8186_mmsys_driver_data')
>>     55 | #define MT8186_MMSYS_SW0_RST_B                          0x160
>>        |                                                         ^~~~~
>> drivers/soc/mediatek/mtk-mmsys.c:64:27: note: in expansion of macro 'MT8186_MMSYS_SW0_RST_B'
>>     64 |         .sw0_rst_offset = MT8186_MMSYS_SW0_RST_B,
>>        |                           ^~~~~~~~~~~~~~~~~~~~~~
>>
>> Caused by commit
>>
>>    831785f0e5b9 ("soc: mediatek: mmsys: add mmsys reset control for MT8186")
>>
>> I have used the arm-soc tree from next-20220301 for today.
> 
> I'm going on vacation right now, did a quick revert of that commit to fix the
> build. Rex-BC Chen, Matthias: please send a proper fix that I can apply next
> week when I get back, to replace my revert.
> 

I send a new pull request with the missing commit included. Please let me know 
if you prefer the commit on top of the old pull request. This would break 
git-bisecting, but the window of commits is rather small.

I fixed my for-next branch yesterday already.

Sorry for the inconvenience.

Matthias
