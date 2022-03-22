Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21A14E3EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiCVMpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiCVMpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:45:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C10213D7A;
        Tue, 22 Mar 2022 05:44:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g20so21507109edw.6;
        Tue, 22 Mar 2022 05:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r04CBJxm3DZpzDmEmr8rDbSFH5vCTJstsaZf1YbJGFM=;
        b=nwGZ5WxTpb2yWRV8tf9rDuUy46IwhQ+ThQKiIQcSEN8HMaJH7MJ59mI5PbDbvsm4dx
         2A2I1fzOLdCkjcrss3oS03RDg7HqRkS1PeAn/r+Gvsm4xPLoDiMMn3au1i5M616O1CKb
         SpsE4E5sfgOTej74ZKouKHi9qZaTdvANyJQY8/zsg3e1PdNDIxiUer+m3AyvTqeRmu1M
         L1XOYUc5E817os6OgtFtFKkFGm2dWTh4a91e8nuo1wSt9/tss/y7Sc4eBmfyuIFTUGS3
         SVRC62GAL2WyCBUisVbYX/Cx+vy24JC5w93af2lfeunJIHLchTCX5eJtZeKKrUKw6YRf
         sVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r04CBJxm3DZpzDmEmr8rDbSFH5vCTJstsaZf1YbJGFM=;
        b=zdNCHW74KXFZfZjeP2849An8cD2Z52y5Zq2JG8HM/EiZ26ATo+rkhX9wywr9YZTuiQ
         aMCTFD3Pw9bqGexRkXo2TNgP5XW7hTegL7gaPwIpiCBBXyVLOwKA/mziop3l+aRCRinR
         EQ3Mpi/GIzXQf1fRVw3i6WJFfr9AOgtekP++DiSHkNKW0pRsjMr3ZSTlbYN7DJIxkBos
         47Do2KpIojpRC9nrOMZFBLP/6U99A4l/gJRoe1Z5Px5MWzArUrZzPcLIaZe8JCS6QvA+
         54xRdgQCqjh/igmeB2xmDFggqYWQoTPJYkTye9d5YwG0zx5oec+NU7i8icaw4wZsQ2yM
         FoWw==
X-Gm-Message-State: AOAM530J48C7+6eEPmy1jnactAPDwveROhFS9EHS2yzYgCk1ouYT5wiT
        DVxtQ/FjejhY82OjtLqxyF7vYqp+ZwxACnHZOxjH91w=
X-Google-Smtp-Source: ABdhPJzPWmEDoDZa7136BbSor+VhTmmgqTOr7MrjtN5T5j8rQiaeyVriFOqWWM2koAdLDD7fr7N1qknh+wMGIeEYoVo=
X-Received: by 2002:a05:6402:1d51:b0:418:bd81:78b3 with SMTP id
 dz17-20020a0564021d5100b00418bd8178b3mr27560173edb.46.1647953046811; Tue, 22
 Mar 2022 05:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220322141029.1885af98@canb.auug.org.au> <Yjl4KsmOQWVfUui8@google.com>
In-Reply-To: <Yjl4KsmOQWVfUui8@google.com>
From:   Rob Herring <robherring2@gmail.com>
Date:   Tue, 22 Mar 2022 07:43:54 -0500
Message-ID: <CAL_Jsq+54TmvzTJ9iEJOWBjVd0dukZGSHN97Kqtfhpw_8f3kYQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the devicetree tree with the mfd tree
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Walle <michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 2:18 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 22 Mar 2022, Stephen Rothwell wrote:
>
> > Hi all,
> >
> > Today's linux-next merge of the devicetree tree got a conflict in:
> >
> >   Documentation/devicetree/bindings/mfd/syscon.yaml
> >
> > between commit:
> >
> >   844dd8fe02f2 ("dt-bindings: Add compatibles for undocumented trivial syscons")
> >
> > from the mfd tree and commit:
> >
> >   c1ff0c0f24d6 ("dt-bindings: mfd: syscon: add microchip,lan966x-cpu-syscon compatible")
> >
> > from the devicetree tree.
>
> Did you accidentally hoover this up Rob?

I'll drop it.

Rob
