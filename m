Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE5A51B056
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378582AbiEDVWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiEDVWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:22:38 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA0251E47
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 14:18:59 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id m128so4561110ybm.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 14:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6bErpLDN6CEEoWSzxhVYEvy5hGMXbYXtcuwfFFGVAPk=;
        b=sWL0jayo/BfRe3n+jU/541fJTcBDKRz3K3MBqQOBfVFyUp3lXVtijyDPbGwHYO9VVN
         Y7UVxdogikdk6NI+5DxCaqQLBng9/sh7yXAG6TTlEgHVftOtxRnqs5FKRin60E6MUXE1
         0jBv8iPox4obg8v1FulX+HmQOlgvhMlC2KKM78UZLu0VIhybG3qNG6oDTXrIThDy7MHe
         NQLjlQKUEY+lWo1sjIrZyvYvn/yO55hj1PmOUXZU9ffk2LCYOFJhb6TQ9W4X8P4594+9
         //eI8vN7+IjAguBRByZZIdQQ6x+CVTCZkwDnQXPKEjeTn1C736aqZXckpAnFre9qwByV
         XTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6bErpLDN6CEEoWSzxhVYEvy5hGMXbYXtcuwfFFGVAPk=;
        b=IV8p7spUgX6z3Bh307BAbIomlU8fx3yQWqpSoO+biKKR2NuRL0XTiQoov8muBUXIER
         P0lirLXVHNlfi1p/uN+8pA/pp6bktBEu1rLWYd9hwAokujs69uC5uBA1f7oue5TYc1Nd
         3jDykachKW/z52z75ypz63dEHvmFcpHslM+SWhNpWbk4SoALtf0qTL4nZAtM+I7n8LrA
         zYia+j6AGCv97C5jbltgrD9xBHvHIY7uL4t4dseWnSqL+o+fD2mQEh91LCLG5PNMadkV
         bAL97Tssn/eWteWTwR5ED/93JhCEqDo5nLcNNf/Ce5BGD69LSGwh9E6AR2w+yR8STqr+
         46Fw==
X-Gm-Message-State: AOAM533aYXRqDCx6ehCNHQ2Cp2lUiszWZ+MbkGbyAhdHhicdJU8iBJNK
        UxLs2GAxvya+LDVPkGqxfiZLUhZJY+WuhkF0x0V0col6qQM=
X-Google-Smtp-Source: ABdhPJzz+s6AELg+oOJUfJgzIhMlw+qtR1aNwDxIJCIHUMQYEN1ETifkaKkBhr0GUTxTIHvNmBQAt9dhJ2lpCPMTVc8=
X-Received: by 2002:a25:bcc7:0:b0:648:d728:d39 with SMTP id
 l7-20020a25bcc7000000b00648d7280d39mr19531071ybm.514.1651699138505; Wed, 04
 May 2022 14:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220502164557.3cbb18ca@canb.auug.org.au> <CAHp75VddQMK7b-xbPy91rQ0QskXerhnY_sRiT0ZfGraRmKpL_Q@mail.gmail.com>
In-Reply-To: <CAHp75VddQMK7b-xbPy91rQ0QskXerhnY_sRiT0ZfGraRmKpL_Q@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 May 2022 23:18:47 +0200
Message-ID: <CACRpkdZnCjvjUSP=0M9dOxV6d5PGAP+yqa2P7F2T-Ksgkbmp5A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pinctrl tree with the gpio-intel tree
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Mon, May 2, 2022 at 5:43 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> Thanks for the fix. I think the best course of action is that Linus W.
> can pull the same branch that GPIO tree has into the pin control tree
> and resolve that, because the drivers touched are all pin control
> drivers while the core part of GPIO subsystem was updated.

Yup did this!

Yours,
Linus Walleij
