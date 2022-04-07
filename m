Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83934F84A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345626AbiDGQNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiDGQN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:13:27 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C2212082
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:11:26 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h5so4385935pgc.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zZ+X5NwIT3Ilre3MBBFmMIR7GaB22k8MhpZuVDzBpfg=;
        b=alOLYFapVJTwjNCt+HI8OgHd4gZ7wRBv6j9rqciH7HeTcTE0zUmp1UzM0juI6ONaNd
         /x6sTIs/2QyP14JTKesaY7AzYWzmW6Dg9o8Nb/jZ7oAVtSL82LAEKymuFTyaGrExb5dZ
         kcvlnoeFawLSjkW6h3PmF4SZ7oHJ8SqQGNf57pRnX1nQlOZdPsr+lNxi4kKkgxoCip8U
         uV2THYWuW2JfO7WAZe/II0fF7ljf/vWTnSTVQh9Nu1byvBovupmqArUmffcbm4eV0m8v
         KZuYS+xCfJlY1ve8w2G+nE+egKTDFyOOrUyCHtwiAAWMoqOnnO95xxnxhmE46JnIu3RY
         4REw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zZ+X5NwIT3Ilre3MBBFmMIR7GaB22k8MhpZuVDzBpfg=;
        b=hzLY5UCKFQE96QaHCzZACgtBPS0HKAWaSXTaRM4RhXWRv3Am/14fgfShT4jO3vocjL
         Le1rJ1OGjrOV/Woz9urYAGHUWmtvDgS4T4rGJBvH82dMl+wqIe7apEdSxP0rJaJdz0AE
         sp1sQKBjbMIT39BXXR0H2geLTYyzWYOitMTHqqIQLu9VjwfkmeThPsyVwFpxEeV49fl0
         CWU7uDlvBYzxGl5/Z+H9PTeq+zDnsGzqc5Lb/YWg9VuI+Fq9O/tvAtEe/OmL5Nsh00+S
         WXUMksTKmRzl+e2Svoyto1+T90Nya5mIfRZXh+pYpCDkp2D1h2iBG30T3p7vJ9lQTSm1
         j5DA==
X-Gm-Message-State: AOAM533k4NQogik8C33nXecJYVMgmsFTajIKD4GrnY8OxNnrBcHiGsWR
        u5+oGT/2ltJJl+CH1Y2QLJo=
X-Google-Smtp-Source: ABdhPJzXpBKnMk8RUBqHUQgMBr4hdwI+4c4C1MfdJdjMdh8OLbohG8kS5yhbNPL3aaJRQtENqg68RA==
X-Received: by 2002:a05:6a00:1589:b0:4fb:e7c:7c53 with SMTP id u9-20020a056a00158900b004fb0e7c7c53mr14654280pfk.78.1649347886338;
        Thu, 07 Apr 2022 09:11:26 -0700 (PDT)
Received: from [192.168.66.3] (p912131-ipoe.ipoe.ocn.ne.jp. [153.243.13.130])
        by smtp.gmail.com with ESMTPSA id b14-20020a056a000cce00b004fabc39519esm24090890pfv.5.2022.04.07.09.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 09:11:25 -0700 (PDT)
Message-ID: <f86a10e1-b5a7-5c59-8e53-cec65d97234b@gmail.com>
Date:   Fri, 8 Apr 2022 01:11:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ASoC: rt5682: Add jack kcontrol
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <20220407141316.5099-1-akihiko.odaki@gmail.com>
 <Yk7+jbQ0KBM0zVh9@sirena.org.uk>
 <96dae189-c0ff-4054-3d00-41c3b44c2cd6@gmail.com>
 <Yk8Ktyyt0veW4g+j@sirena.org.uk>
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <Yk8Ktyyt0veW4g+j@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/04/08 1:00, Mark Brown wrote:
> On Fri, Apr 08, 2022 at 12:46:04AM +0900, Akihiko Odaki wrote:
>> On 2022/04/08 0:09, Mark Brown wrote:
> 
>>> Why not use DAPM for the jack?  Note that normally the jack is part of
>>> the machine driver not the CODEC - there's no way the CODEC can know how
>>> it's been wired in on any given system.
> 
>> It seems it is an unsual case where the codec knows the source of the jack.
>> RT5682 has interrupts and registers for the jack; see e.g.
>> rt5682_button_detect in sound/soc/codecs/rt5682.c for details.
> 
> That bit is very common but there's still machine specific aspects - is
> the required hardware wired up, if it is wired up how exactly are things
> wired (separate microphone jack, headset jack, one of many jacks?).  A
> lot of the machine driver part of things is about labeling things so
> that it can be displayed in a way that's easy to connect to the physical
> system.  Generally the machine driver would define a jack and then
> connect the CODEC to it.

Whether the required hardware wired is told from the user of the codec 
via jack's type specified with snd_soc_card_jack_new(). The other 
details live in the codec.
