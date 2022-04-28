Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA43513486
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346175AbiD1NJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346832AbiD1NJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:09:04 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB4EB0A6F;
        Thu, 28 Apr 2022 06:05:49 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id m11so5228110oib.11;
        Thu, 28 Apr 2022 06:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Q8sY5EYm3EAW/+YeLHV7h7x0ZdCODIrdPi50A0ISao=;
        b=u++iRuKcHfDFMmWbZnvEIpEYIUADDRqtLhhrwzutcxvS8GTGXzqsZkb2bTXqIRzb5f
         on3N5xou4Z6Y4cXWfaEzqL3/yGXdu99nk80pbYwvors5f434LNaexTxtFdl1xn/4tDD7
         KsRL4eiG7xNfTpYIgwXnXeskebRJtEbALXuwR2uHYJAgXLxzOaT4+5g4NpyYCE4rbWc6
         uP2ixTsn9obX3xVIFUW0U/lPsLTdkF3071g7R5ZclXXL4NQW1ZWLKSKwMonF0d4zk78C
         I+DY9qlrqh10e5HZ1CX8GKuLzyq2cyUqePnLjW8WnEZoZeYzuFLj4qt+0q554AgBm+pv
         /0Gg==
X-Gm-Message-State: AOAM531FgLj7EG7Dvo6K4Hq9cqfRTrpWQJduxwafzMFVEwf4WzzFZyUC
        rVVtkXUM7fMTrYh+RZMy7g==
X-Google-Smtp-Source: ABdhPJz6TYrHQtltlSw6ndMYP3gm28JA36oK2lDbmJR8WaKuAC2Bu+/+6uLXbKrudAPgGHRM7xjyoQ==
X-Received: by 2002:a05:6808:124f:b0:321:855d:5b19 with SMTP id o15-20020a056808124f00b00321855d5b19mr16189828oiv.30.1651151148774;
        Thu, 28 Apr 2022 06:05:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k4-20020a9d7604000000b00605d52c6472sm2130753otl.9.2022.04.28.06.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 06:05:48 -0700 (PDT)
Received: (nullmailer pid 2066044 invoked by uid 1000);
        Thu, 28 Apr 2022 13:05:47 -0000
Date:   Thu, 28 Apr 2022 08:05:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Anmar Oueja <anmar.oueja@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: Re: [PATCH 1/1] of: unittest: rename overlay source files from .dts
 to .dtso
Message-ID: <YmqRK1uWiady7BHD@robh.at.kernel.org>
References: <CAMuHMdXPn9FHr41xmihuuzNNNKvY-50yAwY4HyuyVo6qBn=Z1w@mail.gmail.com>
 <CAMuHMdWeL3DOXY3xcPOBW2WDDGW3PxgSM8didt7J1KxSm1ivJg@mail.gmail.com>
 <CAMuHMdWXXoS9mmX9VWRQyXfmsy8YROgpLZ-xB7zthEdPdM2u4A@mail.gmail.com>
 <CAMuHMdVWkSnki8VQDaYRzJ8yu8xtEKpXyfQppTtw3wXDQPmYzw@mail.gmail.com>
 <d4b7ce06-23e7-1c60-cc0c-b6aea07e0a1a@gmail.com>
 <CAL_JsqKTckMABk6cM8d=boZcHyLdcqYmbzfKDjAHdCXoCPSDtg@mail.gmail.com>
 <CAMuHMdU4oUKaGxmaPiC=cX0XpHG3KXhr+4MywEfeQ8sq-EG18A@mail.gmail.com>
 <CAL_JsqL3fHXNdGS=ap6+5Y25T2zmnDYRkt5dNV9mW7hyanVvuw@mail.gmail.com>
 <CAL_JsqJn459-8wnwT0N0CKumnvh_gDkVdgVebvMVa13oTxfQ=g@mail.gmail.com>
 <CAMuHMdUyuJbyHthc4ATuRXY=zM_Vbc7DmsZvWgX_u8w3FfhzDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUyuJbyHthc4ATuRXY=zM_Vbc7DmsZvWgX_u8w3FfhzDg@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 08:25:31AM +0200, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Wed, Apr 27, 2022 at 11:14 PM Rob Herring <robh@kernel.org> wrote:
> > On Wed, Jan 26, 2022 at 1:31 PM Rob Herring <robh@kernel.org> wrote:
> > > On Fri, Jan 14, 2022 at 3:25 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Fri, Jan 14, 2022 at 3:10 AM Rob Herring <robh@kernel.org> wrote:
> > > > > On Thu, Jan 6, 2022 at 11:23 AM Frank Rowand <frowand.list@gmail.com> wrote:
> > > > > > Patient Geert has pinged again.
> > > > >
> > > > > If it's not a patch to be reviewed, then I'm not going to see it most
> > > > > likely. I don't read the DT list regularly...
> > > >
> > > > Fair enough...
> > > >
> > > > > > If I remember correctly you guys were not thrilled with this idea, but
> > > > > > also did not seem strongly against it.  Are you willing to go along
> > > > > > with .dtso for overlay source files?  If so, I will revive this patch
> > > > > > series.
> > > > > >
> > > > > > David, if you are against supporting .dtso in the dtc compiler then
> > > > > > the kernel can still support it through make rules.
> > > > >
> > > > > I'm not really interested in diverging from dtc. I'd suggest moving
> > > > > the discussion to dtc list and/or devicetree-spec if you want to get
> > > > > more attention on this.
> > > >
> > > > What needs to be supported in the dtc compiler?
> > > > The fallback passed to guess_input_format() is "dts".
> > > > So this has been working out-of-the-box since forever?
> > >
> > > Ah, okay.
> > >
> > > > > Also, keep in mind that extensions also affect MIME types which
> > > > > someone was also asking about recently.
> > > >
> > > > You mean "MIME type of Devicetree Blobs and Sources"[1]?
> > > > According to [2](2022-01-13), none of that has happened.
> > >
> > > This is what I was thinking of:
> > >
> > > https://github.com/devicetree-org/devicetree-specification/issues/46
> > >
> > > In any case, given everyone is ambivalent, send me an updated patch
> > > and I'll apply it.

^^^^^^^^

> >
> > Ping! Anyone still want this?
> >
> > What I don't want to see is a mixture of .dts and .dtso. And now I'm
> > reviewing RPi overlay patches[1] with .dts.
> 
> I still prefer .dtso over .dts, as it allows tools to detect the file
> type without having to read the file's contents.
> Without this, e.g. make needs to have all overlays listed explicitly
> in a Makefile.
> 
> We do have .c, .h, .s (even .S), .dtsi. So why not .dtso?

Read above! I said to resend this patch and I will apply it.

Rob
