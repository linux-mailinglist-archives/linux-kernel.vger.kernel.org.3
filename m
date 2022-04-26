Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C2150F897
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344691AbiDZJlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347803AbiDZJYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:24:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF3963D0;
        Tue, 26 Apr 2022 01:55:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e24so4552681wrc.9;
        Tue, 26 Apr 2022 01:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=e+fyQIZPV7NoV3Nod6UHAccnK0CLWkG2aHz5y9VhZv8=;
        b=mCn50J0G0pIsDbTwj+TZtEw0V68JDqfrQQrFB2AY1+h4lWLRMX/ljFrV6Vd7g6A6kA
         hr2ayMQ2ki3pVP/8eRZSOOdj8DFLJyOKTaCrMpH7+gF/DFiVMWVYeCQUoyb0wV3Rp/SK
         4vq9FOV2q7YowHIyQjJqnKJ0N3p8quU71Nd9ARGjez6Np4vITWsRIm8Z6yAchhTwUaQF
         iCneGmOzpqRtcRIPpNYWipXbwaWyZa5bNRasKRbKaIeBHkrNJKMWP4dVVeXpO0annW57
         lVPT3/Pc0j1+tlbnk09vWdVULEKOG8bi9njcQnmN3tzB/wQhrLJxRQUAYtYpJylAM+yF
         tLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e+fyQIZPV7NoV3Nod6UHAccnK0CLWkG2aHz5y9VhZv8=;
        b=sYAg2cvQKhETL1lrpL4Yuuu+xhRMOmbpozYPG4/M13Z/Yqri45qwmq8zvXWvWs/FSQ
         eU2N17ZuXL+7+Yk8FW2ObfU5sWjVRsEowdMb/8z95I9RiTIK3gr4Is/i0IAXc/dVwVU+
         y5HYqbuEk42EoxaYS2KYGPFmS04TrjMiLh0KvNfI/ZNkx0zvciiQi/D0Xd3xIPJuWILs
         CiOLhZe9nOWsptj/0oFxw2IN8rGhAGCaz9zCCZZZcCVqkMrgg28wLIfKdDIGaMWNtXEj
         bFIBSnkeLmdweQyeodAjNzrB1ihVfZXRl9y663jhMFvYC5guciT9GyOeYk8cJv9iixS9
         5T3g==
X-Gm-Message-State: AOAM531xcue3EUo4mNdXTHmYbv+anUC8nGDpt+GhzdomZSIOJnEAyOrV
        1GanxMuHZYoOVwHrbDxVlD4MtuvaugSLhg==
X-Google-Smtp-Source: ABdhPJyxSMG4rhEGcHNP97yPqxKsYSR7w1dlUkY+0VI22TH2G92zLfDHfvSw3Hea9XOLAXAyqXvHMw==
X-Received: by 2002:adf:fd45:0:b0:20a:d0fa:1342 with SMTP id h5-20020adffd45000000b0020ad0fa1342mr12872604wrs.595.1650963304964;
        Tue, 26 Apr 2022 01:55:04 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id q3-20020adfab03000000b0020ad57b8ddesm7675079wrc.101.2022.04.26.01.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 01:55:04 -0700 (PDT)
Message-ID: <0e84ae3d-318c-f88e-bca4-3ae947c3e734@gmail.com>
Date:   Tue, 26 Apr 2022 10:55:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: linux-next: Signed-off-by missing for commit in the mediatek tree
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220426080706.26c6816b@canb.auug.org.au>
 <60b73431-ea41-bcca-8374-1836488b399c@gmail.com>
 <55c9dd79-2703-b7f5-f593-3324d09085e5@kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <55c9dd79-2703-b7f5-f593-3324d09085e5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/04/2022 10:52, Krzysztof Kozlowski wrote:
> On 26/04/2022 10:48, Matthias Brugger wrote:
>> Hi Stephen,
>>
>> On 26/04/2022 00:07, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Commits
>>>
>>>     775ef8aaa66e ("arm64: dts: mediatek: align thermal zone node names with dtschema")
>>>     c8b8db1a173d ("arm64: dts: mediatek: align operating-points table name with dtschema")
>>>     c01d9aa630b8 ("arm64: dts: mediatek: mt8183: align Google CROS EC PWM node name with dtschema")
>>>     75a3c81bc634 ("arm64: dts: hisilicon: align 'freq-table-hz' with dtschema in UFS")
>>>
>>> are missing a Signed-off-by from their committer.
>>>
>>
>> These patches are taken by Krysztof and merge into my tree via a tag [1] to
>> avoid any conflicts. Please let me know if there is anything I need to do to fix
>> this problem.
> 
> Hi Matthias,
> 
> Before you merged my branch, which was fine, but later you rebased all
> this thus making yourself committer. Commits pulled from other trees
> should in general not be rebased, because it creates duplicates - there
> are ones in my tree, and separate in yours.
> 
> Additionally, such rebase changes the author, so you need your SoB.
> 

Ok thanks for the explanation.

> Since you already rebased it, I propose you add your own SoB to Mediatek
> patches and drop the one hisilicon (75a3c81bc634). I will do the reverse
> - drop Mediatek and keep hisilicon.
> 

Ok, I think this is the easiest solution. Sorry for the inconvenience I created.

Regards,
Matthias
