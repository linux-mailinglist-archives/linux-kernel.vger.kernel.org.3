Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BB9559566
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiFXI1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiFXI1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:27:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4176177044;
        Fri, 24 Jun 2022 01:27:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD308B827C9;
        Fri, 24 Jun 2022 08:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECC3C34114;
        Fri, 24 Jun 2022 08:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656059223;
        bh=qpDM01dkJCwqn/oXRRFbVvx6B5RLwkKav9j/47BwKzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iVZe6EOwT7Vr2kotm/nhThp0vfeufoCzz4OV9j8zFTJy4GjU7PJL3W9rm5wcG9tM0
         T218W6rtYAuPiC7nD4/vGmB5J9o2dL2/v8Q7FrIMi5G8X4x1AIWhdgYX6ik7dRQjKZ
         TQqzp3xBEfckduVe6+c/17YTVihXSCSZCM7v4u5Y71bkAZtGiYmBF89K0gPeGH5c4M
         BppFcY4j/4AtzdYBpTKWwD26liQ12TaKDA9+40kkVRTxym/heXH1FEx0kPJsg67+Qx
         dm/YfWtgHWawRrfeTrIl4BI2EpD2j2a+PvJDwdqpy1kWmd+UZOX+dWvE6JethmJzHh
         cH+Y4VRcKDdNA==
Received: by pali.im (Postfix)
        id 416C1711; Fri, 24 Jun 2022 10:27:00 +0200 (CEST)
Date:   Fri, 24 Jun 2022 10:27:00 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Marek Behun <marek.behun@nic.cz>,
        Josef Schlehofer <josef.schlehofer@nic.cz>
Subject: Re: [PATCH] powerpc: dts: Add DTS file for CZ.NIC Turris 1.x routers
Message-ID: <20220624082700.pzqm2wgrfpbukyfz@pali>
References: <20220511143712.22550-1-pali@kernel.org>
 <877d5669mc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877d5669mc.fsf@mpe.ellerman.id.au>
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

On Friday 24 June 2022 13:08:59 Michael Ellerman wrote:
> Pali Rohár <pali@kernel.org> writes:
> > CZ.NIC Turris 1.0 and 1.1 are open source routers, they have dual-core
> > PowerPC Freescale P2020 CPU and are based on Freescale P2020RDB-PC-A board.
> > Hardware design is fully open source, all firmware and hardware design
> > files are available at Turris project website:
> >
> > https://docs.turris.cz/hw/turris-1x/turris-1x/
> > https://project.turris.cz/en/hardware.html
> >
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  arch/powerpc/boot/dts/turris1x.dts | 470 +++++++++++++++++++++++++++++
> >  1 file changed, 470 insertions(+)
> >  create mode 100644 arch/powerpc/boot/dts/turris1x.dts
> 
> The headers say you Cc'ed this to the devicetree list, but I don't see
> it in the devicetree patchwork:
> 
>   https://patchwork.ozlabs.org/project/devicetree-bindings/list/?state=*&q=turris&archive=both

Email is on the devicetree list:
https://lore.kernel.org/linux-devicetree/20220511143712.22550-1-pali@kernel.org/

> Which means it hasn't been run through Rob's CI scripts.
> 
> Maybe try a resend?
> 
> cheers
