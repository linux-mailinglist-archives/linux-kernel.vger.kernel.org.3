Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0114E95A6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241910AbiC1Lrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242731AbiC1Lns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:43:48 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575202CE24
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:39:12 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z12so10401538lfu.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pzx8qqpSnwG1wLkI5RwMbGMXLwJB5p31g2jEsQjzdxU=;
        b=IUznpuz3FW2immwzpFLIxX9Jt0ZuTSePyhtAzx/Nv1ONawtCJAmSQlNRCs3D+t0bu0
         s39qYCm9M0pssq6Zkvpjwqh10zt3iVTzJgCNPNUbSbem1uSc01RE0Tr894UuzD6Biybv
         yDYdY1mMj7RtwDHs5G1okANX6z0fOeWDAMED5bToz5UGFtM+EpJdNAcM29ktcyecOAm9
         YLoD4xc8ls9PCr2QXilRKDYKB761wMsPheNOV8eUXBzYo8O1Du0pWG0snceut/xyvaQK
         zNqHfpflc95nMZV7nehNtp5gDsKxBCT1udA30kh8i9Zb6OwbXkGsXDBgvU4oonDXMyrG
         H1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pzx8qqpSnwG1wLkI5RwMbGMXLwJB5p31g2jEsQjzdxU=;
        b=DPLblmrBSiES4CsMXLoTsHz9IRAv49DluKCOJvrlRqOM/RQBkPRaA1gW5DWFMztIHk
         G54Ev9Vwc9cFM3Ws5WnANU9HvBb22z//dqHHeAUaNCZ3s3gWRL7nCMmvuElxLDfC+sMq
         1jYMhOpJnboi4bJ1qut1WTpZxUCQzZq632fNq0vXFq7ITyqEYtUHteiWnY3FvytIceOj
         ZHuoiRqkV09zhE1sr5DkXh5P0kpW+NvbNlL8mG1Bk/NENiB3fKqvzPLO876MuIRMzqaV
         0KAmWXjkdA8khpXD1wKsRjWIRGYQ95Tja6U/5B+PseIcqcbSk8jEQZb19CgRFbojYA9E
         znyw==
X-Gm-Message-State: AOAM530yJSDCY3GvQAUAW3tBLXY/7qDw5n2poSRpuPU1q2KB9lZzhjUR
        tIJt0VHAqmwZ9zOtdE5m1z87rF8Q3yspr1FpTK/GrG5V+Y1V8Q==
X-Google-Smtp-Source: ABdhPJzoAlBDgJqBsELPR82zmA7I24BxXbHO/3/xLeQkDQlBceC57LECo4BNbjP6XzyMlpfBeaHed/4AucKo2iIWhkE=
X-Received: by 2002:a05:6512:ea8:b0:44a:81ad:c39a with SMTP id
 bi40-20020a0565120ea800b0044a81adc39amr9825142lfb.358.1648467541927; Mon, 28
 Mar 2022 04:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220312044315.7994-1-michael@allwinnertech.com>
 <83edf9a1-1712-5388-a3fa-d685f1f581df@intel.com> <88e53cb9-791f-ee58-9be8-76ae9986e0e2@allwinnertech.com>
 <DM6PR04MB6575C3B87DFA920EDCD994CCFC0F9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <32b29790-eb5c-dac0-1f91-aede38220914@allwinnertech.com> <DM6PR04MB6575A4A2A687A876EA5C04B7FC119@DM6PR04MB6575.namprd04.prod.outlook.com>
 <312d724c-e43f-d766-49fb-9c5b10fe8b07@intel.com> <7ec0cf3e316a4ed9987962b4cbf01604@hyperstone.com>
 <a1230f11-a2dd-1959-5444-28c57d3babf6@intel.com> <CAPDyKFpnR12+nrbiB-Ps-C4vn-WeHneRGJioQ_0b2ikk2CBChw@mail.gmail.com>
 <CAPDyKFqnFVd=mvQMnydT569Y6YFg3zPkttQ=amdzmT_yqYQeTg@mail.gmail.com>
 <a39e9f71-7a9c-bf0e-50d0-d45de3c2e132@allwinnertech.com> <CAPDyKFoVVrCNqJUztKnOqyJHhFYnH0H3PR1z02qVN7pchD6W0g@mail.gmail.com>
 <580a9991-b117-86aa-a7b9-bf952d580a87@allwinnertech.com>
