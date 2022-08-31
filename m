Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CB35A861D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiHaS4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiHaS4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:56:06 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B7461D46;
        Wed, 31 Aug 2022 11:56:04 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3376851fe13so316202837b3.6;
        Wed, 31 Aug 2022 11:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GlDBbqQGEUSGUTxcKRe7u2M4/gH0IknucXRHAJlwKWY=;
        b=HokelKnleAYKY5XMocSjaOZX9zD1lRnE68ovZ8bPITgi7KBAlYwTvQrjWlfjF8URln
         wShsWkwsBF4dsBdeTvjJjQgNldxDle/N0IrifrcnLBuTPXAPX0mrKyiEhhyts96wxLOc
         IZljpu/WsTdQ9dw7dgQUwpSg5/N69Ii8muF08zT0hqiaa5ylOulMhaNvSn0jFh4ppg6a
         oM7T+RKMTL6qKGjwI0dq9/J5wqqtnZV5j44EFEgK99+pxU3ZVqa5+dke4n9nzqSSHE21
         EE58m6MpiPoq8cgvykl3rBpClEFt0ljIT8GYnHREQsbHsAyTPO/e5OAklh1iqWlbPUEf
         mcAQ==
X-Gm-Message-State: ACgBeo2UsNuHtDLzHiCxeNzt7KkG5ZA++xKPXFApR5li1HthQFox4isQ
        LFLh6wtiESX2dK7hWgKagcD17Eyp9GfsfEiw/38=
X-Google-Smtp-Source: AA6agR6qG6dVIYh8CrroiengqgkLkvUbuz2mHoW0DTxXiVTBq7D+1N4PbIe1pWtUvEtgKrLse2SnMUSRkspXaT4Bnlk=
X-Received: by 2002:a0d:c841:0:b0:33d:bf96:f823 with SMTP id
 k62-20020a0dc841000000b0033dbf96f823mr18679668ywd.326.1661972164250; Wed, 31
 Aug 2022 11:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220811120450.13886-1-wangborong@cdjrlc.com>
In-Reply-To: <20220811120450.13886-1-wangborong@cdjrlc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 31 Aug 2022 20:55:53 +0200
Message-ID: <CAJZ5v0g5GO97E4b2EWtktrdP1pKEAbZ-wUvBeTiPZAQ5G88rUw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle/coupled: Fix comment typo
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Aug 11, 2022 at 2:05 PM Jason Wang <wangborong@cdjrlc.com> wrote:
>
> The double `are' is duplicated in the comment, remove one.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/cpuidle/coupled.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
> index 74068742cef3..9acde71558d5 100644
> --- a/drivers/cpuidle/coupled.c
> +++ b/drivers/cpuidle/coupled.c
> @@ -54,7 +54,7 @@
>   * variable is not locked.  It is only written from the cpu that
>   * it stores (or by the on/offlining cpu if that cpu is offline),
>   * and only read after all the cpus are ready for the coupled idle
> - * state are are no longer updating it.
> + * state are no longer updating it.
>   *
>   * Three atomic counters are used.  alive_count tracks the number
>   * of cpus in the coupled set that are currently or soon will be
> --

Applied as 6.1 material under a modified subject, thanks!
