Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47604D6FAD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 16:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiCLPRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 10:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiCLPRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:17:20 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F51E1B6E15;
        Sat, 12 Mar 2022 07:16:14 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id o6so15945048ljp.3;
        Sat, 12 Mar 2022 07:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yP2kewe3ti9ZfOopOVa7K12sPi5NnAgBl2PzcRBkWxE=;
        b=DWV+Ze/xxejqT2xuEHPDwP7tMXEou8ChjnbYU9d1tNyzMZ+aeyZ5Eipp7rVQ+LfV6+
         FGe6sze7Te+y03eLyZ9iTRz7Z7aKNT96YQfhnf5YiyADQfaMoICoPra4LuNFZaCfeV62
         XOkto9pkMGGB075KVJlJcoF41LQvl8cnBFxo8nhgaSGaAPUUw9pY3U5ou+zTMMe8GmUV
         M6ViOlgC52qZpszdGsT5vOVADEABD2c86+XTKhT6XRN5/0cBvPGjMkMlRDsU7cJmzLqK
         e1FxnLLcWkZgTQ/uw79IQdPFN93ea+O9k7NiBx3ly8R9hAJsbryKPWBCP60CG0ggXOP4
         FosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yP2kewe3ti9ZfOopOVa7K12sPi5NnAgBl2PzcRBkWxE=;
        b=GDONWJIZd99v+Dn7RhuLbaMxiToIeJcttYKWQ6mCA5z1TkVb4phacU6TGWfp9yXx/4
         sDlOto4woWyodFpjKgmUqIR26sr74/xnGn6hKWU1ywEyPO8OhCyyPZXVE8QBqhjsH2w+
         nq003qU1iYtv7uWMifOSryBLhMe0L8Fai+w7s8HueufmABoKmlKnQGKJWYVXuIDP9pud
         mBu8rkEgI/HT+RH0dMckSOYi5kxeOfbloem2Kyc3BOS8itf1r2Yq4XSkr4GDUrW4e/xh
         i5bkah72COQOK40E2CFqQSbTBilJFkBIh+IUcLk5QvU3ZCB861lBPRpzA5evd9MsF0/a
         SPMQ==
X-Gm-Message-State: AOAM530XHXREXtG7toEGs/xbsaOC+WJgMqleaWJn7bIgf0nKJpQASOfh
        PDy806NEKahgixq4sRQR5Co=
X-Google-Smtp-Source: ABdhPJxWFf7aRx4X94FoJ/xI/3+bHDfLbdTua46QbroQpRlZlIlc9vUOewmmfV/XlVccLiPGLtoKwg==
X-Received: by 2002:a2e:7d18:0:b0:247:f205:96fa with SMTP id y24-20020a2e7d18000000b00247f20596famr9020348ljc.269.1647098170958;
        Sat, 12 Mar 2022 07:16:10 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.107])
        by smtp.gmail.com with ESMTPSA id k9-20020a192d09000000b004487dfc9d9csm668361lfj.260.2022.03.12.07.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 07:16:10 -0800 (PST)
Message-ID: <7da316f4-aa65-896e-9020-2dfff2bbfc09@gmail.com>
Date:   Sat, 12 Mar 2022 18:16:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Fw:Re: [PATCH] fs: nilfs2: fix memory leak in nilfs sysfs create
 device group
Content-Language: en-US
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        =?UTF-8?B?5oWV5Yas5Lqu?= <dzm91@hust.edu.cn>
References: <3192BC90-D082-472B-B310-6E09A14A77C6@hust.edu.cn>
 <CAD-N9QUqfq+0UeMjQALUmGpX5xgjS6=BXvsqcXQpJRzhB6hHLw@mail.gmail.com>
 <CAKFNMokdB+Zph-1OyC1-Xnyi93r+yKSusgaEaa=CkuUBttwRZA@mail.gmail.com>
 <CAD-N9QU8-Od3G+-=RHM5K7vR2-4Af+4t=XutJJVdmkKhH7OarA@mail.gmail.com>
 <CAKFNMo=E8mMuY7Et0auH02fOzGKx04k2=LOj8mZJ6a-=J+sPzQ@mail.gmail.com>
 <CAD-N9QWt=d2Vj2bevSzOPL4AWF08_zTyq=hHOcOOROCazNY4_A@mail.gmail.com>
 <CAD-N9QWrBLygN24EC6QLRFF6uf7=PiTRdA4suKqEXJ7tk9aocA@mail.gmail.com>
 <dac7104a-21ac-24f4-6132-e51960fa0b7e@gmail.com>
 <CAKFNMon3=fFWtuUa1_wDyK9agpCXjbzA8b+rj=OYu=7Gs8nMqQ@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAKFNMon3=fFWtuUa1_wDyK9agpCXjbzA8b+rj=OYu=7Gs8nMqQ@mail.gmail.com>
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

Hi Ryusuke,

On 3/12/22 18:11, Ryusuke Konishi wrote:
>> In case of nilfs_attach_log_writer() error code jumps to
>> failed_checkpoint label and calls destroy_nilfs() which should call
>> nilfs_sysfs_delete_device_group().
> 
> nilfs_sysfs_delete_device_group() is called in destroy_nilfs()
> if nilfs->ns_flags has THE_NILFS_INIT flag -- nilfs_init() inline
> function tests this flag.
> 
> The flag is set after init_nilfs() succeeded at the beginning of
> nilfs_fill_super() because the set_nilfs_init() inline in init_nilfs() sets it.
> 
> So,  nilfs_sysfs_delete_group() seems to be called in case of
> the above failure.   Am I missing something?
> 

Yeah, that's what I mean :) I can't see how reported issue is possible 
with current code.


Sorry for not being clear




With regards,
Pavel Skripkin
