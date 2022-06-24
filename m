Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA81D5596A9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiFXJao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiFXJaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:30:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A998F29817;
        Fri, 24 Jun 2022 02:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E48C62072;
        Fri, 24 Jun 2022 09:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48530C341C0;
        Fri, 24 Jun 2022 09:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656063037;
        bh=fCo+37lS9RXjimcPtcfJ1/CRyO6x8Ddi+h/sRG2BNaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ArdhgntWfBKlsSdoXNrsOKrWIlssbrOVvQZHAq/Cqgd1FmQ+aERFWtSIH9lpKOAcv
         AuN/6IQp4CaTeIUJQ6X1C8v/d4QgHLHOiAjVA5YixksNhh/5sEtujeBA33h15QtMBP
         FuD+nBpaksaAtO5EMFaTaTfsn8gSb5JV9JvbLp7tDfJ9RA2nY3lKmmsBhzEdIw7dqW
         5dmvKitBhspUNCsOxlYJzjpaoKmIGuBGyUSBQlqPExFwP/t6u5VA6cnCvMU7uMnMJG
         LdtjNh6OXbVNMmf/Gkg/epyBignacMDN6MSRX5jjLKcmG7qcs3oQGWUks1G62sPqFu
         mV9zD/uVhl+/g==
Received: by pali.im (Postfix)
        id 640A6711; Fri, 24 Jun 2022 11:30:34 +0200 (CEST)
Date:   Fri, 24 Jun 2022 11:30:34 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Marek Behun <marek.behun@nic.cz>,
        Josef Schlehofer <josef.schlehofer@nic.cz>
Subject: Re: [PATCH] powerpc: dts: Add DTS file for CZ.NIC Turris 1.x routers
Message-ID: <20220624093034.qcuodruw4e7b6tuy@pali>
References: <20220511143712.22550-1-pali@kernel.org>
 <877d5669mc.fsf@mpe.ellerman.id.au>
 <20220624082700.pzqm2wgrfpbukyfz@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624082700.pzqm2wgrfpbukyfz@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 June 2022 10:27:00 Pali Rohár wrote:
> On Friday 24 June 2022 13:08:59 Michael Ellerman wrote:
> > Pali Rohár <pali@kernel.org> writes:
> > > CZ.NIC Turris 1.0 and 1.1 are open source routers, they have dual-core
> > > PowerPC Freescale P2020 CPU and are based on Freescale P2020RDB-PC-A board.
> > > Hardware design is fully open source, all firmware and hardware design
> > > files are available at Turris project website:
> > >
> > > https://docs.turris.cz/hw/turris-1x/turris-1x/
> > > https://project.turris.cz/en/hardware.html
> > >
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > ---
> > >  arch/powerpc/boot/dts/turris1x.dts | 470 +++++++++++++++++++++++++++++
> > >  1 file changed, 470 insertions(+)
> > >  create mode 100644 arch/powerpc/boot/dts/turris1x.dts
> > 
> > The headers say you Cc'ed this to the devicetree list, but I don't see
> > it in the devicetree patchwork:
> > 
> >   https://patchwork.ozlabs.org/project/devicetree-bindings/list/?state=*&q=turris&archive=both
> 
> Email is on the devicetree list:
> https://lore.kernel.org/linux-devicetree/20220511143712.22550-1-pali@kernel.org/
> 
> > Which means it hasn't been run through Rob's CI scripts.
> > 
> > Maybe try a resend?
> > 
> > cheers

Now I sent V2 and it appeared in devicetree list archive too:
https://lore.kernel.org/linux-devicetree/20220624085550.20570-1-pali@kernel.org/
