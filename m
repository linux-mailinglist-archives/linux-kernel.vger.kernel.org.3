Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AAB582039
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiG0GlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiG0GlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:41:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A7821812
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:41:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A36CFB81F00
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9DEC433C1;
        Wed, 27 Jul 2022 06:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658904063;
        bh=dT9PySUtedQZbXYkEvW3U83X64gVVqmDriSBOZXzJIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kqy0WimsByLB63M5mVD7vfZplFEZjVLvcYPG80hAA1+e1vhJ8ta4/lj29ZEpgxsLc
         PizQm5bbO/GTmMxI/ZnLR4Cub2tbdwOCy1DU0THjWS8kQJXrmh9ACmNihv0CrBzsF2
         DFqgeApiU7SLol1zVNYrPhF/tmLP7cNQLhZe4GeU=
Date:   Wed, 27 Jul 2022 08:41:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Strachuk <strochuk@ispras.ru>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] staging: rtl8723bs: remove useless comparison in
 _rtw_reg_apply_flags()
Message-ID: <YuDd/K5LSj1035pw@kroah.com>
References: <20220719155309.463286-1-strochuk@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719155309.463286-1-strochuk@ispras.ru>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 06:53:09PM +0300, Andrey Strachuk wrote:
> Local variable 'ch' is initialized by an address
> of field of ieee80211_supported_band structure, so it does
> not make sense to compare 'ch' with NULL.

Where is it initialized with an address?  You need to document this
here.

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")

This is not a bug fix, but a code optimization, so no need for this
Fixes: tag.

thanks,

greg k-h
