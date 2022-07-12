Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D439572286
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiGLSZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiGLSZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:25:07 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3101CB79E5;
        Tue, 12 Jul 2022 11:25:07 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id y195so15439163yby.0;
        Tue, 12 Jul 2022 11:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WhigSqxeprC/iSJ1PmZDgrTrNXdKTQMiYjkNAnJuhDQ=;
        b=cpjPJypm3a1bcsYKwvB7cPS7nqg2Ls2ulHKaGwDTPqDCUUYJ+heqh/GTFicw3GANNN
         m5mPG849zwsHswMbWtp4iV4wxLBRhs7QqlyvF3LF7pyIPHu6+Rft8LvO0ue8xX7L3+Hj
         0q9/Iw4CDkOILcBtOCwfMTm8RRJASKMRb5ub8BgQz81URJ6Y7d8elc20ZUzLGTEo3DKd
         PlFKCzF60JcqZjvrhKIh/FslC6IMvN0ykzX2gTDBqjNmG+1xd3KXAnsCbBaYqh4KbUeh
         oQDoUCDjAbkVSPYvAN/8sTXtKiATV+KhqVPr5WNm/RN1Z1km1UVQBFYbxQblogr86bUf
         tw6A==
X-Gm-Message-State: AJIora+oiLHVXoVkyN7vDhrbRHwmZ6GXGaqzUmW3+MWzyIzZkzGKGMcH
        3erK8uiBHBC6hecO+a1Fh7N2CPmWw/0pXC4oO8w=
X-Google-Smtp-Source: AGRyM1sJRFpRWREBGTsyEusLfQW7bqW/jZJS4G6oCVKzesRFaRJRtA7WeQJmY45VWkelgOQGJM8Iv1Vw8yZj+NqWwkY=
X-Received: by 2002:a25:d714:0:b0:66f:5898:9eb1 with SMTP id
 o20-20020a25d714000000b0066f58989eb1mr8352308ybg.633.1657650306516; Tue, 12
 Jul 2022 11:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220622155543.9780-1-jiangjian@cdjrlc.com>
In-Reply-To: <20220622155543.9780-1-jiangjian@cdjrlc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Jul 2022 20:24:55 +0200
Message-ID: <CAJZ5v0ioojTNtwEXu=JKPTTYypxoYDr1uUQFSCR0rpVRUQPhXg@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: drop unexpected word 'is' in the comments
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
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

On Wed, Jun 22, 2022 at 5:56 PM Jiang Jian <jiangjian@cdjrlc.com> wrote:
>
> there is an unexpected word 'is' in the comments that need to be dropped
>
> file: ./drivers/thermal/intel/x86_pkg_temp_thermal.c
> line: 108
>
> * tj-max is is interesting because threshold is set relative to this
>
> changed to:
>
> * tj-max is interesting because threshold is set relative to this
>
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/thermal/intel/x86_pkg_temp_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> index 4d8edc61a78b..a0e234fce71a 100644
> --- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> +++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> @@ -105,7 +105,7 @@ static struct zone_device *pkg_temp_thermal_get_dev(unsigned int cpu)
>  }
>
>  /*
> -* tj-max is is interesting because threshold is set relative to this
> +* tj-max is interesting because threshold is set relative to this
>  * temperature.
>  */
>  static int get_tj_max(int cpu, u32 *tj_max)
> --

Applied as 5.20 material with some edits in the changelog and subject.

Thanks!
