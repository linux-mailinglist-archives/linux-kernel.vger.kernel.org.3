Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14C053D751
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbiFDOyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiFDOyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:54:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05B92A27C;
        Sat,  4 Jun 2022 07:54:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64E7CB8069B;
        Sat,  4 Jun 2022 14:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC55C385B8;
        Sat,  4 Jun 2022 14:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654354481;
        bh=N7YW05IlDg8P0hn1zuvZrekP5B7RaicMuLai3tp/gVw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QRFaQl9Xv4s8TDzKFGOO84jmNqCVEVLl8gjiwqkAmZTRfgPU7plIMcQIKUFxyOwUB
         CPxmkO0YfXgzALUdsOefClPPa43kKnDpJvt8f0g1mRI3el2ZeGsMJXso1HUeV1Tvqm
         mvbXWZkgX5gG5ULHJYZr4JYuYGdFbxicDmAwAYSwuWAD5nuwYSQG7CZQ1TzdgFaUH4
         yTApNNZ0XbtZL5ukgdFBwhQobde0H/WikXUD/Zfh3oPvtcrqotXLIq7GPCVoSCfxqX
         ++VJz1BOqJQpfgX/5AvJXT7/XD+U+St0c7RGZRU8yYjdUYL6YT7iFmPpu/JW53gBfg
         XWmKAytCx3GlA==
Date:   Sat, 4 Jun 2022 16:03:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: sca3000: Fix syntax errors in comments
Message-ID: <20220604160342.4ac69684@jic23-huawei>
In-Reply-To: <20220604040541.8470-1-wangxiang@cdjrlc.com>
References: <20220604040541.8470-1-wangxiang@cdjrlc.com>
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

On Sat,  4 Jun 2022 12:05:41 +0800
Xiang wangx <wangxiang@cdjrlc.com> wrote:

> Delete the redundant word 'via'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
Hi,

Patch applied.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/sca3000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 29a68a7d34cd..08dedee76e46 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -424,7 +424,7 @@ static int sca3000_read_ctrl_reg(struct sca3000_state *st,
>   * sca3000_print_rev() - sysfs interface to read the chip revision number
>   * @indio_dev: Device instance specific generic IIO data.
>   * Driver specific device instance data can be obtained via
> - * via iio_priv(indio_dev)
> + * iio_priv(indio_dev)
>   */
>  static int sca3000_print_rev(struct iio_dev *indio_dev)
>  {

