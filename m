Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9C65A883C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiHaVl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHaVlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:41:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0A4DDB7C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:41:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kk26so30927743ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WU8TwX59weh2KUi8DJriBAWyfNZOK1JyUwKsa61x6BM=;
        b=m3wdSFgjzGQu1pPgx6azYcxKeljJ49h1JlVjujJsNt9NawYYgNLaC3I3LreWNceZqg
         2oSclvFIWIJSAxHHl4Zab3Pya83jR7BT7UN7on6KTFF/3X7m0Ny4EArdKii6R1KQvZj1
         uL51NmO5vyDtkHzHn83VhRdXfB+Xk9prHxMD4x7Ldi/Wj/DzAlQH9Vtc6t0Q3nSah7/a
         suE01B9qVO0IODLC11qiJMdc/8wqVdAmWEYcpoYYBV8qJO/4HZX5/3AXbrKAbNETTICn
         FPSChOaPIMgeK27zykg5oBctTfwUm6+FX6fPeSrI5bNGxj4kj4BnTzctaj/a8e9aoCM0
         wRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WU8TwX59weh2KUi8DJriBAWyfNZOK1JyUwKsa61x6BM=;
        b=zlY4S7bZrfZ7helbwAdDW1S4F/zoOzUUqib+1JMQUjifxMvFYNE2mXpiVrMGb8Sc9l
         tLK22PkCU+B/Zbsmj9/HVRlZETPH/BN2rIJ3JJZ3hMZIu4/V3jTMfXGFoTtM0DWm8fA7
         B9nthHh3bmXY3aVhZGhcC3sfo+CjNGUxyZ3lrQleUNGc0aOUlA0tmvS7RdtgvbIYJgoI
         gz1t/0uWm5eJP9Sib2KfMhqiZCDyGKMXhcFqld3fTynAMiijFMMg73YLvlGKqEcfz/BJ
         JFg9jrrXwCBjpybOblDLFWXiOuPSwM5tAyIpjOzBL9n1LLWOpVokALleatlEXUMJiAMn
         wQWw==
X-Gm-Message-State: ACgBeo0j/Fq+hJ2werYyOEGT95otTzqoO+tygwmvw2gknDW8W3vj6J4P
        uMvNzrm7LlrQBRAfgghAQKQM2Oxd2JXyhHM/u6egWw==
X-Google-Smtp-Source: AA6agR7uKsgczyO+XmFZeHo/84bBm3HGz6xwgh/+SeaVLOtk9R7nCnZujhQjjSGkL+hDcbAutoG+U+ipoq3XseXzMoM=
X-Received: by 2002:a17:906:cc5a:b0:741:5240:d91a with SMTP id
 mm26-20020a170906cc5a00b007415240d91amr14851062ejb.500.1661982083426; Wed, 31
 Aug 2022 14:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220831212744.56435-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220831212744.56435-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Aug 2022 23:41:11 +0200
Message-ID: <CACRpkdbYkJLTVgCjLOWnxJPPr4AWNhj=6mfFoQ_1BvaT4GjGGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] swab: Add array operations
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:27 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> For now, some simple array operations to swab.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I like what you're doing here :)
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
