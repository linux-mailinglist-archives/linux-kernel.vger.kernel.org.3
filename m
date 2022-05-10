Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636965220A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347041AbiEJQJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347092AbiEJQF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:05:57 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0AE60DBE;
        Tue, 10 May 2022 08:58:27 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id f3so8584360qvi.2;
        Tue, 10 May 2022 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zYeXIFwGiTGro2v4wofWCP3x3yzwe1mbrvTcoIvl73I=;
        b=Y0UK2ZT1mss57lmKDIxKL9SOGd3b5Eo9D4CMwvWBhqJyBfYNkcPA3ujTBXvuxrNbMt
         OHpZgN7qjIJAkRWDp2Sx2hBLVentL669y4N/u7Ozs/6DVFRpJzok3LkAEtVvi8Zt3ecX
         f0YIWuiAGOf9fnwQOKKt/FWxyZPrRqXHWXpGEQWU0niapvFMjOxI+lApp/ePgT+txVme
         2pktdWLQjJhBIkshQKowjn5xEb+IzT83jGrYzoPu+kV5z0kFu6loiTWemlmXrln3+ccp
         Ka+M7x3RunfTrqOVSkosoTLZj8gnOOPhSDdAFrIwUiGFQgmZis9v4ZUP99gqR9lbbmnx
         jbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zYeXIFwGiTGro2v4wofWCP3x3yzwe1mbrvTcoIvl73I=;
        b=01Y8wor2iQ0DxolUqY0/nBbBm8n/DPn2y+Nt4p481FGj50FMsI8LnRCWWsK6ZLaJBX
         zIFV3pUXbjcu+Uwjf3aTWO+PPZqAXx5ptwCkJd1DNbAa9cRTPd6Hw7+53XWF7aNq4FhW
         v7rlcdR0x2APHMlBeT6zo6+6b50dD0CB0njjHVlutVDyNdjdQdJ9fB7CnK/s25qNuxPD
         ZJtQ2zS5QywB3p1+mmk88jeUCmYI4PDdxj69IRwu3xbb1uIwipPYXYL8CJFCZ5d4Senq
         4A27SBaMuBZw6IqBp3mE+OFw4cYi77zG8AFBArYOgxDY9Al7Fu2qp1PkW+JNOHQ5Q6Ul
         j4pw==
X-Gm-Message-State: AOAM5330Ho70KDHLWziaEwOYgzOj4JQ+TrOIRKHtzErQq8GtZYhAcrjw
        nvMQj0ZFqlmSQJpFtewUbh4ooJ2KLpzYPn/ivNg=
X-Google-Smtp-Source: ABdhPJxk+ozZLx9K+xUPrC/224lGhrrXO3Lwd9Dnf/AVoIFQ8a9K7dsFoSV3sXUhBKLlMnpf3UDsav4JXMrcfI3UtyY=
X-Received: by 2002:a05:6214:d8d:b0:45a:fbe2:e7c with SMTP id
 e13-20020a0562140d8d00b0045afbe20e7cmr13813421qve.48.1652198306484; Tue, 10
 May 2022 08:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220503195605.4015616-1-robimarko@gmail.com> <20220503195605.4015616-2-robimarko@gmail.com>
 <YnLdTIKx80wszbj7@robh.at.kernel.org> <CAOX2RU5RMra4zj-jWZFH_fev-EavsnLnjob0z4FsaYnn8cs5gg@mail.gmail.com>
 <YnmDyDKhMlUkwJJY@robh.at.kernel.org>
In-Reply-To: <YnmDyDKhMlUkwJJY@robh.at.kernel.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 10 May 2022 17:58:15 +0200
Message-ID: <CAOX2RU5ZGPcH+3LspX=CPNXO+SEAHS+QqQY_+0Jh-MEzsjD4Xw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: clock: Add support for IPQ8074 APSS
 clock controller
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-clk@vger.kernel.org, dmitry.baryshkov@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2022 at 23:12, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, May 04, 2022 at 10:45:22PM +0200, Robert Marko wrote:
> > On Wed, 4 May 2022 at 22:08, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Tue, May 03, 2022 at 09:56:01PM +0200, Robert Marko wrote:
> > > > Add dt-binding for the IPQ8074 APSS clock controller which provides
> > > > clocks to the CPU cores.
> > > >
> > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > > ---
> > > > Changes in v2:
> > > > * Correct subject
> > > > ---
> > > >  include/dt-bindings/clock/qcom,apss-ipq8074.h | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > >  create mode 100644 include/dt-bindings/clock/qcom,apss-ipq8074.h
> > > >
> > > > diff --git a/include/dt-bindings/clock/qcom,apss-ipq8074.h b/include/dt-bindings/clock/qcom,apss-ipq8074.h
> > > > new file mode 100644
> > > > index 000000000000..df07766b0146
> > > > --- /dev/null
> > > > +++ b/include/dt-bindings/clock/qcom,apss-ipq8074.h
> > > > @@ -0,0 +1,14 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > >
> > > Dual license please.
> >
> > Hi Rob,
> > Krzysztof asked about this in v1, I have derived this off IPQ6018
> > binding which is marked GPL-2.0.
> > So, I was not sure if it was appropriate to mark it as GPL/BSD dual license.
> > If you say that its not an issue to dual-license, I will gladly do it.
>
> Technically, you should maintain it, but I don't think 2 defines is
> really enough to represent copyrightable work (but IANAL). I also know
> that QCom prefers the DT stuff to be dual licensed because they've
> raised the issue with me.

If that is the case, then I will dual-license it and send in v4 as I
am waiting for
the code portion to get some comments before resending.

Regards,
Robert
>
> Rob
