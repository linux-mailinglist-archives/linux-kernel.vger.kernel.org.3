Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435C957B6F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbiGTNCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiGTNCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:02:38 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029F451A18
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:02:38 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id x125so16174503vsb.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x1ADlbcOE17NYUMjiVagDfq4PUxtl1uXmumEQgrN0ns=;
        b=jvD6x40J3yho1JCQqEblcfudZ/i3pFzH6EP0raY01ry+4aGebg1QdnwCVsATMnrGyJ
         NrQyyemO5XLsKz3yCkJXo/jXEvrgVEyiSjrqK07Wv9mqS1zAajXiw203GIHggPqZEXKm
         iQyRezph1eQMpSTOu85fh1VHUZh2R/WKMgzx08STdgwYelol59Xuq/C3qjyxIak8Ypam
         Q/pd3+tvuLpov1NiSb1MZVfrhkNyI93Bal3j+nJdaCSFh1DS2YnDAYpe6WsIAXsHb1B3
         OyEkUJ1zn87tzp6BBE0Cyjm9XnkHKonjOuogXGDt+2sKSpRdpJ18yZSVaJBRQ78rp3Ka
         CP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1ADlbcOE17NYUMjiVagDfq4PUxtl1uXmumEQgrN0ns=;
        b=gySwHqn5gqLhzY2nhOiHGUA65+HLb5gSYqgWEVQY48V7k+S9+saVwUK0+rAhrNFyRt
         PsOG2G2AoZXtH03Fhd60YDYS7WpPZXMBampSfwiyyeDT1mb5K3jTJq1kxYQcyLQV/kKL
         InAa6bgRD3czTbGNS4QSJep2ZVv/18ZDqfD+Gyd13oRHawYV0HRap5DNc1XzCEnHQiL7
         Ny0XmFukXLMreXlNaizG69WsQHhAV72gcWAtJXVmHYQ50nDk+X9GdBKEGS+TwJfozqQj
         goMPJzS75qN1CcJLXeLb5uThVSQ75dh6w89+K7a6GkG6sO4d0Jo/O51OLK46Ywwwmp1e
         h9vA==
X-Gm-Message-State: AJIora+2lmGX/nOi8wC6Tujh06nju3ij6sBuoE5/B3D3+rNpmd6Kgsw5
        N8cJSoZUUJuIyuQm6jaa8gcVtU9URYcEQDOpUxDJdA==
X-Google-Smtp-Source: AGRyM1utT93d5kWPKobsQR1mFixnWNiywLDzDUUYqbQcLQ2ntUnx4AgebIkC27zZLeUIViUiVAOPEgijG2dG4dOw66w=
X-Received: by 2002:a05:6102:34d1:b0:357:ee01:3e64 with SMTP id
 a17-20020a05610234d100b00357ee013e64mr4095477vst.70.1658322157067; Wed, 20
 Jul 2022 06:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220720044754.4026295-1-tzungbi@kernel.org> <20220720044754.4026295-3-tzungbi@kernel.org>
In-Reply-To: <20220720044754.4026295-3-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 20 Jul 2022 06:02:26 -0700
Message-ID: <CABXOdTeC5hNuP_k8Gj-0-2_vCECNJYVkt2qfy23P7tPKfWp3zg@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: cros_kunit_util: add default value
 for `msg->result`
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 9:48 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> Add default value for `msg->result` so that it won't be garbage bytes
> when the mock list is empty.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_kunit_util.c | 6 +++++-
>  drivers/platform/chrome/cros_kunit_util.h | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_kunit_util.c b/drivers/platform/chrome/cros_kunit_util.c
> index 090927d43035..f0fda96b11bd 100644
> --- a/drivers/platform/chrome/cros_kunit_util.c
> +++ b/drivers/platform/chrome/cros_kunit_util.c
> @@ -13,6 +13,7 @@
>  #include "cros_ec.h"
>  #include "cros_kunit_util.h"
>
> +int cros_kunit_ec_xfer_mock_default_result;
>  int cros_kunit_ec_xfer_mock_default_ret;
>  int cros_kunit_ec_cmd_xfer_mock_called;
>  int cros_kunit_ec_pkt_xfer_mock_called;
> @@ -25,8 +26,10 @@ int cros_kunit_ec_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_comman
>         struct ec_xfer_mock *mock;
>
>         mock = list_first_entry_or_null(&cros_kunit_ec_xfer_mock_in, struct ec_xfer_mock, list);
> -       if (!mock)
> +       if (!mock) {
> +               msg->result = cros_kunit_ec_xfer_mock_default_result;
>                 return cros_kunit_ec_xfer_mock_default_ret;
> +       }
>
>         list_del(&mock->list);
>
> @@ -112,6 +115,7 @@ int cros_kunit_readmem_mock(struct cros_ec_device *ec_dev, unsigned int offset,
>
>  void cros_kunit_mock_reset(void)
>  {
> +       cros_kunit_ec_xfer_mock_default_result = 0;
>         cros_kunit_ec_xfer_mock_default_ret = 0;
>         cros_kunit_ec_cmd_xfer_mock_called = 0;
>         cros_kunit_ec_pkt_xfer_mock_called = 0;
> diff --git a/drivers/platform/chrome/cros_kunit_util.h b/drivers/platform/chrome/cros_kunit_util.h
> index 88134c9f1acf..414002271c9c 100644
> --- a/drivers/platform/chrome/cros_kunit_util.h
> +++ b/drivers/platform/chrome/cros_kunit_util.h
> @@ -23,6 +23,7 @@ struct ec_xfer_mock {
>         u32 o_data_len;
>  };
>
> +extern int cros_kunit_ec_xfer_mock_default_result;
>  extern int cros_kunit_ec_xfer_mock_default_ret;
>  extern int cros_kunit_ec_cmd_xfer_mock_called;
>  extern int cros_kunit_ec_pkt_xfer_mock_called;
> --
> 2.37.0.170.g444d1eabd0-goog
>
