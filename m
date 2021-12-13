Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76038473749
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243512AbhLMWNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:13:02 -0500
Received: from mail-oo1-f54.google.com ([209.85.161.54]:36516 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240321AbhLMWNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:13:01 -0500
Received: by mail-oo1-f54.google.com with SMTP id g11-20020a4a754b000000b002c679a02b18so4521515oof.3;
        Mon, 13 Dec 2021 14:13:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v31tC0qcXxxYSS5IAXi+fFNTSzyMQMvXUgj4HBbpB4s=;
        b=Hn2xIoOnAlWP4DOGtwIofHL6cSQYN+9PUhuWj3T8ZHjA1gW4ucsvvCNJTMuPTodFdc
         ZK6Cn+6o4EbsvxFS0soVKNN6aP8l+FWvNcZimEt8FtOqC0s1264W5bR85I5T7uSbvxBt
         w7DzvlL+3BN075uxfGgSA0SQEosKtFl66986Kw3A7zxna0qqw6pN2Kyw038SM4XOXq/9
         yfYlGldkcOA7i7Pij/HsKSBeDdcgh29UpZOziuS7yTJrg/pLkBgtYuVOJCRlMldQhi6H
         o2CIqHVYQfWDbFh1s/3HI0XF0koWkj6fCkWd5Dgo/1S/EL0SDirTRFI3Vszswc7Mba7B
         i/xA==
X-Gm-Message-State: AOAM531QK3Wy+r5h3XX9iToUEL1ePf0+Q1BKjpoBWcmakbjEFR9FYXk8
        PS+bdSsKrZYPUHhU8Xjf5Q==
X-Google-Smtp-Source: ABdhPJyoWRvOl7qwZ15fGEuQyJZC7Vyl3dPCG8dI/QJaP4EFkV31Coa80PW1/AfVeUfTbrb6R7KHQQ==
X-Received: by 2002:a4a:ea84:: with SMTP id r4mr825457ooh.13.1639433580298;
        Mon, 13 Dec 2021 14:13:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o19sm3074085oiw.22.2021.12.13.14.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:12:59 -0800 (PST)
Received: (nullmailer pid 1670034 invoked by uid 1000);
        Mon, 13 Dec 2021 22:12:58 -0000
Date:   Mon, 13 Dec 2021 16:12:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     arnd@linaro.org, heiko@sntech.de, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/5] dt-bindings: Powerzone new bindings
Message-ID: <YbfFapsmsjs4qnsg@robh.at.kernel.org>
References: <20211205231558.779698-1-daniel.lezcano@linaro.org>
 <CAL_Jsq+JgudbhJVyGWB0RJ2LPQ6xZFJ7TxWzjNtWXky-kCxA4Q@mail.gmail.com>
 <1cdd9874-9ea7-ad1c-1351-8729453cd478@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cdd9874-9ea7-ad1c-1351-8729453cd478@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 07:29:43PM +0100, Daniel Lezcano wrote:
> 
> Hi Rob,
> 
> thanks for taking the time to review the bindings.
> 
> On 07/12/2021 20:58, Rob Herring wrote:
> > On Sun, Dec 5, 2021 at 5:16 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> The proposed bindings are describing a set of powerzones.
> >>
> >> A power zone is the logical name for a component which is capable of
> >> power capping and where we can measure the power consumption.
> > 
> > How is the power consumption measured? I don't see anything in the
> > binding allowing for that.
> 
> Mmh, good point.
> 
> It is based on the energy model which is built from the
> "dynamic-power-coefficient" but this one provides only for CPUs and GPUs
> ATM.

That's more a calculated power than measured. Measured implies some h/w 
or firmware interface, but there isn't one it seems.

Wouldn't anything with "dynamic-power-coefficient" be a powerzone 
implicitly?

> In the future, SCMI will provide get/set power/level
> 
> What would you suggest?
>
> >> A power zone can aggregate several power zones in terms of power
> >> measurement and power limitations. That allows to apply power
> >> constraint to a group of components and let the system balance the
> >> allocated power in order to comply with the constraint.
> >>
> >> The ARM System Control and Management Interface (SCMI) can provide a
> >> power zone description.
> > 
> > Instead of DT?
> 
> It can use DT or SCMI protocol. That is what I understood from the white
> paper [1] page 6
> 
> Lukasz may confirm / elaborate ?

Do you mean the 'performance protocol'? Because we have a binding for 
that too! And that is exactly the problem. No one, AFAICT, looks at
all aspects of power/performance/thermal together.


