Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5934B2449
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349448AbiBKL3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:29:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiBKL3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:29:39 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D330E64
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:29:38 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id y129so23907068ybe.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HR1DCsTq8FbR4jChot452jyukpf3RSW8+TwQL0Os82c=;
        b=Oewgw1mANcEdHO97bC22n4WPZLTCVC20k22OUzh472scR9w+kXiinaBinhtSUNAJBE
         30h04hfNyANEr3E+79vKP4cOziY8SvRnHul53RlONP2GF/wdaYIDH6DtqEhCXyp5d7Q5
         XRYkAhtSHMI9XQ75cGkj9bQxrwCNYE+QkPIXr1iWbwO0Lr3RfJPUVeWRSKP0CSHA4S5b
         16fEpYa7w7XpKDpc4TjnT7yQOoWuYsgi68UtNXtIYwhJedKjvNB8UTTsiWEO6T1YXP2Z
         uHuvfBHy8bcLYQmumDUmkf5yJeMgrztrMkeq9FJwDscFwxjIUCXsu1weZjQGTmtuZkT5
         Xspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HR1DCsTq8FbR4jChot452jyukpf3RSW8+TwQL0Os82c=;
        b=ttoKt1br9704sh9jwVLBUkFT5uw66SC3/jZdbANafSqS9/ZH4RIGmrvYiD1ORapgdI
         2c5Cn6zGO0oXbbeguk2R0R0w3In2fGGwiu4B3uDAuM2q9YmHE/bLYmZHDkRz3+oxR/et
         b+SN36hFhSbHSw5lBaxAsJvqyBBLDHdnvtnU1Atsb5tbp7sK45vNTj/pat4OkXMCsNXQ
         1hKY2IBhc+lZMGorsh913yEbsFhsAlew+jdDdnrnHLMIYN/yc1jklHgso0lS76RnCxap
         5gXnET/9c0yUMjfFkQ7cA4V5A0YsvKU4XZNYSfIRu1XtrDHEhoreBJD/5t7dxTkr/2da
         wj9A==
X-Gm-Message-State: AOAM531xKqnoyYCyTN+RoEMOrML1M9BuJjgnhAOlvqkjrja57MVr9khW
        u+CVaMKYpp/qzK5mDuf5K9dPUfQDa9J/5yqjUblKmA==
X-Google-Smtp-Source: ABdhPJy9RurKC32AmfoVtPB3myBVO7shQtC7EsCY0JHURPmETIddV1Edg7rfNmYRfWt4357UrFJU1CJpEa2eHyaGgDU=
X-Received: by 2002:a81:3542:: with SMTP id c63mr1093033ywa.87.1644578977117;
 Fri, 11 Feb 2022 03:29:37 -0800 (PST)
MIME-Version: 1.0
References: <20220210230819.3303212-1-frowand.list@gmail.com>
In-Reply-To: <20220210230819.3303212-1-frowand.list@gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 11 Feb 2022 16:59:25 +0530
Message-ID: <CA+G9fYvuk-vhRXU1ncz51WJfbR3CZ=VgY9SZmw9Qoub6P2NeWA@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: unittest: print pass messages at PR_INFO level
To:     frowand.list@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 11 Feb 2022 at 04:38, <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> Printing the devicetree unittest pass message for each passed test
> creates much console verbosity.  The existing pass messages are
> printed at loglevel KERN_DEBUG so they will not print by default.
>
> Change default to print the pass messages at loglevel PR_INFO so
> they will print with the default console loglevel.
>
> The test community expects either a pass or a fail message for each
> test in a test suite.  The messages are typically post-processed to
> report pass/fail results.
>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log link,
https://lkft.validation.linaro.org/scheduler/job/4529628#L1697

> ---
>
> One review comment to similar previous patch "of: unittest: print
> pass message as same lovlevel as fail" suggested to also change
> the text of the pass message to include "PASS" instead of "pass".
> I would rather leave the text unchanged to minimize churn for any
> existing users of the message.  It is my intention to change the
> pass and fail messages to KTAP version 2 format as soon as that
> version of the specification is completed.
>
>  drivers/of/unittest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 70992103c07d..9012e6900965 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -44,7 +44,7 @@ static struct unittest_results {
>                 pr_err("FAIL %s():%i " fmt, __func__, __LINE__, ##__VA_ARGS__); \
>         } else { \
>                 unittest_results.passed++; \
> -               pr_debug("pass %s():%i\n", __func__, __LINE__); \
> +               pr_info("pass %s():%i\n", __func__, __LINE__); \
>         } \
>         failed; \
>  })
> --
> Frank Rowand <frank.rowand@sony.com>


--
Linaro LKFT
https://lkft.linaro.org
