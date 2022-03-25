Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0294E784D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355883AbiCYPqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377124AbiCYPnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:43:07 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6311D4C7AF;
        Fri, 25 Mar 2022 08:38:02 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id z92so9663873ede.13;
        Fri, 25 Mar 2022 08:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V3nO6d/mIFndMoIv5fF65xBZWYCs2bp5IpMKAoTo1Bk=;
        b=49rv8QzOuUg3paKDnyhfd79NRDraOkmlnjj7tWMvnWdlKuwkmcSJICQEpcjgTMYmec
         GsrBQ3cEQBpjRgVPYbUUnmrXZocIirv3AwXhYo8gPr+3d9tSvH0nU/Ay+A6kt01A9oCB
         Nc+PV99WPQm31p0WLpJoJ7LVKqh97ASr/SeWOH1yXZWyQUV/4W1Z7iY5rLFi8a05Q35D
         nA89Y/mUtAQKyEVOqOrGOMtcd+ZZqDhc5zfDAJYlnnTCYW+qdL3vzNHBcEMz4uOOwhAi
         nf8vGVPGohpUtW56zbRTyryJUsRGumx+MgbK8sTncFxOnAw2XFqLgGS3XRhid0Ptk1cF
         5WTA==
X-Gm-Message-State: AOAM531cnKzFcJZO1Nq8CgRHi/xZ11HCGRuWmSuQadMGD4pEqcKYR/Zq
        OhgUMdDdkruKpZf06HaXE461dAG6mVg=
X-Google-Smtp-Source: ABdhPJw69lO06lZbj+mR+Dc2s5HgECM0tyKGFhqlueX/AVFEfWdUY7nxhpfEGm2IdcdvQwO0KKVQSw==
X-Received: by 2002:a05:6402:40d5:b0:419:496b:5ab0 with SMTP id z21-20020a05640240d500b00419496b5ab0mr13751750edb.284.1648222665503;
        Fri, 25 Mar 2022 08:37:45 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id bm24-20020a170906c05800b006d58518e55fsm2406059ejb.46.2022.03.25.08.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 08:37:44 -0700 (PDT)
Message-ID: <03999953-77c5-0272-7477-ab8a069b3671@kernel.org>
Date:   Fri, 25 Mar 2022 16:37:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] regulator: rt5759: Add support for Richtek RT5759
 DCDC converter
Content-Language: en-US
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1648170401-6351-1-git-send-email-u0084500@gmail.com>
 <1648170401-6351-3-git-send-email-u0084500@gmail.com>
 <d2b431f8-9197-4a42-4ee2-4e771e20e0aa@kernel.org>
 <CADiBU39RGQj1-+yK18mZf3MR78KACKqb2kAxkCFKGXKpJ6Nqxw@mail.gmail.com>
 <e4a15ceb-c013-96be-48d1-e65267400463@kernel.org>
 <CADiBU3-gwsh5v1NLUYr_ovXwpUxQqgR61f-Jpc3G-zHs_yV4uw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CADiBU3-gwsh5v1NLUYr_ovXwpUxQqgR61f-Jpc3G-zHs_yV4uw@mail.gmail.com>
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

On 25/03/2022 15:59, ChiYuan Huang wrote:
> Krzysztof Kozlowski <krzk@kernel.org> 於 2022年3月25日 週五 下午10:47寫道：
>>
>>>>> +
>>>>> +static const struct of_device_id __maybe_unused rt5759_device_table[] = {
>>>>
>>>> I don't think this can be __maybe_unused. It is always referenced via
>>>> of_match_table, isn't it?
>>>>
>>> I think it can declared as '__maybe_unused'.
>>> If 'of_device_id' is unused, then in probe stage,
>>> 'of_device_get_match_data' will return NULL.
>>
>> But your of_device_id cannot be unused. It is always referenced.
>>
> I'm not sure, but your assumption is based on 'CONFIG_OF', right?
> Only if 'CONFIG_OF' is not defined, then it'll be really unused.

Is it possible to build this driver without CONFIG_OF? Did you try it?

Best regards,
Krzysztof
