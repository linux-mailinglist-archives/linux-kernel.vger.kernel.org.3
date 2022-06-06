Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA5153F297
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 01:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbiFFXem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 19:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbiFFXej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 19:34:39 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EC0A88A7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 16:34:38 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w19-20020a9d6393000000b0060aeb359ca8so11843521otk.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 16:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=rguJKwRR36lQl5uxZm7mHzCFYZdBsPv0ibNSdNomq/k=;
        b=dXUI/JUv2d8G38kg33SyEWXiYyw2PJJXVOxl1omnLH9Ja27JzXJUX6fxIVIJFIbJaG
         dzF/NOhUNrECly3GluZei2LvRqwnZwcw4HLnbdiWxJ6x+PjHN0h/ebSlOKVaTHKq3qwr
         0lkT9APpstb3GD1fHst78eocrp4yrVMiAz3A4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=rguJKwRR36lQl5uxZm7mHzCFYZdBsPv0ibNSdNomq/k=;
        b=rV82zhIolSbi8j8pOHpN783Azinm1VEeVTBOYDedkwv+I2+aKjRVlVb2SGfP4NCeZQ
         mEQmlunOhsNH1z0owlcDyLbxp+2y4buw6HpYPGRUaTGJPn2ymNoOe/hLG/zxSHCSC7i+
         +Al0YY0Mf1yAnAJEbTVh/cmOJ+NwzgP1RAViXLN42XiK/uXHswpyrs52XzFpejrkYcyr
         PchNGNBFtVC+OKgdOs9884f/NWMXJMGcXl15eHWdTV8ObAbBJYzRuQJj4+Qy96UY68Kj
         v7hjWjrULS+gxfU8bqfWjM1USHmHCQ9f7Cb4QEVK0bm49ZtLbRLMGFeFuFldaj/0+Q/v
         mhag==
X-Gm-Message-State: AOAM530NouTHrtTx3mpoYdKPC4Ok8BFRwo14HiqLlYIfwG9NW3Xh/dv3
        iZZ2i37snYK6StU9HqxC7oTHpQcVfKuim2KY1wH3ww==
X-Google-Smtp-Source: ABdhPJzLShdt3/ZtY8VDYrGeT2bzo7GXF1G0CHIwEpTjOmrao6i0lcn628upmloNW7vGMA5dYEStU0exWrOIQCT7qso=
X-Received: by 2002:a05:6830:113:b0:60b:eb0b:4054 with SMTP id
 i19-20020a056830011300b0060beb0b4054mr5867675otp.159.1654558477386; Mon, 06
 Jun 2022 16:34:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jun 2022 16:34:36 -0700
MIME-Version: 1.0
In-Reply-To: <20220606201825.763788-4-pmalani@chromium.org>
References: <20220606201825.763788-1-pmalani@chromium.org> <20220606201825.763788-4-pmalani@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 6 Jun 2022 16:34:36 -0700
Message-ID: <CAE-0n52GScELw_Bb1HSLnktMLTiw3bjK6A6e4uCNLtqmEx+z_Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] platform/chrome: cros_ec_proto: Update size arg types
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        chrome-platform@lists.linux.dev
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

Quoting Prashant Malani (2022-06-06 13:18:05)
> cros_ec_cmd() takes 2 size arguments. Update them to be of the more
> appropriate type size_t.
>
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index 816da4eef3e5..85e29300f63d 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -232,7 +232,7 @@ bool cros_ec_check_features(struct cros_ec_dev *ec, int feature);
>  int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
>
>  int cros_ec_cmd(struct cros_ec_device *ec_dev, unsigned int version, int command, void *outdata,
> -                   int outsize, void *indata, int insize);
> +                   size_t outsize, void *indata, size_t insize);

We should also mark 'outdata' as const in another patch because it's
being copied out and I assume unmodified by the callee. It's nice to
tell the caller that their data will be sent unmodified.
