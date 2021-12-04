Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C824846814F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383719AbhLDAhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354317AbhLDAhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:37:06 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4122BC061751;
        Fri,  3 Dec 2021 16:33:42 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id v22so5095676qtx.8;
        Fri, 03 Dec 2021 16:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ChPZyK2J3G2xrsSkvqwsURSEru8MTcJbhKW9sp4ILzw=;
        b=gLONs0rqq8xkM9NpyriGAlkctCRlbka3iBky7GyHO567Ht7RKfAuLrwMHHwB4XCKA2
         D5iOwaCfFGM1SEIpDyRcRQVFPzQdiOBhz0XTqx/RAJS+bVYf/QrUIsv4v7ZbsHN1hkKQ
         kaGi9y3STnvBXSeVXTA3FdnWqVb5036xRH6/OQd5eScrs50Yx3gW7USGS2Zf4fL36QVS
         bA5hizXtMUK0sBmSTFr5oitRIxbKQa6Qbk77f3obo1kyj4vKEL3DJqE9miX7nhe0tqcj
         kRjN6jJfGqZw95ErWCOH2wtQl5GbxOYI3ulfnUYesWqQDvmUV2ia5lfbLEcg7+1BTgxQ
         tTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ChPZyK2J3G2xrsSkvqwsURSEru8MTcJbhKW9sp4ILzw=;
        b=F8haUsy6UfBt9usO0ZsD/lJL8I5U4Mzc4ZY+3ldXp8FKQNL4L2Jhts0dgHjHcEZyTS
         T4l3YEQn2/EgTrrpDqZKA1Qx8Vr25QRjJTE3lo8VGO/3JUlKtpE80EBD8jvjlKSgGCP6
         LNiBPi9RMWkRrLG8yJ3d4oRDrcmjn6pqbJJpYfqEf5Z//HUB+sp+zDO1mJLefjNN5ld3
         HTcv6wBbaG9QV/XZw5w8kCfCeClZlpWpoBPEvW2qFwwxfc1y1mkrOFqgbl6jNc4LaylA
         LU6bAyuqv/hbyXSqHIhwgzdNvaKod7G8AR6gWfHErAXAZCVkW7vObDbWahj1Lj8BWqfv
         YCoQ==
X-Gm-Message-State: AOAM531Y1bN0NOVWA2d2R8jlPXxF1WfCPvv+spwuVUDUBg7zoZ4C2r4W
        JMrxSDJvE/UrdujVhZGBPRg=
X-Google-Smtp-Source: ABdhPJwTRmDQJpAIWvv5G96c1Bkao8jqFQcn1mzuuQaIfOsUw2jYkEqaGYYfLly01b5VAAv88tniIw==
X-Received: by 2002:a05:622a:1310:: with SMTP id v16mr24231070qtk.431.1638578021419;
        Fri, 03 Dec 2021 16:33:41 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id j21sm2971381qkk.27.2021.12.03.16.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 16:33:41 -0800 (PST)
Date:   Fri, 3 Dec 2021 19:33:35 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, kgugala@antmicro.com,
        mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr
Subject: Re: [PATCH v1 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <Yaq3X2IlOIX/KEoB@glsvmlin.ini.cmu.edu>
References: <20211203234155.2319803-1-gsomlo@gmail.com>
 <20211203234155.2319803-4-gsomlo@gmail.com>
 <d63edcb7-18c0-06fb-2216-2b1ed3b0215b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d63edcb7-18c0-06fb-2216-2b1ed3b0215b@infradead.org>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 04:20:59PM -0800, Randy Dunlap wrote:
> Hi--
> 
> On 12/3/21 15:41, Gabriel Somlo wrote:
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 5af8494c31b5..84c64e72195d 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -1093,3 +1093,9 @@ config MMC_OWL
> >  
> >  config MMC_SDHCI_EXTERNAL_DMA
> >  	bool
> > +
> > +config MMC_LITEX
> > +	tristate "Support for the MMC Controller in LiteX SOCs"
> > +	depends on OF && LITEX
> > +	help
> > +	  Generic MCC driver for LiteX
> 
> 	          MMC            LiteX.

Heh... tackled at the one... :) I'll have that fixed in v2 -- thanks!
--Gabriel
