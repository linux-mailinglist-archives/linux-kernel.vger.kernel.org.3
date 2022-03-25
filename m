Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DDD4E70F2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354380AbiCYKPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242241AbiCYKPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:15:33 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E455170F65
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:13:59 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id f38so13225141ybi.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dy70LknDltaydRvM2j7tC/JvGxcBI/BpC2sBDwW5Whw=;
        b=vfV/uWpmxibHreycGrmw/VMND9+KkaPPdtstXa9v0Lhs4/uFEuP6+60hce+nXKhVZQ
         IkjbY1N4uwnA0lPGauk0BUD4jE1D92H+fJYU2kBPDXQKnKLXuTvl0rYaoWUs4X53YkhI
         3jDH7/hdIpjzjsPXl68qO1535wFAqIcDszIyrPxZFMhwz7KvuByWeVo9YNAENrn2OS13
         WVs3Aut+SlxtwfwfdZ3RNzZVK18mgvhyeS00LLBjsJ3nRBsw0yoP/GyVChkO0WfA9p7Z
         OMJUzuhPlj+q9l/PFO+8dTuv35wpdxyVeGMOjp1sCU3kAe296BOI644tUnxvX3tuU+h5
         SGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dy70LknDltaydRvM2j7tC/JvGxcBI/BpC2sBDwW5Whw=;
        b=z9B5curOCxHsuwGvCD03iYfjsmjQTC5bo42lNE0M375ql88fS2HJJYyP3NooDSQPIP
         s8THyBg+VcFUsVwq0tWFYcl2D4RhbgTGUskajMER1s5/xh8joamPTZczeeY+d2naQnQv
         O+vxRhHmajI/TVXQfbJk3pWKUUVOXwZj+NNgcK9dtFIizTqnhqLa7PR6iKgcxQXyCG2Q
         lbKIKn5RNtyJdc0kRn6TzAEMhjTRz7nOpwdg00bR/12r/x1CezvHJAHNy0O+8JPo78zO
         qEEtgGuDzWsxtLz/cNu1dSz+WTQSnTmaaPyiR+9asejNumDhRkqkRzmNPvW56vr8Bifs
         2GQA==
X-Gm-Message-State: AOAM5334dclmt+psan7omiF258jsMkk0DvQ3ujwUFsfnbaGdMRAwgkGi
        mKs3tG0hgUmtW8UE63GXUI5FCVdnRrWM1tbK7Mep+Q==
X-Google-Smtp-Source: ABdhPJygOttWqHBybnGqCkLkJtMfcXn5Ipj6ZXybayWFtfoPxakdfslCt6yTUQ2pQ95Ht6z3qOf8tH6YVyW77KzwvyE=
X-Received: by 2002:a25:23c2:0:b0:633:b871:ce27 with SMTP id
 j185-20020a2523c2000000b00633b871ce27mr9312035ybj.644.1648203239081; Fri, 25
 Mar 2022 03:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220312044315.7994-1-michael@allwinnertech.com>
 <83edf9a1-1712-5388-a3fa-d685f1f581df@intel.com> <88e53cb9-791f-ee58-9be8-76ae9986e0e2@allwinnertech.com>
 <DM6PR04MB6575C3B87DFA920EDCD994CCFC0F9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <32b29790-eb5c-dac0-1f91-aede38220914@allwinnertech.com> <DM6PR04MB6575A4A2A687A876EA5C04B7FC119@DM6PR04MB6575.namprd04.prod.outlook.com>
 <312d724c-e43f-d766-49fb-9c5b10fe8b07@intel.com> <7ec0cf3e316a4ed9987962b4cbf01604@hyperstone.com>
 <a1230f11-a2dd-1959-5444-28c57d3babf6@intel.com> <CAPDyKFpnR12+nrbiB-Ps-C4vn-WeHneRGJioQ_0b2ikk2CBChw@mail.gmail.com>
 <CAPDyKFqnFVd=mvQMnydT569Y6YFg3zPkttQ=amdzmT_yqYQeTg@mail.gmail.com> <a39e9f71-7a9c-bf0e-50d0-d45de3c2e132@allwinnertech.com>
In-Reply-To: <a39e9f71-7a9c-bf0e-50d0-d45de3c2e132@allwinnertech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 25 Mar 2022 11:13:22 +0100
Message-ID: <CAPDyKFoVVrCNqJUztKnOqyJHhFYnH0H3PR1z02qVN7pchD6W0g@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
To:     Michael Wu <michael@allwinnertech.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>,
        Avri Altman <avri.altman@wdc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "porzio@gmail.com" <porzio@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        allwinner-opensource-support 
        <allwinner-opensource-support@allwinnertech.com>
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

