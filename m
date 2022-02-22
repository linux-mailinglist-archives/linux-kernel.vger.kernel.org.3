Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379B34BFFDC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbiBVRMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiBVRMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:12:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABCFD10B5;
        Tue, 22 Feb 2022 09:12:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0F579CE13B7;
        Tue, 22 Feb 2022 17:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DBFC340F6;
        Tue, 22 Feb 2022 17:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645549926;
        bh=omsP2wspDeKBbcO6aHkA8qeKmX9rrZFhv/B8ii8a4ro=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GFu7uCE/JfSx+0efsuAE0Upup4Vso37SPJj/IsmyBR9qF6i8BQK2ZqPKkWWAPVuOt
         JhAsc3cvumIC+ZPFeJ8ijECHoPcQft5RdwlATy1V0jUq0RUaIEefoZuuDqZf719REq
         G0yaHG8rldxXzOXeLNHeVz9KpMAvi3+XeHG7Pd8Yi7Io9EWzb0UWU/z9K7nUIyrYLQ
         TakaQ5A5PoRTUDVVMHxO/T2NjjABjGfCqA/EnEq2YweQscz3OPWv+GS6zwfiglrxkL
         t29ETfjbG/ZV7OnBaXDHLXTuDP9B833+2ijwFJOPeb7nIGwmkaV1lF4Ln50wuBrD2j
         uzieOagOxRvzQ==
Received: by mail-qk1-f174.google.com with SMTP id d84so392614qke.8;
        Tue, 22 Feb 2022 09:12:06 -0800 (PST)
X-Gm-Message-State: AOAM532gsgldlYXIwJl1YOnvLNZowCXvDmpBMLp60xI2AZHeCjkH+/Pg
        jgvuZn6SyjDvdkz67di8BP6EYJyCF4LaNwzjvw==
X-Google-Smtp-Source: ABdhPJxKYy1Tc7ku6sW15BPD9hLjoMpH8sy4XOkikMtTGwAOyTAxpvHONEdLda6jtM6mJWOl2Ru7KOlSJ6UeWwC6NFk=
X-Received: by 2002:a37:5484:0:b0:477:78a7:a132 with SMTP id
 i126-20020a375484000000b0047778a7a132mr16468601qkb.94.1645549925452; Tue, 22
 Feb 2022 09:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20220216132830.32490-1-shawn.guo@linaro.org> <20220216132830.32490-3-shawn.guo@linaro.org>
 <1645070363.942246.2266021.nullmailer@robh.at.kernel.org> <20220217065447.GC31965@dragon>
In-Reply-To: <20220217065447.GC31965@dragon>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Feb 2022 11:11:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLAi4KGHVFpW_+TkdtaYLXEoZg7rNOfwgpnY-JyxnBxJg@mail.gmail.com>
Message-ID: <CAL_JsqLAi4KGHVFpW_+TkdtaYLXEoZg7rNOfwgpnY-JyxnBxJg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: interrupt-controller: Add Qualcomm
 MPM support
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 12:55 AM Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Feb 16, 2022 at 09:59:23PM -0600, Rob Herring wrote:
> > On Wed, 16 Feb 2022 21:28:29 +0800, Shawn Guo wrote:
> > > It adds DT binding support for Qualcomm MPM interrupt controller.
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > ---
> > >  .../interrupt-controller/qcom,mpm.yaml        | 94 +++++++++++++++++++
> > >  1 file changed, 94 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> I ran dt_binding_check without DT_CHECKER_FLAGS=-m.  Will re-test and
> fix.

'-m' is not related to your problem. That's just 'undocumented
compatible' warnings. Probably you need to update dtschema.

Rob
