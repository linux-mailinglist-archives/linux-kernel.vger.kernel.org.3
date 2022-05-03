Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF49518CF5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241782AbiECTRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241802AbiECTQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:16:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC1F3FBCD
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 12:13:06 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p12so31961549lfs.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 12:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=gScoDEP6H/e2lI5aewxp6CF++a7zPjIJd6rBgjg+7gQ=;
        b=g80alIQgcsogfvNR+vlagnVLLLFaTSdEq7aWHE+TvhjlAxM19YDbjJaC8hvBvUSdd6
         X7qzLkX0GNkwIsgjX9VVMTMJp4MllktFpVGEJC+YDwT/qfXsSFTmD0i0+wtnLcEoymqh
         om5phHKEqnUn/1oPFtYow+DFIxFH0Agn5hj2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=gScoDEP6H/e2lI5aewxp6CF++a7zPjIJd6rBgjg+7gQ=;
        b=Bypn0WMNDG/QH3poXL0vKIT9fO5YOfHE0WmToVTqAlh0y3FYqDx5xNhtGxTKFXgW37
         P89BRSe7ka06D2ih3D+PbMSeBZfUAMpwr1IhUEngoIHTbdRziREMq47FjKLlyyPCAm3Z
         wUcdcKBPOJMGR/b9V8FBQ0NTX1StIiT2Mhjz7fHvUM7F64gV/QpSr7IzNNzbmT5BsZfM
         dj48AuikMs9/1eiVLcIIwR3rqvEfuQKUTAqrsmpMDq8IF5E900D3qdH+WosvRmoqCgTd
         ISQ/+osiKS+UouKLG1nRUb3yV49raSHgxn5effVgzCJG26Iykel8bOLvJNPhI091Lb2U
         /gXw==
X-Gm-Message-State: AOAM530gTytzu5ekeaJ8zhRjMQe/79EhDcGWYf+oqdSG2oSFY4gD5XZ+
        UZP6/z3d1FgkTQsZmIxG2mUk0TJJzM2T3it8tjMwIg==
X-Google-Smtp-Source: ABdhPJwhnIwiZGhNfy9KvY44aruMr9TzFcBKZpVBHorn7YXHX7AMFkY5pxuQW/7NoScJrtPcWBFyjRS8ez2p4ADQUFY=
X-Received: by 2002:a19:ac42:0:b0:448:1f15:4b18 with SMTP id
 r2-20020a19ac42000000b004481f154b18mr12184218lfc.32.1651605184466; Tue, 03
 May 2022 12:13:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 May 2022 12:13:03 -0700
MIME-Version: 1.0
In-Reply-To: <YnE5xMS13oSuR5rx@robh.at.kernel.org>
References: <20220503004156.3559940-1-swboyd@chromium.org> <20220503004156.3559940-2-swboyd@chromium.org>
 <YnE5xMS13oSuR5rx@robh.at.kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 3 May 2022 12:13:03 -0700
Message-ID: <CAE-0n50OM1mV0xc6RrSAo_rC63hWbM6fH4+9pJuwvBCG4YeqwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: sx9324: Add CS idle/sleep mode
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2022-05-03 07:18:44)
> On Mon, May 02, 2022 at 05:41:55PM -0700, Stephen Boyd wrote:
> > We need to configure the sleep and idle mode of the CS pins for this
> > device. Add a DT property to do this so pins are in a proper state
> > during sleep (either hi-z, grounded, or pulled up to vdd).
> >
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  .../devicetree/bindings/iio/proximity/semtech,sx9324.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> > index d265eb5258c8..6cec3481c8b2 100644
> > --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> > +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> > @@ -126,6 +126,14 @@ properties:
> >        UINT_MAX (4294967295) represents infinite. Other values
> >        represent 1-1/N.
> >
> > +  semtech,cs-idle-sleep:
> > +    description:
> > +      State of CS pins during sleep mode and idle time.
> > +    enum:
> > +      - hz
>
> I was trying to figure out how Hertz was a pin state. 'hiz' or 'hi-z'
> instead?

Sure. I was following the datasheet that has "HZ" but hi-z is better.
