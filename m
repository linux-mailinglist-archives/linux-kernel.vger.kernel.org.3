Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CDA4A2ACD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 01:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351927AbiA2A4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 19:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiA2A4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:56:19 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA7DC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:56:18 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id w81so1155805ybg.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nmGDwuvfkax3Sda7saTwAAxqwMsmlPhpVKCcAyRAE+4=;
        b=g8yjPt4IeG+Szx3AUtuIzVZxmHIhM2XsIrQO8mD23tMBnH/IH9AWs+sRSsbRLkJCEB
         ++gkH3G3WtjfV2VLWYUhdnjSWQ2WP+Syda59cci4Wmv3GYQCbNPimfY8fLFUC1fnnR+Z
         Aylj+v5+p0FmA1i02GWJk3GmU4tejCH2xWdsAP8IWQ2g41kGy1l2BbVBJgu7ViZUFDk4
         DoC2nW0E5tjN3czpD2RbtQkCYIvP53yLxDm/2V5nR/sLn7zvuOanvVhPmPYcc4jclwNY
         KuiivmT0lHgtpOUFTQQk/AYXPdgYniimNqtRIGg4jT/y0LZw/jpHkh/9BxzsUe3YzYNK
         H6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nmGDwuvfkax3Sda7saTwAAxqwMsmlPhpVKCcAyRAE+4=;
        b=zyX7xv8Bc9OGX60XRoUJYv4sdEoexwU5AIp/r8MMCvUX4cCHX+yWCwYNrS6f8IYlV6
         eI15nAeBvyJj4QWwR5M9ewbD9ZejmhRPzOH6H4dLhzZWnHYGA3SM15vTYcGJPvbp0mnc
         i1cdUBZqna5cyJg3MFKrfG2udUezftfE4fhwSgyPuIdwnqfD/DVVzlmhI4Rvi1E8GJJQ
         uXQ0vAbPIttEKPO3xZPsbtTMv2xSa9/sKGTdyqtv8F2d/B/NdAPuzvBbiW7wS9HDFbyj
         oPLVtMQEIMv+ojZoEVpnulI0nOnCFBzGLP9zCBxD7z0/UtR8BGfHeDt2jv2rCjHxPNaj
         tDAg==
X-Gm-Message-State: AOAM531+EIp4UBuwt0mpbDOWv/cUl9eVu3IrZ8oVLS3R0n/4dR/oreHR
        ycaiJDmuDae1accV/LmAqZvZ7Nhm3BXaddfwCBq3jKjZvH4=
X-Google-Smtp-Source: ABdhPJyWvdcU804CKXVZLmLkK6HbWC8olU8hvyg812kD7z4qs+CeseBUaCVnodiEtWpoWFivSUYVy22N4+xx6mVOD/w=
X-Received: by 2002:a25:df56:: with SMTP id w83mr16041704ybg.110.1643417778032;
 Fri, 28 Jan 2022 16:56:18 -0800 (PST)
MIME-Version: 1.0
References: <202201281045.Z9UBygXr-lkp@intel.com>
In-Reply-To: <202201281045.Z9UBygXr-lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 29 Jan 2022 01:56:06 +0100
Message-ID: <CACRpkdY0zN1RexZDyqdqX_QhtHMV61DBfxiNv1ODXo8KWy42fw@mail.gmail.com>
Subject: Re: drivers/power/supply/ab8500_fg.c:2243:75: warning: variable 'b'
 set but not used
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 3:36 AM kernel test robot <lkp@intel.com> wrote:

> FYI, the error/warning still remains.
(...)
>    drivers/power/supply/ab8500_fg.c: In function 'ab8500_fg_get_ext_psy_data':
> >> drivers/power/supply/ab8500_fg.c:2243:75: warning: variable 'b' set but not used [-Wunused-but-set-variable]
>     2243 |                                         const struct ab8500_battery_type *b;

This is being addressed in a series I am working on (gets deleted) and this
is not urgent to fix.

Yours.
Linus Walleij
