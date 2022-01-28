Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7328949F3DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346403AbiA1Gy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiA1Gy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:54:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6A3C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 22:54:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17AAA61AEC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18DAC340E0;
        Fri, 28 Jan 2022 06:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643352866;
        bh=ikLQPNsjf8L/3fYTx8FkHATsPixNTMoEy1VsDndjwq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bngk/iVyTHY88J6pTD/RyS3mrKYOaYJdv7GGfJ0AcTKfZzoW3ENAREq7ljObDyahr
         MObrnUNZcCaN3V94n/IpPJr+mPt3dOm18wNO2o0mLqlcmhZXqgtLqGzAVESgkPUc0f
         p7TJLOOtAat24lVMrPrQL9fX5AF5AkBl3kbT7QkM=
Date:   Fri, 28 Jan 2022 07:54:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hideki Yamane <henrich@iijmio-mail.jp>
Cc:     Takashi Iwai <tiwai@suse.de>, Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] firmware: Add ZSTD-compressed file support
Message-ID: <YfOTHj8oRoxdhX6c@kroah.com>
References: <20210127154939.13288-1-tiwai@suse.de>
 <YBGeXDTEy8myghot@kroah.com>
 <20220128032213.c93b56aa2ea1c77e34b28290@iijmio-mail.jp>
 <YfLnTm7L3m6jEB+4@kroah.com>
 <20220128093335.e8d01f21c4b930c30f77e08a@iijmio-mail.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128093335.e8d01f21c4b930c30f77e08a@iijmio-mail.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 09:33:35AM +0900, Hideki Yamane wrote:
> On Thu, 27 Jan 2022 19:41:18 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > What is "this"?  You are responding to a year-old email message :)
> 
>  Oh, yes, sorry.
> 
>  What's the status for adding "ZSTD-compressed file support" for loading
>  firmware feature config FW_LOADER_COMPRESS in drivers/base/firmware_loader/Kconfig
>  has still XZ_DEC only, where should I check to know its progress?

If you need this feature, take the patches and rebase them to the latest
kernel tree and submit them for inclusion.

thanks,

greg k-h
