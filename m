Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0417A4CAD75
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244364AbiCBSZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiCBSZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:25:20 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E061B939A2;
        Wed,  2 Mar 2022 10:24:36 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id g26so5108572ybj.10;
        Wed, 02 Mar 2022 10:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k8trmR3Q/wKgFOlN56Zfs9MLMD2hMa6/k0WKIWBkMmM=;
        b=EI7PKbxWvSqGp9xJmAzLPWSp5Tf1E04s3YrH5kSS7z6m+CKHqqpxsF1gSsptgTcOcP
         s92pTtvsM1mPJlvaG7OtmwhLVLwZj/9riUWO8vLV72/BDvSjj+rvsO4KlqLXBNUW4Wsa
         jbDq62016TJkK8q8iZwUdEaU8qe40kqrghh1GqvbX7Gq9mSUMvDVyO2JYFjrLH+dgaWW
         Y5We2GXHWVHPyr3pLLn9QNykj6paKj5xfYDElWRybIvDGi28yatztI44TWmZoRTGxIOm
         KD8BRSfnehZMnzHlXWDkmeocicXx0K2iD3tCxtfS7nu6euo1LBpEkcv4z7KEzBURG8od
         fj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8trmR3Q/wKgFOlN56Zfs9MLMD2hMa6/k0WKIWBkMmM=;
        b=daJorFwjgxktax5gKKTbXn2lQEQSsLM/+gBcWMQshs5uCXjk2oEcrgOKwwK7cLkDrl
         vukbkgMFoi2yEgW/oPJh1CBTzEfn+P7qMeItVmqIag1BjcK0BtFrHvEYq+vb+6NwbvCn
         PAxFjNrP7Qb/oQlhKg6iqw7YHKy2o5uHwYLFVAIV7rPMBmC22LrhypF4XSrZaOBsjp9d
         1c6rBaRjLlJO0GYQIrjbvwnHTIdFyj9CJUlroKUL0efGJqQohPzIVlQYLVCSdCNxeHFV
         WVGOOxQVoP0iFR0hsgDseca6jOH/Z9vxoll3fuG8R2wOTsOefwnwWQ2dSESq6YppcRlO
         SdBQ==
X-Gm-Message-State: AOAM531hM0BF0h5FvkukP1MqPtZPV0TPeu4cvYRrO6WQhA2Mm1i9jX9R
        KzX3lY1bUt5rYYhiE5EebiL1V7CNIJBByBn7iO4=
X-Google-Smtp-Source: ABdhPJztt2OEDdgAGfUkeMuakEtvQlotuosKn6RGHzjaJ0yQIJbh4vJafHCFX3KRfLld0T8niouzFGhLQs3ATA6lq9o=
X-Received: by 2002:a5b:dc8:0:b0:624:a898:dea6 with SMTP id
 t8-20020a5b0dc8000000b00624a898dea6mr29475925ybr.600.1646245476111; Wed, 02
 Mar 2022 10:24:36 -0800 (PST)
MIME-Version: 1.0
References: <20220302143427.447748-1-vkoul@kernel.org> <CAL_JsqJMZ8PHqJk6drNbNHprmfeV9UvJzJnech7sz_JwcdbckA@mail.gmail.com>
 <Yh+l7+7zDvI/9e6n@matsya> <CAMdYzYoVz4wk-EhfxQdwu9FqRg8Vj-HGMFG+CFjfsHeM8HcnNQ@mail.gmail.com>
 <CAL_JsqL1cYyU=LCmEn=dEk712CECpxj8sUWrwpi8_XpoaXEQig@mail.gmail.com>
In-Reply-To: <CAL_JsqL1cYyU=LCmEn=dEk712CECpxj8sUWrwpi8_XpoaXEQig@mail.gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 2 Mar 2022 13:24:24 -0500
Message-ID: <CAMdYzYqMgoOKuBw9gKuybcoGxiGYtwf3aA07C9Mqvq2gjB47rw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Revert "dt-bindings: soc: grf: add naneng
 combo phy register compatible"
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Wed, Mar 2, 2022 at 12:34 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Mar 2, 2022 at 11:25 AM Peter Geis <pgwipeout@gmail.com> wrote:
> >
> > On Wed, Mar 2, 2022 at 12:14 PM Vinod Koul <vkoul@kernel.org> wrote:
> > >
> > > On 02-03-22, 11:04, Rob Herring wrote:
> > > > On Wed, Mar 2, 2022 at 8:34 AM Vinod Koul <vkoul@kernel.org> wrote:
> > > > >
> > > > > This reverts commit b3df807e1fb0 ("dt-bindings: soc: grf: add naneng
> > > > > combo phy register compatible") as that was wrongly merged, so better to
> > > > > drop the wrong patch
> > > > >
> > > > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > > > ---
> > > > > I am applying this to phy-next to fix the issue
> > > >
> > > > Reverting will just cause a different warning that it is undocumented.
> > >
> > > Right, but a patch for that would fix that
> > >
> > > > The fix in the other thread won't apply either if you revert.
> > >
> > > It is not applying for me, so that needs to be updated anyways..
> >
> > It seems phy-next has fallen out of sync with -next.
> > It's missing this patch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/Documentation/devicetree/bindings/soc/rockchip/grf.yaml?h=next-20220302&id=7dbb47d64acf4aac131a2aaade726913aa62abe7
>
> That is not how things work. linux-next is a tree that no one can
> apply patches to (in the worst case like this one). It's useful for
> integration testing and a shortcut for getting a maintainer's tree,
> but should not be the basis for patches to the lists. You should
> generally use the last rc1 or a maintainer's tree when there is a
> known dependency. Using a stable base means 'git am -3' works and the
> merge tools work rather than git just failing to apply anything.

I apologize, as I'm not the progenitor of the original patch or the
merge conflict I'm missing insight here.
My series is dependent on patches that were pulled in several trees
and the only place they are all currently available is in -next.
I attempted to correct the merge issue in my series, but I don't know
how I would do so when it needs to be based on multiple trees to be
correct.

I will wait until this all settles down and resubmit based on 5.18-rc1

Respectfully,
Peter

>
> Rob
