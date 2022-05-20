Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4697952E4E9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345794AbiETGWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiETGWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:22:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E2EBC6CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:22:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c12so9488586eds.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2qNVFmiF/TTMdfF9KQaUQuxRKJ4iuZ6iN+QlrxgUKnA=;
        b=SFqt9UOrMboZYYQDF1PI76h4elHYHxG9uQtEJeGv3ZvDqDMBr9VzkLWaLhdRXWG2SH
         1+OV1sAY8Wvdbb4ZXAE7Eh3aPpJXBYh7e276E8QCCCTG5NowqLGohiwSS7H/Rztz5Otg
         pklPeKeyiicDHIjwDmwePAzTtGdZxNGc8bqZCIwQ9qebOzQbOYT3XXStluuiQzNYZ0+M
         /gy0KzA1+HEkAzFNAH5aiH6H2FBLjYakLk/CzQaew8o9P6mP2jA31s0L/AG+MW4SBP14
         Yg6At+iZtGX/4zp151xto235Yk3ipky07JrMfaNrC0pagnGaq/1J/nqO8kbOZYlQEphS
         gjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2qNVFmiF/TTMdfF9KQaUQuxRKJ4iuZ6iN+QlrxgUKnA=;
        b=LZuJfKywj4Za8bOPswuEwe0Tp+TjHe9SLTWwECcVLC4ON40og/NzTrMtXevSvaD4BT
         6ALAhXpyGAS1fEh8btxTcZ+eTeMDw4RpAtgJiRHEV073cGv6T3o99uRIPySBcIo9L85h
         JDGh+uIYeW+9rdOoppsRdSWU8TQ12LFXHhnEjr/HTPdx03chnPewGRzs7DD5/amHLsx8
         xjpu1EuxQrCg1i2jJRMshDCV0oMhdE9k+ql5yj+k53B4My6+n6tF9Grvo/7APmEa+NtM
         BoSH4MbKmE6os08xpS+xEAigIdo5IRv35gZ7kRvZrtAl1xwpeXyhuIJu22VySR4yVPsB
         7syg==
X-Gm-Message-State: AOAM531yzioriclKNRNIiA6nVcmkF9gkQcTLa7/tdlngqpcLK6ggzf4D
        SL3QLSK9ZKlNSxSl+LCg6i0=
X-Google-Smtp-Source: ABdhPJw53K8igu5RpJ7t4nDpoJn09N8/AdK9nO7GxYmBWHaKQiibcUV7d6mxgSlKXJ6K0kEE0Sds7g==
X-Received: by 2002:aa7:d6c3:0:b0:42a:cc78:1764 with SMTP id x3-20020aa7d6c3000000b0042acc781764mr9089918edr.134.1653027761559;
        Thu, 19 May 2022 23:22:41 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:66f:9303:6022:1507? ([2a02:908:1256:79a0:66f:9303:6022:1507])
        by smtp.gmail.com with ESMTPSA id qs24-20020a170906459800b006f3ef214dabsm2886921ejc.17.2022.05.19.23.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 23:22:41 -0700 (PDT)
Message-ID: <045157bb-31a0-2d76-18b7-4272fab218ef@gmail.com>
Date:   Fri, 20 May 2022 08:22:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] Revert "workqueue: remove unused cancel_work()"
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
References: <20220519135642.83209-1-andrey.grodzovsky@amd.com>
 <CAJhGHyBQ60Lh3WZCa+2cE4T36t3vjNxYTBCxS7J0xhZr8Eb2wg@mail.gmail.com>
 <e1e2e63d-a1a9-12ad-97a7-a3771210edda@amd.com>
 <CAJhGHyC7VLM1PnXMu2zmdX=xtSNKo6VGO5p0AkUnaaMsuZytpA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAJhGHyC7VLM1PnXMu2zmdX=xtSNKo6VGO5p0AkUnaaMsuZytpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.05.22 um 02:47 schrieb Lai Jiangshan:
> On Thu, May 19, 2022 at 11:04 PM Andrey Grodzovsky
> <andrey.grodzovsky@amd.com> wrote:
>> See this patch-set https://www.spinics.net/lists/amd-gfx/msg78514.html, specifically patch
>> 'drm/amdgpu: Switch to delayed work from work_struct.
>>
>> I will just reiterate here -
>>
>> We need to be able to do non blocking cancel pending reset works
>> from within GPU reset. Currently kernel API allows this only
>> for delayed_work and not for work_struct.
>>
> I'm OK with the change.
>
> With an updated changelog:
>
> Reviewed-by: Lai Jiangshan<jiangshanlai@gmail.com>

Good morning guys,

for the patch itself Reviewed-by: Christian König <christian.koenig@amd.com>

And just for the record: We plan to push this upstream through the drm 
branches, if anybody has any objections to that please speak up.

Thanks,
Christian.

>
>
> Thanks
> Lai

