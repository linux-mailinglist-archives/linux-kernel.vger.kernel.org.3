Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999B1487B4A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348477AbiAGRVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiAGRVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:21:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F388C061574;
        Fri,  7 Jan 2022 09:21:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4F12611B1;
        Fri,  7 Jan 2022 17:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BF6C36AEB;
        Fri,  7 Jan 2022 17:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641576107;
        bh=R4m7g3AlfOH+TrxVDcGPDb1ic2Lz8Nne1NVo+cQ1N/o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D7ng5rOcjMyaXcNKxaIPMKpFqGcvu6GCEIbmCgIT5S5jb7hxZ/FEzUejsUMX9iSyv
         8WqQryhnACz2lpDOYCJhR5PbwKdm/hpkB3ouNWukJjHObWVPRjQs8OeBG4y4yuBY7L
         JmQbGnIFTdqF54ZCRMEoLdvV6rsNvm8RF6Qo98/nRuD1FXM8T329C4p59DeUOmQ9r5
         lgO5k3ePiACXqjqGsVRb4PRuWtkzUyJdupWeJfafjciPKbeNu4jL33taBlXoHSuDl7
         qDZVWAEUTS5wLFHs4EhZWb1eH0ayl33PWMTvQFJph1sNUhx1s5a4jHQQ6Tf/9+H/pU
         RURBia/lyIgqQ==
Received: by mail-ed1-f46.google.com with SMTP id c71so13149001edf.6;
        Fri, 07 Jan 2022 09:21:47 -0800 (PST)
X-Gm-Message-State: AOAM531j+Nxw2MsVvUkY0tP4FNkrs9V51hvx4qr/zuMq6yWEbBbEPTeT
        ZfP/WqGTVu0poZUwO+PU9VP0rgA/dgEzLK6M7Q==
X-Google-Smtp-Source: ABdhPJwSri5klnWOlYutuBDglAE7lCy6dumP313wBQDYBZdCdr17gajDIZeXx9w5rXYDTz8oEGTgDGoIWRFYjpl+2g0=
X-Received: by 2002:a17:906:7945:: with SMTP id l5mr50449077ejo.82.1641576105689;
 Fri, 07 Jan 2022 09:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20220107030457.2383750-1-robh@kernel.org> <642312db-4af8-7087-45bf-e86923396038@ti.com>
 <762335b1-d6a2-64d2-75a1-f865cd557098@ti.com>
In-Reply-To: <762335b1-d6a2-64d2-75a1-f865cd557098@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 7 Jan 2022 11:21:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL85KE-WjBO1hkxw_VQdLTwZd8Bu0LzUaNXoABVoqK0TQ@mail.gmail.com>
Message-ID: <CAL_JsqL85KE-WjBO1hkxw_VQdLTwZd8Bu0LzUaNXoABVoqK0TQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: remoteproc: ti: Fix the number of mailboxes
To:     Suman Anna <s-anna@ti.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nagalla, Hari" <hnagalla@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 8:17 AM Suman Anna <s-anna@ti.com> wrote:
>
> On 1/7/22 8:13 AM, Suman Anna wrote:
> > Hi Rob,
> >
> > On 1/6/22 9:04 PM, Rob Herring wrote:
> >> Based on the example, the TI K3 DSP and R5 have 2 mailboxes, but the schema
> >> says 1. Fix the schema.
> >
> > No, 1 is correct. The OMAP Mailbox binding uses #mbox-cells as 1 and not 0, and
> > uses a phandle as the cell-value.

That's unfortunate. Really, ti,mbox-tx/rx should have been the mbox
cells with 2 entries (rx and tx)...

>
> The following is what you get with your current patch,
>
> Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.example.dt.yaml:
> dsp@4d80800000: mboxes: [[4294967295, 4294967295]] is too short
> Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.example.dt.yaml:
> dsp@64800000: mboxes: [[4294967295, 4294967295]] is too short

Ugg, yes. What I'm working on is getting validation on dtb files to
work. That means the dts <> are lost and we have to either parse the
properties properly (look up #foo-cells) or use __fixups__ to find
unresolved phandles (the case for most examples). The latter works
most of the time except a few cases like above. So the fix here is to
add a mbox provider node to the example.

Rob
