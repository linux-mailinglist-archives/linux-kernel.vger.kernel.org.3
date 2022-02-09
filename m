Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274A84AEFFC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiBILdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiBILde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:33:34 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D20C1DC2EA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:25:55 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A27973F1E6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 10:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644402353;
        bh=i2KI5hMSSyeIYLLHODdHiXGfEoepYgSQjsAA0Z52iOo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=cHy/gcYuNa4aV5WtsXg6UHbTzStbmAI6AOs0V2LeKkJ8WichnkXKjSTGR+hXNF61z
         oT9Mtr49CYXfCI7jwAoKhF0tutaLF5OtnoVGFVXEUk25tDmRzoCt4SSBJe6QODkAYk
         oIgkYQZdkBNmf9L6g6ZX8AtLW9B5wzug8hvoisGZJe4Rflzsc5xYA6i3Fug3Y+wBg4
         odnLjUKiZe2pu2LHoFLbFtHpaxmi9YqAhCrcMN3s3pJVMWbZWyWqs3Ml8dLVh1GUnW
         2VmNXPpqMtiwLwdqBtx+SGWGb811IAKgOCbKLCG9Lc+qtXZu2FN4tuDULE9ELelntw
         2lHjSlISeJJNg==
Received: by mail-ed1-f71.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso1131312edh.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 02:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2KI5hMSSyeIYLLHODdHiXGfEoepYgSQjsAA0Z52iOo=;
        b=vYdMtsovnjGkgKKahzNDuC29M+ccJzOu5dqi3YqkSX/mwLL5Qle/H0/f5t1R1mTkLr
         vHqkBguT7an403uHqdfrofEX7QMdUcWxdx7b1Fb7enfYfsB7WxL94twkdY6R9cGAGbu9
         Guu9bZGUlueMSFQT+yBvkqwHmYZhMRd3SrrWhKjInZjw9jjTNMqeGOUwwMufwhyIEyyn
         p7GUoeoyE1HAg6h0jRj3cl1Q2g10D6LmbkcZuWU7CjD2cQng1LxAzthKWe/3hMvTVadg
         6BvlwKkZUgJ8PEdpsSyvjfcBSt02mfvUZVYgnZ+ClEUB/1ad0fMIlWJYbK567RiBYbbF
         X9lA==
X-Gm-Message-State: AOAM531LtebQGCNvsz4bCl9eK2tYv9k2MqQk60M89ASJa/bKYJT0nOaD
        gfHEHysbr7dcAoJP9Erg8VmiPIQMw/Cfa9cKSU/T7yioTKMZbilnUEz4N6lZMcJ2JAvcJCY6Y2x
        KccuL40xxGIJFlvX1nVgU04nlgL4L1UTcS6ahuxLeR5YiUtxGGo5VrCMkUg==
X-Received: by 2002:a17:907:1c1c:: with SMTP id nc28mr1295629ejc.651.1644402352732;
        Wed, 09 Feb 2022 02:25:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRaSoiC+XlrvlLAdpRn5m2h3uJb8sozRIUppuILQY5sQ+ZHYc6VwQrATFbYHecvSmkHWdwQvCCJZlalnZpyhA=
X-Received: by 2002:a17:907:1c1c:: with SMTP id nc28mr1295621ejc.651.1644402352590;
 Wed, 09 Feb 2022 02:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20220209101439.1657557-1-clabbe@baylibre.com>
In-Reply-To: <20220209101439.1657557-1-clabbe@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date:   Wed, 9 Feb 2022 11:25:41 +0100
Message-ID: <CA+Eumj7sWb9JCi4MzRj0bkBBD9LjsVBuZwimen11uLNapK73CA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: rk3288: fix a typo on crypto-controller
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2022 at 11:14, Corentin Labbe <clabbe@baylibre.com> wrote:
>
> crypto-controller had a typo, fix it.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index aaaa61875701..a0d29de3acf7 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -971,7 +971,7 @@ i2s: i2s@ff890000 {
>                 status = "disabled";
>         };
>
> -       crypto: cypto-controller@ff8a0000 {
> +       crypto: crypto-controller@ff8a0000 {

This should be rather "crypto" as a generic name (see list of examples
for generic naming in DT spec).

Best regards,
Krzysztof
