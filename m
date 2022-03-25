Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6133A4E7DB3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiCYTZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCYTZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:25:52 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DA33E06C6;
        Fri, 25 Mar 2022 11:57:45 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id t21so4252240oie.11;
        Fri, 25 Mar 2022 11:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ayOYjTZU6HmufvMH+uKYpu/1dCIaQ5A33lYHz9+DMm4=;
        b=X+FNOez4egUGi+RaEDC5o5ifCxnPeAfq9cKoQQXRcF/X2s6qCcDabfodEZqtqP/0od
         lcKDpg5zdyKA0VfQxajowo2N9HrIRQBF1bBCnHD2DkeibXkuGPEgOt/UZGMsOcCk0gYL
         Prm8lhECgBMpAltiHAWJIMm2YO91CQDkFYQssH6ntOXpAWz4JChc3Gb4CrUDQmh5uvsS
         P3yCPBbSUoWo5SXyWtNxbVV/B8OxseinYxnd6EcJk/8egWfeCX2KLAKfdZXFur5oZWIf
         ol1ErG6sBtdoxsbv6c1zkZOtjZNrrYbybeS6kSTlU0snIT+/4aXoexhXhIMNsG1rQt7p
         SV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ayOYjTZU6HmufvMH+uKYpu/1dCIaQ5A33lYHz9+DMm4=;
        b=GlIXq6Gb1BKDxXo2c8Pwq6YifU1LlF0FfjVvYUes8NAdJUzzNgHPScZrjtwL2rZPLZ
         w8g5ibhSPXl2D+lWrX1XU3Ip8DQM6h3hE4k9D36tKDBJzjYn3JDyBEqpYtOMFFclLrIw
         mY8fUJR2Eyie1YIWCnb7gMt3bFlzU+65U9z8afQ3n6epCraCHBhKQgLkrj6jeuKBA90Y
         /EKe5qPIGQYd8i8rPfw+EEEnrSykhy2BiezzqU7YminyZevn8HX4xZr8jE5G+CtkDtPQ
         A954rnE8i6NMWHwZ3PJF0D55XRBFSphOlWR5oaX3DbTVA4BNEWKyJI7LRK/4p9oqB61g
         wrmg==
X-Gm-Message-State: AOAM533whwhD8LJdQAT6YmxpwMjY1X+EvLsHVQvOIAg8Na1nO4VyZkPR
        bzoVcaliqR26dIdjgreoz9ydjxRc+OQ=
X-Google-Smtp-Source: ABdhPJw3p6wgf3puKfvwDvOdglHa/WYaO+uhShtAN0fwz7BRG4eEy82IN781iCaO/bIGRTwjoMTc+w==
X-Received: by 2002:a17:90b:33cd:b0:1c6:5db5:5ff9 with SMTP id lk13-20020a17090b33cd00b001c65db55ff9mr14110308pjb.197.1648229912288;
        Fri, 25 Mar 2022 10:38:32 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id pi2-20020a17090b1e4200b001c7b15928e0sm6737763pjb.23.2022.03.25.10.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:38:32 -0700 (PDT)
Date:   Fri, 25 Mar 2022 23:08:26 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ARM: dts: spear13xx: Update SPI dma properties
Message-ID: <20220325173826.GA70042@9a2d8922b8f1>
References: <20220323175920.93155-1-singh.kuldeep87k@gmail.com>
 <20220324023904.h2qfxzxlznggbsyr@vireshk-i7>
 <20220324062547.GA15504@9a2d8922b8f1>
 <20220325015849.sazvlevnvdqj5z42@vireshk-i7>
 <CAK8P3a0Q8eOTeRmd5-G8rNCKAcH+4HReCsOAGKd4Vq30C9TaEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0Q8eOTeRmd5-G8rNCKAcH+4HReCsOAGKd4Vq30C9TaEA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 10:11:41AM +0100, Arnd Bergmann wrote:
> On Fri, Mar 25, 2022 at 2:58 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 24-03-22, 11:55, Kuldeep Singh wrote:
> > > Fixed order of values is important in case of properties like
> > > compatibles etc. In case of dma-names, yes order shouldn't matter here.
> > >
> > > This patch is more of appeasing dtbs_check warning rather than fixing
> > > something.
> >
> > Exactly my point. We have seen similar type of issues with other tools, like
> > coccinelle, earlier and such patches were rejected as the kernel was just fine
> > and tooling needs to be fixed.
> >
> > > It's safe to go with this patch.
> > > I am not sure if there's a provision to exclude dma-names from fix
> > > ordering checks. Rob can help here in providing better insights.
> 
> I think it's a question of the scale of the warnings: my understanding is that
> there are only a handful of dts files that trigger the warning at all, and it
> would be rather hard to change the tooling around this. Since the proposed
> dts change is clearly harmless, I don't mind applying it.
> 
> Kuldeep, you have probably looked at all dts files in the kernel, can you
> say how many of them are affected by the dma property reordering?

I have checked spi-pl022.yaml as of now and this was the only one which
was affected with dma ordering.

For all dts files, I can definitely give a try and will come up with
some numbers. Please note, there are still bindings left to be converted
to yaml format, so won't be able to catch those cases.

- Kuldeep
