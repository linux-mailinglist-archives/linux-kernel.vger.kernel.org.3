Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284FD58364E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 03:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiG1Bdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 21:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbiG1Bdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 21:33:36 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C3443314;
        Wed, 27 Jul 2022 18:33:35 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u17so442650lji.5;
        Wed, 27 Jul 2022 18:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxKqbswVZsLw8IW+LGNWP2UVTeG8mb8Td38Txe23DLc=;
        b=ioYCFu7ds8X+9fH4MQ8VhDkAHZyEVt8mHQC0yLhf8dL+SBXHv9B15r9Ygf6cpTMyxB
         hM82tnNs7fFafqFmzgUN7FDXYgxxMfSXJMO6mTVqOEUsrJxAhd2oS040F+lUM8NkBcr2
         f8+tZFJ2m2L8MwO7/8X3jij/D31dms6zW9Gq/6FzlI7mvXbLolH8ewPp+Ryny3qi/tNo
         ceBP6bOaV6kyBCyHh8iSoXv1Pa9rAWNJVlRA1AaJQnIYVLgTMWDMf2gf/ENL2lo9cLiA
         igqrZikLOIbvd8y2F7aDYIKDf5M33OJnVfv7eW8RzZ1v6On8o2I3UN8Gal/MLzCmWaYZ
         ob3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxKqbswVZsLw8IW+LGNWP2UVTeG8mb8Td38Txe23DLc=;
        b=xvA3RK6mkL5xLIz3tfD3XhaZYTW63BgynW9v7rHibSrGpmDGcOCUdTVIRBCAspS+V8
         ruJpMwVJQ/+yCL2jTKrKOHv8IsZRMg2v2N1g1CpJW26GItwbyMaHFN6Fnj0t36VDwSLf
         kwuOChDdtueNDABLt+M3vBq1NPQoXWjBx1rvVVBcz6We5YCIU9kZBzuW+w6PeOWp1YS0
         oFQXqSnKxTQLRgJE0WBIVpIAvAD/KB1I4L3foBJecJ74zEZLKgWZQsldCsjdbuAm25ei
         u2hRDDCLgjy3hW7mwLKciRfDP6pk7NSZh6NkyDgPFcrjIM+Kj851+PL8CQqc3qIo/czb
         gj2w==
X-Gm-Message-State: AJIora+5t3M3/vlIroVRydlAsrcVaeTL+j49gU7AVVOdGuyDy4yaBoYy
        BeU18/bFdpGDc7g5uV96K6YTU/yyh6BTn4OuLw==
X-Google-Smtp-Source: AGRyM1uFMam3hnsK/BpxjPm7jHKpt4PmxF9vD8g8fuWsdGwccicJMLYIAc2ZVMcm+WAVO53Ii/hxi//ZYyr43iuexS4=
X-Received: by 2002:a05:651c:1a1e:b0:25e:e19:b5da with SMTP id
 by30-20020a05651c1a1e00b0025e0e19b5damr4679868ljb.307.1658972013330; Wed, 27
 Jul 2022 18:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220727034454.31892-1-stanley.chu@mediatek.com>
 <20220727034454.31892-2-stanley.chu@mediatek.com> <b8ecd9ce-35b7-276d-b028-2d8a4a900945@acm.org>
In-Reply-To: <b8ecd9ce-35b7-276d-b028-2d8a4a900945@acm.org>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Thu, 28 Jul 2022 09:33:21 +0800
Message-ID: <CAGaU9a-=sdD2O0=Jv0J0DgLwzR8nqt7tfcKjLTPzobVRSxFPrQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] scsi: ufs: ufs-mediatek: Remove redundant header files
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>, alim.akhtar@samsung.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        peter.wang@mediatek.com, Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        alice.chao@mediatek.com, powen.kao@mediatek.com,
        mason.zhang@mediatek.com, qilin.tan@mediatek.com,
        lin.gui@mediatek.com, eddie.huang@mediatek.com,
        tun-yu.yu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On Thu, Jul 28, 2022 at 3:03 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 7/26/22 20:44, Stanley Chu wrote:
> > Remove redundant header files like
> > <linux/sched/clock.h>
> >
> > Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> > Change-Id: I7796a23a5fdc767a4d00475b399844ceeaded0a8
>
> Please leave out Change-Id tags from patches that are sent upstream.

Ooops, I forgot to clean them up in v2. Will fix it in the next version.

Thanks, Stanley
