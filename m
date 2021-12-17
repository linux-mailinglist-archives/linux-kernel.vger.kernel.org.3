Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E5D479225
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbhLQQ6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239458AbhLQQ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:58:53 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A56C061574;
        Fri, 17 Dec 2021 08:58:52 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b7so10223046edd.6;
        Fri, 17 Dec 2021 08:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vsfyTSsZXnb8YFLDp9DXpw54wOCxRQbig7zQ+ANnizQ=;
        b=WH68yNdwElHQtQBp2UMfSr5Z3AbVf2bvQXcwkWvif3H+GKJZUjDwFqkFQADfTY0l8R
         l/I1oV0fyu57fy5iTnJhJI2rW/T4f9nZPATMz3Qt+KqiTi/PN0/7CLWx5is73ZG/tbvI
         FxkufHGtcEOY4uA5VMlaPaCXLvtjFpovLDfqsyS0aq/DLDDKqWT5V8iPM63rsuhR3b8r
         De20lVMg/c4VHJ/KoAVZZS3PlojjX6FwUzDUfAR8mhmT2mIuiNBAhKLLbNFEJnc7ALLU
         PegE3xWidCgrs9G3MNAHmmUw2Bt867k81kPvfSB/IZNhtd1nPAg63maqWjuqzthVby8q
         fsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsfyTSsZXnb8YFLDp9DXpw54wOCxRQbig7zQ+ANnizQ=;
        b=BfHDoS5ojwi2WvunWU2pX8yZIuH/zCYAiU86WD8u1/Df5VDYNy5WBESesaoHoMA8Fk
         zk0+hYAmzoA6BvgR7EdL7C7ny5twaUMjMdEWk2F2cyuftbLYAS6TSloHAjnlBKxPA+Au
         z7tAT/3aZnNkdipOm0bPr2m15QS9I7kSchfNnbUX2TuG8Mo0AQmfw0tOfhM9eps6bCKT
         YcQlHupQCYUNsMKKEgsnoj6KnrQCY9pYU6T0OHHqdmM2IXOH0DeBOUBy9Iy/K/QfgHuo
         cWHeOkXER5TY3L1typ9qjtbWlRkbSwfpDeMN+POEPqtFxKUiD8Owc1OLoWlkj+aCOL83
         kARg==
X-Gm-Message-State: AOAM531DV8h72FmAt6lEjOyNSxS41elgUwV6FwLsqbBFviXVZva/RfZP
        ViPUvImqygyreNaVcSU+TtgfpGlmA6PV7YxFf48=
X-Google-Smtp-Source: ABdhPJzfuhs2MIMFH7GqxdAEbfgZfa+fRQFJvFICdtNlgGJZh/YU8sC06yyhF+1k1DKuhFfzcnFVoOG7OT5zMkga/ls=
X-Received: by 2002:a17:907:2d12:: with SMTP id gs18mr3234648ejc.198.1639760331172;
 Fri, 17 Dec 2021 08:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20211215004626.2241839-1-aford173@gmail.com> <20211217031305.GP4216@dragon>
In-Reply-To: <20211217031305.GP4216@dragon>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 17 Dec 2021 10:58:40 -0600
Message-ID: <CAHCN7xLqE_JWNt0L0KD-MMK-3pSKpCRrQtA+azPntM80vEfrNg@mail.gmail.com>
Subject: Re: [PATCH V5 0/9] arm64: imx8mn: Enable more imx8m Nano functions
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 9:13 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Tue, Dec 14, 2021 at 06:46:17PM -0600, Adam Ford wrote:
> > The i.MX8M Nano is similar to the i.MX8M Mini in some ways, but very
> > different in others.  With the blk-ctrl driver for Mini in place,
> > this series expands the blk-ctrl driver to support the Nano which
> > opens the door for additional functions in the future.  As part of
> > this series, it also addresses some issues in the GPCv2 driver and
> > finally adds support for enabling USB and GPU.
> >
> > V5:  Clean up the GPU clock assignments.
> > V4:  Rebase on top of [1] which fixes hangs caused from CSI and DSI reset
> >      and add the same fixes for CSI and DSI to the Nano
> > V3:  Fixes an the yaml example
> > V2:  Fixes the clock count in the blk-ctrl
> >
> > [1] - https://www.spinics.net/lists/arm-kernel/msg936266.html
> >
> > Adam Ford (9):
> >   soc: imx: gpcv2: keep i.MX8MN gpumix bus clock enabled
> >   soc: imx: gpcv2: Add dispmix and mipi domains to imx8mn
> >   dt-bindings: power: imx8mn: add defines for DISP blk-ctrl domains
> >   dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
> >   soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
> >   arm64: dts: imx8mn: add GPC node
> >   arm64: dts: imx8mn: put USB controller into power-domains
> >   arm64: dts: imx8mn: add DISP blk-ctrl
> >   arm64: dts: imx8mn: Enable GPU
>
> The series introduces hard dependency between different branches.  To
> ease the merge process, let's postpone the DTS patches to the next
> cycle.

That's fine.
Do I need to resubmit later, or will you take care of it when the next
merge window opens?

adam
>
> Shawn
