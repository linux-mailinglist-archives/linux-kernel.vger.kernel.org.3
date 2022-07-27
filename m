Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89FF5833CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiG0Tnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiG0Tnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:43:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA491121;
        Wed, 27 Jul 2022 12:43:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 762A661AA5;
        Wed, 27 Jul 2022 19:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00DCC4347C;
        Wed, 27 Jul 2022 19:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658951013;
        bh=22tmQ0744zweWy6Sd0m5sISYSk9XRc5uyToEJOX6XwA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=elPJyLY8XnqGWGB86Kv1TktpvCzasthPaWVMG01889KU0S0FCJwcY4KebThT+yPJu
         eq506qPZohKFjQbU3LPGoLvXMmOnndylF41McbCI69PukIe0B0nDzEC2mp4vj01ReY
         pkLvH5o2UuFwh8SIzbWQwHSL1x1bXOPX2kpBT1/uyBMuDAIemn/utlB/Fwc53XSGlM
         kx8uSzlXbfgT1MnOr520U02kCcjfVzKTr5dER4vLd7wECOAEf7EGIS/CAWCAlJh6X9
         kCB7r+TNrD/jhDWFEtJdN4VV+da40hr9EJwCvb2MfTNwXot5liSDa2yFiMqDzCXQUZ
         tHqp1zR2qdsmA==
Received: by mail-vs1-f52.google.com with SMTP id 129so9979572vsq.8;
        Wed, 27 Jul 2022 12:43:33 -0700 (PDT)
X-Gm-Message-State: AJIora+c4itQHarhgpwxtt5HhOJ0JSgphCi166HPXjRQrCUwdcB9YwiS
        gcG0Ls9HsKrLHBTh7hCeJ3smFvq8rdR/MaaALQ==
X-Google-Smtp-Source: AGRyM1sMdp5ur6vooR3ja9tDEyEvMx73JLt7DSWJst3LANXtktK+yJI7uEPlzKk/B9hwwggFCFM+0gj7WxJDm789aLQ=
X-Received: by 2002:a67:c18d:0:b0:358:5bb6:2135 with SMTP id
 h13-20020a67c18d000000b003585bb62135mr5163757vsj.53.1658951012697; Wed, 27
 Jul 2022 12:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220726212354.1.I5b9006878bdabd6493b866b46dbd6149968d545b@changeid>
 <20220727160320.GA2755147-robh@kernel.org> <CAD=FV=U8ek0FR=hZwemK5JcbUP=JsnRTtv7WzJKmOb-UFwHfXA@mail.gmail.com>
In-Reply-To: <CAD=FV=U8ek0FR=hZwemK5JcbUP=JsnRTtv7WzJKmOb-UFwHfXA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 27 Jul 2022 13:43:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ=jj6isKbBEKGjax266MS_h+Oehn9zYMMjXzc3K-t4Wg@mail.gmail.com>
Message-ID: <CAL_JsqJ=jj6isKbBEKGjax266MS_h+Oehn9zYMMjXzc3K-t4Wg@mail.gmail.com>
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

On Wed, Jul 27, 2022 at 11:40 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Jul 27, 2022 at 9:03 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Jul 26, 2022 at 09:24:31PM -0700, Bob Moragues wrote:
> > > Zoglin is a Hoglin Chromebook with SPI Flash reduced from 64MB to 8MB.
> > > Zoglin is identical to Hoglin except for the SPI Flash.
> > > The actual SPI Flash is dynamically probed at and not specified in DTS.
> > >
> > > Signed-off-by: Bob Moragues <moragues@chromium.org>
> > >
> > > Signed-off-by: Bob Moragues <moragues@google.com>
> > > ---
> > >
> > >  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> > > index 581485392404..63091df3cbb3 100644
> > > --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> > > @@ -475,6 +475,7 @@ properties:
> > >
> > >        - description: Qualcomm Technologies, Inc. sc7280 CRD platform (newest rev)
> > >          items:
> > > +          - const: google,zoglin
> > >            - const: google,hoglin
> > >            - const: qcom,sc7280
> >
> > Is just "google,hoglin", "qcom,sc7280" no longer valid? If it is valid,
> > you need another entry.
>
> If it makes people happy to have another entry then it wouldn't hurt,
> but it has no long term benefit and I would recommend against it. The
> next patch in this series changes the existing "hoglin" device tree to
> have all 3 compatible strings and thus when both patches land then
> make dtbs_check will pass. I assume that is the only goal of
> documenting these boards here. Certainly if you had a device tree that
> had only "google,zoglin" it would boot fine on zoglin devices and if
> you had a device tree that had only "google,hoglin" it would boot fine
> on hoglin device. This is true of all of the entries for Chromebooks
> that have multiple compatible entries.

Why even add the entry? If it is just a different SPI flash, you can
tell that from the SPI flash compatible or device ID.

Rob
