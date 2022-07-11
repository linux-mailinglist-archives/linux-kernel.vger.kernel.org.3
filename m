Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1DA570CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiGKVlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKVl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:41:29 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997F381499;
        Mon, 11 Jul 2022 14:41:28 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31cac89d8d6so62959787b3.2;
        Mon, 11 Jul 2022 14:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MGQCeiIJ9AkmyNDZxDCtYHiqmGwukNQ4DHAac7Z7dc4=;
        b=Gzf8ZoxNXFao+pfJzNKD/BL7s8RFfEPS4e4a2ewPMQcDpkmcBRIXf3rZ3mDJlZY0N+
         2AJ92hmYwpdWt17ZJaw7UMDluNKW716g5ZeqTdMR/Dx/cHAyx5O1FdsleAAWA/el1guQ
         OOYq+1jknAI/bSZyOst3ZKGyvZAab/U05/n16v9ja147pP0pfCzo7slrztjP0TFbCJSF
         LpWxVp/IIQKZJAerSj4txJMPjq9Zv7kX7SAJ+fjNPt4Y3aik7wXJArELI0HYJiNeNBBf
         9OlRPAWYtDBKW+ogf742khp9G2FzQbLDf5EjW3SEm66NdSS8yyVz8UVncDyTLOwicFAW
         mwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MGQCeiIJ9AkmyNDZxDCtYHiqmGwukNQ4DHAac7Z7dc4=;
        b=hmmGULRnjeeRnqqZoqGMHrvtIf6JoIaI76Nrs5Q+ZbPVW1Wc3RtBLN/g3/voWsyG9u
         bQa5XPCIcU/H3tm1hAyk7uoHSiQ/KhE4CUz5vTDLH9Uc9yksHNQRAj72jQUTFWIVGGl+
         +n4n2Wf/B0XQnLyXIs+e+Fk4Ux69TQHIsai+1Tce67gb3jBE9kPhH/5ZM3XvWTJeqmFE
         rNtQDLza5mf0nabnuJI5u73XEoIMEDLcXXQ5qrJHFDL/zv5ANELT6qsEW97Jd0q6JjYa
         rHt8sk+qj+C6ZgtWUJtJbvDBy1ogzwsNFE4m/usg+EAsKNEKUq73uHtNO62u2+yyIXTL
         P9HQ==
X-Gm-Message-State: AJIora/ITsoqmrkxDiiLaoMgKooC3peKzqQl7FK8iBjxfjTsk56/VGGh
        2PPy5HRZMVKc0y7fl/G2UOieGhWKCH5tQcHyDV8=
X-Google-Smtp-Source: AGRyM1sVCVwsBnMatLyX5AazmHesbMbDuTsAbayrrc0I/ovjc4BUKGYM1zNyjREDPwwKBO2sKj6a5J6SynN049zYr6k=
X-Received: by 2002:a81:4986:0:b0:31d:388b:d08d with SMTP id
 w128-20020a814986000000b0031d388bd08dmr16920977ywa.185.1657575687825; Mon, 11
 Jul 2022 14:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220705163136.2278662-1-vincent.knecht@mailoo.org>
 <CAHp75VfwoSqLZVbsN3DduP=SEKvr=tSfmxF1MTnYma0zh-JsXQ@mail.gmail.com>
 <e17913649e255d91bc357d3ab3e70957d05493e6.camel@mailoo.org> <CAHp75VdcT4TRZU_w-cntTt3jYTnwADcUo055vWLM8xrkWTXChg@mail.gmail.com>
In-Reply-To: <CAHp75VdcT4TRZU_w-cntTt3jYTnwADcUo055vWLM8xrkWTXChg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 23:40:50 +0200
Message-ID: <CAHp75VdNW0v2G=6HSQMkQp7iPNT3Fh8mqT4iuJg44FZmzxAdVg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] leds: Fix/Add is31fl319{0,1,3} support
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 11:39 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Jul 9, 2022 at 11:51 AM Vincent Knecht
> <vincent.knecht@mailoo.org> wrote:
> > Le mardi 05 juillet 2022 =C3=A0 20:57 +0200, Andy Shevchenko a =C3=A9cr=
it :
> > > On Tue, Jul 5, 2022 at 6:32 PM Vincent Knecht <vincent.knecht@mailoo.=
org> wrote:
> > > >
> > > > v3:
> > > > - pick up Rob's R-b for patches 1 and 2
> > > > - reinstate bindings docs license and maintainer
> > > >   changes with Nikolaus agreement
> > > > - took Andy's comments on patch 4 into account
> > >
> > > Thanks for the update. Nothing serious, but a few comments.
> > >
> > > Also a question here. Do you have plans to convert it to use device p=
roperties?
> >
> > Hi Andy, and thank you for the reviews.
> > Just sent a v4:
> > https://lore.kernel.org/linux-leds/20220709094642.4078222-1-vincent.kne=
cht@mailoo.org/
> >
> > As for converting to device properties, it will take me some more time
> > since I'm not too familiar with the concepts and how to do it exactly.
>
> I just sent a series [1] which is based on the top of yours. You can
> rebase it (it fixes a couple of subtle bugs: 1) GPIO error messaging
> during error probe, and 2) mutex destruction is out of order) or
> handle it together with yours. It seems you possess hardware, so I
> assume you at least can test it.

...missed link...

[1]: https://lore.kernel.org/linux-leds/20220711213524.3587-1-andriy.shevch=
enko@linux.intel.com/

> > Got some hints from git history, will look into that.
> > Also I'd like to add blink support...

--=20
With Best Regards,
Andy Shevchenko
