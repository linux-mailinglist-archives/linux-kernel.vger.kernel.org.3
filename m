Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B410574B58
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbiGNLAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237669AbiGNLAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C506F564EE;
        Thu, 14 Jul 2022 04:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6401560C1C;
        Thu, 14 Jul 2022 11:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD83C34114;
        Thu, 14 Jul 2022 11:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657796419;
        bh=d7dJzHy3R4d3efKnyqF1Bs4i3d1AFlB+D2NT0p1gevU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mIMm8UuymYGzasiWrapSwDV3BiJoF1yRtWQMqJJ5cqYVEOqF2xjIzfbD36CAzxyYt
         NrEDpwQNhh9tbxqYRMu887wgzprhX8SwYgd2tt6B9C5bo77b+ybDEUwI7uuweLVQTO
         tVhJSf7tsinQEcd+Rj+D6xELXiQSnnCB2pHqVejQ5jvmLvuxD1aTKqgK1IwBWzm5dx
         bbhEyMf3pmi25tCnuC8MpjBUjgdMuvqw6SCv7xbfE8CxGnTyLZRScWjQas7togxw+k
         a8Vw4WNL/7qBewkR0iP157GyKKBP7UK+Wku44rHE9Hz7/5NXaf/tF+lGwiAQJMR0zT
         lvmkuBLic7Q7w==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-31caffa4a45so13150227b3.3;
        Thu, 14 Jul 2022 04:00:19 -0700 (PDT)
X-Gm-Message-State: AJIora8X0M6GQJew/D9SnxKql0w+vaqAHCbTrAiLf3NVlwB8NYmgLk+c
        6c7sC66veykK9EPU9kegnfMS6WHmgrlzxMEx+lE=
X-Google-Smtp-Source: AGRyM1v8B84SNAdGfOI4zRumWOHG4tF3fWc5HBtUKpdHnhrTodjFGxXFqWCe2mA6l8aeAzCy9c7C96Np8oZnHoxYPK4=
X-Received: by 2002:a81:1608:0:b0:31c:925f:c52c with SMTP id
 8-20020a811608000000b0031c925fc52cmr9171091yww.93.1657796418888; Thu, 14 Jul
 2022 04:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220714103119.22927-1-colin.i.king@gmail.com>
In-Reply-To: <20220714103119.22927-1-colin.i.king@gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 14 Jul 2022 13:59:52 +0300
X-Gmail-Original-Message-ID: <CAFCwf13ppoKUGtVRUc93EySHOVsXF-3XkfHUvC0K1O2adVDpFQ@mail.gmail.com>
Message-ID: <CAFCwf13ppoKUGtVRUc93EySHOVsXF-3XkfHUvC0K1O2adVDpFQ@mail.gmail.com>
Subject: Re: [PATCH][next] habanalabs: Fix spelling mistake "Scrubing" -> "Scrubbing"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 1:31 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a spelling mistake in a dev_dbg message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index cb2988e2c7a8..05dd5e13f13e 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -4723,7 +4723,7 @@ static int gaudi_scrub_device_mem(struct hl_device *hdev)
>         addr = prop->sram_user_base_address;
>         size = hdev->pldm ? 0x10000 : prop->sram_size - SRAM_USER_BASE_OFFSET;
>
> -       dev_dbg(hdev->dev, "Scrubing SRAM: 0x%09llx - 0x%09llx val: 0x%llx\n",
> +       dev_dbg(hdev->dev, "Scrubbing SRAM: 0x%09llx - 0x%09llx val: 0x%llx\n",
>                         addr, addr + size, val);
>         rc = gaudi_memset_device_memory(hdev, addr, size, val);
>         if (rc) {
> --
> 2.35.3
>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Applied to -next.
Thanks,
Oded
