Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70285514C89
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377144AbiD2OSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiD2OSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:18:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC79F2D1DA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:14:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e24so10958824wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sQ5hx/1I80/ATcVuz87Z3HOb4p0v8DYlIUMYGZsRBdE=;
        b=RACFG9W4y1wv3p+zbZFhkum5n/4ZTluBZlNOC2uPxE0Xd8towmfqbrb5IXc31ssgnk
         hURf46bg864bZzE1QN9WXiUNh5h5qHURE/BUTuebAHu41AG+agtJW+16DuDKpkdg+5P9
         IHnSq0JJUXKj5wyWzjqbgeLzgvTFsRjxugejt3SYhJdzL4FwaAILDCbFi+B21LFTArNu
         zgPqevjBAYbJ8mK2+0HO9u6sxmLQIwc8byjWNJQ4t/DOUK6+9xWH5DP1oEt+ExN21Geu
         0I0sqOVtVQJ9FNre7yDi9DHFX+TGygCjduVm+MHQOeAsfgSwS+wj7mEU1U0SyJleEd+8
         NbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sQ5hx/1I80/ATcVuz87Z3HOb4p0v8DYlIUMYGZsRBdE=;
        b=5jYeYmaJbPkkretzFN+yfEULQvf9sZcx71YYOb7b269bRM7o5XyXcmxIdsgSmRnpWG
         OfkUUXbQVyEdeuGFcc26RElhmgQBM/s2AzYYv0ohcooRjb3Qdp3nNj7ezpizl+dJBpEj
         FGiTCtGHQS7Dem+p0XTg+pXl5hClQ9kBNJOnKF6js3sydBMk5xGPUKBlLX1kDAVV5NuS
         ibAkKqdBzeO6K1FnZVarR3O35B2BPsnd+71rLgKIcTI6gWLxyMC5DBtVF/0P/nZpwC04
         tYUyq34ZziuZIKmjyzAXp6F6G2PpzGcKsAN6Sb8eVQd999WPvzdfkcmnUraLb6tV521e
         yxww==
X-Gm-Message-State: AOAM532JbB4eQ+vK8ucF6K1iTeGf9kiR8ts356vtPQ+DoFMUjNCORA5E
        TbF8Asf6o0UT4VS4HAS1ZwVVgPagGb4mXQ==
X-Google-Smtp-Source: ABdhPJzfaiRae6b81cpv7KrZwqL2m0bvOQN+hU568QRVAx+NHzEwcPmDaHwUvwnLn2Ga2HrNJxJ7BQ==
X-Received: by 2002:a5d:53c1:0:b0:20a:db5d:2590 with SMTP id a1-20020a5d53c1000000b0020adb5d2590mr20417157wrw.411.1651241684047;
        Fri, 29 Apr 2022 07:14:44 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id n2-20020a1ca402000000b003942429cd1esm917859wme.10.2022.04.29.07.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 07:14:43 -0700 (PDT)
Message-ID: <8eafa7d7-511d-bc05-ad1d-3542d17c073a@gmail.com>
Date:   Fri, 29 Apr 2022 16:14:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: mt7622: specify the number of DMA requests
Content-Language: en-US
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        ryder.lee@mediatek.com, daniel@makrotopia.org
References: <20220429084225.298213-1-rsalvaterra@gmail.com>
 <91d8eb87-adf0-da62-0c7b-dbf94442f535@gmail.com>
 <CALjTZvYdvGrfjTWaP=LjX0UGJPJVxuF9RtgbneDwu7KCnSdtJg@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CALjTZvYdvGrfjTWaP=LjX0UGJPJVxuF9RtgbneDwu7KCnSdtJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,

On 29/04/2022 15:05, Rui Salvaterra wrote:
> Hi, Matthias,
> 
> On Fri, 29 Apr 2022 at 12:57, Matthias Brugger <matthias.bgg@gmail.com> wrote:
>>
>> Applied, thanks!
> 
> Would this and the cache topology patch qualify as stable material?
> Intuitively, I'd say yes, but I'm not really sure.
> 

my understanding is that these fix some warning, but no real bug in the sense 
something does not work without them. So no I don't think they are stable material.

Regards,
Matthias
