Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF1A4CC59B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 20:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiCCTH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 14:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiCCTH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:07:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5C419D751;
        Thu,  3 Mar 2022 11:06:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D097F61A8A;
        Thu,  3 Mar 2022 19:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F4FC340F3;
        Thu,  3 Mar 2022 19:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646334401;
        bh=2BtpIBsXVCJxVQ/oh3K2FgXEMXiekUDLQX9xD2gdbLM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o2c+ye5BqYrayS6wcIkhykEd9oMUM08fnMBunZ6ubqX+UPCADV0E3K1UilobnxEPQ
         sjmgxT04DSYUChMdCZVaAVyy6CXFMzPmUDVfXCOHmMz1U7anuFgSLwFqFWWlO6vpm/
         Ibuza1+FbskVwliS18eABoFLCDlTEAmnkV7CiQX7bG0YpjPE8COYneNTvKag0LoL5G
         c4OqdEIfpQaaAiypnu9/cZpft0YHLK88txfnlhsoopUuEcX1UIDkDqZgGS03IL5Mn1
         zqj05azs8MVzTuDztpZrpkyYk5qi0sb4Td1zcAw+k3CjFcSFYw7+6ijKAIPw82Etxz
         DW+fCwyHjboxg==
Received: by mail-ed1-f43.google.com with SMTP id q17so7878712edd.4;
        Thu, 03 Mar 2022 11:06:41 -0800 (PST)
X-Gm-Message-State: AOAM533+fFcS5jz4NiB3e3Sv6PMbcD1sMv/j2t9RTsYMeiOcyVRjKUSS
        ukmku3Z0jTr2+zzBJZAWmeQc/vwG3WH+gRVCdQ==
X-Google-Smtp-Source: ABdhPJwEoJqO4GxeRtl4C7IV0N8/KXSt+tovp2KwzQmA0QQzU7BNoyVpkRvxSAPAd3L4v7UJIYii2bTAUw20bGdm/cM=
X-Received: by 2002:a05:6402:4384:b0:413:9e36:b56f with SMTP id
 o4-20020a056402438400b004139e36b56fmr25115772edc.280.1646334399480; Thu, 03
 Mar 2022 11:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20220215081334.788419-1-peng.fan@oss.nxp.com> <Yhj9joQkgTswMVcs@robh.at.kernel.org>
 <DU0PR04MB94172264E2DCE759EE3B9A3688019@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB94172264E2DCE759EE3B9A3688019@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 3 Mar 2022 13:06:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL_02Gw6hw59NdH_rCDmwy5f+OrCsifmuNkxo2OgTYnYg@mail.gmail.com>
Message-ID: <CAL_JsqL_02Gw6hw59NdH_rCDmwy5f+OrCsifmuNkxo2OgTYnYg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: fsl-lpuart: Add imx93 compatible string
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 6:44 PM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Rob,
>
> > Subject: Re: [PATCH] dt-bindings: serial: fsl-lpuart: Add imx93 compatible
> > string
> >
> > On Tue, Feb 15, 2022 at 04:13:34PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > The lpuart on i.MX93 is derived from i.MX8ULP with some industrial
> > > enhancements, it uses three compatible strings, so update the
> >
> > Looks like it's 2 compatible strings...
>
> Oh, yes. i.MX8ULP/7ULP is same uart IP.
>
> >
> > > compatible string for i.MX93. But for a few instants,
> >
> > s/instants/instances/
> >
> > > DTR_B, DSR_B, DCD_B and RIN_B pins are supported, so use one
> > > compatible string fsl,imx93-lpuart-v2
> >
> > If the differences are just what gets pinned out, then I think the differences
> > should be handled with separate properties. We probably already have some.
> >
> > Plus, while you may have all the above signals, a board design may still only
> > use a subset.
>
> It is SoC integration level with above features not support in some instances,
> so no such signals connected to SoC pin.
>
> Saying LPUART IP itself support DTR/DSR/DCD/RIN, but instance A has the
> feature disabled when doing SoC integration, instance B has the feature enabled
> when doing SoC integration. What's your suggestion with such case?

Unless it changes the register interface in a non-compatible way that
the driver needs to know about, I would not do a different compatible.
For example, register offsets change.

Rob
