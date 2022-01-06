Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDDC486A10
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbiAFSmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242731AbiAFSmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:42:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEA1C061245;
        Thu,  6 Jan 2022 10:42:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54AEBB8216A;
        Thu,  6 Jan 2022 18:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114CEC36AED;
        Thu,  6 Jan 2022 18:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641494549;
        bh=AVM78RmfE8vDgH0zl071K/ipXbzcVJGsoaOCqdXNCqo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QQscDcxbMC/Z6pvcQ71mmVVKHz8+GqYGvHRGPROefMCWJMZfIOizODzskTjGNvuN8
         nqna3rg/U51cAcIvFJ7rz8ouB+NUt4bxrnsU4dpMVX4gQEdO+cOj35jGNJyKCkjI4I
         TQEutsC3lZPwj+Obt5kH1pYth62nX2uwkx+8G1vFwncFgp8qF0h9XuxCBo7l/+dFNU
         HgLpJMFEWq+3IqLXKONX3U/OF/ZJaD2xzFwt24DKhZfLQtn2JvRxuikdZ7DTH24Dky
         1SFpUP0J+e6PqHxUMgQ6T30qeJSQ8wTdIeBno/NmVrNXsg88kOELAIigrF1opcTwqZ
         b5dY/vkKIGldw==
Received: by mail-yb1-f178.google.com with SMTP id v186so694455ybg.1;
        Thu, 06 Jan 2022 10:42:29 -0800 (PST)
X-Gm-Message-State: AOAM530FFQfovabRxITXSqRy78WbgKphVJo74nvqtJiaUqq8veQclbWn
        EjjdNDigLG4AE1P3t7CwStPmlR1KDvrjB4pVCFc=
X-Google-Smtp-Source: ABdhPJxIpVyBxrDVktngcmRTfy3nlYGwvJuvTWxisNja+rcM7E97susiKeHKn4hCn0BWd0NBLQqVVU7quZsWoBzQ9Vc=
X-Received: by 2002:a25:8e10:: with SMTP id p16mr66036062ybl.219.1641494548170;
 Thu, 06 Jan 2022 10:42:28 -0800 (PST)
MIME-Version: 1.0
References: <20220106100335.3279066-1-gregkh@linuxfoundation.org>
In-Reply-To: <20220106100335.3279066-1-gregkh@linuxfoundation.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 6 Jan 2022 10:42:17 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5hmLiMtW+U02kSQ3tcnhFQSAuG7=D8pwWM1JLWhvaWSw@mail.gmail.com>
Message-ID: <CAPhsuW5hmLiMtW+U02kSQ3tcnhFQSAuG7=D8pwWM1JLWhvaWSw@mail.gmail.com>
Subject: Re: [PATCH] md: use default_groups in kobj_type
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 2:03 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the md rdev sysfs code to use default_groups field which
> has been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.
>
> Cc: Song Liu <song@kernel.org>
> Cc: linux-raid@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied to md-next. Thanks!

Song
