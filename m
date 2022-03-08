Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38C34D150C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345960AbiCHKrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345929AbiCHKrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:47:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC22142EC8;
        Tue,  8 Mar 2022 02:46:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64D8261584;
        Tue,  8 Mar 2022 10:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D7AC340F7;
        Tue,  8 Mar 2022 10:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646736395;
        bh=IKXUYtmKjsKoAjOIxL2cGHVYl7X2/wSeAGkMxrw6wbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2HgbNvC3Zl7sd8IKCk+IBar9B5vPyQwHEDCQKWfVOSPk3Z85YuSayYAQC/6l5dKxT
         Nw5PuSjss76hIwTLRNo0BeNQSaRwgX1E50WTH3phRbR4LWfAtcCzUuPD9LGBUCCeL/
         6w2J6tEK5xl8aNLUZXMZjPebohzuKEIf3pkzOiEU=
Date:   Tue, 8 Mar 2022 11:46:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 1/1] staging: fbtft: Consider type of init sequence
 values in fbtft_init_display()
Message-ID: <Yic0CN+qSvDtSiEz@kroah.com>
References: <20220304193414.88006-1-andriy.shevchenko@linux.intel.com>
 <Yictcf0BCvveVT+V@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yictcf0BCvveVT+V@smile.fi.intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 12:18:25PM +0200, Andy Shevchenko wrote:
> +Cc: Helge
> 
> Maybe you can pick this up?
> 
> On Fri, Mar 04, 2022 at 09:34:14PM +0200, Andy Shevchenko wrote:

You sent this less than a week ago!  Please relax, staging driver
patches are way down my list of priorities at the moment.  Wait at least
2 weeks before trying to get someone else to take patches for this
subsystem.

relax...

greg k-h
