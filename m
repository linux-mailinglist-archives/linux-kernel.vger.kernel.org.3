Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A8A4BDC94
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380086AbiBUQTc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Feb 2022 11:19:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377666AbiBUQTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:19:31 -0500
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296F719C3E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:19:08 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id j12so35407381ybh.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:19:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6TJNFXXNBdkkkYS+97aXPvHCApsS0XC61WEFMoSbFNo=;
        b=L7CIKoBNdmf6KA2Kqi54zCPqaSbBRxadieUlATe+FZbv9mm2Xcl2J6M+xfnUKYHFEA
         xh5gOJFnJuFV5oZCb4BqRNOEJrcFoGcMg4Js9inn6Cu03lXO8KAyoQ04IcF3fEe3/qT9
         TMJZHc0O/iK77qyl81GHG45bOTuhcn5K6q4qxSeT4Q+sznFbYV9hq5YdqHGOgSgNlwLx
         IUJwQZN3yqeIxX5l3Rzr+ISrMxLcT++42Rs4tZp3CaEd6bPAH3v9/4nEYcvWh+IYhuAq
         TNvwkHsinBLLlXqlIr1FkzUli40kS8bKl6HkFmDGiZVz7UhlLnxDE2pI2zjmgw/8AjhI
         Wyxg==
X-Gm-Message-State: AOAM5324dHZr4uACCXzYcEtGyqGQJMGAlG/y4QoZHrRzLJuzw5/ZHzl5
        rRiSO/xA9pnutPOK8YdFQoj9iPsj/jggzVDm1K93iobs
X-Google-Smtp-Source: ABdhPJy8BsNybFiNZERDqHFpQTrdJlVrChlefSKmtPCXaWQ9DyItP2y8mjFvAF21KztOU1T59eCuas4HkpT6frImAk0=
X-Received: by 2002:a25:7d81:0:b0:624:43b7:ed70 with SMTP id
 y123-20020a257d81000000b0062443b7ed70mr14311810ybc.365.1645460347450; Mon, 21
 Feb 2022 08:19:07 -0800 (PST)
MIME-Version: 1.0
References: <CAGsy+6s36Vf+n9cMbis2a=A4=dUNvsbda7K7rszHikq_HGOAtA@mail.gmail.com>
In-Reply-To: <CAGsy+6s36Vf+n9cMbis2a=A4=dUNvsbda7K7rszHikq_HGOAtA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Feb 2022 17:18:51 +0100
Message-ID: <CAJZ5v0iNLXVAR8fG-gjnRP4BSwReL1sZ9XiLHvO+YVKFJFjGOQ@mail.gmail.com>
Subject: Re: Error when compiling kernel module - Re: More power management
 updates for v5.17-rc1
To:     eh kernel <ehkernel@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 1:15 PM eh kernel <ehkernel@gmail.com> wrote:
>
> Hi Rafael,
>
> I now get an error when compiling the kernel module (out-of-tree) with the new PM macros.
>
> /home/ubuntu/pressure/bmp280-core.c:1163:28: error: expected ‘)’ before ‘(’ token
>  1163 |      bmp280_runtime_resume, NULL);

Which of the macros has triggered this error?

>       |                            ^
>       |                            )
> /home/ubuntu/pressure/bmp280-core.c:1149:12: warning: ‘bmp280_runtime_resume’ defined but not used [-Wunused-function]
>  1149 | static int bmp280_runtime_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~
> /home/ubuntu/pressure/bmp280-core.c:1141:12: warning: ‘bmp280_runtime_suspend’ defined but not used [-Wunused-function]
>  1141 | static int bmp280_runtime_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~
>
> When I revert to the old file without the new PM macros it works just fine. Do I need to take some extra parameters into account now with the new format when compiling?
>
