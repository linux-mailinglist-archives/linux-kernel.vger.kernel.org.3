Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3383F535DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350781AbiE0KEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350762AbiE0KEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:04:38 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C265106A69;
        Fri, 27 May 2022 03:04:37 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id x137so7097402ybg.5;
        Fri, 27 May 2022 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5JIYIoPQbAr8+N/6Btv1Jhwnhm7d6XglBceN1Qe6Sgg=;
        b=RyObOFEt9mrpw1GFgsf97COA3nU0+H88/3PXIdOj5Fnkf4HBbF7C68+ZciXfCILMYf
         b6hexwK6RaYMbIHqqjO0c2FbFFbMOB1/PhMDDu3kNUkWxnu/lFbJ+6VjEvCmENqwmwQP
         /9KEPyvyrWQW86Uto87PtYyVxtKsXIdSufp/YJMGGS0FihaaBkb1VSqLi3/K7INqaE61
         jPr4SprPehyy7tyc3El0xf+3pKgv9S1ZKQrs90IpPDE3QGq5finBWG0Z3uW3ds++wrSM
         ZaTO2rb2+Cftee2Z9rgG9aGsMThyRMADCLbHlgdD9VAiyboBOyaMdFNVvwM6flGW5H2s
         6Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JIYIoPQbAr8+N/6Btv1Jhwnhm7d6XglBceN1Qe6Sgg=;
        b=VI85LRBcUnR/4nd4Y8lArP16KybcdAmfaxFY3nZS3calFbHwmCl+GEXS0k+ga1cjAk
         hnVrosaRNI7QByPtLjkoHybxfSUgXUOOS4cHW7Eih4b1PuqnDQcs/R3YmIlw4vmqjONR
         6dykMJrQNWrtMkBntu/I1PLWMia7U9yiVAjHK2p/P0bSu4/RB/Zc2Jhrjwxgs5eB5K0D
         fHmYGTr/pW8O9l4RNwl23xy+x34aNk+IwWjR/7LAyl7hYOk801gfRyTY1il9S/57fUFl
         tMqTHZ3RWP5q5Cw0zj1fNWRHcGuq3jY/w5P3FWL5Sr+aQPy3ku3iIpaG1uqqQjuZn8tI
         fsrA==
X-Gm-Message-State: AOAM530mwyRK56vpfV/U4TCMFptx2wS/HvyKDF96x/g5Q0vuVxpgmKoN
        VZxarzh8VzkzLUVuUFqHKEK8V9ahn5sSX2eyhPeVrmlEP1A=
X-Google-Smtp-Source: ABdhPJxFjKSnq7Y/HKDtruNHyzaSMSuJHcQI86uptqpuKtH7XmDC5NFFJhzVoMiNXmnwoNMYzowzX9ss0zn0OqY420M=
X-Received: by 2002:a25:40b:0:b0:65b:5f11:2b5b with SMTP id
 11-20020a25040b000000b0065b5f112b5bmr1049941ybe.520.1653645876784; Fri, 27
 May 2022 03:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjGWp4+Ub_Ccaw+tx1NQrNcqyjUG5K30uPH3uYTF_wxfw@mail.gmail.com>
 <CAOuPNLgzBA2Sbn6vS4856LwYyBo67OYKQp49+xpwX=Bi+KpLZg@mail.gmail.com> <65f1b675-84ac-b5da-6075-2a9f0353ab37@quicinc.com>
In-Reply-To: <65f1b675-84ac-b5da-6075-2a9f0353ab37@quicinc.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 27 May 2022 15:34:25 +0530
Message-ID: <CAOuPNLh-NJ=GK63+iHFE-th9J8yfWZg_S3xmLgHGM_-nCFexvg@mail.gmail.com>
Subject: Re: Queries: Using ifdef CONFIG condition in dts files
To:     "T.Michael Turney" <quic_mturney@quicinc.com>
Cc:     open list <linux-kernel@vger.kernel.org>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, frowand.list@gmail.com,
        linux-mm <linux-mm@kvack.org>
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

Hi,

On Thu, 26 May 2022 at 19:53, T.Michael Turney <quic_mturney@quicinc.com> wrote:
>
> Kernel developers correct me where I go astray, but this seems like the
> CONFIG_XYZ value is not available in this file.  This would explain why
> the disable case works.
>
> At top of dtsi file are you #include <config.h> or whatever the correct
> syntax is to see the CONFIG values?

Thanks for your comments.
No, I could not find any specific config,h to be included to make the
CONFIG values visible to dts.

Thanks,
Pintu

>
> On 5/26/2022 1:46 AM, Pintu Agarwal wrote:
> > Hi,
> >
> > I have a generic question regarding conditional compilation options in
> > dts/dtsi files.
> > Our Kernel version is: 4.14
> > Let's say I have a Kernel config such as CONFIG_XYZ.
> > This driver uses a CMA reserved memory and its node is defined in a
> > mysoc.dtsi file.
> > Like:
> > #if defined(CONFIG_XYZ)
> > &reserved_mem {
> >          xyz_region: xyz_region {
> >                  compatible = "shared-dma-pool";
> >                  reusable;
> >                  size = <0x600000>;
> >          };
> > };
> > #endif
> >
> > The problem is as follows:
> > a) The same kernel/dts source is shared across 2 product versions.
> > b) In one product we need to enable this CONFIG_XYZ but in another
> > product we need to disable it.
> > c) When we disable the CONFIG we wanted this dts node also to be
> > disabled together.
> > d) When we add "#if defined(CONFIG_XYZ)" check in the dtsi file, it
> > works if the CONFIG is disabled, but it does not work if CONFIG is
> > enabled (node is not getting created).
> > e) This mysoc.dtsi file is getting included in many other dts files,
> > so we cannot add a compilation check in Makefile. We will end up
> > renaming many files just to protect this one change.
> >
> > Is there any other better way to handle this situation ?
> >
> > I see that in latest kernel we have a conditional compilation added like this:
> > #ifdef SOC_HAS_USB2_CH2
> > https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/renesas/salvator-common.dtsi#L1028
> >
> > But the same is not recognized by the device tree compiler when using
> > kernel CONFIG_ check.
> >
> > Is it the device-tree compiler issue which got fixed in the latest version ?
> > Or, is it because Kernel config cannot be shared with device-tree ?
> >
> > Please let us know if there is any other opinion.
> >
> >
> > Thank you.
> >
> > Regards,
> > Pintu
