Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B707549BA72
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356284AbiAYRex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:34:53 -0500
Received: from mail-yb1-f173.google.com ([209.85.219.173]:42912 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588374AbiAYRc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:32:57 -0500
Received: by mail-yb1-f173.google.com with SMTP id m6so63785678ybc.9;
        Tue, 25 Jan 2022 09:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjG6ZPCabDj/UvtG4OHrzsxA62qetQeyeJAyJGBtSVE=;
        b=1lj7w5vv7oXhME4S5kJOZihRJM47ldNNGmXohYDd1Zv2JaxyP8W4t4UtJtzjr0Mm8q
         q421ZuDZ89s2/ER6vGRVGhLHUaCbBkM4CgXN+UKumpbMHcwSuhUOHD7VsYn4ENY6VoWU
         shhYBUqn1rFEjLTH3GeFpkabKFxFJkEXE6p6xX8blRkn0ht1yA7jbBP3N5uWtUl49ZEv
         wY8+3sYPRO2XAbcbNHdO69pyoqUPuL1PKdMGiEamZYb409uW3+ZQ7JD+yUixuLfC1Tj7
         ly40nvXNJqK4Kzd2N9AxkAaDvvogvKzkaMCNKTNEJtMh0QKW7zG5IWWlDROIebKQRxuX
         VdYw==
X-Gm-Message-State: AOAM530RpIrjYHWKBWXzM4/znEo4NFLWbSvjIwBc3FmdiTr+8G1Zx6Gq
        M08t7n32OxBOZNBJhjmMaUJCn4lO+r3hl6KSuTY=
X-Google-Smtp-Source: ABdhPJyH4Kd890IJUjOtliereYgvWaUxJ13iEDli2vfNRtvAwU8mJV65rX43apM9rCL3ari6pYOrqPw5jdcJrtUzgXk=
X-Received: by 2002:a25:1e0b:: with SMTP id e11mr30012726ybe.272.1643131976647;
 Tue, 25 Jan 2022 09:32:56 -0800 (PST)
MIME-Version: 1.0
References: <20220118004821.27408-1-rdunlap@infradead.org>
In-Reply-To: <20220118004821.27408-1-rdunlap@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Jan 2022 18:32:45 +0100
Message-ID: <CAJZ5v0gfQSrEZEwqnBGwYuyS-wt6bHden_87SK5c=cd+_aHVQQ@mail.gmail.com>
Subject: Re: [PATCH -next] thermal: fix Documentation bullet list warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 1:48 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix bullet list indentation formatting to prevent a docs build warning.
> Use same indentation style as other files in this directory.
>
> Documentation/ABI/testing/sysfs-class-thermal:201: WARNING: Bullet list ends without a blank line; unexpected unindent.
>
> Fixes: 80da1b508f29 ("thermal: Move ABI documentation to Documentation/ABI")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: linux-pm@vger.kernel.org
> ---
>  Documentation/ABI/testing/sysfs-class-thermal |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20220117.orig/Documentation/ABI/testing/sysfs-class-thermal
> +++ linux-next-20220117/Documentation/ABI/testing/sysfs-class-thermal
> @@ -203,7 +203,7 @@ Description:
>
>                 - for generic ACPI: should be "Fan", "Processor" or "LCD"
>                 - for memory controller device on intel_menlow platform:
> -               should be "Memory controller".
> +                 should be "Memory controller".
>
>                 RO, Required
>

Applied as 5.18 material, thanks!
