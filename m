Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D271752FF88
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 23:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244918AbiEUVFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 17:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiEUVFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 17:05:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A151249C8E
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 14:05:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y32so19619334lfa.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 14:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EkmajMsiYUhXvdrsUvmOT04jWZKTsPHdMPmsBMpezRw=;
        b=HnpXN/wSHlv/VEmQGhFVZKncoGfope+/brDTF6S+FoYf38JOPI4PUWKS7X66g5CUpI
         e168lzIxSSQw7MwsAk9amI/I5INXpyDzGztfYnmKODOuR+0BLjwICH+BO6IF8SAcI4OP
         S+RXXC4uOK3C6sBqkhNrv0HBUpTpDcnQQunaFKthy7J8sUQbxBORbQNULb5XfaXYBIiY
         KpEXuemSs7JU2JBDYzNvcHFQbCnE/m//B+7P6nPCkUZzakVFlYpvX3d4fp1cXcEgxiLN
         i4IKuKgAmhDGHsmztaI1DmyDuNEHOuFPOIXMrRHXmg89gxpsBhyqPPJuqo8qulCjs8Fs
         FJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EkmajMsiYUhXvdrsUvmOT04jWZKTsPHdMPmsBMpezRw=;
        b=NV095/wY26qj7L3gCMxR1A7RSrIHP0BJPk+k1URGLgMRMW3aULcEayB5IPWhnj+cwX
         wGjs12F8xGol0xAFi4is5aL5iLCrKA1wGk3ZgDzSsWxBzwibeAbl13yZYkg7ly2km867
         XuwvCeQUMk1vAOHe5epyU7TrZePdz42dn/4qN5EHOY8tz7mk3pyv6/tPk7H+GABNHxtW
         gYo86E7r/qhLYyEXoM9rcd6DZl888pUVrCr1B1yU66OBGI20xCuMX5v1/zyNHr+OQA1x
         6NpfHMttbK7lfvwWWyLPVnJ6gpuN7J9U2zXR4GS+SwGWVXEJJstwopvto9D/j9HYIE68
         EXtA==
X-Gm-Message-State: AOAM531FnF96xAUdV3qbGd2pYG771YnTw7AOlun6vMmo4hi+FvSxuCt5
        0OMfjRZc7U8EuzyPyG3K72Y=
X-Google-Smtp-Source: ABdhPJymc3KO6kebafKYNGTa/JzoZ5/Pot2UgArE7micAEnyJ3ghlHSadFTf1pLFKRQjJ+s4ajxoQw==
X-Received: by 2002:a05:6512:4007:b0:474:2df9:573d with SMTP id br7-20020a056512400700b004742df9573dmr11524539lfb.166.1653167135821;
        Sat, 21 May 2022 14:05:35 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.4])
        by smtp.gmail.com with ESMTPSA id o27-20020a198c1b000000b00478509b44e6sm805221lfd.84.2022.05.21.14.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 14:05:35 -0700 (PDT)
Message-ID: <3e4761a4-5ee8-0ba0-d64c-fe8798f2f010@gmail.com>
Date:   Sun, 22 May 2022 00:05:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3] staging: r8188eu: add check for kzalloc
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Martin Kaiser <lists@kaiser.cx>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220518075957.514603-1-jiasheng@iscas.ac.cn>
 <20220521155017.7jjz7prdnspm2276@viti.kaiser.cx>
 <8fb49b5b-106b-3346-a75d-d54e0a065587@gmail.com> <YolRut+PJ68J9mcM@KernelVM>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <YolRut+PJ68J9mcM@KernelVM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

On 5/21/22 23:56, Phillip Potter wrote:
> Hi Pavel,
> 
> I agree with you totally - we should change these semantics to reflect
> how the rest of the kernel generally does things. That said, that is a
> bigger patch set and I noticed the driver was broken before I read this
> thread, so I've submitted a patch already just to fix the breakage for
> now.
> 
> Changing these semantics is a bigger patch/patchset and I wanted to get
> this out in the meantime - if you are looking at doing this conversion I
> will by all means leave that alone as no desire to tread on anyones
> toes :-)
> 

I think, redoing more then 500 place will take quite a long time, but 
driver should be fixed ASAP.

So let's apply your patch and then someone (maybe me) will cook a patch.




With regards,
Pavel Skripkin
