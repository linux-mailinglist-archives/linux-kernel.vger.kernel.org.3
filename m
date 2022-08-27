Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862C85A379A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 14:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiH0MYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 08:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiH0MYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 08:24:37 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1A93B966
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 05:24:36 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id w28so3111903qtc.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 05:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=9nup9V/tgn3MtcA8wXBcTGVLRmFgbH3BHlvUTXQNwec=;
        b=g2/aj1McEKHouYJxXOrcrZQUx8ROU3gZW2px0Ol4vxoJvJ+UjN3LVKnU8ziDejbeD0
         yVtqADuyW7n/zIQ5UtNbA6OkJhkgc+ajusLBfCPAF63PttFDRFZ1Yhm2POO9SiEQuWgz
         PzM7hOONtAED5VdtTXV4LYecxQDcDtt09EJYU6tNjXNb0UDAasnAdmFBCVxL8n/CEvn+
         ZNsyyBXH3rW6Bjj28lsa1n1pR/EdBtSjhbn5Mu2zsJ9o9tkUIlXRdLgdyk6GwHNkmVKI
         txtlCjL+B/F2rqaiWeY8IhtSIVb/MFTslRVmyDw6cSs1qn3wm5rykG3AuKzHZG+DZ58k
         XLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=9nup9V/tgn3MtcA8wXBcTGVLRmFgbH3BHlvUTXQNwec=;
        b=AJzgzhjcoceoVNJI+IJQ0LEkZwuk+/fn5++zzOXUYfrX4/xThIe1DpmGSGmm6aInUn
         pRxr/i2k0Ri2+LrQhrITs1mJQj/eP1/DLgBwntAYs2USc6J8iMU0jD7JtpUOUoZfptwk
         MEvBSoNR+a8KwPrY9+LQduCmjJ8Ovx/wOZvWh8ike6GnVszmO2u4mU8cQzZkR/C/7zkR
         kkrIWAone3FR6rPoNDVC2DtLqkw11pXf4jnqBucDwXPwuf1r/5mgdiXG7jeR6BAh38OC
         TyfCNxutOJUryejLT6NgpYSMMKDz02JzLcz028LRIOAfqVwbHCUKWJg070g5bABPeBsi
         wIkw==
X-Gm-Message-State: ACgBeo3uWH2SrWOuyJ8sor4qKAtoyQzIno8bRoYDV1D3bYMLYnJBtDBt
        sEFNzFVHHhForuEZCwy8jQqBcI3Nqe8Gi3MONqWP3A==
X-Google-Smtp-Source: AA6agR4OlmAJ0z9M+WZyW+t/gAyhiNlneq+OQ9F5I2vSPGPmrGOgewgtRjyXI/xtQhYQF9Rinen+PQO1QezU9dl+OSU=
X-Received: by 2002:a05:622a:206:b0:344:a554:e555 with SMTP id
 b6-20020a05622a020600b00344a554e555mr3304002qtx.187.1661603075582; Sat, 27
 Aug 2022 05:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1650539846.git.robin.murphy@arm.com> <20220421141300.GC20492@lst.de>
 <665d2b46-c9e2-2543-cad5-9adf022e4bcb@arm.com>
In-Reply-To: <665d2b46-c9e2-2543-cad5-9adf022e4bcb@arm.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Sat, 27 Aug 2022 20:24:24 +0800
Message-ID: <CAMSo37XN3PC22JK4ot-B8gUxWOhK+UD-73Zb8LqvYpgPL1Bj6g@mail.gmail.com>
Subject: Re: [PATCH 0/3] More ARM DMA ops cleanup
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        m.szyprowski@samsung.com, arnd@kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Bajjuri, Praneeth" <praneeth@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Robin, Christoph

With the changes landed in the mainline kernel,
one problem is exposed with our out of tree pvr module.
Like the source here[1], arm_dma_ops.sync_single_for_cpu is called in
the format like the following:
    arm_dma_ops.sync_single_for_cpu(NULL, pStart, pEnd - pStart,
DMA_FROM_DEVICE);

Not sure if you could give some suggestions on what I should do next
to make the pvr module work again.

Thanks in advance!

[1]: https://android-git.linaro.org/kernel/omap-modules.git/tree/pvr/servic=
es4/srvkm/env/linux/osfunc.c?h=3Dandroid-mainline#n4615

Thanks,
Yongqin Liu

On Thu, 21 Apr 2022 at 22:35, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-04-21 15:13, Christoph Hellwig wrote:
> > On Thu, Apr 21, 2022 at 12:36:56PM +0100, Robin Murphy wrote:
> >> Hi all,
> >>
> >> Thanks to Christoph's latest series, I'm reminded that, if we're going
> >> to give the ARM DMA ops some cleanup this cycle, it's as good a time a=
s
> >> any to dust off these old patches and add them on top as well. I've
> >> based these on the arm-dma-direct branch which I assume matches the
> >> patches posted at [1].
> >
> > All these do look sensible to me.  But weren't you working on replacing
> > the ARM iommu dma_ops with dma-=D1=96ommu anyway?
>
> Yes, that's somewhat entangled with the IOMMU bus ops stuff, so I'll
> probably get to the point of having to revisit it in a couple of months
> or so. These patches are off the bottom of that stack from my first
> attempt, where the aim was to make the current ops the same shape first
> so that the switch is then easier to reason about (particularly in terms
> of sounding out any issues with the hooking up of dev->dma_coherent,
> although your series will now be taking most of the load off there).
>
> Cheers,
> Robin.



--=20
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
