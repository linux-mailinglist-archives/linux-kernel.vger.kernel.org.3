Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1C146F638
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 22:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhLIVz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 16:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbhLIVz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:55:58 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CCEC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 13:52:24 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id s137so6277267pgs.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 13:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7N+H0P5BA/bsYR8s/evbQpkfs/r8CXZ+uBWoNHbfeOg=;
        b=VN+TCGxNTm+HQxltL9LL5Lv08J4Pvm8p44ODDbpVu+jF/sitcXCsYFeYvybvUu2OLl
         xKDAv5mIEsfikF+mPoFcorI2GAWcz0QK4ij58K7AaFC5cb7CpSQjdfqygWJS3bidlmDu
         LIc9K6QadOfe4IbWCnowXQJ1VuZmrqx/3UWth1Vs1k3d2YgoLuYbFsY9XuBxM6EdQTfs
         LlPHUPgsMRLo7PVcIOoApmNYrLpIH87yTmwFGdMupZu8z3AYFrjfSxKrO31ReHWLRFVS
         008S0jnQR2HuMEkNHNpw+UMddd7s/dv9/hzVX4pMWvcD+prfNb1+PjhF3803xaj3Sl/t
         oMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7N+H0P5BA/bsYR8s/evbQpkfs/r8CXZ+uBWoNHbfeOg=;
        b=13/6TTMAJ81tO3VqKkfjyfcDTXwMP92GgHEwu73P9liROUMDsjm7I40L/SOFxQSed9
         GgSo/du77r1oYdjpMnPvLgv7wwL5eMmZWG3YEjdjPu41dTjz+NlsDsamT9QSi94TvkeV
         UVYjULlUEicyNhlLdLpFG8/anMfbmiBGpL258cGz8qw8MyzV9qm1F7Aw56S8uun1JKu2
         UWa8VBwKiTOre34gGLxpLkMgMaF3dfRJ/5IGCAri619NmfZ7LaWXm61UKelHo+MHWkPV
         e10YUMeGt89odqx5JVJ4n5kW2IIx/eY1XlrLD+JyyH8F835YenGi2HBruBkeY2sJNTEL
         fTdg==
X-Gm-Message-State: AOAM532TV91/u+Neu2OXjkXe0DRhc59BdkoL2ddk0dwimnITZDgzXKJV
        BqnnLkAteFAo2kF1E7INDRU=
X-Google-Smtp-Source: ABdhPJzkCO0z+g/264ZFXOeNe7s6rKIEuKJIGpeinvuQ5fIhUH5jPRqfJziUuYf5knJuK4IDMCPZBA==
X-Received: by 2002:aa7:8717:0:b0:4a2:967c:96b with SMTP id b23-20020aa78717000000b004a2967c096bmr14328203pfo.14.1639086743686;
        Thu, 09 Dec 2021 13:52:23 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id v9sm531851pgk.55.2021.12.09.13.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 13:52:23 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 9 Dec 2021 11:52:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] kernfs: Replace kernel.h with the necessary
 inclusions
Message-ID: <YbJ6lbhQiM9t3gQW@slm.duckdns.org>
References: <20211209123008.3391-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209123008.3391-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 02:30:08PM +0200, Andy Shevchenko wrote:
> When kernel.h is used in the headers it adds a lot into dependency hell,
> especially when there are circular dependencies are involved.
> 
> Replace kernel.h inclusion with the list of what is really being used.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
