Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E30959FF52
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbiHXQTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238311AbiHXQTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:19:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD296D9F0;
        Wed, 24 Aug 2022 09:19:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B1C861997;
        Wed, 24 Aug 2022 16:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CBEC433C1;
        Wed, 24 Aug 2022 16:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661357948;
        bh=pY8JHDREC75sNrXhPI6q8iQHeDHUSgsIfDGggArlwvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i4Cns/GsLAaIkCRjutxVqlgHv7RfcbNBrq6yCjf8ICjrtTD4xYrPZwI5zQWaf5rM/
         f4YIaHxuYjgRwiOBcyZ7w0uqDIOBIgAITHIh1WQZFUmvkwIBMNmT0tGpDxWJBifq8u
         L6VWQT5avu7XO3V88o4rTWcLi/EZD38xb54rI7Bg=
Date:   Wed, 24 Aug 2022 18:19:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     JFLF <jflf_kernel@gmx.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: add quirks for Lenovo OneLink+ Dock
Message-ID: <YwZPeZJ7bbxlWpw+@kroah.com>
References: <20220824160946.10128-1-jflf_kernel@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824160946.10128-1-jflf_kernel@gmx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 06:09:46PM +0200, JFLF wrote:
> The Lenovo OneLink+ Dock contains two VL812 USB3.0 controllers:
> 17ef:1018 upstream
> 17ef:1019 downstream
> 
> Those two controllers both have problems with some USB3.0 devices,
> particularly self-powered ones. Typical error messages include:
> 
>   Timeout while waiting for setup device command
>   device not accepting address X, error -62
>   unable to enumerate USB device
> 
> By process of elimination the controllers themselves were identified as
> the cause of the problem. Through trial and error the issue was solved
> by using USB_QUIRK_RESET_RESUME for both chips.
> 
> Signed-off-by: JFLF <jflf_kernel@gmx.com>

We need a real name, sorry, please use what you sign documents with.

thanks,

greg k-h
