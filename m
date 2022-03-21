Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216A44E24FF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346546AbiCULIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244325AbiCULIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:08:46 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA026E02A;
        Mon, 21 Mar 2022 04:07:21 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so1046456wms.2;
        Mon, 21 Mar 2022 04:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G5Fxd6dDMUMlTPBPLtvy82x/psh+jTZud4elMZgGQak=;
        b=R8Pp2l1T91x62SNoqlbmHZIn5xsVU3Q3D54jUZh8L0ZPQCTm8lZAXNUJcYsP7TuGU7
         obrI8ZX/jhPkCpTx3ypEqRvvky7r2j5nBBtijZAElwppDpfyw414SjRcf3ErKBKajLZ4
         NGRK28N167kwp6bom5WTAbNiydcfIMASNI8A03+DlRMxFBSuSH+A3bq6gtSBRNeWg7di
         7w/Sl8zkcKWa0hqhQ6Iyom5zWuv/VgzP6mFlnL33F1Sk5+0iOdC8pKOSbaxij7qpBGsn
         6sxHPAxc75kFN1GwPchmtFRyWvB4KMrP7+R3o8/bzcjNu9toxPraRMR9Ecy8kdFLoBpv
         VhbA==
X-Gm-Message-State: AOAM531MBkp/1Cfm6+j5FCHKKinSwRvsJs7o8EfieHk/RdOTKDE2v+/x
        7utQB5mmVWp5cciS/wNimrtZ+sgz2YA=
X-Google-Smtp-Source: ABdhPJyA99qDboRIT+RILzjvUvWuDFu8KJXg/BEMcQsHfHDUZ6I/MWUPFv2vZg6tBK56BhJ0kuV4PQ==
X-Received: by 2002:a05:600c:384e:b0:38c:9a8a:d205 with SMTP id s14-20020a05600c384e00b0038c9a8ad205mr7503391wmr.44.1647860840049;
        Mon, 21 Mar 2022 04:07:20 -0700 (PDT)
Received: from krzk-bin (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id 185-20020a1c19c2000000b0038a1d06e862sm17453690wmz.14.2022.03.21.04.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 04:07:17 -0700 (PDT)
Date:   Mon, 21 Mar 2022 12:07:15 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Hammer Hsieh <hammerh0314@gmail.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: SERIAL_SUNPLUS should depend on ARCH_SUNPLUS
Message-ID: <20220321110715.qrz2holf5aky2ztm@krzk-bin>
References: <59f46272ab5b16853acac4d585c3333cfd394223.1647352195.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59f46272ab5b16853acac4d585c3333cfd394223.1647352195.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 02:52:32PM +0100, Geert Uytterhoeven wrote:
> Sunplus serial ports are only present on Sunplus SoCs.  Hence add a
> dependency on ARCH_SUNPLUS, to prevent asking the user about this driver
> when configuring a kernel without Sunplus SoC support.
> 
> Fixes: 9e8d5470325f25be ("serial: sunplus-uart: Add Sunplus SoC UART Driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
