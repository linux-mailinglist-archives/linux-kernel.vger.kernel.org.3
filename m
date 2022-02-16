Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B72F4B90A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbiBPSo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:44:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbiBPSov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:44:51 -0500
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD3C224948;
        Wed, 16 Feb 2022 10:44:35 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id p19so8012088ybc.6;
        Wed, 16 Feb 2022 10:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5O250ZbFc6xxsVLUfdV/FJOXw/nR5fNqCdyV/14B3ag=;
        b=mK6zaclFqkvD1f9Ca/vKA6Lw8nZXc4oq40l6z6SKDT4pthNMQQ5jn9F8BP7BMylH4L
         w9tbdBjH8o+OlAWrMWajbOzS0KVUo3I7b7lLjwQVHsFbJl5H4Dbt/yd5BK+/4+pSFPUv
         dUg4WxTg9a5vkHildKiEfuKfsEeTaIFJbtZmSbE96T/zH8HcbEc4AcTg6YaUvP9SSOIq
         b18lnZZ1KdZfjLlfSUyee7FlzrPg3yVlfb27s0VL872sz+OpbaKaqjmW64x6tWbAPwf4
         CPKA9RN3tjj2VPPwTIgK6GIVkIQf9Czl9RBpqE0Rtmz8JdNaJ2t4nakndt1IqVLgg/Rx
         DfVw==
X-Gm-Message-State: AOAM532+6AAVBkfyWg9rPyYNg/BdYgVBj3bMudLTauJDgbAhPiyUdTZ8
        QOgaTLilhOCzYgdiFkqNSMqKt4FZjRBh9bIZt4M=
X-Google-Smtp-Source: ABdhPJz0dWMy9L0KImFinDaYaMygvUl1SbDHcjdRyT+qEsarJa5kaonBjrPTHfW29kEqH5aPq9sc2TsznEJQlz8zU3E=
X-Received: by 2002:a25:782:0:b0:61d:62ed:112d with SMTP id
 124-20020a250782000000b0061d62ed112dmr3384808ybh.466.1645037074491; Wed, 16
 Feb 2022 10:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20220207191307.2903314-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20220207191307.2903314-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Feb 2022 19:44:23 +0100
Message-ID: <CAJZ5v0gqatnkRt0VqTyHjgL8yNp40Ui3UCMv-PV8qvzefaV5HQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: admin-guide: pm: Document uncore frequency scaling
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Mon, Feb 7, 2022 at 8:13 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Added documentation to configure uncore frequency limits in Intel
> Xeon processors.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> Resent by adding linux-pm@vger.kernel.org
>
>  .../pm/intel_uncore_frequency_scaling.rst     | 56 +++++++++++++++++++
>  .../admin-guide/pm/working-state.rst          |  1 +
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
>
> diff --git a/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst b/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
> new file mode 100644
> index 000000000000..b3519560594b
> --- /dev/null
> +++ b/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
> @@ -0,0 +1,56 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +==============================
> +Intel Uncore Frequency Scaling
> +==============================
> +
> +:Copyright: |copy| 2022 Intel Corporation
> +
> +:Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> +
> +Introduction
> +===========================================

There are no other sections in this file, so can the section header
above be dropped?

> +
> +Uncore can consume significant amount of power in Intel's Xeon servers based
> +on the workload characteristics. To optimize total power and improve overall
> +performance, SoC has an internal algorithm for scaling uncore frequency. These
> +algorithms monitor workload usage of uncore and set a desirable frequency.
> +
> +It is possible that users have different expectations of uncore performance and
> +want to have control over it. The objective is similar to set scaling min/max
> +frequencies using cpufreq sysfs to improve compute performance. Users may have
> +some latency sensitive workload where they do not want any change to uncore
> +frequency. Also, users may have workload which requires different core and
> +uncore performance at distinct phases and they want to use both cpufreq and
> +uncore scaling interface to distribute power and improve overall performance.
> +
> +To control uncore frequency, a sysfs interface is provided in the directory:
> +`/sys/devices/system/cpu/intel_uncore_frequency/`.
> +
> +There is one directory for each package and die combination as the scope of
> +uncore scaling control is per die in multiple dies/package SoC or per
> +package for single die per package SoC. The name represents the
> +scope of control. For example: 'package_00_die_00' is for package id 0 and
> +die 0 in it.
> +
> +Each package_*_die_* contains following attributes:
> +
> +``initial_max_freq_khz``
> +       Out of reset, this attribute represent the maximum possible frequency.
> +       This is a read only attribute. If users adjust max_freq_khz,
> +       they can always go back to maximum using the value from this attribute.
> +
> +``initial_min_freq_khz``
> +       Out of reset, this attribute represent the minimum possible frequency.
> +       This is a read only attribute. If users adjust min_freq_khz,
> +       they can always go back to minimum using the value from this attribute.
> +
> +``max_freq_khz``
> +       This attribute is used to set the maximum uncore frequency.
> +
> +``min_freq_khz``
> +       This attribute is used to set the minimum uncore frequency.
> +
> +``current_freq_khz``
> +       This attribute is used to get the current uncore frequency.
> diff --git a/Documentation/admin-guide/pm/working-state.rst b/Documentation/admin-guide/pm/working-state.rst
> index 5d2757e2de65..ee45887811ff 100644
> --- a/Documentation/admin-guide/pm/working-state.rst
> +++ b/Documentation/admin-guide/pm/working-state.rst
> @@ -15,3 +15,4 @@ Working-State Power Management
>     cpufreq_drivers
>     intel_epb
>     intel-speed-select
> +   intel_uncore_frequency_scaling
> --
> 2.34.1
>
