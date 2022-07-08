Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D0256B9DA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbiGHMiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbiGHMil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:38:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1B91180B;
        Fri,  8 Jul 2022 05:38:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 08FD9CE2A7E;
        Fri,  8 Jul 2022 12:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C22C341C0;
        Fri,  8 Jul 2022 12:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657283915;
        bh=5h6p+C2YCmoTHZKEs1ifkYD/9q78xN4MnVC5rO6q8gI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cT4QujeKTMaCqkogk6RL+mlv917FcMdplNnTbIeFaNVPhWChN79HjaUOQanR73cYx
         n1L/IgJYsKT9JuRR1dAnq2JzlXpBxpWVFs7edgFasAV8cIrA1qgfSHuDWrc3FEwUX4
         cxUIR+lW2NPni3q7r0g5QlLxMvyti8GnFDCggtFM=
Date:   Fri, 8 Jul 2022 14:38:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev, bleung@chromium.org,
        heikki.krogerus@linux.intel.com,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v3 1/9] usb: typec: Add support for retimers
Message-ID: <YsglSJvB/bvwSGZ2@kroah.com>
References: <20220707222045.1415417-1-pmalani@chromium.org>
 <20220707222045.1415417-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707222045.1415417-2-pmalani@chromium.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 10:20:08PM +0000, Prashant Malani wrote:
> Introduce a retimer device class and associated functions that register
> and use retimer "switch" devices. These operate in a manner similar to
> the "mode-switch" and help configure retimers that exist between the
> Type-C connector and host controller(s).
> 
> Type C ports can be linked to retimers using firmware node device
> references (again, in a manner similar to "mode-switch").
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

As you are adding things to sysfs, do you need to add any
Documentation/ABI/ entries as well?  I can't see any new sysfs files
being created here, but explicitly saying so in the changelog here would
be good.

thanks,

greg k-h
