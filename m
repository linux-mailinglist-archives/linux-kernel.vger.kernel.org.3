Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2835469502
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242398AbhLFLbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbhLFLa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:30:58 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A8CC0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 03:27:29 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id z7so24439360lfi.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 03:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9l63LtAsEZ6fYHmNhW8V7RRUrW8tCaNYojj6Fpbnsc=;
        b=uhNWdOyxLAH1Gc7+kfxaRvlBBxUi+OUvBxT5uZ0MOKxizvOmvT318NzaXaxpgw/j12
         7lRwLYKdcc5KUs9Fc50Fq8DKy/A7KKAeq8cff7oh8663DfqPnV2vwd4HJV2xgc85tANm
         J2BclrLK3nrm+2VdoUwNv+J9IfzZ9sBQpnaagZJ7SDnMJqTOQBFLVuLc0qihXmhluHPf
         Ty1PfL08Bau65qVKyF/4HKxHZgtOeH0/EXHXFObc9F0SvFeSEFerQLHFdTm4wp+ULNww
         VsVL16KfxarQ+zyZ4j+WJjHKFlA8res7tCsbIob1g/eJkCUTNHAKc2oJUIN1JAcNRgcw
         cc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9l63LtAsEZ6fYHmNhW8V7RRUrW8tCaNYojj6Fpbnsc=;
        b=yQW/ZNE0KhYQMG9XH2ttwHetB9wLbJlqN82SdGpssyeVOJNsgKr1p7tZHn6RzPca0E
         yJ4yD8dPSR6+yPyaGfz1pVxa697V+4f+n6ADEdYm14vdeVA8gOyCq7GmgzmK4G6H/JCL
         Ra4Xrs7A5W8ex+tWMQTKrGPxar08NEEIPZHUkCcs+/C1YC9w0SE9Y/EvjvFFzvtqlQ/1
         VLhaKO5aYuwRt15HglfWsuQ3IQ1hXPh7xwKTHmLgdJ66bAAouXOJuwYrRgR8l3whf2Cm
         r6ezctr2EX9G7V1epTfoIA8WlLyR3d1cGNffhh7r6DbF0uExG8apK6SY4p4AFclV3E4C
         OtVg==
X-Gm-Message-State: AOAM530bj3ULEDWukTZcOF9qOEPSyXckKyZR7WlnxMH3QZLl9GMUXgMU
        OX62PO4MhiMFBRnzu2gHn0tNZKhEeN6fMxR0RAUue0jx3w8=
X-Google-Smtp-Source: ABdhPJwdIQ1dnfeDSo3UmRCh16RMfUAdPKZVinqmUpBJqmAuCFq6pTZ0DBJ+jHVBxeOd5eeEcWhJfajHk8NyYduX3rE=
X-Received: by 2002:a05:6512:3d07:: with SMTP id d7mr35870671lfv.233.1638790048200;
 Mon, 06 Dec 2021 03:27:28 -0800 (PST)
MIME-Version: 1.0
References: <2633024.mvXUDI8C0e@kreacher>
In-Reply-To: <2633024.mvXUDI8C0e@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Dec 2021 12:26:52 +0100
Message-ID: <CAPDyKFq4KPbrQM7B79NsE1MjiOJ-3rRNt8ZEN+JvW=_pS-1JbQ@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Fix pm_runtime_active() kerneldoc comment
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2021 at 17:19, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The kerneldoc comment of pm_runtime_active() does not reflect the
> behavior of the function, so update it accordingly.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  include/linux/pm_runtime.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-pm/include/linux/pm_runtime.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm_runtime.h
> +++ linux-pm/include/linux/pm_runtime.h
> @@ -129,7 +129,7 @@ static inline bool pm_runtime_suspended(
>   * pm_runtime_active - Check whether or not a device is runtime-active.
>   * @dev: Target device.
>   *
> - * Return %true if runtime PM is enabled for @dev and its runtime PM status is
> + * Return %true if runtime PM is disabled for @dev or its runtime PM status is
>   * %RPM_ACTIVE, or %false otherwise.
>   *
>   * Note that the return value of this function can only be trusted if it is
>
>
>
