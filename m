Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD10B4F956D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbiDHMP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiDHMP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:15:57 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D625B140DDA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:13:49 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id g11so3499724qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 05:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Arewm4aQpx1cT2q4dPKQ3HPLjp07y7cA6oxjb8oJlW8=;
        b=VKgfA8yrFSFOJIddQ/PpANf1sfzrMGxijHDMvjVQx4hjCnWb9Ld4jB4oBtszl+ppQT
         QYqjR2pAjQju6o1gswuZmtFffh2m4gDg/g16gDI+t1OhuEOIvoR9X4CvOMXB03B1FASM
         UtA6slUL9gNiySX82qtdqEwk9fNSNbOwmJeHY+IH3ONgTmjvpefoY4AlpYQ8VbmzYTgz
         pRB/MDy1V90CpF9Xeqjio2ZJF3pCZizbOj1GV7RevgZeGXOMK5u8QiV4UT+lFefIaOEf
         6MEnDSJ3e8W26O2U3AmmuG7Kwb65WaDd9Qx2NiLTzNuzfk9Q4I9LOyONhNZ3T+hXIP+z
         xpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Arewm4aQpx1cT2q4dPKQ3HPLjp07y7cA6oxjb8oJlW8=;
        b=qsXe6G0YDRHKNtN5FzqK4fxBRL4evp/CxJDB6Vt9VALdPQXDeY61Dt6mRusa0S1LW+
         0bi+XsDeb4AhG8SzxHG/7fdXHcROIEXek2ecrOrMvbNwA3UmEf+dgxHvkKt6xofTlEQ+
         UUJa5XM+9GN+68WxmWtrwNXnJNpJaYSfLs9sy6ak+c9VCDxDnn1ux0XKlO3gSutH8Ts8
         eOE9LIYL0faxdYVG40M4sCjdFsR32P0xaTJ8YKrmKu7cBPk1tBtlcdZ3ybs6lYqmr/pJ
         kPSosITvk5jjjLBRoomioyvWpp8NVtT7RyE6/G62dIHJOVPxnjmNfj00nIVHQHmCPL1U
         JPUA==
X-Gm-Message-State: AOAM532BXJU4br36nJ1++f5lKqCD2yAhIoyF1+01ou9wR17C1aBFucgz
        H/BEb1z4So4uk5B2rC8tnERXnoe37gSWVgePcftCFQ==
X-Google-Smtp-Source: ABdhPJy5P9+4bfSCbB1onvnvwIp8rhXMjt0EzyPw6aJVpgHebQZIks1AUDZz/i0HFQXxvuXWYClnpcoYSSCUg+3xJqA=
X-Received: by 2002:a05:620a:28c7:b0:67d:6d4e:16ee with SMTP id
 l7-20020a05620a28c700b0067d6d4e16eemr12338727qkp.59.1649420028771; Fri, 08
 Apr 2022 05:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <1648656179-10347-2-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=X+QvjwoT2zGP82KW4kD0oMUY6ZgCizSikNX_Uj8dNDqA@mail.gmail.com>
 <392b933f-760c-3c81-1040-c514045df3da@linaro.org> <CAD=FV=W4PYK-t607yjRbfjDjjEZX0KdgHDRukw_vSH8E8EDH6w@mail.gmail.com>
 <CAA8EJppt9XONbgtKfmHmN+==QNqiVJeb8GKJFdZm=yyY-tgmHQ@mail.gmail.com>
 <CAD=FV=U5-sTDLYdkeJWLAOG-0wgxR49VxtwUyUO7z2PuibLGsg@mail.gmail.com>
 <CAA8EJppgfYgQjG8A4LsR-1wmBj3Ku3eO8cKfAYhxjWXL7e3eHg@mail.gmail.com>
 <CAD=FV=V=a1CnT8fqTJR40WoS3BaDQ3xZ=HnHVHqZh=MEmVUZBA@mail.gmail.com>
 <3e5fa57f-d636-879a-b98f-77323d07c156@linaro.org> <CAD=FV=Uibu-kZyix7K4_WVc-+C8xpzTqU4WFy7O=6sukMZrX5g@mail.gmail.com>
 <MW4PR02MB7186245772DAC3E04FA8D1C0E1E69@MW4PR02MB7186.namprd02.prod.outlook.com>
 <CAD=FV=Wk3U7_bVdiCPp8iQ4bcCA_Botemu4pwHeRtgBa3Xk6KQ@mail.gmail.com>
 <c4f086ce-c56f-f7c9-4092-7f2432330d50@quicinc.com> <CAA8EJprdV64jOexEF-XqbkwsNDWBNRRndOAas-QqMHaL=zp9rw@mail.gmail.com>
 <CAD=FV=XdRKWFQnJx9AKYmB2p26sXmhjqxLzz+LYyCt7rg+zF6w@mail.gmail.com>
In-Reply-To: <CAD=FV=XdRKWFQnJx9AKYmB2p26sXmhjqxLzz+LYyCt7rg+zF6w@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Apr 2022 15:13:38 +0300
Message-ID: <CAA8EJprvSy1PuYCXMr-TxBF1XwcAZaErSmzH2Tw5-NAovxHY7A@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] drm/msm/dp: Add eDP support via aux_bus
To:     Doug Anderson <dianders@chromium.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Sean Paul <seanpaul@chromium.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sean Paul <sean@poorly.run>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 at 03:28, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Apr 7, 2022 at 4:36 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > The ps8640 driver looks 'working by coincidence'. It calls
> > dp_aux_populate, then immediately after the function returns it checks
> > for the panel. If panel-edp is built as a module, the probe might fail
> > easily.
> > The anx7625 driver has the same kind of issue. The DP AUX bus is
> > populated from the probe() and after some additional work the panel is
> > being checked.
> > This design is fragile and from my quick glance it can break (or be
> > broken) too easy. It reminds me of our drm msm 'probe' loops
> > preventing the device to boot completely if the dsi bridge/panel could
> > not be probed in time.
>
> I did spend some time thinking about this, at least for ps8640. I
> believe that as long as the panel's probe isn't asynchronous.

By panel probe (as a probe of any device) is potentially asynchronous.
As in your example, the PWM might not be present, the regulator probe
might have been delayed, the panel-edp might be built as a module,
which is not present for some reason.

> Basically if the panel isn't ready then ps8640 should return and we'll
> retry later. I do remember the probe loops that we used to have with
> msm and I don't _think_ this would trigger it.

I don't have proof here. But as I wrote, this thing might break at some point.

> That being said, if we need to separate out the AUX bus into a
> sub-device like we did in sn65dsi86 we certainly could.

Ideally we should separate the "bridge" subdevice, like it was done in
sn65dsi86.
So that the aux host probes, registers the EP device, then the bridge
device can not be probed (and thus the drm_bridge is not created)
until the next  bridge becomes available.

-- 
With best wishes
Dmitry
