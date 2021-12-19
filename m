Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC8147A092
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 14:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbhLSNIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 08:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbhLSNIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 08:08:54 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5652BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 05:08:54 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e5so14325243wrc.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 05:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=MWJbhbofpLE1nsEhf784qNMM4Xv8gHh1HZEymr75AVo=;
        b=QtckVAQ2A0WLJlIGHRWPme/cAH+uaPysST/39pf4uf/IWM3s+Lp22UXIIgCC6HYoTM
         +Ik6BCgrngJ4Z+sd4fHugVNXzn0l6pbMwzirhhgUjnArhux8cCebUG9+gI42eeL9I/e/
         scXCZSI9IQ9BkovpVM3m8wjAmNyskSueUwAm7sk5dZpaDfBkxRoK1CgJrqZJVv+kNaW5
         iGEtF6COvXWlAg69kvD8gxHUW/Phi3vl9+npPYDg4ZVfo21HKAB4zRr+SbFmKhhs5OS/
         Ms8NUtATckb2Nd6Uy6NE635syw7aGUGzD95aj96LNf0UWNucOnk7ceII2u+GvJvMpTO4
         EBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:in-reply-to;
        bh=MWJbhbofpLE1nsEhf784qNMM4Xv8gHh1HZEymr75AVo=;
        b=xuGdWdGv5Kc8VDMJe0+pbAVaEdQfQNxskybHS2xucT78hE9YU/a/+3aeylxwOBD0/o
         ESfodWZonB0g2cmFC7/Kv9RosjXH3bQWvyvh7diAJTZm70XBkh13e4S+HByhnA3EIYcV
         tT8m1RV6hLVvazpW8zrZDdmWRPJuRmcFDP1x9N0AphH7mQMb+/0eqQ5+ZC6gEXB8TOiv
         cykcTmj1pTrRy8PNZm+necRU9/tBzzPgtdc/hzxBB+YmKQcygEvTfeY0lyOWTXywlWEj
         HyciDTkMf9pmVsw8vt+FduLkcmSTyj1s3wdm14R++CITSUUow0RiyiIDxBg0tDh/l0k2
         2b1Q==
X-Gm-Message-State: AOAM533CT7RD2AvDR9mGB3hbpkKqolrA/PAKVUxBCH5NKvkc6MMnhK95
        cRVw0BzvxCB3ig5hEualVjez20WCM5PdIA==
X-Google-Smtp-Source: ABdhPJz70AXqXd3e8gn9+snrDtaORDxs+AtpDhabvCI3Wp0+gkGpjnHg+O8ntcVHFMWuxSTAX4r9Dw==
X-Received: by 2002:a5d:608a:: with SMTP id w10mr8988769wrt.596.1639919332892;
        Sun, 19 Dec 2021 05:08:52 -0800 (PST)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id bd19sm5515313wmb.23.2021.12.19.05.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 05:08:52 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Sun, 19 Dec 2021 14:08:51 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Julius Werner <jwerner@chromium.org>,
        Thierry Escande <thierry.escande@collabora.com>,
        linux-kernel@vger.kernel.org,
        Paul Menzel <pm.debian@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Waychison <mikew@google.com>
Subject: Re: [PATCH v2] firmware: Update Kconfig help text for Google firmware
Message-ID: <Yb8u44SLN25A3ONT@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618225540.GD14131@decadent.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 18, 2018 at 11:55:40PM +0100, Ben Hutchings wrote:
> The help text for GOOGLE_FIRMWARE states that it should only be
> enabled when building a kernel for Google's own servers.  However,
> many of the drivers dependent on it are also useful on Chromebooks or
> on any platform using coreboot.
> 
> Update the help text to reflect this double duty.
> 
> Fixes: d384d6f43d1e ("firmware: google memconsole: Add coreboot support")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> v2: Mention coreboot, and don't touch GSMI help text
> 
>  drivers/firmware/google/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
> index f16b381a569c..ca049ecf5cfd 100644
> --- a/drivers/firmware/google/Kconfig
> +++ b/drivers/firmware/google/Kconfig
> @@ -2,9 +2,9 @@ menuconfig GOOGLE_FIRMWARE
>  	bool "Google Firmware Drivers"
>  	default n
>  	help
> -	  These firmware drivers are used by Google's servers.  They are
> -	  only useful if you are working directly on one of their
> -	  proprietary servers.  If in doubt, say "N".
> +	  These firmware drivers are used by Google servers,
> +	  Chromebooks and other devices using coreboot firmware.
> +	  If in doubt, say "N".
>  
>  if GOOGLE_FIRMWARE

Prompted by a question downstream in Debian it looks that this patch
never go applied.

Is there anything missing for having it applied?

Do you want a fresh resent of it?

Regards,
Salvatore
