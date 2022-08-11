Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C964590526
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbiHKQwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbiHKQvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:51:51 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CE618B04;
        Thu, 11 Aug 2022 09:25:19 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-328303afa6eso177602337b3.10;
        Thu, 11 Aug 2022 09:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JGzD77U2Oto0Aqe+gV/4YCX3SgodzAwICFq6gJm9KqQ=;
        b=5oo0b7Nq44R77cJnbhMZjgHyLvNHWfxMWzyXIF4Nqf3IlXlKsd2eTFwvrTtzdGS7Yf
         cm6TVya2IA0KRYJllhmPBtqv2nrI80OvY+Omrns5R+aWV6ThW4NKaaddivboGNQgUOZn
         Dw0o27WcSlXKTJvBxBF/E+yI7Eu1ay808SEXIo3lKk+Fnehwq2y2T4kgcH6jhyR6Ta4g
         HSuhzPLBONYLP9pvNcB+4DqNWCAPP79vk41e+g8jdxNrw1lh2UiNVNsyJxpL6doJEph2
         Cnkd2vfHTLMjgQtEmG7NXZzpmOxi4WLCv4QBqgyppduP8kx3B16y04BFBv91DIkq1w1V
         3uvw==
X-Gm-Message-State: ACgBeo1nPkoxoUCegPWM0CWn+jwGdDzVvtsX/dGcmgV1m7igWA8vuOv6
        pRF0unuydU9HJQJ1LfYYjdLAB4M1gXmQdAXhp2wvMeYc
X-Google-Smtp-Source: AA6agR7xQjC2PfNKM8PnGugI3psJeIEWfvzwZah5ZiCgr9LZ9PxKFGb9Z0NdfE7pGOMoE9xaZ+b4si/z8AoIkxnSrz4=
X-Received: by 2002:a81:ae0a:0:b0:324:59ab:feec with SMTP id
 m10-20020a81ae0a000000b0032459abfeecmr34997601ywh.7.1660235118995; Thu, 11
 Aug 2022 09:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220811154357.18674-1-dengshaomin@cdjrlc.com>
In-Reply-To: <20220811154357.18674-1-dengshaomin@cdjrlc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 11 Aug 2022 18:25:08 +0200
Message-ID: <CAJZ5v0gRUmMu7zGgH3F32C8DB6RsOqnNPw+L8023A89Tiqy-qw@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Fix typo in comments
To:     Shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
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

On Thu, Aug 11, 2022 at 5:53 PM Shaomin Deng <dengshaomin@cdjrlc.com> wrote:
>
> Delete the repeated word "method" in comments.
>
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>

Please note that the ACPICA changes need to be submitted to the
upstream ACPICA project on github.  If your change is applicable to
that code base, please consider submitting a pull request for it on
github.

> ---
>  drivers/acpi/acpica/psparse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
> index ba93f359760a..b0faab1e6d3f 100644
> --- a/drivers/acpi/acpica/psparse.c
> +++ b/drivers/acpi/acpica/psparse.c
> @@ -508,7 +508,7 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
>                         }
>
>                         /*
> -                        * If the transfer to the new method method call worked,
> +                        * If the transfer to the new method call worked,
>                          * a new walk state was created -- get it
>                          */
>                         walk_state = acpi_ds_get_current_walk_state(thread);
> --
> 2.35.1
>
