Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D9B4C97C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbiCAV1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiCAV1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:27:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E273B6A033;
        Tue,  1 Mar 2022 13:26:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F50CB81DC1;
        Tue,  1 Mar 2022 21:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05619C340EE;
        Tue,  1 Mar 2022 21:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646169999;
        bh=y2ueTPLbvAHTRFSDMc0R5Y97o/tsKrtE78AjY5VFPWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dhFYgRfeG9PXlxYEkUT6bOd76gPXCa87t1IbpsQJe/h/H6h3b8GN5254fwmXFfiyL
         To4UAEtoAquo/HTqWkF4AUJxiYO2+LkyuvtMjaNZNJHIqCf6x6+y7jzqn95PUgIYXQ
         p6DcourVJWeFgoDwKWTUPK4zcy22tr5gPY+ppduw=
Date:   Tue, 1 Mar 2022 22:26:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] mmc: rtsx: Fix build errors/warnings for unused variable
Message-ID: <Yh6PjZ9/HAiyZ09M@kroah.com>
References: <20220301115300.64332-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301115300.64332-1-ulf.hansson@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 12:53:00PM +0100, Ulf Hansson wrote:
> The struct device *dev, is no longer needed at various functions, let's
> therefore drop it to fix the build errors/warnings.
> 
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Fixes: 7570fb41e450 ("mmc: rtsx: Let MMC core handle runtime PM"

Forgot the trailing ')' character :(

I've fixed this up and ignored the obviously incorrect kbuild
warnings...

thanks,

greg k-h
