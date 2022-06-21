Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D315534A3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351816AbiFUOg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351476AbiFUOgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E766920BEA;
        Tue, 21 Jun 2022 07:36:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8319F6168D;
        Tue, 21 Jun 2022 14:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7A8C3411C;
        Tue, 21 Jun 2022 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655822183;
        bh=9hzVJBmXejWxqKoWbTYAA5mBykUEAvY+19xhKlfx+aM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h9XH0EAkI74XOBgpK92u1iqaQqlF0Y5PaZFC9rX4RJWOuJSVJ6268ltKh196Uo5Do
         geb/cdM+8qvDgcfiue/PulRRVnhw2W3dZY5G1/hdVBDtVESzt5DuTuguC5gtAaJ4Z1
         hfwKwY5OmnlhzASl4GhLJFBvltZK70nVMaEJ/qQU=
Date:   Tue, 21 Jun 2022 16:36:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Bin Liu <b-liu@ti.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 0/2] Add support for PolarFire SoC's musb controller
Message-ID: <YrHXZYe4e4vlCHh3@kroah.com>
References: <20220613114642.1615292-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220613114642.1615292-1-conor.dooley@microchip.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 12:46:41PM +0100, Conor Dooley wrote:
> Hey Bin, Greg,
> Short series here adding support for USB on Microchip PolarFire SoC FPGAs.
> The kconfig dependency for INVENTRA_DMA has become a bit of a mouthful,
> is there a better way of dealing with that?
> Thanks,
> Conor.
> 
> Changes since v1:
> - Drop unneeded resource copying as per Rob's changes to the other drivers
> - Drop the dts patch
> 
> Conor Dooley (2):
>   usb: musb: Add support for PolarFire SoC's musb controller
>   MAINTAINERS: add musb to PolarFire SoC entry
> 
>  MAINTAINERS               |   1 +
>  drivers/usb/musb/Kconfig  |  13 +-
>  drivers/usb/musb/Makefile |   1 +
>  drivers/usb/musb/mpfs.c   | 265 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 279 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/usb/musb/mpfs.c
> 
> 
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> -- 
> 2.36.1
> 

Any chance you can get your company to fix up their email settings:

Grabbing thread from lore.kernel.org/all/20220613114642.1615292-1-conor.dooley%40microchip.com/t.mbox.gz
Analyzing 4 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✗ [PATCH v2 1/2] usb: musb: Add support for PolarFire SoC's musb controller
  ✗ [PATCH v2 2/2] MAINTAINERS: add musb to PolarFire SoC entry
  ---
  ✗ BADSIG: DKIM/microchip.com
---
Total patches: 2

If I didn't know better, I would think you were spoofing the address...

thanks,

greg k-h
