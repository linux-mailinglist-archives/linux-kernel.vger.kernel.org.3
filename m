Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD37C580A32
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 06:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbiGZEDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 00:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiGZEDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 00:03:00 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD322A24E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 21:02:59 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31f1d1c82c8so36930717b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 21:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B35ZTE2adzguA+KA+PCVmrFGgSP+8khovmRbpkdhlpk=;
        b=iCdcCg7dM7MrFzki/3KEbQYMzTmQgc9+qWJAZrNU8ELqn0bE3XgMEc1d2okpbiVLZ+
         6GDIDf1M6474U1hs605YAbEATDzljM+GguLrWnC/0MReW8WUUI/rjOo2uG1R4JD4nwmd
         dQFWCaW1ru1zC9yXCYQ8og8B/ViW4imjyb9yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B35ZTE2adzguA+KA+PCVmrFGgSP+8khovmRbpkdhlpk=;
        b=Q64zexHx+TI54VNRjKHC5UYqiILy3dPG3+G5lNGqX/d/HI7y1AluTFIdfyF/YfZ2C1
         mFWMnS+mpYDCSg01IzLBVXeMIZBII6+cOda3kaXBZskbatQPN6WEGJ2JpvvEhGL0G5Z/
         C0kKUIszC6FM1qBz4T/5mUZkDuVTnMS1rqS+GZcmjnoq/Z7Xb3TRWyF19pl8Rq0nORCI
         7XAsdxWek0sOuo8TB2Obum1+aqTYavP2sIBq/BWfDsSVI7+sCy8P5iy+04a6EoPHjFNT
         IlV3hNc2k2Wv6rwCfz3/zJYc8/gPuEZb1XOGwkATlSoid3mrGsl8tIQoX3BtViYOFJWV
         IRWw==
X-Gm-Message-State: AJIora8zmtfDzQH3e10U65riQIMcILbxuWK1MOxOexFWfXaXI+5z609P
        95+ik1xUkVNwC4fgdiGgRXAwG68nw5hSUmTnU8uAaA==
X-Google-Smtp-Source: AGRyM1vmWMY8rCSkbeemY4WorPmrRFiCRux9K2cC6nnBK7+bevjeA5pxMFdDx99a/rivPkSWyE2mHoHOJfMxvnIXARo=
X-Received: by 2002:a0d:d90f:0:b0:31e:5401:8533 with SMTP id
 b15-20020a0dd90f000000b0031e54018533mr28793ywe.167.1658808178849; Mon, 25 Jul
 2022 21:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220721145017.918102-1-angelogioacchino.delregno@collabora.com>
 <20220721145017.918102-7-angelogioacchino.delregno@collabora.com>
 <CAGXv+5E+6aCz3dxsfCqZAOkcmqDp0YWngsv-OZ23NDYhuZSfHw@mail.gmail.com> <f3027153-860f-7ffc-b4a0-ff2a43100cf4@collabora.com>
In-Reply-To: <f3027153-860f-7ffc-b4a0-ff2a43100cf4@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 26 Jul 2022 12:02:48 +0800
Message-ID: <CAGXv+5EkQ_CmhHGTkJ4DfmRUZnKw3XaJ0qUvQHG8=qxXPUPY9w@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] arm64: dts: mediatek: cherry: Enable DSP, audio
 codec and sound card
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 6:49 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 25/07/22 12:44, Chen-Yu Tsai ha scritto:
> > On Thu, Jul 21, 2022 at 10:53 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> All machines of the Cherry platform have a working DSP (integrated
> >> into the MT8195 SoC), and audio support, some with a different audio
> >> codec: specifically, some using Realtek's RT5682I and some RT5682S.
> >>
> >> Write a configuration for all the audio bits to enable functionality.
> >
> > I think we're still missing some code for SOF that implements the
> > machine_select() callback, plus the firmware has to be fetched from
> > the ChromeOS rootfs.
> >
> > It might make sense to have SOF disabled for now. Removing the adsp
> > reference and the overriding dai-link entry from the sound node
> > should do the trick.
> >
>
> Uhm... I think that we should either have audio, with DSP, or not have it
> at all... the userspace configurations will differ, so we'd end up with
> two different confs of which one will get unused and cluttering the ucm2
> conf git.

You're right. I haven't even figured out which ones to pull in.

> At this point, I think that the most sensible option is to either omit
> this commit, or keep audio disabled until the machine_select() callback
> gets in...

Agreed.

ChenYu
