Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E21D495F44
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 13:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380482AbiAUMuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 07:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346928AbiAUMuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 07:50:03 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87CBC061401
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 04:50:02 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c2so17786111wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 04:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8WnVlLCad+BTJhIq1dYyjRwPU8yt5oqicLvPToifnLY=;
        b=ozMEk0hea1zS5Y3gEF5I0OxJbZApnPGXQN5yxCoUM1ZaTRgmEnhgT484AY3aqP03CR
         sGyWgMkDPHMZmm0ggm39/6hqhQ+L59bkU+PvId3JKs/UvRAFzFGbL0eg/ajSJNXomqpg
         xL/U7skkjwbL+c/aAQvydDx7expBjDvvULOtP/7lktsgke/CZPAZNCANAhBWE/JQTReT
         ppHSnxOwqnXco7iYDYuueD5V8AOHdoAr/sO4H4OyLjIcUS0lRve72Nyd1BAGkumQRRmK
         gadYVgsFJ8FGErL8y9XTplrskdebK1Cf5ESiDKFX7gAokPO0QA241XNezcnRcfpyY5HL
         U1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8WnVlLCad+BTJhIq1dYyjRwPU8yt5oqicLvPToifnLY=;
        b=yc7vx1rezFyHVTBK8F6GjV5Lt9ATNlGIaN9xehjiA+nyUtRJs2ifToJA8AiHParRay
         3TDZekhr5wnDEVvJ847ippBiGagcEBztnoV9bUimznp8Mi0IGVa+AZWR5yLct1hOBkqP
         mPk9CZLQC2PvH1+aF+UvTrb2fb9YX6o8h0VUG0rUA5wCZ1S8Na59j5VZZuNwELdYkHt/
         WgI7qnZYKJyco3PTQwRGJYah89npyvq3nK07IjG3pfcwuk8ott7OPOn2JAn4RW3Acnzq
         smgrK08+WZq9uBMRtDKkSiUe+eIuttChb1GesJJci5wipqUNjq5b4cnVod8AzdQt3B6a
         2qBw==
X-Gm-Message-State: AOAM533LxOViZaxfRe7Z3ZIaoxVEVRLpRax3SX02KXLuAky05DPnaIj8
        s9rkdU5uNIopCOLdImgXPxq192c0NP+/r/MZ0lK+3A==
X-Google-Smtp-Source: ABdhPJzzbzZ/20qfk+1Vkh9zB6guw8awdzHtefTn02lW4V4lNLfILOv7KJowBpV6DKCtyC6Sz/6TEhNvyzxIJ3Cv8/I=
X-Received: by 2002:adf:df84:: with SMTP id z4mr3717112wrl.519.1642769401342;
 Fri, 21 Jan 2022 04:50:01 -0800 (PST)
MIME-Version: 1.0
References: <20220113091056.1297982-1-james.clark@arm.com> <20220113091056.1297982-6-james.clark@arm.com>
In-Reply-To: <20220113091056.1297982-6-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 21 Jan 2022 12:49:50 +0000
Message-ID: <CAJ9a7VgyG-pomy0F35pXhy=vNUcUFgxnpMNPZ0pKxbnHdyemhA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] Documentation: coresight: Link config options to
 existing documentation
To:     James Clark <James.Clark@arm.com>
Cc:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.com,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Mike Leach <mike.leach@linaro.org>

On Thu, 13 Jan 2022 at 09:11, James Clark <james.clark@arm.com> wrote:
>
> In order to document the newly added branch_broadcast option, create a
> table that links all of the config option formats to any existing docs.
> That way when the branch broadcast docs are expanded they are accessible
> from both places.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../coresight/coresight-etm4x-reference.rst   |  4 ++
>  Documentation/trace/coresight/coresight.rst   | 39 +++++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/Documentation/trace/coresight/coresight-etm4x-reference.rst b/Documentation/trace/coresight/coresight-etm4x-reference.rst
> index d25dfe86af9b..0439b4006227 100644
> --- a/Documentation/trace/coresight/coresight-etm4x-reference.rst
> +++ b/Documentation/trace/coresight/coresight-etm4x-reference.rst
> @@ -650,6 +650,7 @@ Bit assignments shown below:-
>      parameter is set this value is applied to the currently indexed
>      address range.
>
> +.. _coresight-branch-broadcast:
>
>  **bit (4):**
>      ETM_MODE_BB
> @@ -657,6 +658,7 @@ Bit assignments shown below:-
>  **description:**
>      Set to enable branch broadcast if supported in hardware [IDR0].
>
> +.. _coresight-cycle-accurate:
>
>  **bit (5):**
>      ETMv4_MODE_CYCACC
> @@ -678,6 +680,7 @@ Bit assignments shown below:-
>  **description:**
>      Set to enable virtual machine ID tracing if supported [IDR2].
>
> +.. _coresight-timestamp:
>
>  **bit (11):**
>      ETMv4_MODE_TIMESTAMP
> @@ -685,6 +688,7 @@ Bit assignments shown below:-
>  **description:**
>      Set to enable timestamp generation if supported [IDR0].
>
> +.. _coresight-return-stack:
>
>  **bit (12):**
>      ETM_MODE_RETURNSTACK
> diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
> index db66ff45ff4c..803a224dbb0e 100644
> --- a/Documentation/trace/coresight/coresight.rst
> +++ b/Documentation/trace/coresight/coresight.rst
> @@ -585,6 +585,45 @@ sort example is from the AutoFDO tutorial (https://gcc.gnu.org/wiki/AutoFDO/Tuto
>         Bubble sorting array of 30000 elements
>         5806 ms
>
> +Config option formats
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +The following strings can be provided between // on the perf command line to enable various options.
> +They are also listed in the folder /sys/bus/event_source/devices/cs_etm/format/
> +
> +.. list-table::
> +   :header-rows: 1
> +
> +   * - Option
> +     - Description
> +   * - branch_broadcast
> +     - Session local version of the system wide setting:
> +       :ref:`ETM_MODE_BB <coresight-branch-broadcast>`
> +   * - contextid
> +     - See `Tracing PID`_
> +   * - contextid1
> +     - See `Tracing PID`_
> +   * - contextid2
> +     - See `Tracing PID`_
> +   * - configid
> +     - Selection for a custom configuration. This is an implementation detail and not used directly,
> +       see :ref:`trace/coresight/coresight-config:Using Configurations in perf`
> +   * - preset
> +     - Override for parameters in a custom configuration, see
> +       :ref:`trace/coresight/coresight-config:Using Configurations in perf`
> +   * - sinkid
> +     - Hashed version of the string to select a sink, automatically set when using the @ notation.
> +       This is an internal implementation detail and is not used directly, see `Using perf
> +       framework`_.
> +   * - cycacc
> +     - Session local version of the system wide setting: :ref:`ETMv4_MODE_CYCACC
> +       <coresight-cycle-accurate>`
> +   * - retstack
> +     - Session local version of the system wide setting: :ref:`ETM_MODE_RETURNSTACK
> +       <coresight-return-stack>`
> +   * - timestamp
> +     - Session local version of the system wide setting: :ref:`ETMv4_MODE_TIMESTAMP
> +       <coresight-timestamp>`
>
>  How to use the STM module
>  -------------------------
> --
> 2.28.0
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
