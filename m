Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D62552B658
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiERJ3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbiERJ3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:29:07 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB377980F
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:28:26 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a23so1780336ljd.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4iyJbssYNlPi+45f+NtThll+M9Lz9Ppn1K4R1sxXFY4=;
        b=lrwDlx4vlJSZ304EbwWlxfiASSbB2MWLS1vq7d9jIEKpzYSfYfOzV3m8rUPL3LOeAG
         22O1NXT3tRuXmQ99d1LbczVJFBZXYDkC87uUURbLdTLAuE9a32v7eawxXlSG6cxiZAda
         e5oyiXmj8CswIQ9r4prkCHwQyDFbvqQY6xn0yjhZr7wo/yVSSXOyV2f9Bo8PZ4kQwu3F
         B9sgQrGUNmtDxh1pLLYRYuYCQclCfsqNnivxMM8kEsw3aDulfwLNzBeymCLHtHriSLHH
         Dn/tNP1emfMHReGrP3zYiGF7MDFQX78zp9NK1EDhoFJcohdzjU4G7Fc60wnG3VlpHZVB
         UcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4iyJbssYNlPi+45f+NtThll+M9Lz9Ppn1K4R1sxXFY4=;
        b=saMLEMHCBXZxo5n+ADKVlIxG8fSA73D89OpiSMtu1JcOVqc6ILM5G58o/fnzmiYVYK
         1LnhXyVKpUCCMw6qJS1B+aCqnrY84foVyWvgZnfFA/VZ84zW8bVorqUKbig5/RL56OTK
         4+pq7HazFDpQG6g62dTWo69yiwqbjb3CJp+1U8512Xcx4kpxrtx6XCTzLldLXOnFWcBn
         Zw9xVmdFdtcTsCtMcrLGkJMQGA/wiroByltGzkntigHN9KO0h5I7qd0DET7N1NAQv+yQ
         z1FppCdU0etQrUt9HGB1ZSnSpeq+5HPxMtU0c/UUaB/flrPZkWIXsBUzJSCVuHcp2CR8
         ov6Q==
X-Gm-Message-State: AOAM531yxU0jnavI9f/b/bCD9XSMlqWrIMGk9ZVcZ3juXnrV/f9HO+TL
        k7H1B/xBMncXKtepTZ9xN4a+hMjEDHjqIilQ8iOhow==
X-Google-Smtp-Source: ABdhPJz2CkQgPCfvtX9fVD2yj+/wu/0+UOjIEd7iMSHzt0d0flR8zOqn3w8ny0OUB2jNis4/T445xAVbiwnPPEUTD8c=
X-Received: by 2002:a2e:9d90:0:b0:24f:224:8dfa with SMTP id
 c16-20020a2e9d90000000b0024f02248dfamr16508885ljj.46.1652866102497; Wed, 18
 May 2022 02:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220511144601.2257870-1-james.clark@arm.com> <20220511144601.2257870-5-james.clark@arm.com>
In-Reply-To: <20220511144601.2257870-5-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 18 May 2022 10:28:11 +0100
Message-ID: <CAJ9a7VigLVCa+S=rmpBs9qrmzOtkmo-yzuJJDb_wfZ5coGJnRA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] Documentation: coresight: Expand branch broadcast documentation
To:     James Clark <james.clark@arm.com>
Cc:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.com,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 at 15:46, James Clark <james.clark@arm.com> wrote:
>
> Now that there is a way of enabling branch broadcast via perf, mention
> the possible use cases and known limitations.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../trace/coresight/coresight-etm4x-reference.rst   | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/trace/coresight/coresight-etm4x-reference.rst b/Documentation/trace/coresight/coresight-etm4x-reference.rst
> index 0439b4006227..fb7578fd9372 100644
> --- a/Documentation/trace/coresight/coresight-etm4x-reference.rst
> +++ b/Documentation/trace/coresight/coresight-etm4x-reference.rst
> @@ -656,7 +656,18 @@ Bit assignments shown below:-
>      ETM_MODE_BB
>
>  **description:**
> -    Set to enable branch broadcast if supported in hardware [IDR0].
> +    Set to enable branch broadcast if supported in hardware [IDR0]. The primary use for this feature
> +    is when code is patched dynamically at run time and the full program flow may not be able to be
> +    reconstructed using only conditional branches.
> +
> +    There is currently no support in Perf for supplying modified binaries to the decoder, so this
> +    feature is only inteded to be used for debugging purposes or with a 3rd party tool.
> +
> +    Choosing this option will result in a significant increase in the amount of trace generated -
> +    possible danger of overflows, or fewer instructions covered. Note, that this option also
> +    overrides any setting of :ref:`ETM_MODE_RETURNSTACK <coresight-return-stack>`, so where a branch
> +    broadcast range overlaps a return stack range, return stacks will not be available for that
> +    range.
>
>  .. _coresight-cycle-accurate:
>
> --
> 2.28.0
>

Reviewed-by: Mike Leach<mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
