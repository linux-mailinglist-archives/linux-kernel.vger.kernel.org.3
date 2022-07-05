Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847F7567188
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiGEOvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGEOvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:51:11 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEA413E10;
        Tue,  5 Jul 2022 07:51:11 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id l24so11288089ion.13;
        Tue, 05 Jul 2022 07:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4pr9idqRA1hITkupO1aLjT1dL1RQ3YrTUVMjd+qhvbk=;
        b=n+nzCT8v6lUIkuTShVwTvgoItpDBz9PHXlN1JzvvCwlZapw9ZVknukX8bC6jVsTp4H
         JZvkmHzsSUxQT5ehQDIQMn/RsSIAAk5NvoS4YnAo092zzbMcoYuxVUQ/+Ak3oHzxKu3N
         UIuftk+rP90yPYWVO49reDqqIPktdJLZfNqhqRZ8bFzHVVvU0QB2siMAJ8wl349ZAulH
         LH0SZu7BUZpVSq68RTCAgDaqvpMvTuUCwA7iMYJ/4lIivG2OjroACwaksg5yEHVatSAG
         Q/NLgSjeItkMv/wVU7JAav4Gp7GLPuZciKXBUYClB8XyD+SQwFWW12s8DuVJGppJOZtC
         Ai6g==
X-Gm-Message-State: AJIora/i61bmDgFLWovC39plUbpSyWdybD4Q7o6f5SjUV+NnfAxpPwhP
        u2/WJWC2lvFb7eut1n3x+g==
X-Google-Smtp-Source: AGRyM1usxj6oworCSQ3my3IZbWYltLVQEQI3Tbb80lTn0GWANP6QD16VjKVUHzGUJq5sHQwNSOmlmQ==
X-Received: by 2002:a5d:914b:0:b0:672:6629:bfa2 with SMTP id y11-20020a5d914b000000b006726629bfa2mr18823204ioq.159.1657032670453;
        Tue, 05 Jul 2022 07:51:10 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o62-20020a022241000000b00339de279a5bsm14776485jao.126.2022.07.05.07.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:51:10 -0700 (PDT)
Received: (nullmailer pid 2089291 invoked by uid 1000);
        Tue, 05 Jul 2022 14:51:08 -0000
Date:   Tue, 5 Jul 2022 08:51:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] dt-bindings: hwinfo: group devices and add
 s5pv210-chipid
Message-ID: <20220705145108.GA2083998-robh@kernel.org>
References: <20220703183449.12917-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdUnH0oRQg3i1VorZOmNSKKXRP91BiQEgBaV5W5ig+YH2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUnH0oRQg3i1VorZOmNSKKXRP91BiQEgBaV5W5ig+YH2A@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 09:18:31AM +0200, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Sun, Jul 3, 2022 at 8:35 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > As suggested by Rob [1], I organized a bit bindings for SoC devices having
> > similar purpose - chip identification.

What's the base? It didn't apply for me.

> >
> > These sometimes are put under nvmem directory, although in that case the
> > purpose is usually broader than just chipid.
> 
> Thanks for your series!
> 
> >   dt-bindings: hwinfo: group Chip ID-like devices
> >   dt-bindings: hwinfo: samsung,s5pv210-chipid: add S5PV210 ChipID
> 
> So why not call it "chipid"?
> "hwinfo" sounds too generic to me; aren't all DT bindings hardware
> information?

I'm fine with hwinfo as the color of the shed. I don't think we should 
encode where the information comes from.

Rob
