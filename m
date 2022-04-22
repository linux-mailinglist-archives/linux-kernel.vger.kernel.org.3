Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C802350B7C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447681AbiDVNBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447679AbiDVNBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:01:42 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9295717D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:58:46 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f38so14343787ybi.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DfSV+SdlR8Sf7mp7AcKYrPQXZGND+P1rOaA8+1b1Lh4=;
        b=inUnrmIOKDkafweoPUVdpRlcYq+mTG280zrm62S3nx1Dl4mAFCGU01OckSH2xMEVSg
         PmwetmCGopIDTMITcr5viQ5GNZImjX6ssy9RC0QDkLIUVp2iHYJvjAWGwQg9x9FR2IIY
         wVAEtQoTRg+BiIXjVWpdEEPFrlMroiI4bKRVbri8MwNHAe2DJWHDE8Fj4tuRD6Yhpmbd
         MdTQfSI77b98nre81mgz1MHToTO3wcyiws7hpoXirlqPA4lD6pxmA8yUkAMlg1brW5AU
         X5SdxmDgdH9xNFfeJbpHJg+Pap5h8tg1mASytae70HAvd1jdUE8r56U+7UasYlJhfXjj
         vGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DfSV+SdlR8Sf7mp7AcKYrPQXZGND+P1rOaA8+1b1Lh4=;
        b=Prta/H6I6urthI2Bs+D1XCddpRiz1RPOzSAczlGiUoYpCmztgtRIcATl1GaEPxojvq
         Z7YpCITsXcjPMD3DjeqtwqDHNoO8V7+4RJvU49435YcJ+uDiRbSQ9tfZBxNkdP4mpDU3
         PiYP5IFk5rUdXDr6TWjIMXOrjRH+byq1TjqQyJUYdV3iHvzNCxIcdD1jy+E0E+wSrASL
         yey9Tp1lNdzZR4eP9HgTaFxJJz9ybqqk/xzM+LEVpBSVu8zSxegJ3zVPk8xADW1lcEOP
         JZnDryR6q4yXVCwpEmV8bPRBvf00i77zx1tToGFS4GEbdrWnggCYc2teXISejeb6cK8v
         ZRkQ==
X-Gm-Message-State: AOAM533ubU7LWhp/gDH86xljo2E1y5bGtajk5j8NPEBQ9qo8dl+IfEsc
        7HBqyF64FhCcgY7adFmcTg42sURm2FDMZ+QVzVQvVQ==
X-Google-Smtp-Source: ABdhPJznFkRmQLzcoL+Jzums+pKoRDC+nmrIZwzMiCGsmWqyGnLMbGvgkJtmhphRtJoiDiQN+J/FqJENPKq+H6KFeag=
X-Received: by 2002:a25:aa8f:0:b0:645:7d91:ba2b with SMTP id
 t15-20020a25aa8f000000b006457d91ba2bmr4394539ybi.332.1650632314312; Fri, 22
 Apr 2022 05:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220421015728.86912-1-nathan@nathanrossi.com>
 <87mtgfgx7d.wl-maz@kernel.org> <CA+aJhH026fR5p6-JBaoQikZwC1F-iLBQWrqAvagauKjQoOqykQ@mail.gmail.com>
 <87fsm6ahnh.wl-maz@kernel.org> <YmFJ4zKn/9MpjhOh@lunn.ch> <CA+aJhH1uRWrW1+WJiWoH7pge49gc=SvWQ1L+UpLk+Hin5eo4uQ@mail.gmail.com>
 <YmKdajB8ufVz5meG@lunn.ch>
In-Reply-To: <YmKdajB8ufVz5meG@lunn.ch>
From:   Nathan Rossi <nathan@nathanrossi.com>
Date:   Fri, 22 Apr 2022 22:58:23 +1000
Message-ID: <CA+aJhH27-TkorTqKVYBvHLz-8-0Pkbmjvx+aekb-24N75OAAKg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/armada-370-xp: Enable MSI affinity configuration
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 at 22:19, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > If you have a PCIe device that you can use with the 370 rd.
>
> Sorry, nothing on its bus.
>
> The only device i have which might make sense testing is a
> WRT1900ac. That has an Armada XP dual core. I could try building a UP
> kernel for it, but i guess you have tried that already with your
> machine in order to test a UP setup?

I have tested with SMP=n on a Armada 385 without any issues. So no
need to do that on the Armada XP.

There is still value in testing on the WRT1900ac device since so far I
have only tested on a Armada 385. The Armada XP does have
registers/etc. of the MPIC very similar to the 370, compared to the
385 having some significant differences. So if it is not too
problematic to test on (it appears to have its wifi attached via
PCIe?) please do.

Thanks,
Nathan

>
>         Andrew
