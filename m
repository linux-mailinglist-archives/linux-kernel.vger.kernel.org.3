Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558C555D6E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244697AbiF1GAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbiF1GAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:00:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015102C664;
        Mon, 27 Jun 2022 23:00:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3131B81C17;
        Tue, 28 Jun 2022 06:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A95C3411D;
        Tue, 28 Jun 2022 06:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656396028;
        bh=29k4Ow4oNcUSrFKMbJ2975+WfuAaRON14I7dvFBkeNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xf0rToeQPRPfD7q0e5T5XQu9pKwLF7pDRLXgyaEYzuaBK16fJeClIa4pf1a1sWhh0
         luqcSqGI0DFLr58g4XBuKzA21noZoyfcbXcnX5/arbeqjY2glJdlGbBnUy66SfKKVv
         DF8hePeldvOKatR4dnty92To7g+ZqoLfkpss6sRY=
Date:   Tue, 28 Jun 2022 08:00:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] PK: runtime: Redefine pm_runtime_release_supplier()
Message-ID: <YrqY+c1NPQ+wEiUk@kroah.com>
References: <2653259.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2653259.mvXUDI8C0e@kreacher>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 08:42:18PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of passing an extra bool argument to pm_runtime_release_supplier(),
> make its callers take care of triggering a runtime-suspend of the
> supplier device as needed.
> 
> No expected functional impact.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Nice, thanks for cleaning this up.

If you want to take this through your tree:
	Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

But if you want me to take it, please just let me know and I will.

thanks,

greg k-h
