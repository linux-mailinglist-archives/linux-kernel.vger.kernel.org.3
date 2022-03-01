Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615B74C926A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbiCAR7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbiCAR7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:59:21 -0500
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635C53EF02;
        Tue,  1 Mar 2022 09:58:35 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id b35so28713136ybi.13;
        Tue, 01 Mar 2022 09:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MBGf7BonI3ap2E4zIN9sAwq7uxa0Dhwh8KKVMelMOeA=;
        b=CdOSnmeMgMbVSw5IWnIKpJdYtsGofY8fCZSIBOpiB6ExycYtUW0mMgCfLW0ekw8Cnz
         4n2frtLHl0BpzqLIx2xL4UXBveaK1QhS3T6+IgX8MAi+4QNtxAIad2KizbN8Fn2uUD+F
         f/HeYAzxxLYVmCFh4TLVi8q15sAB2kSDxJMc/uhnfU/9ByhVwn4lhe+s5Xvgu1vcDAMi
         JXtYVOtMMz8PFYvPSfhhrwjVL1x/Go1LffP+wEpWUufDgz0QJWGdeF1JzcQwhiU4R2bX
         EG2NHgKh0bozrC3zIWx97UoP9iJBp/RQzIQbFHSYIdL/Dab6yQMdYNfEF4po3Qnz9jBI
         PMBA==
X-Gm-Message-State: AOAM530UUy3I8EkJX83ICJbGQ1kPjplQQDofKbZhmvXsRaC5p7KSJ4tA
        abpBUSIB5Wi3aC+dRvlrHxbK2McJYnGXSbACZFxlKtis
X-Google-Smtp-Source: ABdhPJz5SZhw0CpuWATFioDafwyrSWmIvZN1RYk6r8PiHn3hcphDNq4zDYVsLeEr0gv7HOVI7tgDAvIIHoyQqSMVLXQ=
X-Received: by 2002:a25:3a41:0:b0:628:86a2:dbc with SMTP id
 h62-20020a253a41000000b0062886a20dbcmr2572961yba.633.1646157513220; Tue, 01
 Mar 2022 09:58:33 -0800 (PST)
MIME-Version: 1.0
References: <202203011104.TkmvSjFD-lkp@intel.com> <20220301032854.GA65991@baa819af95e9>
In-Reply-To: <20220301032854.GA65991@baa819af95e9>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 18:58:22 +0100
Message-ID: <CAJZ5v0jQcNUN-mQPu9+tsb=cfdrCaH16U77yMoAPZ2Si2gKX2Q@mail.gmail.com>
Subject: Re: [RFC PATCH linux-next] powercap/drivers/dtpm: dtpm_node_callback[]
 can be static
To:     kernel test robot <lkp@intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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

On Tue, Mar 1, 2022 at 4:29 AM kernel test robot <lkp@intel.com> wrote:
>
> drivers/powercap/dtpm.c:525:22: warning: symbol 'dtpm_node_callback' was not declared. Should it be static?
>
> Fixes: 3759ec678e89 ("powercap/drivers/dtpm: Add hierarchy creation")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/powercap/dtpm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index 414826a1509b6..6d890d8cf9169 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -522,7 +522,7 @@ static struct dtpm *dtpm_setup_dt(const struct dtpm_node *hierarchy,
>
>  typedef struct dtpm * (*dtpm_node_callback_t)(const struct dtpm_node *, struct dtpm *);
>
> -dtpm_node_callback_t dtpm_node_callback[] = {
> +static dtpm_node_callback_t dtpm_node_callback[] = {
>         [DTPM_NODE_VIRTUAL] = dtpm_setup_virtual,
>         [DTPM_NODE_DT] = dtpm_setup_dt,
>  };

Applied, thanks!
