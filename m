Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B3948BCFD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348319AbiALCOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:14:17 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:35815 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiALCOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:14:16 -0500
Received: by mail-ot1-f45.google.com with SMTP id 60-20020a9d0142000000b0059103eb18d4so971825otu.2;
        Tue, 11 Jan 2022 18:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xDZwp1RpgUqiJWiQLnFoilI1CwJ7sriHv7jgndUrRv0=;
        b=6Jxy4Ijt+cMzYhPOifBQ4Ge2oSEu47IDukqHVyhsaxx9zhH8DJvS72typ1zY+eOsKS
         3b4HVHCB77wEkJHO9qNMRC5S1AAyp2zKACFYi8mTLTJ4HMaumGwVTEHOvo6rXoSEl2ha
         A1PoSX0X2aoAs+wK0O1+wgk3XJjHdYZI0u/LYJlsQfUNZalZsAonowk6We2l7AkNk5qL
         jFXqxKt+HoC+i1oSGjij+itr3hPw8OsEYfK3Ipgw05SHot2vufWpyYKX9KIkVP2D0MvA
         WqGiBPDQBLmmYojrirKB6qzAqT5qncMmc46AaFdB4KWrff+qmuCDqseUpk1ElTRmMmLO
         6UFg==
X-Gm-Message-State: AOAM531IeP7VpmkAw3h+BvLqCB7kuIiIIbTZD0l6BRIBMtLntMXSMTvK
        6fdROkLt/tPCwlJL9Hb8tYXnDiKxuw==
X-Google-Smtp-Source: ABdhPJxv4ceHLsRSRP8AEcZNyx95RQ9t7DxidsoXxomfARqy38EYFsg7POnSlUKhsDzeaeFwLb3bFQ==
X-Received: by 2002:a9d:60f:: with SMTP id 15mr5048995otn.266.1641953656131;
        Tue, 11 Jan 2022 18:14:16 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v4sm2263905oot.36.2022.01.11.18.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 18:14:15 -0800 (PST)
Received: (nullmailer pid 3933654 invoked by uid 1000);
        Wed, 12 Jan 2022 02:14:14 -0000
Date:   Tue, 11 Jan 2022 20:14:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: add Huawei
Message-ID: <Yd45dgW8Fgsmuzrm@robh.at.kernel.org>
References: <20220109132311.GA2827@standask-GA-A55M-S2HP>
 <20220110095543.00001ac0@Huawei.com>
 <20220110121307.GA1894@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110121307.GA1894@standask-GA-A55M-S2HP>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 01:13:07PM +0100, Stanislav Jakubek wrote:
> On Mon, Jan 10, 2022 at 09:55:43AM +0000, Jonathan Cameron wrote:
> > On Sun, 9 Jan 2022 14:23:11 +0100
> > Stanislav Jakubek <stano.jakubek@gmail.com> wrote:
> > 
> > > Add vendor prefix for Huawei (https://www.huawei.com/en/)
> > 
> > Patch description should say why...  Is there an existing binding
> > using a huawei vendor prefix?
> 
> Not sure about bindings, but there are device trees using the huawei 
> vendor prefix. I'm aware of at least these two:
> /arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
> /arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts
> 
> Similar situation with the other vendor prefix patches I've sent yesterday.
> 
> Should I send a v2 with an updated patch description for this and
> the other patches?

Yes.

Rob
