Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BEF59C49C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiHVRG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbiHVRGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:06:54 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326C8422C8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:06:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z2so14799125edc.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yq00nMAmmdOVK3LrfY7efLvJa1UyHrXxc7OvcasMVWw=;
        b=u7IL+AKZZZNWXnISptZyq8hMQdrEpTcugXYWPxYgGiIx97VYEb/Ofzv2TnO9P/O8tD
         SMVRlqX4avEXXdXRA0DDBDUGmUyibgcztVdWq5esziWmP8hdXVu7VwBmQv2VrJBSZ9a5
         XOVuLnebN3mxOHNzVIfu8VPfT0dQjfmbVznTbX020e6AKj9REq5RBk+62u2fVb9AJZFC
         bBE8N0dd7qrNYbGps0yw5FJyzXD2zFUWzO/JXsfPw+eBF3CfKVK06tPSY4mhB4AB2oPi
         GqDdOAI/NJutt4g2B/+FIKVcZtvJL1HBuV+/Sju7XCM+zxeLYCxUvXVxbKaEkIG8PU6M
         zeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yq00nMAmmdOVK3LrfY7efLvJa1UyHrXxc7OvcasMVWw=;
        b=Xy+8mGCa7wI5B+yjQmMPgbAZUvoMO56lQG6kjuIe2lkNpiqezA5vzqK1Du2lHpVYju
         P8/pMQkj1JuwhqE3a3uySsoUYsBlbZIFMFP9bjk2w0FRPtCT02Z3q3OZ48H8+gDj4USv
         RsvilMrBbs+vXelHk/0yNsGvkpoaWcbbA6khzFdwXQ1X/fAka8KC5u5saiyENDk7/yJl
         SMuYbrNWPFAa3YiJX7Vd+jARFfGWcPd9Pflta01fKjd1JFC3PoGD8c/wXWmwcD2x4xuD
         Nx/7Mr4RRETsi0OVDrtGBLH4kTHHai4+/EEtgV7iL8MTSDvtqFuLk96ynaMEWH9AxoqX
         JRmQ==
X-Gm-Message-State: ACgBeo3LvsWOvH/XSxevKKFJ0jQTpYV3seTCeSTlYvUMIQvqKvGEAzMK
        MBCRwnlxVvuYHohzEzwlB70CXRFYEwuklFnaEyGM3g==
X-Google-Smtp-Source: AA6agR5R+Iw/Vr1KokMtpw8qpbmlXsE28LNUhVY9yJGMOoDcEQne6vWTGopnXYGv6KYqVbH43wTlHo7R85OQBsdeue8=
X-Received: by 2002:a05:6402:11cf:b0:446:fbf6:bf with SMTP id
 j15-20020a05640211cf00b00446fbf600bfmr106473edw.259.1661188011671; Mon, 22
 Aug 2022 10:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220808111113.71890-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220808111113.71890-1-krzysztof.kozlowski@linaro.org>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 22 Aug 2022 10:06:39 -0700
Message-ID: <CAJ+vNU2=kLpbGr_W9O0Tp=nawfgV5ioGr6C-7KWfjLXy8kGTmQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mfd: Drop Robert Jones
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 8, 2022 at 4:11 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Emails to Robert Jones bounce ("550 5.2.1 The email account that you
> tried to reach is disabled").
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> For dt-bindings see:
> https://lore.kernel.org/all/20220808104712.54315-1-krzysztof.kozlowski@linaro.org/T/#t
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4832b317fe05..ee8f04918d44 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8442,7 +8442,6 @@ F:        tools/testing/selftests/futex/
>
>  GATEWORKS SYSTEM CONTROLLER (GSC) DRIVER
>  M:     Tim Harvey <tharvey@gateworks.com>
> -M:     Robert Jones <rjones@gateworks.com>
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
>  F:     drivers/mfd/gateworks-gsc.c
> --
> 2.34.1
>

Acked-By: Tim Harvey <tharvey@gateworks.com>

Tim
