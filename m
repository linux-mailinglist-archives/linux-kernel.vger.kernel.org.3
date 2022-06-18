Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791B955061C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 18:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbiFRQXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 12:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiFRQXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 12:23:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5E81055C;
        Sat, 18 Jun 2022 09:23:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D15260F30;
        Sat, 18 Jun 2022 16:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC72C3411D;
        Sat, 18 Jun 2022 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655569420;
        bh=5gCzLzShuvKNoQCaZ1sv/yrWTlcGBOdeQ8QzK85FSlc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NKH5l1D1rPjlFfn5omKPx3cZXmXkEgzJVJ1UwuGfQN0StipvMHELXKllUc3XbLLTL
         4AmhiiHUqKjHabJYLjHB65goIkW39Isw0oBWWEk+S4LwzhHsYIxVdYExuRU6ApgHyv
         wOa8dEyMzRixeeJeCzl89cOkwP5paayixD7/jALYqIuwf4QAMv7aq9sIUKBEte1Lp+
         PWv9dMo/dS/cFouC5BZAtugH/4pSDx7XnJre34MFIYwV8Lb6/DlaljrivmPFTfQPIc
         /m+4Qo/4L7qvvlpF9zUJ31GU9EXS6WnALqxgtrX60uYaRF5qKVQTGXdkv7Y49G0hz3
         8NKfQOaCeQS3w==
Date:   Sat, 18 Jun 2022 17:32:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add include/dt-bindings/iio to IIO
 SUBSYSTEM AND DRIVERS
Message-ID: <20220618173258.4be9882b@jic23-huawei>
In-Reply-To: <20220613115045.24326-1-lukas.bulwahn@gmail.com>
References: <20220613115045.24326-1-lukas.bulwahn@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2022 13:50:45 +0200
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Maintainers of the directory Documentation/devicetree/bindings/iio
> are also the maintainers of the corresponding directory
> include/dt-bindings/iio.
> 
> Add the file entry for include/dt-bindings/iio to the appropriate
> section in MAINTAINERS.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied,

Thanks,

Jonathan

> ---
> Jonathan, Lars-Peter, please pick this MAINTAINERS addition to your section.
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b8aec742e6e..503b8042784e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9656,6 +9656,7 @@ F:	Documentation/ABI/testing/sysfs-bus-iio*
>  F:	Documentation/devicetree/bindings/iio/
>  F:	drivers/iio/
>  F:	drivers/staging/iio/
> +F:	include/dt-bindings/iio/
>  F:	include/linux/iio/
>  F:	tools/iio/
>  