On Fri, 25 Mar 2022 at 06:46, Michael Wu <michael@allwinnertech.com> wrote:
>
> On 24/03/2022 19:27, Ulf Hansson wrote:
> > On Thu, 17 Mar 2022 at 10:14, Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:
> >>
> >> On Wed, 16 Mar 2022 at 17:08, Adrian Hunter <adrian.hunter@intel.com> =
wrote:
> >>>
> >>> On 16.3.2022 16.46, Christian L=C3=B6hle wrote:
> >>>>> So we are not going to let the block layer know about SD cache?
> >>>>> Or is it a separate change?
> >>>>
> >>>> I have some code for this laying around, but as it requires reading,=
 parsing and writing Function Registers,
> >>>> in particular PEH, it's a lot of boilerplate code to get the functio=
nality, but I'll clean it up and send a patch in the coming weeks.
> >>>>
> >>>
> >>> We have the sd cache flush.  We would presumably just need to call bl=
k_queue_write_cache()
> >>> for the !mmc_card_mmc(card) case e.g.
> >>>
> >>>          if (mmc_has_reliable_write(card)) {
> >>>                  md->flags |=3D MMC_BLK_REL_WR;
> >>>                  enable_fua =3D true;
> >>>          }
> >>>
> >>>          if (mmc_cache_enabled(card->host))
> >>>                  enable_cache =3D true;
> >>>
> >>>          blk_queue_write_cache(md->queue.queue, enable_cache, enable_=
fua);
> >>
> >> To me, this seems like the most reasonable thing to do.
> >>
> >> However, I have to admit that it's not clear to me, if there was a
> >> good reason to why commit f4c5522b0a88 ("mmc: Reliable write
> >> support.") also added support for REQ_FLUSH (write back cache) and why
> >> not only REQ_FUA. I assumed this was wrong too, right?
> >>
>
> Hi Ulf,
>
> 1. I've found the reason. If we only enable REQ_FUA, there won't be any
> effect -- The block layer won't send any request with FUA flag to the
> driver.
> If we want REQ_FUA to take effect, we must enable REQ_FLUSH. But on the
> contrary, REQ_FLUSH does not rely on REQ_FUA.
> In the previous patch(commit f4c5522b0a88 ("mmc: Reliable write
> support.")), REQ_FLUSH was added to make REQ_FUA effective. I've done
> experiments to prove this.

Thanks for doing the research and for confirming.

Note that this is also pretty well documented in
Documentation/block/writeback_cache_control.rst.

>
> 2. Why block layer requires REQ_FLUSH to make REQ_FUA effective? I did
> not find the reason. Does anyone know about this? Thank you.

The REQ_FLUSH indicates that the storage device has a write back
cache, which also can be flushed in some device specific way.

The REQ_FUA (Force Unit Access), tells that the data can be written to
the storage device, in a way that when the I/O request is completed,
the data is fully written to the device (the data must not be left in
the write back cache). In other words, REQ_FUA doesn't make sense
unless REQ_FLUSH is supported too.

$subject patch should also conform to this pattern.

However, it's still questionable to me whether we want to support
REQ_FUA through the eMMC reliable write command - in case we also have
support for managing the eMMC cache separately. It looks to me that
the reason why we currently support REQ_FUA, is because back in the
days when there was only the eMMC reliable write command available, it
was simply the best we could do. But it was never really a good fit.

I am starting to think that we may consider dropping REQ_FUA, if we
have the option to manage the eMMC cache separately - no matter
whether the eMMC reliable write command is supported or not. In this
case, REQ_FLUSH is sufficient and also a better match to what we
really can support.

>
> >> When it comes to patches for stable kernels. mmc_cache_enabled() was
> >> introduced quite recently in v5.13, so for older kernels that call
> >> needs to be replaced with something else.
> >>
> >> In any case, the relevant commits that can be considered as needs to
> >> be fixed seems like these:
> >> commit f4c5522b0a88 ("mmc: Reliable write support.")
> >> commit 881d1c25f765 ("mmc: core: Add cache control for eMMC4.5 device"=
)
> >> commit 130206a615a9 ("mmc: core: Add support for cache ctrl for SD car=
ds")
> >>
> >> [...]
> >
> > Michael, are you planning to send a v2 for this? Or are there any
> > parts that are still unclear to you?
>
> Dear Ulf, Sorry for the delay. I was trying to figure out the SD cache
> stuff, so a few day was taken...

No problem, I have been busy too. :-)

Kind regards
Uffe
