Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D78B585EDC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbiGaMZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiGaMZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:25:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768A62DD2;
        Sun, 31 Jul 2022 05:25:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1261460D17;
        Sun, 31 Jul 2022 12:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1850DC433C1;
        Sun, 31 Jul 2022 12:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659270315;
        bh=aJBSCZCKJ4tBgDgWlARQRxv+lVkfJRH7DAy3OuzHRDo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GrPDz66c59Mq3cdJCsgFbrC93pnWhgxcEZ9rQH85F5igP2PxYdptfcHMBHEIgwe9Y
         XDnJOLfMWpWP/IdCAdli61DhomE2ukeGup1u6ku8Lt58G0EyoVMaK5dgTdjkQIy3In
         mjidBjo2S1dAQ87RV67bp+kclfXjq6Bt0ah8yyT7xiyzoMFWD/fV4jSp/WNYrrOlLu
         guZdohuW/Hry76SKPZa6uerQB5nPh4rfmNBoNn6VQFyyTULUVyItBG64F3GGzsIE6Y
         5OliWCEiGZOLOKlpf4Fr2QB7fPa91BJdNf7VKxts7hnG1eHV8pUMfyOlLlpTm7cPV1
         mq53yCxTq49Nw==
Date:   Sun, 31 Jul 2022 13:35:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update Microchip MCP3911 to Maintained
Message-ID: <20220731133528.64c51e0f@jic23-huawei>
In-Reply-To: <20220723092030.260812-1-marcus.folkesson@gmail.com>
References: <20220723092030.260812-1-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2022 11:20:30 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> The actual status of the code is Maintained.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Cc: Kent Gustavsson <kent@minoris.se>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio <linux-iio@vger.kernel.org>
Applied to the togreg branch of iio.git which I'll rebase after rc1.
In meantime pushed out as testing where 0-day will probably ignore this particular
patch.

Thanks,

Jonathan

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 85147ee391d5..47dcbfabedf9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13085,7 +13085,7 @@ MICROCHIP MCP3911 ADC DRIVER
>  M:	Marcus Folkesson <marcus.folkesson@gmail.com>
>  M:	Kent Gustavsson <kent@minoris.se>
>  L:	linux-iio@vger.kernel.org
> -S:	Supported
> +S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
>  F:	drivers/iio/adc/mcp3911.c
>  

