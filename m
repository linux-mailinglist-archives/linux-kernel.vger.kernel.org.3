Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05D05752D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbiGNQbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiGNQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:31:35 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD73433410;
        Thu, 14 Jul 2022 09:31:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e15so3132388edj.2;
        Thu, 14 Jul 2022 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhoWI4qXoHsRxXejZ4bDxx8rPwc5PrEne0xLbfw7b3c=;
        b=TMtVpRdxuzY+GFOrJzgXJjS7PgzhBL4YjbaEAWduBAB5qc6UjWHULm5HpSJXOScbnh
         qWEGguzru0OxloGviNMBCEMELWtL87lhZPUrXd+lwmq5MeGAhuz8/wSDdWnagZVMSXO6
         Iwaz2MgUYZWYEk9HwPUn238XUQEyvW4/F89ZSvxYnsnQYfyRDpqB+PlRlQAGkT1Gdv/S
         7UGkeO2D281Yu7wnsy3YzxsgczEQJjmqgHVCwX+fKFpQGejBv1EsHLWb4EyJYtlmOQbW
         H6nYg2W1YS7Rf0gA3nIdJo6HQTUivxtXB2m4D73Sd4ofi6gJ6i/aJNKJz3lQyySfJioN
         fbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhoWI4qXoHsRxXejZ4bDxx8rPwc5PrEne0xLbfw7b3c=;
        b=JMmOqoluSyMRkw2sRC0j92DEwTJWTo2F3h9aWR7uJOMNwhKM2E+Zi4k0v7y0a6XjCa
         Lm2Y5iudvmZzqtCX0oXsWtQNW+nRwdfXSIvtBvq9DvJaBOPzamPyCFwbG0pfa35oFuFE
         inCLkwtV98enPJYjYCaF2a4iaTxu4EogKl5V1oIk+Nr90eT7TBr2zHYFcJdENntnkn2e
         pvamQO0nO4CRkxMOySLpfDHCUI99BLQ9mQ1EqAW+ugWsAq3UhwS1eBVY5uDYa/dhCovi
         i011/5TNLRi3AaiZ+opMnZgUq9f4FTYzXh955VhHU8nSvtIuaEMXW/4Zsn3CZ+x6X2kI
         M3ng==
X-Gm-Message-State: AJIora9Mh83uUbx2HUtzqO46WjwlgeO/xlfi+GSZZb0aWV3cvhgBW2GS
        5talQ05kTc7+4AG86vMJyr9fJfEAqI/6XQPUJ1E=
X-Google-Smtp-Source: AGRyM1vlBR6f4juYCV/yCZg3RjA87tp7VDETKIK9iYx5gzzUL4ZdyFIJbjjXw8MVnaPdQX+oNlbMl0PPVfnIXBNwT48=
X-Received: by 2002:a05:6402:2895:b0:43b:1e47:c132 with SMTP id
 eg21-20020a056402289500b0043b1e47c132mr7007574edb.425.1657816293374; Thu, 14
 Jul 2022 09:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220714103427.23255-1-colin.i.king@gmail.com>
In-Reply-To: <20220714103427.23255-1-colin.i.king@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jul 2022 12:31:21 -0400
Message-ID: <CADnq5_PO79-dzPy0VVG2fuyQ0wX0GcWHbcvyyy_bUrF2JwQSOQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Fix spelling mistake "supporing"
 -> "supporting"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Jul 14, 2022 at 6:34 AM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a spelling mistake in a dml_print message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
> index 6101c962ab0a..fc4d7474c111 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
> @@ -2994,7 +2994,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>                         for (k = 0; k < v->NumberOfActivePlanes; ++k) {
>                                 if (v->ImmediateFlipSupportedForPipe[k] == false) {
>  #ifdef __DML_VBA_DEBUG__
> -                                       dml_print("DML::%s: Pipe %0d not supporing iflip\n", __func__, k);
> +                                       dml_print("DML::%s: Pipe %0d not supporting iflip\n", __func__, k);
>  #endif
>                                         v->ImmediateFlipSupported = false;
>                                 }
> --
> 2.35.3
>
