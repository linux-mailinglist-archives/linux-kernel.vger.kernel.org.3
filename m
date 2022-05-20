Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC99452F4BA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353562AbiETVB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbiETVBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:01:48 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72345A095
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:01:46 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id z5-20020a9d62c5000000b00606041d11f1so6307883otk.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=u7To4MMHANcw9/o4TysXvdWUneIO12Q6tHtlKQSYJzk=;
        b=PB5y7Efk78RijA79yukKg1SRWWLrUWJPRqN2I9+h8jLlNHZ3QbENIkHCBdcfO+VLRt
         GhH0e9C+de8oHDVfkTAzFoKlZqzracUnUJXnMp4wymA5wyXTomNvUl7C7fxBy8+IOOvH
         fAz7Su4mp6KlgXEnVndXia6mALwV7g/UpFhHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=u7To4MMHANcw9/o4TysXvdWUneIO12Q6tHtlKQSYJzk=;
        b=VqFvAaXgqda49fRtYhrdKeDfdUrgKjGf8mSrCuRWEM/yPyeW9d3uSmIp3RjPoFcJ4x
         qo3lo0guZR1pr8M8C9p/vTIsRIImspGhC44laol7gv4ryjiy0i/2MKrbgKnbEwrclShU
         rrvyJAG+NIBfiIia+iVP8eluvNF+AgB4k3BA/q/g+Vk1ogwTq3sAuYPu0EvxXukPJuUg
         y2jCEThINeig+fKPGkwlCPSieU9sHbneFNG64GvW2EOROppHSilQ4Br1qAENv2ajfRYI
         WePqD/fuG4vkwo7vzqiKMBuTXR8JayMsfA9+0ON0CXlwvTuyyYwSwen4uOoLj4nkK73H
         OpKg==
X-Gm-Message-State: AOAM530C+xMmBQhafqGBClmgJNDHSTxM3cE0trIne4AiJjaXULjI2ZPE
        VKsn5K1ECw/r93T+0fAJbFxfHreXeKgyoa+Y8whZlA==
X-Google-Smtp-Source: ABdhPJztEz4nfOcRnEOqEdtwha6jMImJ+Q/Ibb57RRAwOWes+DEAzOegQMN6NEb9JeturtnozTEXfDcqX4otnf6VQpw=
X-Received: by 2002:a9d:77d4:0:b0:60a:e85b:aacb with SMTP id
 w20-20020a9d77d4000000b0060ae85baacbmr3329519otl.159.1653080506141; Fri, 20
 May 2022 14:01:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 May 2022 14:01:45 -0700
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VX_dr+hrNEGyC7GxcYcbMeL-uMaVLEJ5EgKnb76HVoDA@mail.gmail.com>
References: <20220520161004.1141554-1-judyhsiao@chromium.org>
 <20220520161004.1141554-2-judyhsiao@chromium.org> <CAE-0n53e0bq_MbfgZYdxatP8CpGVMKkBKOnSDOV+MvbBFB6wOA@mail.gmail.com>
 <CAD=FV=VX_dr+hrNEGyC7GxcYcbMeL-uMaVLEJ5EgKnb76HVoDA@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 20 May 2022 14:01:45 -0700
Message-ID: <CAE-0n53x6KJPz_Jc7terJB2AtLAHFo4kKZ98kAbUi8xckeCs_A@mail.gmail.com>
Subject: Re: [v2 1/3] arm64: dts: qcom: sc7280: herobrine: Add pinconf
 settings for mi2s1
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Judy Hsiao <judyhsiao@google.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2022-05-20 13:39:21)
> On Fri, May 20, 2022 at 1:38 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Judy Hsiao (2022-05-20 09:10:02)
> > > +};
> > > +
> > > +&mi2s1_sclk {
> > > +       drive-strength = <6>;
> > > +       bias-disable;
> >
> > Is there an external pull on this line? If so please add that details as
> > a comment like we do for other external pulls.
>
> Actually, I think they are output lines, which is why they have a
> drive-strength. I think for output lines we don't usually comment
> about why we're disabling the pulls, only for input lines?

Ok makes sense. Even for an open drain signal it would be an "input" so
that rule still applies?
