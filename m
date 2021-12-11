Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173B3471602
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 21:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhLKUFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 15:05:33 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59138 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhLKUFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 15:05:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 99857CE0A68;
        Sat, 11 Dec 2021 20:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BE0C341C3;
        Sat, 11 Dec 2021 20:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639253128;
        bh=qeCm/LKaezkiKrTscTfvAMTl8B5t7FsCgi2rQzCUItE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=puBnUmRFUOjWrx+LwEOma2RsAt0l+p/1YivjU5rXFjlecFvUcUAgULA95uSYH2oQm
         FDFpIXZfLf5kmjwUnC9ts/GCuXLoBmIbPQqccT9rdqjYfp7P87nk2jyQ7obvC+zsZ+
         gVvOjaLHALfo7rvIPDkZhQxyW+bvfRQem0+jYvgNaXOUXo+VwTHcUG2mbq1d3tdEYG
         pD+jemFrpzvk1l1L3T8kqwiJaG2I3+Z+JVE2zI1HVYDpnjg+Lya4vHoztPKM0hCblb
         og6uJmLNCxd+AWMTeDDFma/20SAPr0m+ytn4x4/BIl2J7sSd6auhmcujAjl+nqm6lP
         XRLdtDQiYPYng==
Received: by mail-ed1-f51.google.com with SMTP id w1so39871307edc.6;
        Sat, 11 Dec 2021 12:05:28 -0800 (PST)
X-Gm-Message-State: AOAM530tDusrGFYtIX4bUJPt4jy4XrO2s1nGlH4LyGf23BQHu2MmY/M5
        MNy+EUJ26VeboeurWVNVJMBD8ITJ9Zsx7KifUQ==
X-Google-Smtp-Source: ABdhPJz6oQ9/ea55Af7SWA6OUXDM4KBuM9Bev/q3Uf53wZn1RxRMeyn57YfpSjZuONVgP96T1zkE3DQebWnJ1Q7LP+0=
X-Received: by 2002:a05:6402:440f:: with SMTP id y15mr50056378eda.22.1639253126974;
 Sat, 11 Dec 2021 12:05:26 -0800 (PST)
MIME-Version: 1.0
References: <20211125144053.774-1-olivier.moysan@foss.st.com>
 <20211125144053.774-2-olivier.moysan@foss.st.com> <1637875562.357461.2858318.nullmailer@robh.at.kernel.org>
 <237f56b3-0597-2526-a182-f1fbdd327338@foss.st.com> <Yaf4jiZIp8+ndaXs@robh.at.kernel.org>
 <627777a4-7458-88ed-e7c5-d11e3db847b5@foss.st.com>
In-Reply-To: <627777a4-7458-88ed-e7c5-d11e3db847b5@foss.st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 11 Dec 2021 14:05:15 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+ZVU=DR0vXq6YOsrK9-MoUp5DJ6RKHmtL-ZGSxQ7qyJQ@mail.gmail.com>
Message-ID: <CAL_Jsq+ZVU=DR0vXq6YOsrK9-MoUp5DJ6RKHmtL-ZGSxQ7qyJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ASoC: dt-bindings: stm32: i2s: add
 audio-graph-card port
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc:     Olivier MOYSAN <olivier.moysan@foss.st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 7:52 AM Alexandre TORGUE
<alexandre.torgue@foss.st.com> wrote:
>
> Hi Rob
>
> On 12/1/21 11:34 PM, Rob Herring wrote:
> > On Fri, Nov 26, 2021 at 11:25:27AM +0100, Olivier MOYSAN wrote:
> >> Hi Rob,
> >>
> >> On 11/25/21 10:26 PM, Rob Herring wrote:
> >>> On Thu, 25 Nov 2021 15:40:50 +0100, Olivier Moysan wrote:
> >>>> The STM2 I2S DAI can be connected via the audio-graph-card.
> >>>> Add port entry into the bindings.
> >>>>
> >>>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> >>>> ---
> >>>>    Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 5 +++++
> >>>>    1 file changed, 5 insertions(+)
> >>>>
> >>>
> >>> Running 'make dtbs_check' with the schema in this patch gives the
> >>> following warnings. Consider if they are expected or the schema is
> >>> incorrect. These may not be new warnings.
> >>>
> >>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> >>> This will change in the future.
> >>>
> >>> Full log is available here: https://patchwork.ozlabs.org/patch/1559750
> >>>
> >>>
> >>> audio-controller@4000b000: 'port' does not match any of the regexes: '^port@[0-9]', 'pinctrl-[0-9]+'
> >>>     arch/arm/boot/dts/stm32mp157a-dk1.dt.yaml
> >>>     arch/arm/boot/dts/stm32mp157c-dk2.dt.yaml
> >>>
> >>
> >> This warning is not a new one.
> >>
> >> The i2s2 node in stm32mp15xx-dkx.dtsi would require the following binding:
> >> port:
> >>      $ref: audio-graph-port.yaml#
> >>      unevaluatedProperties: false
> >>
> >> However the spi binding requires to introduce a unit address:
> >> patternProperties:
> >>    '^port@[0-9]':
> >>      $ref: audio-graph-port.yaml#
> >>      unevaluatedProperties: false
> >>
> >> The warning can be removed by re-ordering the bindings patches in the serie,
> >> as "additionalProperties: true" makes the check more tolerant on extra
> >> properties.
> >
> > That's never right.
> >
> >> The patch "ASoC: dt-bindings: stm32: i2s: add audio-graph-card port" can
> >> even be merely dropped.
> >> So, I suggest to resend the serie without audio-graph-card patch.
> >
> > Only if you aren't using audio-graph-card.
> >
> >>
> >> Does it sound too permissive to you ?
> >
> > I think perhaps you need to combine the schemas into 1. Or you need to
> > restructure your dtsi files such that you only add spi specific
> > properties when spi mode is enabled and only add i2s specific properties
> > when i2s mode is enabled. Or use the /delete-property/ directive.
>
> Initially the aim of this series was to fix a "make W=1" warnings seen
> on spi and i2s nodes (duplicate unit-address). Moving both nodes in a
> common node + using a different compatible depending on SPI or I2S usage
> sounded good) but it is not enough. In this series the common node is
> named as following: "spi2s2: spi@4000b000". It is fine for a spi usage
> but if we want to use this "common node" with I2S compatible and
> specific bindings, the node name remains spi@... and then specific spi
> checks are done. For this with this series applied we got this issue
> reported by spi-controller.yaml:
>
> spi@4000b000: port@0: 'compatible' is a required property
>
> So, if we use two separates nodes we got W=1 warning and if we use a
> common node we got yaml check issue. One possibility would be to use a
> common node with a new node name (for example i2spi@...) but I think it
> is not acceptable.

It is acceptable, see this thread[1].

Rob

[1] https://lore.kernel.org/all/20211203183517.11390-1-semen.protsenko@linaro.org/
