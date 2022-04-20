Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD595087E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378393AbiDTMSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244556AbiDTMSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:18:05 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C25C167F4;
        Wed, 20 Apr 2022 05:15:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q12so1427733pgj.13;
        Wed, 20 Apr 2022 05:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YbcYiKXfCytla+BW4m2NKTI4lgOrUp85w6nmM+TEXIw=;
        b=Z0jvUNK8/qSRcR9etARXOLLU5B+2xz3X6wOCfHECJfGbT3gLbiJ13mZruISUgE3FMG
         JwxvK4kvsmkIPtHmrHtcE9mu71jkG+4eSi4adiwCm85XTdbGBL9aYTE7Y5Yks93NDP/v
         yT/pymRk/On1pQFIqvzpGNKrJKxfI6qjx0C17FVpL+7ErX2kvIY+khOUPGB4ZUAGio/r
         IqHpb2rNvHePX9QLSlM2eyDp0hh5f/KdrBysbGbI+SqwXqeXWb0HNyOuWhX3bIEiN4uG
         J0b2qj94ba21wttJ9LONUB/CB8/RDXgauhgjEU9FuTlo6ScO1ZjlJUbu+/U9w10Aq6z4
         /0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YbcYiKXfCytla+BW4m2NKTI4lgOrUp85w6nmM+TEXIw=;
        b=OBI4HNQSkFH+QSuwXq2+Ky8eiGDYBC7wcCad7ee2fOApAxblXQrzrtDW2mTnqJ/Xjg
         KM/tRPzhbQoNdvFlPx6cooDaMTSIACzYi10tZzUbYvti1kSD2A9v1pofyVKyQxYbOmlg
         BI3kr89vQiqt4mdAsUXNR9UeWFZ8dPUL6cSAhDKx69yf35SxgsaA1vvAKFoUqUgVdqC0
         yf2bY6wkGgN25ESpEI6FF4lHgd9Xp14e6HEGXqPsMv2eai7kYkRAzJFKpO1EB+Dsn0Kn
         lUUC1sJw+rs+YQgmFT4riSm2au9pPcyP55gxh20IWZIm0G7vQl0G+aeYTW65rgOdPWFQ
         A3OA==
X-Gm-Message-State: AOAM533oyB8QHVCT+WHgH3v5jVGn3fSPBN+v8Es/Tj+jfzv9RM8fxg19
        TqI8zjHmMfAI5byjC/AA2vXNn4fCBwbjnIdFTVv3iIGkbOWP
X-Google-Smtp-Source: ABdhPJyZ+PcwvhxxbxJOT+h82qW3FnSblF7avVFdG6+aRm4zvELC8w+IzdSN0zx7uwAcdfqzChII1d/w6xflu3Rxb6c=
X-Received: by 2002:a63:ce45:0:b0:399:1124:fbfe with SMTP id
 r5-20020a63ce45000000b003991124fbfemr19430118pgi.542.1650456918078; Wed, 20
 Apr 2022 05:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhUBjkVME8D5KsHvT=uddBsW_Bh6wr7qeXS=UpQD4LgPmHffQ@mail.gmail.com>
 <05433153-0424-ab66-1573-993d0490c5bc@opensource.wdc.com> <CAMhUBj=JsiHnnQzrqPKzA=Z2+589Ju_HE0cFKyon58Fk0waeAQ@mail.gmail.com>
 <3045fde1-2d5b-e731-ef18-6cf3f0987259@opensource.wdc.com> <CAMhUBjnG75XANF1E5KUyigKSmhxzvJytfapieC6_jpKdiFwzSg@mail.gmail.com>
 <e7bd823c-c387-00e7-3060-97f224df6da4@opensource.wdc.com>
In-Reply-To: <e7bd823c-c387-00e7-3060-97f224df6da4@opensource.wdc.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Wed, 20 Apr 2022 20:15:07 +0800
Message-ID: <CAMhUBjmz1rCDDps3guWBXyOREB6K-dZDg0xQ78FJ18WQvWtejA@mail.gmail.com>
Subject: Re: [BUG] ata: pata_marvell: Warning when probing the module
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 11:07 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 4/20/22 11:21, Zheyu Ma wrote:
> > On Wed, Apr 13, 2022 at 11:42 AM Damien Le Moal
> > <damien.lemoal@opensource.wdc.com> wrote:
> >>
> >> On 4/12/22 15:34, Zheyu Ma wrote:
> >>> On Mon, Apr 11, 2022 at 7:53 AM Damien Le Moal
> >>> <damien.lemoal@opensource.wdc.com> wrote:
> >>>>
> >>>> On 4/10/22 15:30, Zheyu Ma wrote:
> >>>>> Hello,
> >>>>>
> >>>>> I found a bug in the pata_marvell module.
> >>>>> When probing the driver, it seems to trigger the error path and
> >>>>> executes the function marvell_cable_detect(), but the
> >>>>> 'ap->ioaddr.bmdma_addr' is not initialized, which causes a warning.
> >>>>
> >>>> I do not have this hardware so I cannot debug this. Please debug it and
> >>>> send a patch. bmdma_addr is normally set in ata_pci_bmdma_init(), but some
> >>>> drivers set it manually in their probe functions. No idea about the
> >>>> marvell driver, I have not checked it.
> >>>
> >>> To be honest I don't have a good solution to this problem, because
> >>> other drivers don't have similar behavior. The marvell driver doesn't
> >>> even initialize 'bmdma_addr' before calling 'cable_detect'.
> >>
> >> Then this is the bug that needs to be fixed, no ?
> >>
> >>> So a simple idea I have is to check if 'bmdma_addr' is 0 before
> >>> reading it and if so return the error code ATA_CBL_NONE.
> >>
> >> And if indeed, even after it is initialized it is still 0, then yes, this
> >> change seems sensible.
> >
> > Sorry for the late reply, I found the root cause of this issue.
> > The marvell driver execute the ata_pci_bmdma_init() function, but the
> > driver just returned at the following code snippet.
> >
> > if (pci_resource_start(pdev, 4) == 0) {
> >       ata_bmdma_nodma(host, "BAR4 is zero");
> >       return;
> > }
> >
> > So the driver didn't initialize the 'bmdma_addr' but used it in the
> > cable_detect() function.
> > It seems that the problem is caused by the hardware, is this a bug
> > that we should fix?
>
> So it looks like your adapter is saying: I do not support DMA.
> In that case, having bmdma_addr as 0 should be expected and
> pata_marvel_cable_detect() should check the address before attempting an
> ioread8(). It is weird that the cable information is in that bar though...
>
> In any case, you should check the adapter specs to verify how the cable
> type can be detected. And if unknown when bmdma_addr is 0, then just
> return ATA_CBL_PATA_UNK.

Thank you very much for your detailed explanation, it helped me a lot :)

Zheyu Ma