> >> The powerzone semantic is also found on the Intel platform with the
> >> RAPL register.
> > 
> > That means nothing to me...
> 
> The Running Average Power Limit [2]. Each powerzone has a RAPL register
> where you can read the power and set the power limit.
> 
> >> The Linux kernel powercap framework deals with the powerzones:
> >>
> >> https://www.kernel.org/doc/html/latest/power/powercap/powercap.html
> >>
> >> The powerzone can also represent a group of children powerzones, hence
> >> the description can result on a hierarchy. Such hierarchy already
> >> exists with the hardware or can be represented and computed from the
> >> kernel.
> >>
> >> The hierarchical description was initially proposed but not desired
> >> given there are other descriptions like the power domain proposing
> >> almost the same description.
> >>
> >> https://lore.kernel.org/all/CAL_JsqLuLcHj7525tTUmh7pLqe7T2j6UcznyhV7joS8ipyb_VQ@mail.gmail.com/
> >>
> >> The description gives the power constraint dependencies to apply on a
> >> specific group of logically or physically aggregated devices. They do
> >> not represent the physical location or the power domains of the SoC
> >> even if the description could be similar.
> >>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>    V3:
> >>      - Removed required property 'compatible'
> >>      - Removed powerzone-cells from the topmost node
> >>      - Removed powerzone-cells from cpus 'consumers' in example
> >>      - Set additionnal property to false
> >>    V2:
> >>      - Added pattern properties and stick to powerzone-*
> >>      - Added required property compatible and powerzone-cells
> >>      - Added additionnal property
> >>      - Added compatible
> >>      - Renamed to 'powerzones'
> >>      - Added missing powerzone-cells to the topmost node
> >>      - Fixed errors reported by 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> >>    V1: Initial post
> >> ---
> >>  .../devicetree/bindings/power/powerzones.yaml | 97 +++++++++++++++++++
> >>  1 file changed, 97 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/power/powerzones.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/powerzones.yaml b/Documentation/devicetree/bindings/power/powerzones.yaml
> >> new file mode 100644
> >> index 000000000000..ddb790acfea6
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/powerzones.yaml
> >> @@ -0,0 +1,97 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> > 
> > New bindings should be dual licensed (add BSD-2-Clause).
> > 
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/power/powerzones.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Power zones description
> >> +
> >> +maintainers:
> >> +  - Daniel Lezcano <daniel.lezcano@linaro.org>
> >> +
> >> +description: |+
> >> +
> >> +  A System on Chip contains a multitude of active components and each
> >> +  of them is a source of heat. Even if a temperature sensor is not
> >> +  present, a source of heat can be controlled by acting on the
> >> +  consumed power via different techniques.
> >> +
> >> +  A powerzone describes a component or a group of components where we
> >> +  can control the maximum power consumption. For instance, a group of
> >> +  CPUs via the performance domain, a LCD screen via the brightness,
> >> +  etc ...
> >> +
> >> +  Different components when they are used together can significantly
> >> +  increase the overall temperature, so the description needs to
> >> +  reflect this dependency in order to assign a power budget for a
> >> +  group of powerzones.
> >> +
> >> +  This description is done via a hierarchy and the DT reflects it. It
> >> +  does not represent the physical location or a topology, eg. on a
> >> +  big.Little system, the little CPUs may not be represented as they do
> >> +  not contribute significantly to the heat, however the GPU can be
> >> +  tied with the big CPUs as they usually have a connection for
> >> +  multimedia or game workloads.
> > 
> > Can't most of this just be assumed. We have some DT data already for
> > capacity and power per mhz along with opp tables. Isn't that enough
> > information?
> 
> We have a lot of information already and that is the reason why there is
> few information in the description ATM. We need to describe what is a
> powerzone and the constraints hierarchy between the powerzones.
> 
> The hierarchy could be in the hardware and immutable like the RAPL as
> described above which has a RAPL per package, per memory and one on top
> of them reporting their energy consumption.
> 
> Here we want to describe how we want to aggregate the powerzones, so the
> power constraints will be hierarchically described.
> 
> > The correlation with CPU and GPU usage is totally workload dependent
> > which has nothing to do with DT. 
> 
> I was probably unclear, IMO it is platform specific.

We can debate that, but it shouldn't come down our opinions. Where are 
the multiple platforms that show this is different and that we must 
describe the difference?


> For example, let's imagine we have a *thermal* sensor between the Bigs
> and the GPU. There is no way to know which one is contributing and how
> to mitigate them.

So once the h/w is not sharing a thermal sensor, we don't need the 
powerzone binding and go back to thermal zones? Sounds like thermal 
zones need to be extended to work without a sensor.

> But if we know the sustainable power for the big+gpu is eg. 5000mW, then
> we can group them under the same powerzone parent and set its power to
> the sustainable one. From there it is possible to ensure the power limit
> and act on the power for each of them.
> 
> > Nor it is platform specific really.
> 
> The problem is we have devices which are powerzones (CPU, GPU, screen
> backlight, memory, DSP, ...) and AFAICT they can be described in the DT
> as such (may be just with a property), right?

Right, I would think that is "dynamic-power-coefficient" plus an OPP 
table for the devices.

> Unfortunately, we have only a part of the description because we don't
> have the relationship between them. Can this relationship be described
> in the DT?

I'd rather see this taken as far as possible without DT and when things 
don't work across multiple platforms look at what needs to be in DT.

Or say the interface must be SCMI and that has to provide everything you 
need. It wouldn't be the first Arm spec that had to be revised because 
the DT binding was rejected (FF-A).

Rob
