Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA364E3C77
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiCVKby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiCVKbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:31:52 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471425B3C3;
        Tue, 22 Mar 2022 03:30:24 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id 185so8907796vsq.8;
        Tue, 22 Mar 2022 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=B8UKuOImiP6xfcAZEZqeBZGlE4CORIzDO0dNP4mfjcw=;
        b=WsZ0iuA/kXkmThUhhJ5w+ssjWlDr/fphIBrW00ALaI9kJ9IIzU2TCRE/TJj9g3xr0P
         rAI8+VOO+Qi+bznbCvPK8UCJIB9BO/ZCS4y1wPvz63EjdRyMA2l6MHcpp6otT/rZBYL6
         FhsenVoIGfn0IDlTKszUqEpaS7qjMNceep08kQ/F99SY41W/6PWS/Pz9hTI4Hnhi7aFK
         kUCUfrFZ38CM5aJaU9aynFJH+7qiWoWg904w1lqqZvW3KIfoMkYkR+cRQOURly7qSRbX
         mLE2a8fNAiXpNoGsF5HU5StRbYGrGKNZYieX37H9eWn+j8guZDFWNsRzQjU7MsyexZGV
         b8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=B8UKuOImiP6xfcAZEZqeBZGlE4CORIzDO0dNP4mfjcw=;
        b=7kSKU0oAFMtIOLrnq0Qi2+9dHbJRt3Dg8aB5YZpLuxmQbA/CRCHEKq7ptRZ9tHjFFd
         ZhPO1HVAO81RvzOHLqoJMCjGqpBWdLPnAlwMeiJDjtBSomPVMn7joB9QtDZ5WBOEiKIh
         qB8SRZL2ySaxs/XVA0nzaqhZ2ZP8qxWPDOMVJEO+hfzp7On27xcq3LaAE29kzCcg72w7
         gSrzBXTN+L/NorFdxd3CBQwIqgRRmzgXrIOUne5QYO0Sv1/cKex0VlmSPhERZhLBGyQu
         FZahr8++Ef4CoQS7T2dLeuB5U+jg0ojcdokbb3O2Tnket96blp0IAwgIlRWG9O+S2HyB
         m6Bg==
X-Gm-Message-State: AOAM532hYMPEZUMQV124W99f635Cj2484nfgVt4TJmpXb++boF2iE8n7
        mHOfcvOQmMr5y+7K6qV5fvgy7SMzFc6nm3+FyxtnTbwPsSU=
X-Google-Smtp-Source: ABdhPJzDJlAwAisYVa1++sHII6r1VZyfXxBnhrDWbewfmGNNDLn1xWdpbKjaw0dfbszJNafkNj0Be7CyP2x4wxKG2GY=
X-Received: by 2002:a05:6102:284a:b0:31e:c455:5dee with SMTP id
 az10-20020a056102284a00b0031ec4555deemr8583316vsb.27.1647945023414; Tue, 22
 Mar 2022 03:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220217162710.33615-1-andrea.merello@gmail.com>
 <20220217162710.33615-14-andrea.merello@gmail.com> <20220219170645.565afed8@jic23-huawei>
In-Reply-To: <20220219170645.565afed8@jic23-huawei>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Tue, 22 Mar 2022 11:30:12 +0100
Message-ID: <CAN8YU5PvqJ3_wA7JnFRFT_53KftrqzaanELj5Xjbw0d8cnQ6tA@mail.gmail.com>
Subject: Re: [v3 13/13] docs: iio: add documentation for BNO055 driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > +IIO attributes for unavailable measurements (e.g. Euler angles when fusion
> > +mode is disabled) just read zero.
>
> Hmm. Should probably return -EBUSY as 0 could be a valid value.
>

While it seems reasonable,  that can be easily done while reading from
sysfs, but how do we handle this when reading from buffer?
Right now both sysfs and buffer read zero from unused chans, which it
is at least consistent..
