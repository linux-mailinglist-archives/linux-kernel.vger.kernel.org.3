Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAD653E643
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbiFFPqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241113AbiFFPqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:46:19 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F063388C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:46:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u12so29775271eja.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B90rJStIwUJz/WnCT2f0wLQIie5FqhO2ey/SLUJI8AE=;
        b=JeCTo/DqCNpM5Kv2kuBQVM+eXt0aK25d1zghGCk7hGW3gUxaGBBRUYu40pO89yucUe
         qCNOXsLNSSkdgL+SpyKg1aT4wOP4cAVPpP3GNnj2rJPM3BxwUIGH0RkB6aH8QITPF3AR
         2gjhvKGWwX6YDGZ/biAyOq5sj1J6w+DfAq+y1D27ZVfTGoMmBuIenqFUT+W2832G7vRg
         JvHA2dS3Qs+5W81p1XVQ/81JNh+6kEuS5rosD1KcNenaSzVMZ5bZp4LmvM7chzy9wYkG
         h9wMPCLzhsqIsHAwyDdKT6LGsBJMI8KiWdeAGYy30+pj5fUeZ06X0TIeKmfkaU9KumYP
         0i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B90rJStIwUJz/WnCT2f0wLQIie5FqhO2ey/SLUJI8AE=;
        b=V/ewkh9ZYcrLddLDFga0JL9LP/w4BP3JmDRziugPYLT7mvcl5FyxRExNmO/ATrCjj9
         UaHueTjY9+B67+RVPkQ/yi3RnxDeJewGB1ht+Rx2ZNo7ZhA/vRnhUr6QZVfxnx3qSz5l
         X8QsEZiZJpCK6WReoCVMpYAyFgTkhNAv+6XTrBOiRJO55jQDkqXnM7fjgZRtdkR8rzwa
         vl58IKz7kcjuf6izWhiGRxHTI5NtHcbT+9sAngaLQWO+CPd631Po3d6HlKNo8WUDj5D4
         MFJ8zqOE8MEn24LtxYE6FdKfjmFvgRTjmxyiGKhwKKmYB71te81PqSKl2HF1gyVXytBT
         D21Q==
X-Gm-Message-State: AOAM5324/N6o+Pklc2DQ9scM4mubsiidUA/jvfc5sjrEEiVMf8g/Tmm6
        DD7o6Uj9g4vjZabLUAR4DMZgiYFIADxYuoCiNs3l/Q==
X-Google-Smtp-Source: ABdhPJzB+YuQ+3M+THQnaySBs8Wz59q00TglBkIeUDsSm/E4Am0k8haXrYOXSzwG7q6V5eCxtTpVPJLmDvc8gLhkYdo=
X-Received: by 2002:a17:907:90c8:b0:711:c8e1:7109 with SMTP id
 gk8-20020a17090790c800b00711c8e17109mr7056684ejb.492.1654530376186; Mon, 06
 Jun 2022 08:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220606141051.285823-1-tzungbi@kernel.org> <20220606141051.285823-6-tzungbi@kernel.org>
In-Reply-To: <20220606141051.285823-6-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 6 Jun 2022 08:46:04 -0700
Message-ID: <CABXOdTcTjOoXp5nt7Q4Z_AXyYcxc3ZX91+KJAPoo6jOQj3z_pw@mail.gmail.com>
Subject: Re: [PATCH 05/13] platform/chrome: cros_ec_proto: remove redundant
 NULL check
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 7:12 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> send_command() already checks if `ec_dev->pkt_xfer` is NULL.  Remove the
> redundant check.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 629dce3e6ab3..1b851dcd20c9 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -281,9 +281,6 @@ static int cros_ec_host_command_proto_query(struct cros_ec_device *ec_dev,
>          */
>         int ret;
>
> -       if (!ec_dev->pkt_xfer)
> -               return -EPROTONOSUPPORT;
> -
>         memset(msg, 0, sizeof(*msg));
>         msg->command = EC_CMD_PASSTHRU_OFFSET(devidx) | EC_CMD_GET_PROTOCOL_INFO;
>         msg->insize = sizeof(struct ec_response_get_protocol_info);
> --
> 2.36.1.255.ge46751e96f-goog
>
