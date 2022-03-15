Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93E34D9D29
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349063AbiCOOPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349062AbiCOOP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:15:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDAA506E1;
        Tue, 15 Mar 2022 07:14:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53E63B81683;
        Tue, 15 Mar 2022 14:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A83C340E8;
        Tue, 15 Mar 2022 14:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647353648;
        bh=AntXOmmORieoC8es+8HghRbUp736ryeXNRnqon591Wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MaXhJhLcG7oVUPJawpWRTIEfw+5QmIPD9f0vIzXPwvKcRwY1Fu7rY12jGEncxfyoZ
         DuDJQ34U2rKWRjsawaiv9nOrPMdICVcpcalwYT2EFxfbx9vzMClJFiwPnJ9zlR8BKN
         1jDWY9/mI56+IJZrkVHLFZwmj4X7Cz+y15XAg6XE=
Date:   Tue, 15 Mar 2022 15:13:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        NeilBrown <neil@brown.name>, DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        erkin.bozoglu@xeront.com, linux-staging@lists.linux.dev,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: dts: ralink: add MT7621 SoC
Message-ID: <YjCfEeIMuhXwfZnj@kroah.com>
References: <20220315132836.1062-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220315132836.1062-1-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 04:28:36PM +0300, Arınç ÜNAL wrote:
> The MT7621 system-on-a-chip includes a 880 MHz MIPS1004Kc dual-core CPU,
> a 5-port 10/100/1000 switch/PHY and one RGMII.
> 
> Add the devicetrees for GB-PC1 and GB-PC2 devices which use MT7621 SoC.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
> I'm not sure which repository/branch this patch is supposed to be applied
> to. This patch does changes on top of commit dcd520af4eac ("staging:
> mt7621-dts: fix cpuintc and fixedregulator dtc warnings, fix xhci") which
> is currently applied on gregkh/staging.git staging-next branch.
> 
> Arınç
> 
> ---
>  MAINTAINERS                                           |  7 +++++++
>  arch/mips/boot/dts/ralink/Makefile                    |  4 ++++
>  .../mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts     |  0
>  .../mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts     |  0
>  .../mips/boot/dts/ralink}/mt7621.dtsi                 |  0
>  arch/mips/ralink/Kconfig                              |  5 +++++
>  drivers/staging/Kconfig                               |  2 --
>  drivers/staging/Makefile                              |  1 -
>  drivers/staging/mt7621-dts/Kconfig                    | 11 -----------
>  drivers/staging/mt7621-dts/Makefile                   |  5 -----
>  drivers/staging/mt7621-dts/TODO                       |  5 -----
>  11 files changed, 16 insertions(+), 24 deletions(-)
>  rename drivers/staging/mt7621-dts/gbpc1.dts => arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts (100%)
>  rename drivers/staging/mt7621-dts/gbpc2.dts => arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts (100%)
>  rename {drivers/staging/mt7621-dts => arch/mips/boot/dts/ralink}/mt7621.dtsi (100%)
>  delete mode 100644 drivers/staging/mt7621-dts/Kconfig
>  delete mode 100644 drivers/staging/mt7621-dts/Makefile
>  delete mode 100644 drivers/staging/mt7621-dts/TODO
> 

I can take this if the MIPS maintainers say it's good to go.

thanks,

greg k-h
