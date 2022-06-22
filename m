Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263845546FD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357365AbiFVLbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiFVLbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:31:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165DE3C4A6;
        Wed, 22 Jun 2022 04:31:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id t5so1042693eje.1;
        Wed, 22 Jun 2022 04:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eh4HkVDsNUcCjrVrz6IL8I6Ukne0dRUkr7TQ/GhLVBU=;
        b=AZ9iej0XvpRnAhLD0JjZROv9wQKxswkBKvySPNAOlAVr4hLjq6S0zLYbT20iYjL2RT
         LtcXWf6faKwiu8Vm3IRB/m7SgiMBgc27JaqNRB0Ecd7CQNM0oriSgmqQfbXqNsvigxOy
         Z2IcJK3BUajzLfaGACW3JJrVYZbG5FXbzE4vfRcfI/UKVvBgy7YDajzRG+W+ohzOcPXt
         G8+n3ZDIEH69dqmD59bZo9XhziSFnZ3m7cZ3zwXAAo+fXzPFn1pBH/0CHvb0k28p5UEL
         q1O/5IaDBVcqXvbvztxEy0puq3RSiRPFbYsuY88sI+ynuVtauiPw/PTFYRA6Ane8o78K
         4A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eh4HkVDsNUcCjrVrz6IL8I6Ukne0dRUkr7TQ/GhLVBU=;
        b=co2UcAeLV1ZKPF9QPqw28/NYl1uCq2TjDhFFn7rYudMwCKr45vSBkDdV7b5fXElg1H
         Rd7ZjTJRB4hhNoQ2LFF6TsuIG3rE2vcqKYWeqMy9tkuusPUqLaPZ7S3+SgfPu1GCHYJj
         0P1zaq5VIXRR0ZONtrIDOlPvVWRZf/5hXcDHplyMY+6UD5ceMOkgZe+lySZtlmvIqNyq
         jNGBWlinkiwYg+rd2IHjshv2FEzKJgQs0LL7pWT7PLtCpNdqneWqZAm5+LARP07pI2r2
         0f8ELuh2Q/2vu12bvsKLY00WhuoLuHaWk+xqPgYLSk8MQ2EwGcN4KHrZnnZAejyDPQ/J
         4QhQ==
X-Gm-Message-State: AJIora/11Rq5NYZAKKHnOISrckRgPpozctRJd2STvSrw/cqJdp/+gfPa
        bosMR/uQsD/4cMTNNCGPF/10tykps6kY0YhUMz13N5B25ZEqow==
X-Google-Smtp-Source: AGRyM1uB3jIgZPVv/WFvInCqvONtcIcqxiGZf8z2oaOvwVU053ZyMI96nxq9avUKA7dxjIo9PYTLDDP1bUMfNBKUTMw=
X-Received: by 2002:a17:907:e92:b0:722:efe6:90fc with SMTP id
 ho18-20020a1709070e9200b00722efe690fcmr2759893ejc.44.1655897465576; Wed, 22
 Jun 2022 04:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220621150436.3303431-1-sudeep.holla@arm.com>
In-Reply-To: <20220621150436.3303431-1-sudeep.holla@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Jun 2022 13:30:28 +0200
Message-ID: <CAHp75VdFNir18Q-mLVd_87Sxd1Dz0Hg2B4XQfm5XzagO8sZQrg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: ACPI: Update links and references to DSD
 related docs
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 5:12 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> The existing references to DSD are stale and outdated. The new process
> and guidance is maintained @https://github.com/UEFI/DSD-Guide
>
> Update the existing documents to reflect the same.

Taking Rafael's comment into account,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks!

> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  .../firmware-guide/acpi/DSD-properties-rules.rst      | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/DSD-properties-rules.rst b/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
> index 8b2d8d0864c2..70442bc2521e 100644
> --- a/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
> +++ b/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
> @@ -21,7 +21,9 @@ specific type) associated with it.
>
>  In the ACPI _DSD context it is an element of the sub-package following the
>  generic Device Properties UUID in the _DSD return package as specified in the
> -Device Properties UUID definition document [1]_.
> +section titled "Well-Known _DSD UUIDs and Data Structure Formats" sub-section
> +"Device Properties UUID" in _DSD (Device Specific Data) Implementation Guide
> +document [1]_.
>
>  It also may be regarded as the definition of a key and the associated data type
>  that can be returned by _DSD in the Device Properties UUID sub-package for a
> @@ -36,7 +38,9 @@ Property subsets are nested collections of properties.  Each of them is
>  associated with an additional key (name) allowing the subset to be referred
>  to as a whole (and to be treated as a separate entity).  The canonical
>  representation of property subsets is via the mechanism specified in the
> -Hierarchical Properties Extension UUID definition document [2]_.
> +section titled "Well-Known _DSD UUIDs and Data Structure Formats" sub-section
> +"Hierarchical Data Extension UUID" in _DSD (Device Specific Data)
> +Implementation Guide document [1]_.
>
>  Property sets may be hierarchical.  That is, a property set may contain
>  multiple property subsets that each may contain property subsets of its
> @@ -96,5 +100,4 @@ contents.
>  References
>  ==========
>
> -.. [1] https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
> -.. [2] https://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
> +.. [1] https://github.com/UEFI/DSD-Guide
> --
> 2.36.1
>


-- 
With Best Regards,
Andy Shevchenko
