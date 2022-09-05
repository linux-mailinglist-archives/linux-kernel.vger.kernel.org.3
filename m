Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730635AD587
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbiIEOwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbiIEOwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:52:20 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9F64E631
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:52:19 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1279948d93dso2114121fac.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XrNDuvqnz3x270QOXuQAy33WOfsjqmapFJE52YTqUpg=;
        b=oi0qo425zBcquVHa/oI5gkLbXELi1BsH6dzR42ve7xZRJTU1mlRXz3CKccQmvvhzNC
         8kYxj/xNIIOdUVQx7HlbAEDNwuodLPeQULYjSWMnW8GcgTD7kvsOQ/DhKSuRULyU+cxf
         QqFD9A+E4DNWLECHniDiDXPE/m/QpAdFlsnmmQ+pYGPqqaNx6WMSIrC3jLPNjGcvSpaH
         R+Kg01Mf58/k3Yzunzcex5+ojNpgkh/AhprFkscuFf4p4BRsHSz5F3vdvE6npCh0ylf8
         TdIQZyV9mTtkkH1I22X19SJYxbW+2Rynm4IATdRL8P7+IEd4+P2UqxJhY+0ieArjYcRr
         hlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XrNDuvqnz3x270QOXuQAy33WOfsjqmapFJE52YTqUpg=;
        b=bAVWojKZRlctey8QnMCb2MKZRDwoc6kTiSxZ0+0mkPpmfzJNabnvYz0xoWSlQXVen7
         mTbwRYEQCQK1k/+upl+KrOQFBj4il/wGlx/UmwIhtxeESReouNVyfZoIHbPJ0a1XxdjU
         BPILiyZ4k5q48i/0LE3oGAWV4+vgxHPYUcogNFIOG1DMVvW7tFLeoV8S32cOmFbxRW4i
         cRXHRg6crgyyYPzoUSbEND7quYSgNdmao03Q0Cp2J62V89qKxE5+SMR0PdXoiI0zcatu
         yv7XFPK+kK3YoGs5WGdgoRlfz5Iqif5s0imbXsJdB1IrfLbXkfdiI8obt6Is9zdeDh6a
         XdpA==
X-Gm-Message-State: ACgBeo0qTY6eKsBeH04R5KnJ8dtXkzX0vExOE6o7d3gAF1O46U/vuR+7
        2ycjUjV/aBlWFnaZyP27rQt93DCDJJYjUTm+FIylbA==
X-Google-Smtp-Source: AA6agR5XQUV2VFxWcuM62kuNaafeXbxhNazlckf1d5VBFFbyKHMUNJCqXIM0PYh7ggmBLyvsCEc5yw47m9o8L3gW7jc=
X-Received: by 2002:a05:6871:725:b0:127:96e8:21c with SMTP id
 f37-20020a056871072500b0012796e8021cmr1039779oap.104.1662389538822; Mon, 05
 Sep 2022 07:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220901163636.3930634-1-etienne.carriere@linaro.org> <20220905085929.38c737fc@windsurf>
In-Reply-To: <20220905085929.38c737fc@windsurf>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Mon, 5 Sep 2022 16:52:08 +0200
Message-ID: <CAN5uoS8v0Hq0U4-4LUvrcQRATTpTa7unH8_h_xTX4Rdxn12tRQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-binding: gpio: publish binding IDs under dual license
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, Stephen Warren <swarren@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, 5 Sept 2022 at 08:59, Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
>
> On Thu,  1 Sep 2022 18:36:36 +0200
> Etienne Carriere <etienne.carriere@linaro.org> wrote:
>
> > Changes gpio.h DT binding header file to be published under GPLv2 or
> > BSD-3-Clause license terms. This change allows these GPIO generic
>
> You're actually changing to BSD-2-Clause. Your v1 changed to
> BSD-3-Clause, but following feedback, you change the SPDX code to
> BSD-2-Clause but forgot to update the commit log.

Right, my apologies.
I'll fix in v3.

Br,
etienne

>
> Best regards,
>
> Thomas
> --
> Thomas Petazzoni, co-owner and CEO, Bootlin
> Embedded Linux and Kernel engineering and training
> https://bootlin.com
