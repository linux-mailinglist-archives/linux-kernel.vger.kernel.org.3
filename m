Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290D84ADAFC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351005AbiBHORQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351022AbiBHORL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:17:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE85C03FECE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:17:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 593F361227
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 14:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD37C004E1;
        Tue,  8 Feb 2022 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644329829;
        bh=GK8zL7bCJXUu6YBd8ARaHTZaT8YLbCB64RKltU4JUTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sJMlrQOu2pPNdZDw0l5vjkifH8fFo7/LATREK55pEiqV57421UXftgQ75PSt+uM09
         d5hR8nCqsrYtte6hbTosbbwTuSkerdGk5jDcFbBZwL00uZoQLGYm5WTPnbS5Uvk0WL
         gK3eFrlDIhPGl/6XXNiLwc3L6J002BpJqTkJr6gI=
Date:   Tue, 8 Feb 2022 15:17:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ankit Kumar Pandey <itsankitkp@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed stylegude error in drivers/staging/rtl8712 by
 removing un-needed commented out lines
Message-ID: <YgJ7YhsyPVpdBt2J@kroah.com>
References: <YgJ5t1/Cn93qtBAE@ankit-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgJ5t1/Cn93qtBAE@ankit-vm>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 07:39:59PM +0530, Ankit Kumar Pandey wrote:
> Volatile keyword was left commented out as it was probably used during
> development but was not needed in final build.

Are you sure?  Doesn't it convey some meaning here that needs to be
verified before you remove it?

> And this was causing styleguide error, so I have removed this and there
> for this patch reduces minor styleguide warnings to 0

You can not mix coding style fixes like my bot told you :(

Also the subject line for this change is very odd, look at others for
this same file to see examples of what to do:

$ git log --oneline drivers/staging/rtl8712/rtl871x_pwrctrl.h | head -n 5
9be550ee4391 staging: rtl8712: get rid of flush_scheduled_work
c75afdaf2e53 staging: rtl8712: remove extra blank lines
7c93fdf090df staging: rtl8712: r8712_register_cmd_alive(): Change return values
e24c1f8658c9 staging: rtl8712: add SPDX identifiers
b355da4c7cfb Staging: rtl8712: rtl871x_pwrctrl.h - style fix

thanks,

greg k-h
