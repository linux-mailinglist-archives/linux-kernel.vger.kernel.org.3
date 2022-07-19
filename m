Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4066F579F60
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbiGSNRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243428AbiGSNRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:17:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88B0C6CB7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:33:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED9AC609FB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD69DC341C6;
        Tue, 19 Jul 2022 12:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658234010;
        bh=zMjMlllVXscrTLNHeZlKujE+ppPXXBHLhhQnH2WdWto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=imxImUOsaU0Ko+4DaRV05N1SyAnPI24Yi3FaBc+lajx6fgzUX6P4sAuEkPwhOcgdu
         ZV5lSvkqSsgkwW7X9/bGHs18f2Ghakm8e+fLqXlSI9iOQP/n4weAs1WqWLa83Ee821
         Vc2LwFpNz/MuysRW2Ntb4qzs2iI1xGkav/R46PH4=
Date:   Tue, 19 Jul 2022 14:17:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linux Phy <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: Generic phy updates for v5.20
Message-ID: <Ytag21DYusQ1S6qs@kroah.com>
References: <YtY8Ggzsqa1MwjL5@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtY8Ggzsqa1MwjL5@matsya>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 10:37:38AM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive Generic phy updates for v5.20. This contains
> bunch of new support for devices in existing drivers, as well as new
> drivers. Also the big Qualcomm qmp phy cleanup is part of this pull
> request.
> 
> The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:
> 
>   Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.20
> 
> for you to fetch changes up to 08680588d340eaad2d5028d6f24a055a118d4e7e:
> 
>   dt-bindings: phy: mediatek: tphy: add compatible for mt8188 (2022-07-15 17:20:04 +0530)

Pulled and pushed out, thanks.

greg k-h
