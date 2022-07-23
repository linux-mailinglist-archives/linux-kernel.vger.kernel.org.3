Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606AB57ED18
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbiGWJcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiGWJca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:32:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369ED2C656;
        Sat, 23 Jul 2022 02:32:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C172160C11;
        Sat, 23 Jul 2022 09:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF316C341C0;
        Sat, 23 Jul 2022 09:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658568749;
        bh=9PlyTGkrBmfhn3eO9/82l7ttu48l72+xagxJ/6XUKK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZML7LKrDnmEziAYD+QtX/tkGveTDWXqC8OGK6CpEXflSwBQdouAXb5a+9Uu/oMeP
         Lfmm9RJXMY9gMrbmP2FnV0PeDkgwrt6Pa1LXCg/6OWOfx1sJs7qlP0FSEhHoiUAaFi
         QKTkvXt6gp4FYOqZVL3Vg/ARAgPX8cEbaTRodVqY=
Date:   Sat, 23 Jul 2022 11:32:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-next@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stern@rowland.harvard.edu, sfr@canb.auug.org.au
Subject: Re: [PATCH v2] docs: fixed table margin in
 configfs-usb-gadget-mass-storage
Message-ID: <YtvAJGY2jleLodgt@kroah.com>
References: <20220723074054.54995-1-mdevaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723074054.54995-1-mdevaev@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 10:40:54AM +0300, Maxim Devaev wrote:
> Fixes: 421c8d9a20da ("usb: gadget: f_mass_storage: forced_eject attribute")
> Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
> ---
>  v1 -> v2: Added Greg KH to CC so that he can accept this into his branch

For obvious reasons, I can not take a change without any changelog text
at all, and neither should any other maintainer.

Also you forgot the reported-by line :(

thanks,

greg k-h
