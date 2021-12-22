Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C1347D096
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244446AbhLVLOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbhLVLOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:14:34 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7017C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:14:33 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g7-20020a7bc4c7000000b00345c4bb365aso858127wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Cd1oRTIvwdGBHC6TEDJuIJm0PK6V5jA3CCVieKSuuq4=;
        b=vVP/FeBuhlKPzT3WjXBViNmWcE5F3nEUxQCRVvwT3aIq1AxK5CigWeoTZ2QCTa4SH/
         /vSs/vtdgCHXNmockXwPcOJ4daXj07sMJmSt78nDTOpji096+ncRzojSxPw35TculbCD
         birRxpjqogPnZwZWspMl2NTHkYQ0TbJk0huJkcY8W1Dt0hTqBNafgb2Rb52fkBerLz3k
         FxpU6azkEsTDXZrazvBdTE8uJ7Q17heX20EFkMBJmwQTrrpb4HVYGP7qUHEPio/4h8N5
         nAaDkREiwGqUERLO1+430rJW2wTyJzxXEE+hykKeiuaHk1yUW7m8I/WKvRyNq3z+cwGm
         T6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Cd1oRTIvwdGBHC6TEDJuIJm0PK6V5jA3CCVieKSuuq4=;
        b=IGZZhsSbXwNaYjtYSsaiPNEuEXb7t6bIoWEDo8OVLg5N/W3N5r6D44uuVush801LsY
         B3KQvJYyJEA171ItKYMt9DXf0nfdCfUWaX75A5fvYo2akYxXf5wR/Q47kefbyUwhBxWO
         A5jGj5dkNVFSyp/kD7itpFhRK5pfQq6cZcsUPN4SPkDYvrd+dKxe4JwArd64g+tTGZBX
         a8lwsOLjjq/nMvR5rAoWc8LJB46lZflsJGHZ47h+qyftd2AlZ4Hpjbz6/6RaCSRz23bP
         ObqpeSxLmSdN+REza7tWNwxZf7FPOMK25Fe0RmpEhkIJS0/f/oDlaV5KGwQCh6kqi3VI
         EZgw==
X-Gm-Message-State: AOAM530DGYF7DZLGeIKiY26jJ8wQez8+f82UCN24xGr3hQdrDGMthTbJ
        KXF5T/0WcdOO098djnUnVXu9Ng==
X-Google-Smtp-Source: ABdhPJxw6Au4zCsVQB1P8Fug+BOKFnnH6HevD4tlaqZlf4fk1F/xSnPxsmdMq8YgsIVOTV2XogB4rA==
X-Received: by 2002:a1c:e915:: with SMTP id q21mr638905wmc.94.1640171672214;
        Wed, 22 Dec 2021 03:14:32 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id t12sm1858209wrs.72.2021.12.22.03.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 03:14:31 -0800 (PST)
Date:   Wed, 22 Dec 2021 11:14:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] backlight: lp855x: Add support ACPI enumeration
Message-ID: <YcMIlkou9OCGIElk@google.com>
References: <20211102225504.18920-1-hdegoede@redhat.com>
 <20211102225504.18920-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102225504.18920-3-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Nov 2021, Hans de Goede wrote:

> The Xiaomi Mi Pad 2 tablet uses an ACPI enumerated LP8556 backlight
> controller for its LCD-panel, with a Xiaomi specific ACPI HID of
> "XMCC0001", add support for this.
> 
> Note the new "if (id)" check also fixes a NULL pointer deref when a user
> tries to manually bind the driver from sysfs.
> 
> When CONFIG_ACPI is disabled acpi_match_device() will always return NULL,
> so the lp855x_parse_acpi() call will get optimized away.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Remove `lp->pdata = pdata` assignment from lp855x_parse_dt()
> - Add "and is in register mode" to the comment in
>   lp855x_parse_acpi()
> ---
>  drivers/video/backlight/lp855x_bl.c | 73 ++++++++++++++++++++++++-----
>  1 file changed, 61 insertions(+), 12 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
