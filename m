Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529364BD4DC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343971AbiBUEup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 23:50:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343963AbiBUEul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 23:50:41 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3A3443D4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:50:19 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id y189so10235953ybe.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fLPreDyk5i/acRhp6t4wYyRKGMfEFw6AWmQFjTT3XM=;
        b=lcJRQC48zBT6JSk4Cze0rWSvfDcjxUrksvEdhCPEJ9kcKeuCJ8ZTqkOMFnVW9fN4LL
         7kfPRB7tL3AI9stSJYhk2gAYt+K6CgL7KBgSaqC4QmR2ucTci0NCQzyiVDmCf+5V0krp
         PJacX78nweK6yTgCJE0Lz5jgZZdPJe7gbORvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fLPreDyk5i/acRhp6t4wYyRKGMfEFw6AWmQFjTT3XM=;
        b=T0hFIAtzcza0RJj/Au5xymNOKP2ZCcDt27vfyQg5TQceXvAldl9YKXDMG4wBJrWLFp
         piwweh91LRcSsoWWz2VaB5mQlDOag1r2iMPrOAjAlygquuCUGUakt2lUU9nF0iIqIcZa
         gRbCPYaeTfRBctwmT6eNWmKWfa8D3r/BQlsGXx7a/nwd59FWP1hZozVKbLcIgSLJo1yo
         74Vzi1A0J8jljrHO8tsbybf8JytLRZV0y1N91/cZqWXIkVmGrijYmX/VwjnexarfNhSU
         ib7pSy1Zwesw1BjhOj9ukWGRDn85L6AOtE/V/VwT+Wz3TPbrOFQEWi3oP8FQOEEIn0Kt
         lZ6g==
X-Gm-Message-State: AOAM530/pG/UcNQtX84rr8q9RsYA1ggzGcDXnccwAeHxqpXoAeugdN5v
        NApKWEjxtgjxNkoQzsd29FfOZEno1q65lP3ikI7lkoMMuqQ3hw==
X-Google-Smtp-Source: ABdhPJwnJji3Y6vGfmHdiJMJSvQXhmnzkIuuJoCGVqZQWmEi5cZKBvn6o1cT2ydL5KK4nhZsMh8eNWrzvt2qMHhyDxg=
X-Received: by 2002:a25:2d52:0:b0:624:1bf8:2f8 with SMTP id
 s18-20020a252d52000000b006241bf802f8mr16376975ybe.219.1645419018711; Sun, 20
 Feb 2022 20:50:18 -0800 (PST)
MIME-Version: 1.0
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com> <20220218091633.9368-20-allen-kh.cheng@mediatek.com>
In-Reply-To: <20220218091633.9368-20-allen-kh.cheng@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 21 Feb 2022 12:50:08 +0800
Message-ID: <CAGXv+5FO5gBv1L4S_Nitmfv1zwjTGvp3CPP8CyFVEAq3DkkJ-g@mail.gmail.com>
Subject: Re: [PATCH v2 19/23] arm64: dts: mt8192: Add i2c aliases
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "--to=Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 18, 2022 at 5:16 PM Allen-KH Cheng
<allen-kh.cheng@mediatek.com> wrote:
>
> Add i2c aliases for mt8192 SoC
>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 55bcbf72a366..e3314cdc7c1a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -21,6 +21,19 @@
>         #address-cells = <2>;
>         #size-cells = <2>;
>
> +       aliases {
> +               i2c0 = &i2c0;
> +               i2c1 = &i2c1;
> +               i2c2 = &i2c2;
> +               i2c3 = &i2c3;
> +               i2c4 = &i2c4;
> +               i2c5 = &i2c5;
> +               i2c6 = &i2c6;
> +               i2c7 = &i2c7;
> +               i2c8 = &i2c8;
> +               i2c9 = &i2c9;

AFAIK, maintainers have suggested against [1] having aliases in the .dtsi.

If the numbering isn't an issue, I suggest just dropping it altogether.
If it is, then the aliases should be added at the board level, and only
for the interfaces that are actually enabled.

ChenYu

[1] https://lore.kernel.org/linux-rockchip/CAK8P3a25iYksubCnQb1-e5yj=crEsK37RB9Hn4ZGZMwcVVrG7g@mail.gmail.com/

> +       };
> +
>         clk26m: oscillator0 {
>                 compatible = "fixed-clock";
>                 #clock-cells = <0>;
> --
> 2.18.0
>
