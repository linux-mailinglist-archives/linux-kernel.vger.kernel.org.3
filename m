Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C01553F293
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 01:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiFFXcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 19:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbiFFXcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 19:32:42 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9B82935E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 16:32:41 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-edeb6c3642so21078554fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 16:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=hQOXywD53mfOICrUlqm4ergu8RVMvPyByT866xTnrj4=;
        b=X0pxNxEcVR9XS4U5iXvbYSXUQK6/iECGViv3C4LCVQ/IunDo7i4p9wZxjDulQSpKGJ
         Ck8qrgJZ4pWPurmAF1Ab3qyFjCR0gew97jdg1gmpvUB1kh4p9lQbr8cGY0PHDAv3OY47
         q9x1BXrsMAM9UxXgKpPkXbJ0jZxr73z5+qJ4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=hQOXywD53mfOICrUlqm4ergu8RVMvPyByT866xTnrj4=;
        b=GbwM2ma2yGJ2JxlBXgoLL7/x3qhq6ergg+wxwiqhd7a7u28wUv7g6FIBe4nBk/FZ8/
         ohuF+dl6QOZI1pZsQeSOmi+C3sOuR31hehld6+gZF6OaEi93UEYN5RRa2QucfbNIvzWk
         q0qHtRu8ZZYCjH56V0li2stC0otmyG8VNpbHgKd2qAX9TfubVsLWYwEmBBVz1y1f3cfL
         MPtLFUPFb8sn6tUKYVZfHY0ANGcJsCxqTPH5GYYJApt/6Fvg5dywn9OVrdC06bM29o/O
         Sp22dEKO9HWCifGSBHD4Nj5Dnbp+PCk//4YiMUlpRw75ErJLAt+NCID2rQi8yUOo1jkk
         MJ8g==
X-Gm-Message-State: AOAM530Cyw+dQ/nnhEwCO77NJ9nAH8/GM1zY0CiEGLfqBSFOSJpwICjx
        /V56+9Rl2mUCSf5tNB3mLShWq/yqmx7xU2/4Pj8vnw==
X-Google-Smtp-Source: ABdhPJwk9K7j7K/EeZ6d9lvvaM25bB/d0aQ7YdHx/FDpd0oe1BlGdCt3QWlr4jvoED+Hys6JJSsLcGu2mjZVbWgtPy4=
X-Received: by 2002:a05:6870:558e:b0:e1:db7c:26aa with SMTP id
 n14-20020a056870558e00b000e1db7c26aamr15265956oao.63.1654558361069; Mon, 06
 Jun 2022 16:32:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jun 2022 16:32:40 -0700
MIME-Version: 1.0
In-Reply-To: <20220606201825.763788-3-pmalani@chromium.org>
References: <20220606201825.763788-1-pmalani@chromium.org> <20220606201825.763788-3-pmalani@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 6 Jun 2022 16:32:40 -0700
Message-ID: <CAE-0n50YQ+ay02DucYb_V3g_Nf_UOoMQC1a=oJasj6kh+ueH=g@mail.gmail.com>
Subject: Re: [PATCH 2/3] platform/chrome: cros_ec_proto: Rename
 cros_ec_command function
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, Brian Norris <briannorris@chromium.org>,
        chrome-platform@lists.linux.dev,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prashant Malani (2022-06-06 13:18:03)
> cros_ec_command() is the name of a function as well as a struct, as such
> it can confuse indexing tools (like ctags). Avoid this by renaming it to
> cros_ec_cmd(). Update all the callsites to use the new name.
>
> This patch is a find-and-replace, so should not introduce any functional
> changes.
>
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
