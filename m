Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE3655C12C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbiF0MPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiF0MPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:15:41 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CFDDED0;
        Mon, 27 Jun 2022 05:15:40 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id h187so14193128ybg.0;
        Mon, 27 Jun 2022 05:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VV+3h/hOlp+Oqi8pE+qwrDgICcdZetvcWIrS7f4iZ4w=;
        b=G7q2GM+3KjuplnwzdyqeXX35Pt2AyhnLviySmtIC8IlqNWM8IGUmFn2P/6vNDDSp+P
         ya/W+NfULx2HpeefUvoYUeRLaL+TUnrcgYPjJ44fLmG8QkEkQW77avNhrl1mt/iIwrxo
         2bVhAEzZMfgPBhVMyaPvw1rrqrGV/DeTqWyj23q+EvZHnzNxH69EShEVWdqbrtVSN07w
         EfWKGy1PnZA264cxmq7z+SovfThnMmDqEBwqkjs1EwkCUrG9XYkMbH7QLNOFC+0ZaNAp
         Ko2GZ+ZxPrCqMq3imQ3S7H1QOmXRlm/T2oMHsdxfpWhMNUKF6mmEeXe5SwNurj9R0tUZ
         yooA==
X-Gm-Message-State: AJIora8BUxpk/3H3Nb5qKv+iQy1zZnETPq1iYl0qR1HT8HiTblwy61Wa
        BL8S0QptSIjE/mzBJxFGbltq4gYkhlrrfog21EwTht++
X-Google-Smtp-Source: AGRyM1sIcaPnangclcdjMv/KoVhma5+DuiOxcAfH1kPxywchCZWgQK9kFKsDeE0uJPZcFhHgSU8CfaEJReHPYqf6oMg=
X-Received: by 2002:a05:6902:147:b0:669:b0af:c7ea with SMTP id
 p7-20020a056902014700b00669b0afc7eamr12416736ybh.622.1656332139357; Mon, 27
 Jun 2022 05:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <1843211.tdWV9SEqCh@kreacher> <2653857.mvXUDI8C0e@kreacher>
 <2726954.BEx9A2HvPv@kreacher> <YrmWpn03cys9WUK3@google.com>
In-Reply-To: <YrmWpn03cys9WUK3@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jun 2022 14:15:25 +0200
Message-ID: <CAJZ5v0h=_grbXEJa2LKKvbkQ+GkLPvnnThnD-_J01ToC2-48cQ@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable branch between MFD and ACPI due for the
 v5.20 merge window
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Mon, Jun 27, 2022 at 1:43 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Rafael,
>
> As requested.
>
> The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:
>
>   Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-acpi-for-rafael-v5.20
>
> for you to fetch changes up to 0c9b9c2ac0df57b6b5949a51c45043b345698428:
>
>   mfd: core: Use acpi_dev_for_each_child() (2022-06-27 12:22:06 +0100)
>
> ----------------------------------------------------------------
> Immutable branch between MFD and ACPI due for the v5.20 merge window
>
> ----------------------------------------------------------------
> Rafael J. Wysocki (1):
>       mfd: core: Use acpi_dev_for_each_child()
>
>  drivers/mfd/mfd-core.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
>
> --

Pulled, thank you!
