Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2CE5150FA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356101AbiD2QkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbiD2QkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:40:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC9F60E1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:36:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z16so7368343pfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4AhDhjWUwI2Tn5CahkqmhzJNHD5HQcuQ3C3nm662LO4=;
        b=ZdRUbmRvvcg9rqXLGiCVN4eDpXjZirOYZwfuSdri1DmaLsbHCUPYz6ditV4Zh+OsTJ
         YGEOxkRyT2umQVM4d3EC5TRftA2vZA7CCMPb/dJuLWr2JJn/6IM+cZlnyLjA99ssGnTM
         PF/XhOhPhl5uQon8mcIc4DGAXcNQzIy73bbr6hMdSIfkQa1E2Lz/oQae6x2f14hs0u/i
         5kaM2F5OJjOoLpdPoM4Q26Q6YrbAbHoVLxDSPeoB5yIH7eg7e/b69sIA/8y+ArOZpsHM
         8+K4/oMDpE19FdyJmwB9JXMDAXPHmVaqFqW57oXMQMYnZclzHNnVsXveR4xdcxBmubDB
         8fNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4AhDhjWUwI2Tn5CahkqmhzJNHD5HQcuQ3C3nm662LO4=;
        b=L4rtRVXYhGQMomnI43Kd2SarM07DhlNnfXVaYSRcC6eK11k0mBXuS3gOOR65QdzL0m
         FFJYGdU0Nc9Lkh6MhB2tkC9u8CdwaaFaTRbBVcrCQqCKeRlB7kXF14e1MN1lOSwz4O/q
         YzAuIgGKm62R9zoq/EcEfvgpMsQ2OlIHGP/i2reAM863R/N4M6QVWk6fojlhje8jkcrq
         1Qe9XuxHl0GdRSjEuaXdwFWxPXHVeekqlRUzkcQBriA9iUKHX/miDMD8P0Lk6VKbUtsV
         tCGn4DbztMuYr6SeBhMS6TD7kvmXQOOJA+J9oY3RWIKdNIZuw3+vxOe0xryaj4TQ47yZ
         qiRw==
X-Gm-Message-State: AOAM5318e4eRg3f0o9iVRjcW315gInqS/JKWQ278184id/QRBDQrlkrl
        iJ7vy+sdKpP5N3aM6TBYDj0yUELRRmQWOEtlrGMFHw==
X-Google-Smtp-Source: ABdhPJw+o86C+wUIMV8SACUxDWyPWaJYaJvHGulqCMpaWQRoUSS6ySuQi0M4o7t89bMyCN4zDSo+e5KI1gU6qCVR3Fo=
X-Received: by 2002:a63:194b:0:b0:3ab:71e5:161 with SMTP id
 11-20020a63194b000000b003ab71e50161mr184626pgz.115.1651250209745; Fri, 29 Apr
 2022 09:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220429161347.7947-1-tharvey@gateworks.com> <CAOMZO5Do-Vy_s4m99uUTnL1sdJUhghjzZJKp4V-SG4rAK=kTzg@mail.gmail.com>
In-Reply-To: <CAOMZO5Do-Vy_s4m99uUTnL1sdJUhghjzZJKp4V-SG4rAK=kTzg@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 29 Apr 2022 09:36:38 -0700
Message-ID: <CAJ+vNU0Lhgo1Hz_BtbEJb+JPbHj8UWtf5hm1uA0b=H5SeKi3Kg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mm-venice-gw7902: fix pcie bindings
To:     Fabio Estevam <festevam@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 9:18 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Tim,
>
> On Fri, Apr 29, 2022 at 1:13 PM Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > Update the pcie bindings to the correct dt bindings:
> >  pcie_phy:
> >   - use pcie0_refclk
> >   - add required clock-names
> >  pcie:
> >   - remove pcie_phy clock as it comes from phy driver
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>
> It seems you missed the Fixes tag.
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Fabio,

it didn't really 'fix' anything but dt syntax. PCIe works without this patch.

Best Regards,

Tim
