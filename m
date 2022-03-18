Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB69F4DD66A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiCRIsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbiCRIsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:48:00 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8CC2BAE49;
        Fri, 18 Mar 2022 01:46:41 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id 10so6351551qtz.11;
        Fri, 18 Mar 2022 01:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HX28KG1ETTyJqfzKGPZZd77iKDoX+t1pmuXVdkh9BBc=;
        b=Z5aK/m5hJp461lI1t0YTLkryZtCz8/3HW4RW38wNu7h2EGUqR5UuMrj7IZGKTu0qKc
         xqozWfz6HUk279WPyFj16B30DdNahbNTYWsIbBSEex9sA3PsaUSBV+ktq32E+IVv++KN
         JVM+hWttBMY+pzT/KNggcxpvmXVD20QHebxdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HX28KG1ETTyJqfzKGPZZd77iKDoX+t1pmuXVdkh9BBc=;
        b=iqkB9EPr+kS3dKXJLVr7vm0IDmZZbsrzgOMgHWezCBb9dAvQmXnU4A7C354OA7j4N9
         ETHmjP7Plh9R0op4m3toeQ8uE+TLDSplPCHeEILZNfv84YvdjiNi3Hn5pQbqijTY0eLK
         HMV41Mhym5wH7BkpXX16jjzA1f6yro+9hX/qRYZTaw5a4jDq0hq9lymF1Sp/BQoI5YYB
         UvnbVusRt5UDgkcRdS4CrVCnINlbGb7eHpCMJOREs1LT29dm6HUHD60+e8LOI3NcEMYG
         16hAQn76lmn5DK3UVTzFFColrCMqBb6HKazZzJnDSD3IrrVrlwZmZ2wprtMNe3uF8HzT
         LImA==
X-Gm-Message-State: AOAM533sSLEksIw52iNg/vDwWrdRimZDvZCJ98LS5ehY3tdDtKjR19+N
        i8oa7Y7Pf6qiZrRA+N5PKukhY0HSO3yxpQUhgFw=
X-Google-Smtp-Source: ABdhPJwbpE/yU8SuU3bVcc+6HfWkUhrdPIgYdcuCEFhWvubB6MvFcV8t9gzlh4c9xyYxHO1Eosyq9q6syDlj8eCbRI4=
X-Received: by 2002:a05:622a:14c8:b0:2e1:d626:66ea with SMTP id
 u8-20020a05622a14c800b002e1d62666eamr6640121qtx.58.1647593200510; Fri, 18 Mar
 2022 01:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <SG2PR06MB2315A7BAE2F1B384CDADB57FE6139@SG2PR06MB2315.apcprd06.prod.outlook.com>
In-Reply-To: <SG2PR06MB2315A7BAE2F1B384CDADB57FE6139@SG2PR06MB2315.apcprd06.prod.outlook.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 18 Mar 2022 08:46:28 +0000
Message-ID: <CACPK8XdYHb-PgVVQuTtMBokxu4GTObG7nCohm4dosK9XWzE9ow@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: aspeed: ast2600-evb: Enable RX delay for MAC0/MAC1
To:     Howard Chiu <howard_chiu@aspeedtech.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Troy Lee <troy_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Howard,

On Fri, 18 Mar 2022 at 08:09, Howard Chiu <howard_chiu@aspeedtech.com> wrote:
>
> Since mac0/1 and mac2/3 are physically located on different die,
> they have different properties by nature, which is mac0/1 has smaller delay step.
>
> The property 'phy-mode' on ast2600 mac0 and mac1 is recommended to set to 'rgmii-rxid'
> which enables the RX interface delay from the PHY chip.
> Refer page 45 of SDK User Guide v08.00
> https://github.com/AspeedTech-BMC/openbmc/releases/download/v08.00/SDK_User_Guide_v08.00.pdf
>
> Set mac delay according to the mactest result.

This bit confused me. How does the rxid relate to the mac delay
numbers? Which device and code is responsible for using them?

>
> Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> index b7eb552640cb..db16ba307e97 100644
> --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> @@ -103,7 +103,7 @@ ethphy3: ethernet-phy@0 {
>  &mac0 {
>         status = "okay";
>
> -       phy-mode = "rgmii";
> +       phy-mode = "rgmii-rxid";
>         phy-handle = <&ethphy0>;
>
>         pinctrl-names = "default";
> @@ -114,7 +114,7 @@ &mac0 {
>  &mac1 {
>         status = "okay";
>
> -       phy-mode = "rgmii";
> +       phy-mode = "rgmii-rxid";
>         phy-handle = <&ethphy1>;
>
>         pinctrl-names = "default";
> @@ -141,6 +141,21 @@ &mac3 {
>         pinctrl-0 = <&pinctrl_rgmii4_default>;
>  };
>
> +&syscon {
> +       mac0-clk-delay = <0x10 0x0a
> +                         0x10 0x10
> +                         0x10 0x10>;

These properties aren't supported by the mainline kernel. Do you have
some code coming for that support?

> +       mac1-clk-delay = <0x10 0x0a
> +                         0x10 0x10
> +                         0x10 0x10>;
> +       mac2-clk-delay = <0x08 0x04
> +                         0x08 0x04
> +                         0x08 0x04>;
> +       mac3-clk-delay = <0x08 0x04
> +                         0x08 0x04
> +                         0x08 0x04>;
> +};
> +
>  &emmc_controller {
>         status = "okay";
>  };
> --
> 2.25.1
>
