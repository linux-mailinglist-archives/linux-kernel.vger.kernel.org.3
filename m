Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2D447BF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbhLULzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbhLULzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:55:07 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4E3C061574;
        Tue, 21 Dec 2021 03:55:06 -0800 (PST)
Received: from hillosipuli.retiisi.eu (89-27-103-169.bb.dnainternet.fi [89.27.103.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 6E7321B0004B;
        Tue, 21 Dec 2021 13:54:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1640087699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y7NAiTD7hjhwbo469Yfi+SiOl+RdKcOc1Wq+PbLUBAo=;
        b=ES5Ioudz83+w/PDrv1aYeeEewnP3r9f53YdKK1DPNWe1LAMrxk97v23Umhfb+jKmmjbBz2
        1WuEn5SAxqWR8G4hoi75C60gYKV5SrOWQ9qzb8fI0pyIf39koWnH4nfTdflAvEaQV/5GJ8
        Ktrna+a0tafQnhTPft5h2mLuF4D/Ovgj5UMlaocBO7MCY6O0Iuo2R3In85k+7PxMX5a14t
        3e2CycNYPo5GZopetF2h7GZVbfbdall5s185k85Y5SybEuAPCnfHQkwIRuR3U4ftTFfqf7
        yO3G6GMsAtdMBUepjOhEjFenWPVhGEI7WOSqk3wLyUZWnOxuXDvnsEBAb7Hfsw==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 1031C634C90;
        Tue, 21 Dec 2021 13:54:59 +0200 (EET)
Date:   Tue, 21 Dec 2021 13:54:58 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 1/1] software node: Update MAINTAINERS data base
Message-ID: <YcHAkuyML0VLjxP/@valkosipuli.retiisi.eu>
References: <20211221071409.14361-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221071409.14361-1-andriy.shevchenko@linux.intel.com>
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1640087699; a=rsa-sha256;
        cv=none;
        b=HxJQyUKXa7MjdUhuFGPrKVxrX7dagZ7qptzDEQ4xl+Pc4V1KKNgHLL5wYkFdazG9US/rIO
        2HQT+SyI2n7uSSH4JeJS+vya+FD+D3j8PLZWuvdYgUXXgct/gSYkZV1K5mlDJo5HuRWhkU
        3o9iEdiZ8CoGumyjuZRM69AxQ933CAKod0b0AWi+lWQKJNwlwb2etnDdt9/XTLL3fcsaWz
        nHFFirkaTEFd7HxK6Vr+L6mx4QG0ySNykCLQaCIAruhtpkuEmLB0pbOd9d5XNn5KSMbKAu
        oMtUjfTgJX1EoNAtnPB4uTfNosG1rUKsYX0HkJZ8RumsqKPqWcaLQJLFokwSig==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1640087699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y7NAiTD7hjhwbo469Yfi+SiOl+RdKcOc1Wq+PbLUBAo=;
        b=UeWzZPcqc20J2JeHA6Q+CnapaPnX8Vm3w7RW9L2owNRmYj2J7pzcwEIuQHRHzKfXvMKu3M
        cX1NSGnFthZ7NzHnCwRGZOWGC2mHcrUWncESUJ8st+smw6kZX1SrjKudyb9ph43kkC4zjq
        kymYLG/NqnYB3Mweu6sqoFaCFXEcRpOqcsc+yd3c86eluYwPVyb7qP6z+/Yv4eskRYHL/o
        /J+TWnfWwnJS6lBFB1ptQ8suQSpX2TSSzyAKgx/NZA+FA38CamVIeksckHtvgG39bekzAG
        qNRx36CB4Jjk1opTOUt2qP0gEP7DcHM88rGg1BJftj8JFmkly0Xhmar3TnhQaA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Dec 21, 2021 at 09:14:09AM +0200, Andy Shevchenko wrote:
> There are two updates to the MAINTAINERS regarding to software node API:
> - add Dan Scally to be designated reviewer
> - add rather tightly related device property files to the list
> - adjust section name accordingly
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Based on the latest Dan's involvement and amount of patches seen recently
> I went ahead and added his name to the list. Dan, please tell me if it's
> not appropriate.
> 
>  MAINTAINERS | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8912b2c1260c..ccb4aa744540 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17666,12 +17666,16 @@ F:	drivers/firmware/arm_sdei.c
>  F:	include/linux/arm_sdei.h
>  F:	include/uapi/linux/arm_sdei.h
>  
> -SOFTWARE NODES
> +SOFTWARE NODES AND DEVICE PROPERTIES
>  R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>  R:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +R:	Daniel Scally <djrscally@gmail.com>

I wouldn't mind being added as reviewer, too. :-)

>  L:	linux-acpi@vger.kernel.org
>  S:	Maintained
> +F:	drivers/base/property.c
>  F:	drivers/base/swnode.c
> +F:	include/linux/fwnode.h
> +F:	include/linux/property.h
>  
>  SOFTWARE RAID (Multiple Disks) SUPPORT
>  M:	Song Liu <song@kernel.org>

-- 
Regards,

Sakari Ailus
