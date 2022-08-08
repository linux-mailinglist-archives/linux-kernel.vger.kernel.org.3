Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C6658CF1D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244334AbiHHU2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243815AbiHHU2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:28:03 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857E11A824;
        Mon,  8 Aug 2022 13:28:02 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10edfa2d57dso11872536fac.0;
        Mon, 08 Aug 2022 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LZFfaWPD18Mwn/Qf0FVZj2x1xhwBuquEIxoxBMUtgQA=;
        b=kE0qc3AisgkyAVOsp0+1WD3dlNS4GeQRZ7j67HMm+hPcipeVb7jpkSQKROx9XIPzE+
         cDqDz67Ndri+iJTuRM7ShjG3zfASAYpmwv1hKFOyFH7ogOwW4fDLC3uTyEp/clOFUqyt
         L7EWk5GhOO/G9SOmxlvsj15iJzytGdYDtyMgaLDXJaYR4+d60YeAnaADYjo4391WH1TZ
         TkPh+QssbFJvu9qJBeNC6r72nR2E2dNBrBSXvHeRvCpvzxDPblTg5S+Dl9sFZSy5Tlyz
         fcU/4Zprem1uXevmQVApTrpMEc4K9/AIIDJ0nH2UCQ7o8e+x7Mo5uAyJ2m6j8dfYUzTQ
         xA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LZFfaWPD18Mwn/Qf0FVZj2x1xhwBuquEIxoxBMUtgQA=;
        b=k6HXqSpAIXi8ENCajDr4Hjt0fCqKiInlVk3zcbv3wtumEJ/CCNmkyw6cxQKGwavPG6
         FOZI2DMf+Jf9WmA+y3v8HvzrW5rdMSrSh600v44vXoAP89xUOKvTEPj92iyoS96gkhuq
         ly7X8j8qtNSCKIR5RkWOa5H52Kjj/VDyFpSXVtv70J7r3Ieqg2JGWJew4z2H33dT2dzq
         ZTZks8bNCF0wUtIYKZFabTlF+M4X3H6T2hyXqeUZZ6TL8IW9+kXdOMILP/FELtDlgvC6
         jpq9MvX2whE+dd60z1rBzu3Ab70krYTpAFqYt6qph1Scv1dnlriNQ/fx3kXKYd9rF6oo
         9DQA==
X-Gm-Message-State: ACgBeo0xCVSd2SqbBbq1AD9susMrhvL3tJ+8ADq+hVS/ShHFoHk/DbYb
        tS6MZQx46TlH/IK69CQSn7hoHpCv9IQEtGds5J8=
X-Google-Smtp-Source: AA6agR6ye6dw5us5WT0+i8bbYGiBw3rPYmeCiduhNj8+D7R0kKFXxfpvP6A/HaBoK/SMUCs/fyAulvTxgOOgk/NFJjU=
X-Received: by 2002:a05:6870:9193:b0:10d:130e:e57c with SMTP id
 b19-20020a056870919300b0010d130ee57cmr12444363oaf.286.1659990481767; Mon, 08
 Aug 2022 13:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220805103605.23096-1-yuji2.ishikawa@toshiba.co.jp>
In-Reply-To: <20220805103605.23096-1-yuji2.ishikawa@toshiba.co.jp>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 8 Aug 2022 23:27:34 +0300
Message-ID: <CAFCwf10PL+kO5YcaBTmA1N34tSF18NJ0GLJoJ0L2VG5GuV-6XQ@mail.gmail.com>
Subject: Re: FYI: misc: visconti: Toshiba Visconti DSP accelerator driver sample
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
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

On Fri, Aug 5, 2022 at 1:41 PM Yuji Ishikawa
<yuji2.ishikawa@toshiba.co.jp> wrote:
>
> Hello Odded
>
> This is a sample (wip) driver for a DSP found on Toshiba Visconti SoC.
> The DSP typically accepts some images, apply an algorithm on them and yields resulting one.
> Therefore (image-in, image-out), they say this driver should be classified to media driver category.
> However, it can handle various data format (wider than v4l2 officially supports)
> if userland provide firmware (=algorithm) for its own.
>
> Yes, this rough implementation is the first step only our staff could go.
> I'm not for sure whether we could carry out experiments earlier if we chose to use existing frameworks,
> instead of writing our own routine for handling DMA-BUFs and interrupts.
> I hope this post will help your case-study.
>
> Regards
>         Yuji Ishikawa
>
Thanks Yuji.

I've gone over the IOCTLs and they seem fairly straightforward. I
think that we will be able to accommodate at least part of them in the
common code of an accel subsystem.
Oded
