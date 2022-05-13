Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8549F525B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351077AbiEMGaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243588AbiEMGaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540662927AE;
        Thu, 12 May 2022 23:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E318761E21;
        Fri, 13 May 2022 06:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD347C34114;
        Fri, 13 May 2022 06:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652423418;
        bh=IOn/pOV0AeF2oNjVCjrm6Xgmh353s7FLlJ25r2Ka6zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VPZEiXfhCuwNBuoRiAUpiEUdfHlLpkqgYv95yllk28UssbGWuIh+OOWIAOU9H+P8/
         lu8j1U8nS1FzsVmlJc6CXOQ2AFY+BdDCOsA2t7pWXMkzBOz5zECgiAwoOPeGxXmxxT
         Hk6OfykZLEbJBoo9Qnw2+epDHM1AN0b7Uo+Jiq3g=
Date:   Fri, 13 May 2022 08:30:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 5.18-rc7
Message-ID: <Yn368twGLV1CW7Xi@kroah.com>
References: <Yn32DMmVNRmT0zz2@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn32DMmVNRmT0zz2@hovoldconsulting.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 08:09:16AM +0200, Johan Hovold wrote:
> The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:
> 
>   Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.18-rc7

Pulled and pushed out, thanks.

greg k-h
