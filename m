Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7096E583C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbiG1Ks4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbiG1Kso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:48:44 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E191573B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:48:40 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id w16so1078562ljh.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYLN2VgFPShJvkoh7oJtGxXStSJxN1cfz1bpPXRcJLM=;
        b=a+Dj/mYhB8H1Bp+5HLk5zHgeUYIKBPfd7Yo+ipogyQ3BXiEoDKeRLhR1S/YwL2OmaS
         E1A06DTnla0zeAljOyHhRQMruZlceg6qHB9sQGGoJrvAPWsJot3Zvi8gJBXzakTKzYhP
         7sZ1Nz+zP+fVgCfS2JlVWNUeXkWgJNZyHBbKuT6BOmWOr/7L9y8N9AurxpWGAb1nf338
         mmPyfVLmA70r8mCWrfeNwPur8tNSKVSth3eixf4nGGuSrIrHJA812nUGMCPns59eXjR9
         iTtB0qopT7eOf4W2US7gjDOS+JfO3InU/ZOaYdYSKEobdJMyBu/tVYAjV3JIvyvIrtic
         f/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYLN2VgFPShJvkoh7oJtGxXStSJxN1cfz1bpPXRcJLM=;
        b=6j72RtTuOuwu2PbbSR++/SmTf0K/ofIdh2FR3l6uIqSiYzBjdLBFjCATezGOjMq3iH
         wf2AyyNZgT7TcJJ3o3vZFU9SRxhi0uQIN3+YXClZvmrr7qDXJ3BMpqsmPCv0Tk5ntZzl
         63WyDFUvV7KgwFv+i8tYOQBStvhjKvP15+V3HXbdIKfglQ2fLAzolZWbk5IKgviU5XOD
         Apgyzjw58lWrzz6DCj4fKaYlzAKOv2gpl6GXbhLnXm96HBS6oDfucjhc4tBGAzFfwQlO
         QvByxnMAHT9pbkzYImbdz0pzRMb92DIZc3fT7LwaGtlbG4eMaR1uenfoNXhpmJ0VHSgl
         xshg==
X-Gm-Message-State: AJIora+RIPHLTeD4tnbwI23LmwvjIObpAvH9n9F18YhLw/wLmDXrX4J1
        vcBrUOo47Qf+eKIEsJr37xuoJzc0HnRGo61jFyRV+A==
X-Google-Smtp-Source: AGRyM1v0PalcgYlIcJ0DZQcgyrxJwJ31CaZnUffSCZOp+2Ho1FbpEAoopHkS2fCpuqbTQnTWL1WcoxUwQCKwOJPqYTo=
X-Received: by 2002:a05:651c:1147:b0:25d:eb36:755d with SMTP id
 h7-20020a05651c114700b0025deb36755dmr8521602ljo.16.1659005319133; Thu, 28 Jul
 2022 03:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220727185012.3255200-1-saravanak@google.com> <20220727185012.3255200-4-saravanak@google.com>
In-Reply-To: <20220727185012.3255200-4-saravanak@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 Jul 2022 12:48:02 +0200
Message-ID: <CAPDyKFrBuNfs5-mQbtGMjokxAFrbJ5rmQw3tgks16p0mO0uuNg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] Revert "PM: domains: Delete usage of driver_deferred_probe_check_state()"
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, naresh.kamboju@linaro.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 at 20:50, Saravana Kannan <saravanak@google.com> wrote:
>
> This reverts commit 5a46079a96451cfb15e4f5f01f73f7ba24ef851a.
>
> There are a few more issues to fix that have been reported in the thread
> for the original series [1]. We'll need to fix those before this will
> work. So, revert it for now.
>
> [1] - https://lore.kernel.org/lkml/20220601070707.3946847-1-saravanak@google.com/
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 3e86772d5fac..739e52cd4aba 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2730,7 +2730,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>                 mutex_unlock(&gpd_list_lock);
>                 dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>                         __func__, PTR_ERR(pd));
> -               return -ENODEV;
> +               return driver_deferred_probe_check_state(base_dev);
>         }
>
>         dev_dbg(dev, "adding to PM domain %s\n", pd->name);
> --
> 2.37.1.359.gd136c6c3e2-goog
>
