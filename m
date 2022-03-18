Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1181F4DD4AB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 07:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiCRGU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 02:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiCRGUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 02:20:21 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9145141D86;
        Thu, 17 Mar 2022 23:19:02 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id kd12so5881882qvb.1;
        Thu, 17 Mar 2022 23:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdtS4i3yY9UNNOjJROv83jggfwRN/yRDkWJuxc/obNE=;
        b=VK1XyM1461bgnDLYwq5WW39C4DA1YJKtE4R7hEKsgDcY2KpARw6EAR/kIwCsD+6cpz
         mB017TbaQqs+AOWXXXTawLEhwdOTRFIabU80XGkvukwlRwIavxYLNkusuiuYgvrAmm1I
         PerPiFbgrQGXXwAmQzj/7tIXZf1Ytj9tQ1Yr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdtS4i3yY9UNNOjJROv83jggfwRN/yRDkWJuxc/obNE=;
        b=BI5p+ekYIBCl/MDKel9OQDEKxar3Q30usR71gZ6bpom5EnpJsXbVcRk1PaNBh3/xZx
         ETPVH/wFYCHjmfrQbhOZ/DtMbAq9g4GuLx1QKfWbCVaipSMhCWs9oswVp9itnYY+cfQV
         +R0gDo+cqzYE831AhTFyQG078JKSdoFa/ctF1tCseCkfNAotWLzDmL005qad65HU2MsG
         /qg9OBeDwSKe9Tzaf80uahi6OBjcgSCYTCFQFrvHxrZ5ebvzjluVd+ut5T2cIm7mD3w7
         zQns0RVGxcyUHC7aX3Jg3g/znEbcJwplLUaFW37P4HIPxVt7MdK7NgAUJhwfBnVAODVc
         mh7w==
X-Gm-Message-State: AOAM533DMa1/vgMkwjlyAOeIeutlE01eagOPwdV/Ew1pPjBE4JiiIJHu
        swU2pfNhYZb95kUPqe2gdUE1F0sEKrvZyenXMXo/Ve4pbt3U/g==
X-Google-Smtp-Source: ABdhPJxDDiTwL1J4WiCgUpWFC5w+o/LTsTpo9wXxAlaNierkjtHTP73dvxn7PsqnCUm9JvQztmVV+DKZs9+5Da/fAHM=
X-Received: by 2002:ad4:5fc5:0:b0:435:4420:d056 with SMTP id
 jq5-20020ad45fc5000000b004354420d056mr6090637qvb.130.1647584342048; Thu, 17
 Mar 2022 23:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
 <20220317191527.96237-4-singh.kuldeep87k@gmail.com> <87h77wxslh.wl-maz@kernel.org>
 <20220317211024.GA99538@9a2d8922b8f1> <87fsngxnff.wl-maz@kernel.org>
In-Reply-To: <87fsngxnff.wl-maz@kernel.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 18 Mar 2022 06:18:50 +0000
Message-ID: <CACPK8Xdv4bG=Haz5oe+gHotQ_B7=bMbZE3fNnHs-Ezy7Yje6Jg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: aspeed: Remove arch timer clocks property
To:     Marc Zyngier <maz@kernel.org>
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022 at 21:46, Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 17 Mar 2022 21:10:24 +0000,
> Kuldeep Singh <singh.kuldeep87k@gmail.com> wrote:

> > >
> > > >
> > > > Moreover, clocks also matches incorrectly with the regex pattern.
> > > > Remove this entry altogether to fix it.
> > > > 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >
> > > NAK. That's not a reason to randomly butcher things.
> >
> > I hope I explained my reasons above.
>
> My position on this sort of change remains. Blindly changing existing
> DTs based on a warning provided by a tool that totally ignores the
> reality of what is out there is not acceptable.

Thanks Marc for stating this. I share this view; we shouldn't go
around deleting parts of device trees for the sake of the bindings.
It's been happening across the tree, and I think it's to the detriment
of the supported hardware.

In the case of this particular change: I suspect this property was
there for early bringup, before the firmware was in place to configure
CNTFRQ. Looking back in time we had:

 clock-frequency = <25000000>;
 arm,cpu-registers-not-fw-configured;

I'm not sure why that changed from clock-frequency to clocks when the
device tree was mainlined.

That was bringup. These days, the vendor u-boot programs CNTFRQ with a
value for the system. This code is also in mainline u-boot, so as long
as you're running one of those firmwares the standard method will
work.

The qemu model also sets CNTFRQ, so loading the kernel without going
through u-boot will be fine there too.

Given that, I think we can go ahead with removing the property in this case.

Reviewed-by: Joel Stanley <joel@jms.id.au>

I'll take the patch through my aspeed tree.

Cheers,

Joel
