Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A0C528913
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245457AbiEPPjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245441AbiEPPjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:39:40 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4053C733;
        Mon, 16 May 2022 08:39:39 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id p1so5963128uak.1;
        Mon, 16 May 2022 08:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=v4AO4TvHBXHTDE7cylsD4nuz6SSH2GMvFgLvHL67nzg=;
        b=oQvj+YtW4IrWIS+cbVofERrPNxoiZ8a1TfUizMKdXiF+oifQ8rMR6dMTD7xhC/yBT8
         nIlW/vYFRGCmTNzy+RLefilKS93CS3r2u+KmhGJONUoBisSKGNjCJ4GGuhBvM6yJ3Wyo
         cGZfRkJlXPUUXwbK4ElaFRRcOVBN+4fijkzafe5BaXNh3Lo8MvTTcF6ssID+xi6bBX8I
         tKuPZu8AwwauFWuytr7C7kIpD1qnMZle7E14LHJGNXpSyHHc8HjsNR/3Co9ctkUpt6T0
         9WNggDn7scmECNqDFk2r7BaKOivdy3hF0E0Ko1wINSACP7MFzmdbj+xDmWWb6Jq9LP91
         WSzA==
X-Gm-Message-State: AOAM533GXRf6SaXto10Vj8JWJoJrpyNdUUXQ091u6ARi2imeY/phE6Hl
        yABpqvEU/LrqMcd/xidbhVuq5wR+KomV8A==
X-Google-Smtp-Source: ABdhPJwr2O3FGik3cSKjaPSHku0LPtjeQtskgMWSj2/APW6/bM2WjQEqOOhYbESvhMt7lbawcfZW4A==
X-Received: by 2002:ab0:349a:0:b0:35c:b898:a733 with SMTP id c26-20020ab0349a000000b0035cb898a733mr6082808uar.85.1652715578381;
        Mon, 16 May 2022 08:39:38 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id y17-20020ac5c811000000b0034e98f6f2d8sm1281781vkl.55.2022.05.16.08.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 08:39:38 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id c62so15915004vsc.10;
        Mon, 16 May 2022 08:39:37 -0700 (PDT)
X-Received: by 2002:a67:b304:0:b0:32c:fb41:9f43 with SMTP id
 a4-20020a67b304000000b0032cfb419f43mr6526925vsm.83.1652715577451; Mon, 16 May
 2022 08:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220512071858.10805-1-qianfanguijin@163.com> <20220512071858.10805-2-qianfanguijin@163.com>
 <20220513073849.cu4jzykefat2sepg@houat> <1352b9d7-5219-af09-948b-6462def39ea5@163.com>
 <20220513081556.knd3tf6pangfblh3@houat> <666ead08-af1e-81f5-6fe1-e5e3370e6d6f@163.com>
 <20220516075326.hccburhu743t7p6r@houat>
In-Reply-To: <20220516075326.hccburhu743t7p6r@houat>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 16 May 2022 23:39:26 +0800
X-Gmail-Original-Message-ID: <CAGb2v65xifgy4dXciron4yxiUQtHb-2ZRGTqOiSjLrdbFtqQEA@mail.gmail.com>
Message-ID: <CAGb2v65xifgy4dXciron4yxiUQtHb-2ZRGTqOiSjLrdbFtqQEA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: sun8i-r40: Add "cpu-supply" node for
 sun8i-r40 based board
To:     qianfan <qianfanguijin@163.com>
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 3:53 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Fri, May 13, 2022 at 04:23:20PM +0800, qianfan wrote:
> > > > > There's a similar issue for all the boards that don't have a regulator
> > > > > in the first place.
> > > > >
> > > > > The way we worked around this for the other SoCs is to have a DTSI with
> > > > > the OPPs with a frequency higher than what U-Boot boots with (1008MHz?),
> > > > > and only include that DTSI on boards that have a CPU regulator hooked in.
> > > > Is this really necessary? It seems like every board based on sun8i-r40
> > > > have a cpu regulator.
> > > This probably won't be the case whenever someone starts a new design,
> > > and then they'll face random crashes for no apparent reason, and waste a
> > > lot of time in the process.
> > >
> > > Whereas the alternative is that you would be missing some OPPs,
> > > something that is fairly easy to figure out.
> >
> > How about remove the OPPs which greate that 1.08G in sun8i-r40.dtsi,
> > If some boards want to run at a higher frequency, can add them byself
> > in the board's file.
>
> You did all the work to support and test them already. It's a bit of a
> waste to do that and not include it.
>
> Just do a DTSI like we did for the A64 for example.

There's also no guarantee that the board boots up at 1.08G. The board
may be set to boot up at a slightly lower frequency / voltage combination.
Or maybe the board's supply voltage simply isn't stable enough for sustained
high CPU usage at 1.08G.

Letting the kernel assume that it is OK to run at some OPP is not a good
idea. The boards should explicitly include the default OPP table, or define
their own, while adding a proper CPU supply at the same time.


Regards
ChenYu
