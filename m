Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AE454F817
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiFQNEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbiFQNEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:04:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A245183A1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:04:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2A7561FE2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEB2C341C8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655471084;
        bh=IMfxbm0cTlFK5BlhM1fmc8WFH4sMYQn7s1vFXzBCQ7k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hMIaiEcHjLuPobXTOkwBO365MTl2Wcr5ds/x6lsZKilL95DXFbZdV9GJP8fDUmSJI
         DFzuYe+6viwwpOILYmwnuz4zOkhc2rN0sFrAOgw+bOG5SA53FvhtLTA69wHKpmA+y1
         /VjflyoI/NeNqBjSE9FcLaWwHR3f5CDXaKL5BKJAhDf/Chmv2GtasIs0EYFOfTmFiU
         ZXqd8wXngdY48bP11uKX6kWcrdyRZ5JtO0iVfuXDjyNaYyC7kvQtQ2NvteOyAqfSRb
         FjZJQOYxbKDmdqvERgqtsdsKSoeHp7Kc+r6gjrlYClJsBMmIgvVLNUumZsDXtBYFHG
         o11zQrF0nXN7w==
Received: by mail-lf1-f49.google.com with SMTP id i29so6867240lfp.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:04:44 -0700 (PDT)
X-Gm-Message-State: AJIora/zUbKBrjrTm22sIIuo4rG40/hSKDeP8hg/AD8aPwH+4s3mtb9N
        E6AwVWVKB42NO3Im+pbsOUeUk7M0ulu4pi0o/TH+3g==
X-Google-Smtp-Source: AGRyM1sXXKODhqZBKnGTevwM92wMCdZAtlL9XXBrakBrjMza10rWnzK9JjzUXofKG3yb8RDaf0JrQrVnGobeS4Rw2c8=
X-Received: by 2002:a05:6512:a88:b0:479:1d61:a6da with SMTP id
 m8-20020a0565120a8800b004791d61a6damr5493140lfu.471.1655471081989; Fri, 17
 Jun 2022 06:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220521111145.81697-34-Julia.Lawall@inria.fr>
In-Reply-To: <20220521111145.81697-34-Julia.Lawall@inria.fr>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Fri, 17 Jun 2022 18:34:30 +0530
X-Gmail-Original-Message-ID: <CAHLCerOfr-qo50tLLJNqYPMGP3jQQYmFxLHy8a3Ug1U+TGHnOw@mail.gmail.com>
Message-ID: <CAHLCerOfr-qo50tLLJNqYPMGP3jQQYmFxLHy8a3Ug1U+TGHnOw@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/tsens: fix typo in comment
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 4:42 PM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Acked-by: Amit Kucheria <amitk@kernel.org>


>
> ---
>  drivers/thermal/qcom/tsens.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 7963ee33bf75..c96a188b73e1 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -26,7 +26,7 @@
>   * @up_viol:        upper threshold violated
>   * @up_thresh:      upper threshold temperature value
>   * @up_irq_mask:    mask register for upper threshold irqs
> - * @up_irq_clear:   clear register for uppper threshold irqs
> + * @up_irq_clear:   clear register for upper threshold irqs
>   * @low_viol:       lower threshold violated
>   * @low_thresh:     lower threshold temperature value
>   * @low_irq_mask:   mask register for lower threshold irqs
>
