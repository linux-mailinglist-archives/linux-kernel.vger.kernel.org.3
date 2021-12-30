Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99484481C66
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 14:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbhL3NO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 08:14:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37584 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbhL3NO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 08:14:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA8F3616D2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 13:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CE6C36AEA;
        Thu, 30 Dec 2021 13:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640870067;
        bh=c9VoF5J6gtiw/zVyAgJ3CH5TZ9cCVPcFr6L1VqJoasA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AznTNa00q65rmvz227/RbhcsWFtOhaGnXkfiXo9BzpiBVYiM+A0c0irzg7Al5GamJ
         jE5rbmNv60zx/DALqBU88T6C8mBtXkvryFF0CSVmZix6qy5YEZe/eVSHNRViimAPbu
         0hf8MX7Am2SKFhnVy1RV+WvmIsraoG9NTlNTumGI=
Date:   Thu, 30 Dec 2021 14:14:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     tkjos@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] android: use "menuconfig" menu entry type for
 CONFIG_ANDROID
Message-ID: <Yc2wsGmEe7lefB9h@kroah.com>
References: <20211228200634.18968-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228200634.18968-1-jengelh@inai.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 09:06:34PM +0100, Jan Engelhardt wrote:
> Allow disabling the Android driver section from within the Device
> Drivers submenu, without having to descend into the Android drivers
> submenu first.
> 
> Signed-off-by: Jan Engelhardt <jengelh@inai.de>
> ---
>  drivers/android/Kconfig | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git drivers/android/Kconfig drivers/android/Kconfig
> index 53b22e26266c..dc0a373ab879 100644
> --- drivers/android/Kconfig
> +++ drivers/android/Kconfig

You made this patch at one level too deep, it should look like:

--- a/drivers/android/Kconfig
+++ b/drivers/android/Kconfig

As-is, this will not apply.

A normal git diff will output the correct patch file, as will 'git
format-patch', how did you create this?

thanks,

greg k-h
