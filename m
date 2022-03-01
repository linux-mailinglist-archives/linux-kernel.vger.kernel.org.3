Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4674C91DA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbiCARjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiCARjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:39:31 -0500
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A06DBB4;
        Tue,  1 Mar 2022 09:38:49 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id b35so28606320ybi.13;
        Tue, 01 Mar 2022 09:38:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ePx51Sv7Ld1agccWIj8+pLXD3OH6ltHUbmMwSVt9KXI=;
        b=ntFrOp3HcDRuH99EjZBT1aqMYXPO6HBQ8UHjSdwvH+Pv8mgUIzSWRJizRpD+2kFmk9
         bhDUCAp6o2GN+mfjKHYhV/WO9kaPtoYR+BwxetYxgkFpffqoPAVxsF3JEYaJm2FewU56
         zyFxPwr2yWzEw7OA0YUgl43XbnB7yE/JrWiCgSUNcbxfv6KVSvhbs0wMMeGD4OPtr5Vb
         GuZoazsGdN7CwAO8agOgt5ZanRrQgtfOWSbM5yv/twIkh/0WlhFl7E99M6/uUoV+VgsG
         eTv/+Un+xZ4c4l2dvbXCDjus8Q5cjeFuA7t7xC1MX7z018waZD9X3OFPjFizWFpyNu/r
         mA/g==
X-Gm-Message-State: AOAM531cl4OjY8YuoqFQN6tVR2iVtL1loPv9D6UkKyNRlDhS/FYOtqmk
        Jt5FQa4ZQWCU7RTQ6rX8q95e1IsOg93ApX7N84I=
X-Google-Smtp-Source: ABdhPJyyQieBvRl6bas64kvLFYV1/I+bMwcYSMzLk6Fn5RL6vekpAsGWBdDVpIh837co3bbUusTlxHgykN94S3Fvolc=
X-Received: by 2002:a25:bbc1:0:b0:610:b4ce:31db with SMTP id
 c1-20020a25bbc1000000b00610b4ce31dbmr24915976ybk.482.1646156328715; Tue, 01
 Mar 2022 09:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20220228195800.1422004-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20220228195800.1422004-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 18:38:37 +0100
Message-ID: <CAJZ5v0gyL2C=wUO6-H5Lnu9ue4VGasRThmQ3PWE0y0Afa6UZMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Documentation: admin-guide: pm: Document uncore
 frequency scaling
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
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

On Mon, Feb 28, 2022 at 8:58 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Added documentation to configure uncore frequency limits in Intel
> Xeon processors.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2
> As suggested removed "===" (chapter) for Introduction and added two sections
> "Introduction" and "Sysfs interface".
>
>  .../pm/intel_uncore_frequency_scaling.rst     | 59 +++++++++++++++++++
>  .../admin-guide/pm/working-state.rst          |  1 +
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
>
> diff --git a/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst b/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
> new file mode 100644
> index 000000000000..a55cf68d77df
> --- /dev/null
> +++ b/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
> @@ -0,0 +1,59 @@
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
> +------------
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
> +Sysfs Interface
> +---------------
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

Applied (with some cleanup of the wording in the document in some
places) as 5.18 material, along with the [2/2].

Thanks!
