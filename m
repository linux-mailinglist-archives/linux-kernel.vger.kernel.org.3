Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEE752F3CC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 21:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353255AbiETTcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 15:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353232AbiETTb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:31:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E9C195793;
        Fri, 20 May 2022 12:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0F9261B63;
        Fri, 20 May 2022 19:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98497C385AA;
        Fri, 20 May 2022 19:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653075118;
        bh=IJkerf8h8Ew+6kR4B+Gpq30axpkVygwfR6OjpOLtUAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n9VFEPVvA2qiNHEASgU/weCsZUX03ii5IfRkZrQ11dbwyb7dPD0KWwHzimK/c4wZm
         HV1UKs/KmqXFR3B4eTqmK0TsqWkrXa+NYYVpjHuNZxFRHfQys3iWT01IQcoumdx/ap
         KwH1aoTqr9zshKJMi7jB8ER4mfbVLR6xNUsksuMo=
Date:   Fri, 20 May 2022 21:19:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     monish.kumar.r@intel.com
Cc:     oneukum@suse.com, olebowle@gmx.com, davem@davemloft.net,
        wangjm221@gmail.com, chris.chiu@canonical.com,
        vpalatin@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, abhijeet.rao@intel.com
Subject: Re: [PATCH] Add USB_QUIRK_NO_LPM USB_QUIRK_RESET_RESUME quirks for
 Dell usb gen 2 device to not fail during enumeration.
Message-ID: <Yofpwy1/oe8FaKUb@kroah.com>
References: <20220520130044.17303-1-monish.kumar.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520130044.17303-1-monish.kumar.r@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 06:30:44PM +0530, monish.kumar.r@intel.com wrote:
> From: Monish Kumar R <monish.kumar.r@intel.com>
> 
> Found this bug on own testing
> 
> Signed-off-by: Monish Kumar R <monish.kumar.r@intel.com>
> ---
>  drivers/usb/core/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)

I have fixed this up by hand, but next time please run this through the
Intel open source review process first before sending it out so that I
will not have to fix up further patches.

thanks,

greg k-h
