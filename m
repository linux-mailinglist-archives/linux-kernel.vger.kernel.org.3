Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F6050C2CC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiDVWPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiDVWO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:14:57 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE46313D32
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:04:21 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r189so16662531ybr.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aYWN6UcwQn9hYVNP7fZKjl2zkX+QOzOchBwUv3s4NaA=;
        b=KCP19bQ8+TN5wujNrgIYpA+fa5UJ7pdOt3IlkVujAsJ8FfaSHSreaQjpwXjwEbpQMf
         JLB5TO8pPFe60g5ugRq/hJiCFDbc9WMseIIW7G+EsqF8zKlRYPzjvAYr0ZWZxceqtCLh
         gAfmHy1cCeOljPcOY4DWjEVmM1uj2aQQIRYWuhNQV9/M7g2CdHR0Zn01S+imG7K3phw8
         1WQ6XeHNGEKKdIG2Z4S+hwM+/BR7/8pt7bQSNra4xoO+vNQTLneNef+eVD1+asgcRFk1
         omTC6wbYNJh7ohtNzO7Ci4TBfSSjtrD1GHjgdkheHW99KeWHCv5DXQVzoDp6eqGvuHFn
         YGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aYWN6UcwQn9hYVNP7fZKjl2zkX+QOzOchBwUv3s4NaA=;
        b=rPYwGWdq2O+YAxhh6zcf7QVQtUpZzFzZb4Pm5zJmsHheI990358BUaVrDy4jWf+N/W
         d4PsJ1Fy0UUaepszQGjiqSoyyU1ZicJ+E1MLBzifvMCxj4LPTAZlMtH0zQBduKZlGVnU
         2bQ48SDgM5Ib+NiPrgfsCqrYe4H04qa5AsayNKlD+UlYH7dJGVBIoNkhwIVXA/sxhn6q
         BflnGf6avKiLsbO3m7232w6jZo8EBJrD4OLGs+Ac9UqkvRgwM897PEubim9AkCp8vQnZ
         fjSSAQAIEqom6zZhFLnaPQKRzs+7hpWwACrFvVOxOpKCWFacnDjmEimbzfN72W/syiy7
         5tkg==
X-Gm-Message-State: AOAM533FFWjS1nHcQDGj0i9W3OssoYh2PTTprkEVSjj7kmgTvp6IOort
        nFblotiPOBClc2pYcDHUBU0p1JLpCiyuVq+MLW+j2w==
X-Google-Smtp-Source: ABdhPJwOLl69ONZse3LlMSadJfpSlZ5uJgM87jIpZDIuTAvisilaQaJ5kbGJbmhH0Gsjd3SEDd1krUQk9FE89Wl96E8=
X-Received: by 2002:a5b:8c8:0:b0:641:e8de:a6f4 with SMTP id
 w8-20020a5b08c8000000b00641e8dea6f4mr6305577ybq.533.1650661461208; Fri, 22
 Apr 2022 14:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220422102541.33372-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422102541.33372-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Apr 2022 23:04:09 +0200
Message-ID: <CACRpkdaLXQf6ZuH9VHAKCH2Qe2EjHZEbHmZffCy0k5K-xO29+g@mail.gmail.com>
Subject: Re: [GIT PULL fixes] pinctrl: samsung: Fixes for v5.18 (current cycle)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 12:25 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Two fixes for the current cycle.

Pulled in for fixes, thanks!

Yours,
Linus Walleij
