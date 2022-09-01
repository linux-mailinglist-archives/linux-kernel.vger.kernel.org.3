Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D1F5A9A16
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiIAOWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbiIAOWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:22:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C00B6D9D6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:22:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D2D2B8271D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F5AC433D6;
        Thu,  1 Sep 2022 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662042123;
        bh=rZYMHPLOEfxBZxG74ihdGSUM2bYekoe8btdJtlFb58c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TRQP8KRWHpibzu4UK6pi1mWHfftp/WhaqSp6/z3fFjPRpIOk+QECdyhJuCVhBoSI2
         HR5crMF3r7joz8yv3ynNzBEC59r3/cHx2T//Y8q7Aslvty+lNNdEmZ14ls5x3hF79T
         vD0+YYeDnpbXRg6LzmoMWiKlSTGARjlt7cvOJ3iY=
Date:   Thu, 1 Sep 2022 16:22:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     hdegoede@redhat.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] virt: vbox: Add check for device_create_file
Message-ID: <YxDACOSIxR432uab@kroah.com>
References: <20220901131506.3550180-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901131506.3550180-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:15:06PM +0800, Jiasheng Jiang wrote:
> As device_create_file() can return error number,
> it should be better to check the return value and
> deal with the exception.
> Moreover, this driver should be using an attribute group.
> 
> Fixes: 0ba002bc4393 ("virt: Add vboxguest driver for Virtual Box Guest integration")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Your subject line is now incorrect :(

Also, please properly thread your patches when you send them.  I saw a
2/2 but no v3 on that.  The whole series is versioned and needs to be
connected.

thanks,

greg k-h
