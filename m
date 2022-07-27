Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6328F583540
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbiG0WPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbiG0WO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:14:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F256765D7E;
        Wed, 27 Jul 2022 15:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 962E8B82286;
        Wed, 27 Jul 2022 22:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF3DC43470;
        Wed, 27 Jul 2022 22:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658959923;
        bh=OdgQrrPG8BUR2b2yNmh3OFrDvpcW55FL2Q6+RLHW76M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tbnFOJUu/WaozZIVJCnvZPi1eEaf2p6DB34iesgMesKdeS97cbvyEKVMuXt5Mg7A4
         T45PivH+b5v2OIVkzqMY10rLJKYqlFWYP1f/3D8CQKgRiL+p7gALfiU92g5vIvVhCN
         fJYncG0GlbctujlX0SqZWGXjut3GGaZG3HgRPyEQLkt+QsjvnW4EAWkb+RzlaPLqM3
         U/0KGDDATpAoKQMpC/MV17I/kX19Za/qwufcgMiAJcAyzcYfXCs0BdbNMVrw30fqvz
         rHgLBfAO3GE5MKs2MTLIU6ghgIOIjZa+yy4QDpY7YPpG5rRYb1g5xyWjdaRtilXCNY
         AWJhvjHqLwiwA==
Received: by mail-vs1-f51.google.com with SMTP id 66so19403vse.4;
        Wed, 27 Jul 2022 15:12:03 -0700 (PDT)
X-Gm-Message-State: AJIora/treDbuxk4foMn4oXsrCwCScbSFimiBlu+1IccC0/TevkbmbD/
        YTCYtk3qhlhl49wSBkRjnX0U5zbP5+EI2F9rEw==
X-Google-Smtp-Source: AGRyM1uuRDLPni5HdjqtEIbzt0NQRO8rcoruBURHRVynskfUsrrj94bFcELIF4fzDI38jCj6fSCEHXpT1g2KKT916ss=
X-Received: by 2002:a05:6102:21aa:b0:35a:1419:1bc7 with SMTP id
 i10-20020a05610221aa00b0035a14191bc7mr2983610vsb.26.1658959922069; Wed, 27
 Jul 2022 15:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220726212354.1.I5b9006878bdabd6493b866b46dbd6149968d545b@changeid>
 <20220727160320.GA2755147-robh@kernel.org> <CAD=FV=U8ek0FR=hZwemK5JcbUP=JsnRTtv7WzJKmOb-UFwHfXA@mail.gmail.com>
 <CAL_JsqJ=jj6isKbBEKGjax266MS_h+Oehn9zYMMjXzc3K-t4Wg@mail.gmail.com> <CAD=FV=XPTUVKMSrcZdaoztrMU9pCJWXkHLfW-1dHqG70-iR3Yw@mail.gmail.com>
In-Reply-To: <CAD=FV=XPTUVKMSrcZdaoztrMU9pCJWXkHLfW-1dHqG70-iR3Yw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 27 Jul 2022 16:11:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL+5DSXoLDYVDbaDisW4uBncBYx--RFOO6-jd0Bed_RAQ@mail.gmail.com>
Message-ID: <CAL_JsqL+5DSXoLDYVDbaDisW4uBncBYx--RFOO6-jd0Bed_RAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: document zoglin board
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bob Moragues <moragues@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 3:59 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Jul 27, 2022 at 12:43 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Jul 27, 2022 at 11:40 AM Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Jul 27, 2022 at 9:03 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Tue, Jul 26, 2022 at 09:24:31PM -0700, Bob Moragues wrote:
> > > > > Zoglin is a Hoglin Chromebook with SPI Flash reduced from 64MB to 8MB.
> > > > > Zoglin is identical to Hoglin except for the SPI Flash.
> > > > > The actual SPI Flash is dynamically probed at and not specified in DTS.
> > > > >
> > > > > Signed-off-by: Bob Moragues <moragues@chromium.org>
> > > > >
> > > > > Signed-off-by: Bob Moragues <moragues@google.com>
> > > > > ---
> > > > >
> > > > >  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> > > > > index 581485392404..63091df3cbb3 100644
> > > > > --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> > > > > +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> > > > > @@ -475,6 +475,7 @@ properties:
> > > > >
> > > > >        - description: Qualcomm Technologies, Inc. sc7280 CRD platform (newest rev)
> > > > >          items:
> > > > > +          - const: google,zoglin
> > > > >            - const: google,hoglin
> > > > >            - const: qcom,sc7280
> > > >
> > > > Is just "google,hoglin", "qcom,sc7280" no longer valid? If it is valid,
> > > > you need another entry.
> > >
> > > If it makes people happy to have another entry then it wouldn't hurt,
> > > but it has no long term benefit and I would recommend against it. The
> > > next patch in this series changes the existing "hoglin" device tree to
> > > have all 3 compatible strings and thus when both patches land then
> > > make dtbs_check will pass. I assume that is the only goal of
> > > documenting these boards here. Certainly if you had a device tree that
> > > had only "google,zoglin" it would boot fine on zoglin devices and if
> > > you had a device tree that had only "google,hoglin" it would boot fine
> > > on hoglin device. This is true of all of the entries for Chromebooks
> > > that have multiple compatible entries.
> >
> > Why even add the entry? If it is just a different SPI flash, you can
> > tell that from the SPI flash compatible or device ID.
>
> Yeah, it's really unfortunate. :( The issue is a limitation in the
> ChromeOS bootloader infrastructure. The ChromeOS build infrastructure
> cannot handle something that it considers the same "board" as having
> different SPI flash sizes. This is because the infrastructure always
> requires that the bootloader "image" be the exact same size as the SPI
> flash and it assumes a universal firmware (single image) per board.
> It's unfortunately not very flexible but normally for a given board
> the SPI flash size is chosen at the start and never changed. The CRD
> board was an exception here. Though it's not beautiful, this means
> that the firmware considers this as a different board and looks for a
> different compatible string on the kernel command line.

Okay, I guess...

Acked-by: Rob Herring <robh@kernel.org>
