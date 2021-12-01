Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E3946564C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245094AbhLATZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:25:52 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:40521 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbhLATZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:25:51 -0500
Received: by mail-oi1-f173.google.com with SMTP id bk14so50667997oib.7;
        Wed, 01 Dec 2021 11:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R1+7NoubxBPcgvhoV4fHztUtYW0bvTfOsaiYUpkCOz4=;
        b=YxGLsN6fBRlEjcJ7dv+HAhxfZPqnHvmdhQg+Ddx9qh9nLpmX8AJ9Ia64bMWk82YQpq
         Y0Vap2XPcJsTCo292Qt7E87vFrFCHmc0g4DQtYEuI1NZXnyNsIEK1/KA/P5WL1wOdbuT
         UtBMcG8a6vF+h6IAZ5MYQe8lYZBazNkvUHa3CCWTtciwjBv7cs4Kr87wAIlrNhMtGC88
         zBrU1Q/nv7hnuxMdehw5VftLYxZ92SVsNe1yVdKjDD8v5QcAvKUTCFm4ecVw8QHTZIsP
         Ve82B9/V6SlJ/0mC6GcBRhUjd3+vf7oFwBlRgwbd7HrNVeRutGQuAtluSQwvQ5cM4hDg
         7QbA==
X-Gm-Message-State: AOAM530fqq9tTzuraX/pURwANHICbqqgeIOgBu6pbuYe60KI3dtsOkAq
        xwxQ80uw3Wkkt1JGYgDkTVgmuUO4A9QH62Ij6QlLRnkX
X-Google-Smtp-Source: ABdhPJzKqD9FKjt93MN8qWM/HDmpB+9jMWw8rnCcE5bdbD7g/Kr8YXfJjsXiGL6VRMjHpaLdqc4WWod0jHiYQK4NWeY=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr187193oiw.154.1638386549450;
 Wed, 01 Dec 2021 11:22:29 -0800 (PST)
MIME-Version: 1.0
References: <11887969.O9o76ZdvQC@kreacher>
In-Reply-To: <11887969.O9o76ZdvQC@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Dec 2021 20:22:18 +0100
Message-ID: <CAJZ5v0ii+TQDgJ0msejhs5A+OZe+nNiuBq4bxqGsui-hFBpLEA@mail.gmail.com>
Subject: Re: [PATCH 00/10] ACPI: EC: Two fixes and cleanups
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 7:49 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi All,
>
> This series addresses two issues in the EC driver (patches [1-2/10] and cleans
> up the code in it on top of that.
>
> Please see the patch changelogs for details.

No negative feedback, so applied as 5.17 material.

Thanks!
