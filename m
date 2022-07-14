Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398E457575A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 00:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbiGNWEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 18:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240844AbiGNWEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:04:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C7F4F66E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:04:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so9901908pjm.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=KDtjlRiNkbkwbyu0K1cWU8KeaAVIJpnnNwqLxbVq1SM=;
        b=ZVwA55GEKeisOGGK59fMpJ4hYruRMbnUWD907flsikQqWcIGC9s4PaNtfzDSK9+AiM
         R4ob13YAe7zJrPTRE64X4XlhssTohU0uoCxt5DFrJLdflknyfdLqBs+jiFWw2peGBhSX
         gRk83oWFWZZbAAFqoxTR9K+Y50UdHYCSaQcyDX/ogDknUaWlFVIvvnlVMojoDkLGqaqj
         CDORZNdUuRSS6rgHiZi41QwjEjyUYScQjFC6VT+cr4XeR3f7lKEkeOywc4PmGM0Xyk0Z
         4yturnY2DIJMEnbPtDaYpgEqlBWspLGoVP2j/lbjtrv83Nm8/v4+iqJNQcYqm0E3Iaga
         TIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=KDtjlRiNkbkwbyu0K1cWU8KeaAVIJpnnNwqLxbVq1SM=;
        b=uuTs/zkgAaOqzzz25TqxaSoQUE1vQd0wOPSzP9C1VPI6788GiLS5PIAk3p4i93HRH3
         49buN/oWRXDreRNCqZdQ8r88fa797uNc/ng/bsvTNKOXPDcya+MwpG5xQ6ulAnaCu2kz
         ZoZfT4eBTqVsyDc2YCPJdJo8os3ocwwdjokTXH0ugN3UEXKN3cCA5tRzDvDljUktkZwq
         I4U4Wvi75qcDctGecf+AalBXdURwPYlrHsJiuBMaNn0jBRnjeHMMr5KGoo7bV680ffKr
         6d9acJ0wfbJmzn2z/1wEDePcN3FQZw9uU/fqrM2NRQ+hXM6DGwo7vgzvxMFgNbWT34GS
         ynlA==
X-Gm-Message-State: AJIora/CpivukqM8qxJQ4WvMeIk8OhvIFwIBYN5pBqqbSSs8Q/Iaf40U
        9HJMqUHaeAxlFV0d1w4OQeCJJA==
X-Google-Smtp-Source: AGRyM1uqiwhNrcoDyi7BO/M6oUSKAHXy3k3IByQCDQyMTQXgqTtuGVQdh9q861VVmOOyihKz1THYlA==
X-Received: by 2002:a17:902:cad1:b0:16c:9816:648a with SMTP id y17-20020a170902cad100b0016c9816648amr7997084pld.166.1657836242750;
        Thu, 14 Jul 2022 15:04:02 -0700 (PDT)
Received: from localhost ([50.221.140.186])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090a134300b001ef82d23125sm4129123pjf.25.2022.07.14.15.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 15:03:59 -0700 (PDT)
Date:   Thu, 14 Jul 2022 15:03:59 -0700 (PDT)
X-Google-Original-Date: Thu, 14 Jul 2022 14:33:22 PDT (-0700)
Subject:     Re: [PATCH] riscv: dts: align gpio-key node names with dtschema
In-Reply-To: <20220624170811.66395-1-krzysztof.kozlowski@linaro.org>
CC:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski@linaro.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     krzysztof.kozlowski@linaro.org
Message-ID: <mhng-26d4c307-b754-4c87-8858-789dca71c0ae@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2022 10:08:11 PDT (-0700), krzysztof.kozlowski@linaro.org wrote:
> The node names should be generic and DT schema expects certain pattern
> (e.g. with key/button/switch).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> See: https://lore.kernel.org/all/20220616005224.18391-1-krzysztof.kozlowski@linaro.org/
> ---
>  arch/riscv/boot/dts/canaan/canaan_kd233.dts     | 2 +-
>  arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts  | 2 +-
>  arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts | 2 +-
>  arch/riscv/boot/dts/canaan/sipeed_maix_go.dts   | 6 +++---
>  arch/riscv/boot/dts/canaan/sipeed_maixduino.dts | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/canaan/canaan_kd233.dts b/arch/riscv/boot/dts/canaan/canaan_kd233.dts
> index 039b92abf046..f72540bd14a3 100644
> --- a/arch/riscv/boot/dts/canaan/canaan_kd233.dts
> +++ b/arch/riscv/boot/dts/canaan/canaan_kd233.dts
> @@ -35,7 +35,7 @@ led1 {
>  	gpio-keys {
>  		compatible = "gpio-keys";
>
> -		key0 {
> +		key {
>  			label = "KEY0";
>  			linux,code = <BTN_0>;
>  			gpios = <&gpio0 10 GPIO_ACTIVE_LOW>;
> diff --git a/arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts b/arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts
> index b9e30df127fe..8abdbe26a1d0 100644
> --- a/arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts
> +++ b/arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts
> @@ -47,7 +47,7 @@ led2 {
>  	gpio-keys {
>  		compatible = "gpio-keys";
>
> -		boot {
> +		key-boot {
>  			label = "BOOT";
>  			linux,code = <BTN_0>;
>  			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
> diff --git a/arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts b/arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts
> index 8d23401b0bbb..3c6df1ecf76f 100644
> --- a/arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts
> +++ b/arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts
> @@ -52,7 +52,7 @@ led2 {
>  	gpio-keys {
>  		compatible = "gpio-keys";
>
> -		boot {
> +		key-boot {
>  			label = "BOOT";
>  			linux,code = <BTN_0>;
>  			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
> diff --git a/arch/riscv/boot/dts/canaan/sipeed_maix_go.dts b/arch/riscv/boot/dts/canaan/sipeed_maix_go.dts
> index 24fd83b43d9d..03c9843d503e 100644
> --- a/arch/riscv/boot/dts/canaan/sipeed_maix_go.dts
> +++ b/arch/riscv/boot/dts/canaan/sipeed_maix_go.dts
> @@ -46,19 +46,19 @@ led2 {
>  	gpio-keys {
>  		compatible = "gpio-keys";
>
> -		up {
> +		key-up {
>  			label = "UP";
>  			linux,code = <BTN_1>;
>  			gpios = <&gpio1_0 7 GPIO_ACTIVE_LOW>;
>  		};
>
> -		press {
> +		key-press {
>  			label = "PRESS";
>  			linux,code = <BTN_0>;
>  			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
>  		};
>
> -		down {
> +		key-down {
>  			label = "DOWN";
>  			linux,code = <BTN_2>;
>  			gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
> diff --git a/arch/riscv/boot/dts/canaan/sipeed_maixduino.dts b/arch/riscv/boot/dts/canaan/sipeed_maixduino.dts
> index 25341f38292a..7164ad063178 100644
> --- a/arch/riscv/boot/dts/canaan/sipeed_maixduino.dts
> +++ b/arch/riscv/boot/dts/canaan/sipeed_maixduino.dts
> @@ -23,7 +23,7 @@ chosen {
>  	gpio-keys {
>  		compatible = "gpio-keys";
>
> -		boot {
> +		key-boot {
>  			label = "BOOT";
>  			linux,code = <BTN_0>;
>  			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;

Thanks, this is on fixes.
