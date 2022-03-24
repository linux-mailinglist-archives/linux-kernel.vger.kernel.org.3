Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57D04E6279
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349745AbiCXL3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbiCXL3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:29:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB4A9A9BB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:27:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p15so7487379lfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fPfi4Xm9YbqP1IoK9ElG4DOlRT/KjgvgBNNdUk2X6ZQ=;
        b=t/EfuE5B4xcxjUhY3ePpMuxc+uUjdNEyq5MDxPZP2WuJYR7sgQ4BiI89rM+KryafAK
         UKfngnLjaX666ztqaPfZXEurD4HBxenspJu0puiPgk/GAQnHdppbsYHXmI7FTdq3IYTw
         v/i7vTtQmAAdE3PO403saxQypwTvP55bnVYyj29Ro8qDQDyDQYvJ+1c15zRgsYbhrGex
         kg2OiSvY6HCw8Jz6WPokAsW2Vdp4c8Ge8Bk0HDa9aQIIF44+J1qn6H7iFRwlj5qXpy1k
         QJD3UcIvty1RXGS38NehZk1hd23cVf7oEcRFvWQKpBq8TLd8gnbtj1gp1X1O3vpWxewJ
         uVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fPfi4Xm9YbqP1IoK9ElG4DOlRT/KjgvgBNNdUk2X6ZQ=;
        b=czxeImfzf4sdfQmVRzcaPU/aUOLSBkmxhAYJWfhYVqyiBBUHdN3AM0X/WQo4P6TTJO
         S9Nuke8U9PdJriN1OXUMN63knRpl3qAujpvPOYn8mP02rMGyDoZrrIkE7NbmJv367PzO
         g9m1zbUmVCHSLci7jYhY5stPUaEs2TEJ/Iho3Qf7zsqq7gGy1fR41lJ+S7k8si9A6zAy
         aBci7x5yEQ5KrGsfOQkADvXIbAkErX/e3obEBPoeWTTxGkPEIXhrsbbV2VoGJ79WA+tr
         3srffK5ACOyaVqHEZID5sgRcPhDi+gQfZ8SYM3m3LEhItzuP9a3WT10Oyw8zXhysTndF
         dzCg==
X-Gm-Message-State: AOAM532zKtLJ9IbNzl4M76dqi3GGG+zKnm/0C06xgkPu/ekm2qlL59Rw
        IpGJh7Da6k6AVNEnf3mRqVMGcilgGUW6BmW/kKLXkg==
X-Google-Smtp-Source: ABdhPJxdvjqNo4uyHye12q7AtzjdCfzM0RY44K5wbnCJ2Tj14hNItGhGCR5vH6iOrKCB/ZBglN/ZRGwPtefkMIOPPKc=
X-Received: by 2002:a05:6512:260b:b0:445:c54c:4157 with SMTP id
 bt11-20020a056512260b00b00445c54c4157mr3543024lfb.254.1648121261963; Thu, 24
 Mar 2022 04:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220312044315.7994-1-michael@allwinnertech.com>
 <83edf9a1-1712-5388-a3fa-d685f1f581df@intel.com> <88e53cb9-791f-ee58-9be8-76ae9986e0e2@allwinnertech.com>
 <DM6PR04MB6575C3B87DFA920EDCD994CCFC0F9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <32b29790-eb5c-dac0-1f91-aede38220914@allwinnertech.com> <DM6PR04MB6575A4A2A687A876EA5C04B7FC119@DM6PR04MB6575.namprd04.prod.outlook.com>
 <312d724c-e43f-d766-49fb-9c5b10fe8b07@intel.com> <7ec0cf3e316a4ed9987962b4cbf01604@hyperstone.com>
 <a1230f11-a2dd-1959-5444-28c57d3babf6@intel.com> <CAPDyKFpnR12+nrbiB-Ps-C4vn-WeHneRGJioQ_0b2ikk2CBChw@mail.gmail.com>
In-Reply-To: <CAPDyKFpnR12+nrbiB-Ps-C4vn-WeHneRGJioQ_0b2ikk2CBChw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Mar 2022 12:27:05 +0100
Message-ID: <CAPDyKFqnFVd=mvQMnydT569Y6YFg3zPkttQ=amdzmT_yqYQeTg@mail.gmail.com>
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

On Thu, 17 Mar 2022 at 10:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 16 Mar 2022 at 17:08, Adrian Hunter <adrian.hunter@intel.com> wro=
te:
> >
> > On 16.3.2022 16.46, Christian L=C3=B6hle wrote:
> > >> So we are not going to let the block layer know about SD cache?
> > >> Or is it a separate change?
> > >
> > > I have some code for this laying around, but as it requires reading, =
parsing and writing Function Registers,
> > > in particular PEH, it's a lot of boilerplate code to get the function=
ality, but I'll clean it up and send a patch in the coming weeks.
> > >
> >
> > We have the sd cache flush.  We would presumably just need to call blk_=
queue_write_cache()
> > for the !mmc_card_mmc(card) case e.g.
> >
> >         if (mmc_has_reliable_write(card)) {
> >                 md->flags |=3D MMC_BLK_REL_WR;
> >                 enable_fua =3D true;
> >         }
> >
> >         if (mmc_cache_enabled(card->host))
> >                 enable_cache =3D true;
> >
> >         blk_queue_write_cache(md->queue.queue, enable_cache, enable_fua=
);
>
> To me, this seems like the most reasonable thing to do.
>
> However, I have to admit that it's not clear to me, if there was a
> good reason to why commit f4c5522b0a88 ("mmc: Reliable write
> support.") also added support for REQ_FLUSH (write back cache) and why
> not only REQ_FUA. I assumed this was wrong too, right?
>
> When it comes to patches for stable kernels. mmc_cache_enabled() was
> introduced quite recently in v5.13, so for older kernels that call
> needs to be replaced with something else.
>
> In any case, the relevant commits that can be considered as needs to
> be fixed seems like these:
> commit f4c5522b0a88 ("mmc: Reliable write support.")
> commit 881d1c25f765 ("mmc: core: Add cache control for eMMC4.5 device")
> commit 130206a615a9 ("mmc: core: Add support for cache ctrl for SD cards"=
)
>
> [...]

Michael, are you planning to send a v2 for this? Or are there any
parts that are still unclear to you?

Kind regards
Uffe
