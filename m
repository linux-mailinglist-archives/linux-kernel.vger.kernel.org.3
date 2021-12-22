Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8587B47D094
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244449AbhLVLNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbhLVLNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:13:46 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7437DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:13:46 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so1290671wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DGipiHp1dIs1kPPtmTbLZRl22a1nYVdRac1K8tE6rBA=;
        b=QcR/y3ZwpHfN4gNWKrz9BvGpuEVg78TYqXWw0lQwPjyYFafuag/+R5ZJVNbuKu+985
         2BKxn3tUT201fUsvqrvngR+HIJISXdiX8RkzL02jYcGY56bgDAZ5CxbKEg10mg3UpmA4
         DIjXrubi7Oe7jdKtPHYTWyQH5upvZPgATVEUAyskBopZ9sbn4XVQkH58/3eRpezAs8Rp
         mfXBVdQtxftepK9EGkdEIfF6rFGShXVA6s99ENjN9GzemWoQyX9kyp8wbAOLh8wzdpNo
         Kr+hpMW0dPio6EBlyLgdzZNj2XINdhK/V6ih4oukxLUpE7ZJ2kLpK3Zla3p9SgsFBAvL
         6lzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DGipiHp1dIs1kPPtmTbLZRl22a1nYVdRac1K8tE6rBA=;
        b=Qqv6yIm+0n2HvPmrsHvzQVSt08BLNptp33eJI6oHViRzSxelIoEvdg9nVbIBwvcjoD
         8SzAR2dMC7h78jr1FDV7pQSSvlUZq7S+cxqjVftcJa4bkmpVjbWWVANif6K2YyIBy52h
         qKmA5f8QP4LtMK8bxQV2GvnzCVoahydbJsioTx56OfKc/Esn0JGcwb7kqHoiLBzkBB/9
         MyNYDjO124JLxLMHgeN/cCG6oXSrYW6OfZNM/SbrAIRwFRP+wKPqjZdxPDjco47htq+G
         f3oFXSrRJFZnAxsWlH3CJNM743j5fWya5keQuqKS2I0lhwWCvd8tJ6Nx4J7iZwUitqB9
         PhJQ==
X-Gm-Message-State: AOAM533VB+ZL/UCXZdQK3cd1cm5/oln05XG4ke7ZWax1T6jHgopvliY1
        cgf7wO15kdxOSXYtU2XBRKoj6w==
X-Google-Smtp-Source: ABdhPJzt9PwMM7/bA80ZynZIswm6UDaMmNQRRGkgVsd7FGmmrG3zlaVQDMskTcVW7MU4iOIjy+gLTA==
X-Received: by 2002:a05:600c:40d6:: with SMTP id m22mr579448wmh.163.1640171625022;
        Wed, 22 Dec 2021 03:13:45 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id h19sm1415043wmm.13.2021.12.22.03.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 03:13:44 -0800 (PST)
Date:   Wed, 22 Dec 2021 11:13:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] backlight: lp855x: Add dev helper variable to
 lp855x_probe()
Message-ID: <YcMIZgofh7Z/X5qQ@google.com>
References: <20211102225504.18920-1-hdegoede@redhat.com>
 <20211102225504.18920-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102225504.18920-2-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Nov 2021, Hans de Goede wrote:

> Add a dev local variable to the lp855x_probe(), to replace "&cl->dev"
> and "lp->dev" in various places.
> 
> Also switch to dev_err_probe() in one case which takes care of not
> printing -EPROBE_DEFER errors for us.
> 
> This is mostly a preparation for adding ACPI enumeration support which
> will use the new "dev" variable more.
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/video/backlight/lp855x_bl.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
