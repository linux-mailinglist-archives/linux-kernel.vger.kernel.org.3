Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A6D4688E5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 02:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhLEBk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 20:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhLEBk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 20:40:58 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B65C061751;
        Sat,  4 Dec 2021 17:37:31 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id p19so7352651qtw.12;
        Sat, 04 Dec 2021 17:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4XnN3BtFVU8ghBOYYkiMwp/csK2JKCL9fo3KK/aQk7k=;
        b=fCuL/VEp2R3hi5iSgCP7KywisRaM7G0wmX3+tXzPOiO79pPKjThNL6qIfaYF6aTble
         0pr6ysnd3FPghZLnaiB6/QhjbUYLqHtcXlE0j+JZ/FfD6AYkGRtzOdrvsWwvqrI9XeoT
         +h2jJPrGQEWX2mtvt2KCCgCYoAYVSl3QgDGs/Qj6SaUcO8mmKYzBHz31UfJt1nqz//UN
         PgRTpgQ97uN5hX5ZzEWrcdUAozEokD6LCEpEUCp0lto+E4ojWjO5ozH6nnneaufs4Iik
         nyNjMhYFk/7hx6QMVFRtFoipDGCNWYjYb/ohVqj7ucTeOJM4szEqo5cCfr/o2OK/TdMt
         UZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4XnN3BtFVU8ghBOYYkiMwp/csK2JKCL9fo3KK/aQk7k=;
        b=2Dc21ZDVqiAnxpH3gNx28Lr0HkNk0R/BPT9Q0+A6ktVEu+fv0LsCt8CSG7xT70zzPc
         EakNPTHuQVgwthpwOYGMfV26N4rankloSvHB7Op7jD1uaPjvd3t/3F2iW+f/VH8iLU4E
         tMthYFAZrZBJXo7y/cJDizl1fkjvfkziifkx9z5zId1jvBMQIbFJWSrzhFWBi+dX3PyG
         1+z8XlSf8bUaV9KF9dTHMkjShB+tnImRxm63w7FtQ7l0XkKj8XX1aAj9q9lmSYxLQP3Q
         3jri8Pe3y5o6B6K7L48q7QiGbGBMCS2CQHdSFZXSie3bY0w4je1i5+zMTIaWE/vyk+5L
         ud6A==
X-Gm-Message-State: AOAM5300VtQPJlfKMfT6EV1hRLktC1PSYGzzz9qarwvBdd/oifRjPsxy
        oKwnCyVZuRRvqRXrEu38FIg=
X-Google-Smtp-Source: ABdhPJwdcd6NoupRoRqC9vjxhs8CpzPE21N9vtEI52hr8riGPIPhrn0+Xuvk6R2SkQPvFGemRVPK5A==
X-Received: by 2002:ac8:5b82:: with SMTP id a2mr30216325qta.519.1638668250697;
        Sat, 04 Dec 2021 17:37:30 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id j126sm4609048qke.103.2021.12.04.17.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 17:37:30 -0800 (PST)
Date:   Sat, 4 Dec 2021 20:37:22 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, kgugala@antmicro.com,
        mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr
Subject: Re: [PATCH v2 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <YawX0qne+wRTXMeY@glsvmlin.ini.cmu.edu>
References: <20211204204121.2367127-1-gsomlo@gmail.com>
 <20211204204121.2367127-4-gsomlo@gmail.com>
 <e99ad542-14f6-2a06-a83e-c5f4e945303c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e99ad542-14f6-2a06-a83e-c5f4e945303c@infradead.org>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thanks for the feedback!

On Sat, Dec 04, 2021 at 12:57:32PM -0800, Randy Dunlap wrote:
> Hi Gabriel--
> 
> On 12/4/21 12:41, Gabriel Somlo wrote:
> > +MODULE_DESCRIPTION("LiteX SDCard driver");
> > +MODULE_AUTHOR("Antmicro <www.antmicro.com>");
> 
> Admittedly it's not documented, but we would prefer to have some contact info
> in MODULE_AUTHOR(), like an email address or a person's name.
> 
> <linux/module.h> says:
> 
> /*
>  * Author(s), use "Name <email>" or just "Name", for multiple
>  * authors use multiple MODULE_AUTHOR() statements/lines.
>  */
> #define MODULE_AUTHOR(_author) MODULE_INFO(author, _author)

OK, so my plan is to add the following MODULE_AUTHOR() statements:

	MODULE_AUTHOR("Antmicro <contact@antmicro.com>");
	MODULE_AUTHOR("Kamil Rakoczy <krakoczy@antmicro.com>");
	MODULE_AUTHOR("Maciej Dudek <mdudek@internships.antmicro.com>");
	MODULE_AUTHOR("Paul Mackerras <paulus@ozlabs.org>");
	MODULE_AUTHOR("Gabriel Somlo <gsomlo@gmail.com>");

Antmicro folks: Kamil, Maciej, Mateusz, Karol: I'm not exactly clear
on how you all prefer to be credited but I could either:

	1. leave just the first line for Antmicro-the-company, with the
	   "contact@..." email instead of the website URL, or

	2. leave just the developer lines (Kamil and Maciej), or

	3. leave all three lines as currently shown above.

I'll queue that up for v3, once I hear back from you.

> > +MODULE_LICENSE("GPL v2");
> 
> 
> Also, it's up to the MMC maintainer (Ulf), but the function signature
> style that is used in this driver is not the preferred style.
> 
> E.g.:
> 
> +static int
> +litex_set_bus_width(struct litex_mmc_host *host)
> +{
> 
> should be
> 
> +static int litex_set_bus_width(struct litex_mmc_host *host)
> +{

Done, and also queued up for v3.

Thanks again,
--Gabriel