In-Reply-To: <580a9991-b117-86aa-a7b9-bf952d580a87@allwinnertech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Mar 2022 13:38:25 +0200
Message-ID: <CAPDyKFrtVV35mg4dq5UZRnAzNRQRAbmbRXQfCB_gdpdyPETK3Q@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 at 12:11, Michael Wu <michael@allwinnertech.com> wrote:
>
> On 25/03/2022 18:13, Ulf Hansson wrote:
> > On Fri, 25 Mar 2022 at 06:46, Michael Wu <michael@allwinnertech.com> wr=
ote:
> >>
> >> On 24/03/2022 19:27, Ulf Hansson wrote:
> >>> On Thu, 17 Mar 2022 at 10:14, Ulf Hansson <ulf.hansson@linaro.org> wr=
ote:
> >>>>
> >>>> On Wed, 16 Mar 2022 at 17:08, Adrian Hunter <adrian.hunter@intel.com=
> wrote:
> >>>>>
> >>>>> On 16.3.2022 16.46, Christian L=C3=B6hle wrote:
> >>>>>>> So we are not going to let the block layer know about SD cache?
> >>>>>>> Or is it a separate change?
> >>>>>>
> >>>>>> I have some code for this laying around, but as it requires readin=
g, parsing and writing Function Registers,
> >>>>>> in particular PEH, it's a lot of boilerplate code to get the funct=
ionality, but I'll clean it up and send a patch in the coming weeks.
> >>>>>>
> >>>>>
> >>>>> We have the sd cache flush.  We would presumably just need to call =
blk_queue_write_cache()
> >>>>> for the !mmc_card_mmc(card) case e.g.
> >>>>>
> >>>>>           if (mmc_has_reliable_write(card)) {
> >>>>>                   md->flags |=3D MMC_BLK_REL_WR;
> >>>>>                   enable_fua =3D true;
> >>>>>           }
> >>>>>
> >>>>>           if (mmc_cache_enabled(card->host))
> >>>>>                   enable_cache =3D true;
> >>>>>
> >>>>>           blk_queue_write_cache(md->queue.queue, enable_cache, enab=
le_fua);
> >>>>
> >>>> To me, this seems like the most reasonable thing to do.
> >>>>
> >>>> However, I have to admit that it's not clear to me, if there was a
> >>>> good reason to why commit f4c5522b0a88 ("mmc: Reliable write
> >>>> support.") also added support for REQ_FLUSH (write back cache) and w=
hy
> >>>> not only REQ_FUA. I assumed this was wrong too, right?
> >>>>
> >>
> >> Hi Ulf,
> >>
> >> 1. I've found the reason. If we only enable REQ_FUA, there won't be an=
y
> >> effect -- The block layer won't send any request with FUA flag to the
> >> driver.
> >> If we want REQ_FUA to take effect, we must enable REQ_FLUSH. But on th=
e
> >> contrary, REQ_FLUSH does not rely on REQ_FUA.
> >> In the previous patch(commit f4c5522b0a88 ("mmc: Reliable write
> >> support.")), REQ_FLUSH was added to make REQ_FUA effective. I've done
> >> experiments to prove this.
> >
> > Thanks for doing the research and for confirming.
> >
> > Note that this is also pretty well documented in
> > Documentation/block/writeback_cache_control.rst.
>
> Thanks for reminding. I'm clear now.
>
> >
> >>
> >> 2. Why block layer requires REQ_FLUSH to make REQ_FUA effective? I did
> >> not find the reason. Does anyone know about this? Thank you.
> >
> > The REQ_FLUSH indicates that the storage device has a write back
> > cache, which also can be flushed in some device specific way.
> >
> > The REQ_FUA (Force Unit Access), tells that the data can be written to
> > the storage device, in a way that when the I/O request is completed,
> > the data is fully written to the device (the data must not be left in
> > the write back cache). In other words, REQ_FUA doesn't make sense
> > unless REQ_FLUSH is supported too.
> >
>
> Thank you for your answer.
>
> > $subject patch should also conform to this pattern.
>
> I'm not sure if I understood this in a right way... Did you mean I
> should modify the subject of this mail/patch?

No, I just meant that the code in the patch should conform to this.

If REQ_FUA is set, REQ_FLUSH must be set too.

>
> >
> > However, it's still questionable to me whether we want to support
> > REQ_FUA through the eMMC reliable write command - in case we also have
> > support for managing the eMMC cache separately. It looks to me that
> > the reason why we currently support REQ_FUA, is because back in the
> > days when there was only the eMMC reliable write command available, it
> > was simply the best we could do. But it was never really a good fit.
> >
> > I am starting to think that we may consider dropping REQ_FUA, if we
> > have the option to manage the eMMC cache separately - no matter
> > whether the eMMC reliable write command is supported or not. In this
> > case, REQ_FLUSH is sufficient and also a better match to what we
> > really can support.
>
> Hi Ulf,
> As to dropping REQ_FUA, I don't know if it is a good idea, but generally
> we are facing three possible situations:
>
> 1. If both cache and reliable-write are available, both REQ_FUA and
> REQ_FLUSH can be supported at the same time. In this case, with
> available cache, the behavior of reliable-write is to write eMMC while
> skipping cache, which is consistent with the current kernel's definition
> of REQ_FUA. What's more, most eMMCs now support both cache and
> reliable-write command.

Yes, this seems reasonable.


> 2. If only reliable-write is available, REQ_FUA should not be supported,
> which is consistent with the current standard in another way. But I
> don't think eMMCs that only support reliable-write can be easily found
> nowadays.

If we drop REQ_FUA for this case, I am worried that we might break use
cases for those older eMMC devices.

So, no, let's keep REQ_FUA and REQ_FLUSH if reliable-write is supported.

> 3. If only cache is available, we just use REQ_FLUSH. It is not in
> conflict with keeping REQ_FUA.

Right.

>
> Maybe, is it more reasonable to reserve FUA and use if/else to pick it
> up or down, considering the compatibility? I mean, in most cases, FUA
> and FLUSH are complementary. So it seems more feasible with branch to
> choose.

Let's summarize what I think we should do then:

 if (reliable-write supported) {
     enable_fua =3D true;
     enable_cache =3D true;
}

if (mmc_cache_enabled)
     enable_cache =3D true;

blk_queue_write_cache(md->queue.queue, enable_cache, enable_fua);

Does this seem reasonable to you?

[...]

Kind regards
Uffe
