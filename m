Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B786509B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386966AbiDUIw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386980AbiDUIwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:52:54 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0832BF70
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:50:05 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id r189so7519771ybr.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1t5mUF1ebuEHByKOPa7jvd5uPJ4IKlhTRldMrpukDU=;
        b=X7X1O9iZdMtSeshylJiakmEOV4UCGYmtQG5/k2PnUtQR35LhOowY9T0zT0TZ7chMfw
         PfGEjARNnp5i4aK9OW15d4E4lmkPv0Vfa2+oFSvEzlbOUzewFHAWSTPyjUYccbN26eKB
         YEtp4B+p7iKbdk4d2wq3m84k/DDtbU/vgWpSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1t5mUF1ebuEHByKOPa7jvd5uPJ4IKlhTRldMrpukDU=;
        b=gYV0CGNPPgjCnmDxo2amZrOulyOkWZUbvpd+TXjsmIxKXUmkURK5FJ7hdmQjXfHYW/
         xJF5eu5al3/iDsXf49Q4lmBa8J1qxOzi5X5UIjWANmuKTjN1igCdjM7swSt/pxPUrHlr
         k1uNkPCYZPZ+l27QFF7RjkqnG+2FgOzLBbkN8dR0x1TmqQQ7C0gxMZufclP/OsJCgXA6
         AC8EMQ1b7O0wt6pYYTbv0zKd7hrdJKoeRnfhMqHSgOGX/LUnWX0fYRNJ8wxpV3uGO7bP
         ejYzTqwN4qAggdiVC7WtbGYnvRWiyujWTjIIRU6BdSKI1dpyTFFjXn7gvEEkdnGoMCJn
         53Ww==
X-Gm-Message-State: AOAM530rlFL1xF9p2NEn29OhL3aCJGd/Ty5KL0qQ966VP6wn9CXBGl9X
        1/9ry40h0jIA8jWVDVLDzfjH75tyG32fJooDX7HanA==
X-Google-Smtp-Source: ABdhPJyp/x2iHg2u/UbKD2umcDkFiw3TdbXVeOp6mmt8vzeFktbi6PtrjNtBzfFq1Myl4QMjaHUyxzECRA36CLqzFgs=
X-Received: by 2002:a25:2ac3:0:b0:645:36f4:2db3 with SMTP id
 q186-20020a252ac3000000b0064536f42db3mr12076194ybq.189.1650531004985; Thu, 21
 Apr 2022 01:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220414025023.11516-1-Nick.Fan@mediatek.com> <ee2f0819-8c9e-4160-c4ae-fb4ad0da3f3b@collabora.com>
 <b6509465-b7c7-0e66-071a-be85793cce58@arm.com>
In-Reply-To: <b6509465-b7c7-0e66-071a-be85793cce58@arm.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 21 Apr 2022 16:49:54 +0800
Message-ID: <CAGXv+5EhBB2LiQ_XL_ya7aceE7SBqZpjrbXe-gf81ed8qbeKBw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: Add DT schema for Arm Mali Valhall GPU
To:     Steven Price <steven.price@arm.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nick Fan <nick.fan@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org,
        alyssa.rosenzweig@collabora.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 8:47 PM Steven Price <steven.price@arm.com> wrote:
>
> On 14/04/2022 12:51, AngeloGioacchino Del Regno wrote:
> > Il 14/04/22 04:50, Nick Fan ha scritto:
> >> Add devicetree schema for Arm Mali Valhall GPU
> >>
> >> Define a compatible string for the Mali Valhall GPU
> >> for MediaTek's SoC platform.
> >>
> >> Signed-off-by: Nick Fan <Nick.Fan@mediatek.com>
> >
> > Hello Nick,
> > Unfortunately, this binding is completely wrong.
>
> I think that's unfair, although there is room for improvement.
>
> > First of all, there's no arm,mali-valhall driver upstream - this will be
> > managed
> > by panfrost later, yes, but right now there's no support.
>
> We need a binding agreed upon before support can be added.

+1. I asked them to send an updated binding for their hardware so that
we could have a discussion about it and converge on something.

> > Then, you're also setting opp-microvolt in a way that will never (or, at
> > least,
> > not anytime soon) be supported by the upstream driver, as it manages
> > only one
> > supply for devfreq scaling.
>
> The mt8183 binding (already in tree) is very similar. The binding also
> should be describing the hardware not what the driver supports. There
> are indeed limitations in Panfrost for supporting multiple supplies, but
> that's something that needs improving in the driver not a reason to
> block a (presumably correct) description of the hardware. I can't
> comments on whether the specifics of the mt8192 are correct.

Having an agreed upon binding also means that we can bring our downstream
driver into alignment, instead of having to maintain a device tree fork.

And +1 to being able to handle just one supply is a limitation of the
driver. Panfrost in its current state would just not enable devfreq
if more than supply is given [1]. Looking deeper, the OPP core currently
doesn't support more than one regulator for a given device.

> > Besides, please don't push bindings that have no upstream driver,
> > especially if
> > these are for downstream drivers requiring proprietary components, while a
> > completely open source implementation is in the works.
>
> More constructively, Alyssa has already posted a patch (as part of the
> series adding driver support) which would extend the existing Bifrost
> bindings to (pre-CSF) Valhall:
>
> https://lore.kernel.org/dri-devel/20220211202728.6146-2-alyssa.rosenzweig@collabora.com/
>
> I'm not sure I see the point of having a separate binding document for
> Valhall considering the (pre-CSF) hardware is the same from the kernel
> perspective.

So I suppose the next step should be to move the required MediaTek
specific changes into the existing binding instead of having a new
one?

Separately I think we would need a new binding to spell out the
requirements of MediaTek's two supply OPP table? Or maybe this could
be in the description of the Mali binding?


Thanks
ChenYu

[1] https://patchwork.freedesktop.org/patch/429782/
