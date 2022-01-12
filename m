Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D1448C665
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354285AbiALOql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:46:41 -0500
Received: from mail-qv1-f41.google.com ([209.85.219.41]:34520 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354244AbiALOqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:46:32 -0500
Received: by mail-qv1-f41.google.com with SMTP id iw1so3164647qvb.1;
        Wed, 12 Jan 2022 06:46:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFhk5Nmh5dx6HMwjHN15mgwgf4iR/f/c2qMiULcRSuo=;
        b=FjGR7cytMJhUuzoKEAFvQLH/WEt01xIhynvNbJwJKqAYY4ieLQikboy0BZeYD1Tik7
         kVFECeo6w27/OfujhKkaPrOLtqfKqx1pkfUz4FQNq97ERDUpJdjMN2QlcImcmGNZ7Vvd
         BCRtVsqub9JOtK+r7GRbNsargWVcdjApL20WmxU7nmGNXj8K1nUH06dgFQg3+E2HZVV4
         k4A/y8LtzJEzYeUdrQZ0CmY9/eexPe4oaFBN+d7MzBVwQnQpyLdhKPFewqcknkQlrMlG
         D+CMpksWnysxcCAagF7zfs44MVYGDf08Ish1ytoU8rIUBpDuOOHTU6gxbPkjWx1se3do
         mMLQ==
X-Gm-Message-State: AOAM533DwXPfpGU4KyQrXhMif4Z9Qi6oCpeVMhl3Nm6kiM9PJdnCADgI
        3lIghJHJSAFZP/VU2tP6+2kHhBicGJCPBR4jyMlpj44QPzY=
X-Google-Smtp-Source: ABdhPJzA5zVY6mGHMZlrlNefwtnT4AkCdSvzeIa5+Ff6drJm5VG5Utb4Lq9UvZbXP/K2RSehsH2+mU8vt5T4FOuK1Fo=
X-Received: by 2002:a05:6214:518e:: with SMTP id kl14mr5395420qvb.130.1641998791509;
 Wed, 12 Jan 2022 06:46:31 -0800 (PST)
MIME-Version: 1.0
References: <9d2182c6-9c63-f3dd-91a6-efdf3671ed61@boldcoder.com> <1f2236ac-0517-8de6-a7a0-a9d04f65bdc8@boldcoder.com>
In-Reply-To: <1f2236ac-0517-8de6-a7a0-a9d04f65bdc8@boldcoder.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Jan 2022 15:46:20 +0100
Message-ID: <CAJZ5v0hSBZKu4+g-hj6H7+H=-JcF0T79HYiXmZFYB5gAQZ60WQ@mail.gmail.com>
Subject: Re: One-line patch: Make ACPI provide CEDT table
To:     Robert Kiraly <me@boldcoder.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 6:20 AM Robert Kiraly <me@boldcoder.com> wrote:
>
> The attached patch is a one-line change to linux-pm 5.16-rc8.
>
> The patch simply adds ACPI_SIG_CEDT to table_sigs[] in
> "drivers/acpi/tables.c".
>
> Presently, CXL code isn't able to make use of the CEDT table. Subsequent
> to the change, the CEDT table can be used.
>
> If a developer plans to use the CEDT table to program the CXL ports,
> this change is needed. Otherwise, it isn't expected to make a difference.
>
> If this should go to linux-acpi as opposed to linux-pm, please excuse
> the error.

Yes, it should, but please see this PR too:

https://patchwork.kernel.org/project/linux-acpi/patch/CAPcyv4j0NfC4RKr=VU6yUKrqVRKdAer9YeSezRctpp-k31iAzA@mail.gmail.com/
