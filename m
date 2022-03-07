Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D4D4D0A67
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 22:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245611AbiCGV67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 16:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbiCGV65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 16:58:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A274276E01;
        Mon,  7 Mar 2022 13:58:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 087A960C4A;
        Mon,  7 Mar 2022 21:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F66C340E9;
        Mon,  7 Mar 2022 21:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646690281;
        bh=VIEe/YIxsXmJE6OBdQQbW8Qf5uUIPWWQHBapo3sm8cM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhMGwffiH2LHTxiTcA9ljW72Uijy1EVU7TlGrwlJwX/wSG2oGsLsBWXe9iwmVbHC5
         GLST8LECDuWZKaVeq+5t28T9pgHMHILRFw0lcnpYBOiaiUsq71vSYSqb7ovlnL9Cf4
         86Rpj38uxwKVgbFgNWJ/vKnyNiWk1nbPn7q05kwU=
Date:   Mon, 7 Mar 2022 22:57:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Max Staudt <max@enpas.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v3] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <YiZ/5WaNHhaONjX1@kroah.com>
References: <20220307214303.1822590-1-max@enpas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307214303.1822590-1-max@enpas.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 10:43:03PM +0100, Max Staudt wrote:
> +    sudo ldattach \
> +           --debug \
> +           --speed 38400 \
> +           --eightbits \
> +           --noparity \
> +           --onestopbit \
> +           --iflag -ICRNL,INLCR,-IXOFF \
> +           29 \
> +           /dev/ttyUSB0

I think you mean "30" here, not "29", right?

thanks,

greg k-h
