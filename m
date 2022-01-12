Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BDB48BF8E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351438AbiALIKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbiALIKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:10:48 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C8DC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:10:48 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id t24so1633468qkg.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ln4Z+utk5t4wG7dSTr+N/vIytSHGiSk5Tc9SQNyOM48=;
        b=jRXNSagtG+3zCQ/ueepVM/ZM8F+fDU+KYJkYAXte5pXlSXGD9pne8SjP5bzXRhTgTr
         /LDmH+gdHv7f4ka7Fty9DPzim7kmqkCpYiSN6KQNDQ1L+UPPyG2am2s07g300gsYADGT
         AJb+btdFlbtttkdtoD0ebAkqEFyeO5ZOGo36O3wC5NiCecrGTlB1idrAmqutPEOfyWam
         n2rwJW/QZf1zc8D4/iVVtZbcNwIeE6AAM47bc7p45h7cvF0VojA9f3EwrNZAN7Pp7rug
         7ldZ/AEjhRU4lUkcoA5PoPuAYB5eWOFx3J/E/jDvDoQ4tw6dtRSx+L/Q35l36UtxOMOi
         uTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ln4Z+utk5t4wG7dSTr+N/vIytSHGiSk5Tc9SQNyOM48=;
        b=7tHh6OF7NmMyHrxNqguRvfBhxrQX9wGXYbatUZOjOe51GcM5j3akzMB2+F2ct69ooQ
         X3WVDBZZPhFMtWDSlTVccEAWNsoqyzebVW36gfoaY6b3YaZCaeB/0smoojQ9jjlKWHPS
         gP/GeKQ/Y93SfZqE2iwpCesj/0F3Z169vOeeFdzMBwuj0pXls1mmh/ApkRUZx1uWdj/i
         UAKRbWIOgexyISvxvY6KBMmdeyWVq1CosA1M7D/s1eoexbE8/C7ZnTLms89JE8Ixd3Qy
         x4YAyxJZztiAARutPGJkbBKko6dxyrSjxzsgc1q1qTqcl5bJcBiOp2AHkwI3OvGlEGA3
         A1Rw==
X-Gm-Message-State: AOAM5328F4jkB5ALqIH4KlkWFSc0JzuDaVhQksDOUq8R5YsMTG6QZx5D
        Q92Rr23MqmLzyZEx6Whgpcy+qGJqKGXZPYTHq14aYQ==
X-Google-Smtp-Source: ABdhPJxgw8vuzvGsNpSUXyvXwl1oHkWI75DxxBdrzPmti4gBxsNpCUeqpRI1bGJFhSec2o2EMW1PEEto2AraQlbf+yQ=
X-Received: by 2002:a37:8045:: with SMTP id b66mr5682021qkd.670.1641975047533;
 Wed, 12 Jan 2022 00:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20220111175430.224421-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111175430.224421-1-krzysztof.kozlowski@canonical.com>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Wed, 12 Jan 2022 09:10:36 +0100
Message-ID: <CABxcv===MQp6Riutw0Cs=CAxX1k9fNZfcL+nDEuRHveXzjMQBw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] regulator/mfd: dt-bindings: maxim,max77802:
 convert to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On Tue, Jan 11, 2022 at 6:55 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Hi,
>
> Changes since v1
> ================
> 1. MFD: Use absolute path to schemas.
> 2. Regulator: skip properties.
>
> Dependencies
> ============
> 1. DTS patch: nothing depends on it, sending here so Rob's automatic
>    checker won't complain about DTS.
>    I will take it via Samsung SoC tree.
>
> 2. Final MFD patch depends on regulator, so the two last patches could
>    go via Rob's, Mark's or Lee's trees.
>
> Best regards,
> Krzysztof
>
> Krzysztof Kozlowski (3):
>   regulator: dt-bindings: maxim,max77802: convert to dtschema
>   dt-bindings: mfd: maxim,max77802: convert to dtschema
>   dt-bindings: leds: common: fix unit address in max77693 example
>

For the three patches:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier
