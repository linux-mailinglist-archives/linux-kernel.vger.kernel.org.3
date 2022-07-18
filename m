Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81185780FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiGRLid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbiGRLi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:38:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2952182C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:38:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z25so18823512lfr.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKrTbfV1TIjezbnj9pZfW/yzd2q01rdirSDTyvPbTjU=;
        b=mh4onUHAiYaYnh02H+giZGGvog4JkyJdsiglHg/5RBO/SzoXleT/GwqABQJhhcta/e
         97sjZ4BzRpb94ffUJ4GcHRknEqEBywoFBTIBLPdtynJRWVAvjUACicUqzJ0UqED91FYm
         6+uFzlGlL9rB5y4yWoFiRi3JcLoDFpP7Nrn0BFouCWLtHqb3SNRMGhBAQ18kas0QfCTM
         Wf2EtiOqYibN079Th5gzKcXXU+gvCc5eoUhYQM2llJvamMPrtrr1dx6eDUkjzFFba2XE
         2YwOnc1YQPUx6EwdM1fpk+Ro02evibTXm4EzIIztm23MqgAausrckJSWMBpUTIWz8itS
         bqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKrTbfV1TIjezbnj9pZfW/yzd2q01rdirSDTyvPbTjU=;
        b=hIxDm6z/ormlDu9ZD+izDevG+4G3jYIt4VOKd4teO4SGcdJlx5NULVClOfjwWqi3Hi
         zCz36eSej+sKRZ/al7Kryr21DX3QTGpWcvHFcKyD4yKgGdWDF9FZvPsc/la16JKflsvP
         PSuCEc38MGfUo/AOM96FZG7W4rqBwp29IDFfT44nLM+IkLgG10OnrJVCkdIKE4bFcjI9
         Y/SE+H/ekgXBjNDRQOY9RzrpHaVn7RIEVTqsxLSmC0LUL0on3eqlit10tJL5vfVN3v+F
         99MAuTJPuNFVv2PA6ecaRghBhHrSwuzIq1RjQIBujKL2sOgt22PQ7QDCfM2MbyjnYOPl
         kL0w==
X-Gm-Message-State: AJIora8+/xMmls3qCvOsYdk+BuDstVXQ059taZFFIaxdx2vSlsC9ZbGO
        qz9oGFOPVnD5MWq5n7xEzTQuEkyzpdSTV8YTPQSJqKHcv4I=
X-Google-Smtp-Source: AGRyM1ux2fo4OUI95oxoRd8QbK1bLzBMW/WZfSDYFRMjgd9hY4FaDe82H9U40sAKKcXBlfd8qgO4LYb4+n9NNWPVQCY=
X-Received: by 2002:a05:6512:2522:b0:489:daa9:467 with SMTP id
 be34-20020a056512252200b00489daa90467mr15084527lfb.71.1658144304143; Mon, 18
 Jul 2022 04:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220716140401.55494-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220716140401.55494-1-yuanjilin@cdjrlc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Jul 2022 13:37:48 +0200
Message-ID: <CAPDyKFp30G=x-LmiG+1NFsKaDTZvBU8bfgr9eUsMHiD4Jymotw@mail.gmail.com>
Subject: Re: [PATCH] mmc/core: fix repeated words in comments
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jul 2022 at 16:04, Jilin Yuan <yuanjilin@cdjrlc.com> wrote:
>
>  Delete the redundant word 'it'.
>  Delete the redundant word 'in'.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

I am fine with picking up patches that fixes spelling mistakes.
However, I would rather see that you go through all spelling mistakes
in the core and send one patch for all of them. It gets easier for me
to manage it in this way.

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 4b70cbfc6d5d..e4a555a2f202 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -56,7 +56,7 @@ static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
>  /*
>   * Enabling software CRCs on the data blocks can be a significant (30%)
>   * performance cost, and for other reasons may not always be desired.
> - * So we allow it it to be disabled.
> + * So we allow it to be disabled.
>   */
>  bool use_spi_crc = 1;
>  module_param(use_spi_crc, bool, 0);
> @@ -528,7 +528,7 @@ EXPORT_SYMBOL(mmc_cqe_post_req);
>   * @host: MMC host to recover
>   *
>   * Recovery consists of stopping CQE, stopping eMMC, discarding the queue in
> - * in eMMC, and discarding the queue in CQE. CQE must call
> + * eMMC, and discarding the queue in CQE. CQE must call
>   * mmc_cqe_request_done() on all requests. An error is returned if the eMMC
>   * fails to discard its queue.
>   */
> --
> 2.36.1
>
