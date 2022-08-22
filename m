Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C670F59C5B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbiHVSGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236523AbiHVSGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:06:03 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20654622A;
        Mon, 22 Aug 2022 11:06:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n4so14186420wrp.10;
        Mon, 22 Aug 2022 11:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Csmpukwgo5IDJeAZNtEo51qxCB580Q6PQAbe+39XAEs=;
        b=flMnpNlyMf98yXaTDUHLxaouu8dZiDrDL/ODHRRNw7MGZaD5AlbSioph709BtOkrFw
         IZBoL15cn+9jUk/wMVedfuN1Rw0dYL83uNaRb24qCeOPdMTt9dHl1NdRox4nNATn3+m7
         mvrJE2rek2CBrrBz3CIewfmNRX6gnifg/wv69uOq6QjFhG9ti/uRG4h4FPzd2I6+Baj8
         BPcbN2TwmTC6JNZfi9F3+oFDr+RZDBtKY3H30SUzIHPz5WxO1eak1WcocbAYq6B2pCHQ
         5NMkHTTcV0shr+GkeNH6my6Bk4JbRPIsvijstncvdvs4PrecIbQyKmm+7OOi3E2SKmof
         tLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Csmpukwgo5IDJeAZNtEo51qxCB580Q6PQAbe+39XAEs=;
        b=H412pHp10QzACLGw5WxWYz04+1QCvNXGHarVRhEfG/Zr63UujPwbWfbYtAAV9VcH67
         uGVdnRlptQX1IZwAFrySxYNXzw9r2K0NAJA5sBAgUwdNvd/z1Seor4Z0SZ6qzcpoFabF
         +qfar4NfAG22aysX3D+eaam0wj7YZFdQ9/VpqJgLiNF0UPie+2cVZjVl/MHJjrjkWp1Y
         H8cGJpNMajzVqtNEYiXXQyhM276e5x6JlS66ShR6NdlnYjM0u7RwjjvI0/z2L5P5GqBy
         PY6HBFrL22VqtinGIqCKJAlbH6PUK4Oegc82I+gezTIW/ata/hQ5LblQ8lmDYQsOGtKx
         B6xw==
X-Gm-Message-State: ACgBeo2FwCD81XKhEI5/mqPnLL+P1QWBXrixDJTQ9X2BdRHYyVuymSzd
        ltf54Wyo+p9hjdMBnOdgj3E=
X-Google-Smtp-Source: AA6agR6ZvTHnMaSxUzmtXd4F93OXpQZlDYmNRtz2QDv3B2maMzfD5b1HRYZ40Q/fTsDqOPFurm3I/g==
X-Received: by 2002:a5d:634f:0:b0:225:2ab4:d539 with SMTP id b15-20020a5d634f000000b002252ab4d539mr11042085wrw.149.1661191559446;
        Mon, 22 Aug 2022 11:05:59 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id w3-20020adfde83000000b002253af82fa7sm11469438wrl.9.2022.08.22.11.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 11:05:59 -0700 (PDT)
Message-ID: <434d644b-2688-c3e8-814e-b9b2f2b86f85@gmail.com>
Date:   Mon, 22 Aug 2022 20:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Split multiple assignments to individual lines.
Content-Language: en-US
To:     Christopher Carbone <chris.m.carbone@gmail.com>,
        sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <YwOjt+ZrQkKFGRH9@valhalla>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <YwOjt+ZrQkKFGRH9@valhalla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 17:41, Christopher Carbone wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> CHECK: multiple assignments should be avoided
> 
> Signed-off-by: Christopher Carbone <chris.m.carbone@gmail.com>
> ---
>   drivers/staging/sm750fb/sm750.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index dbd1159a2ef0..a0f8ae359248 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -386,7 +386,8 @@ static int lynxfb_ops_set_par(struct fb_info *info)
>   
>   	ret = lynxfb_set_color_offsets(info);
>   
> -	var->height = var->width = -1;
> +	var->width = -1;
> +	var->height = var->width;
>   	var->accel_flags = 0;/*FB_ACCELF_TEXT;*/
>   
>   	if (ret) {
> @@ -498,7 +499,8 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
>   		return ret;
>   	}
>   
> -	var->height = var->width = -1;
> +	var->width = -1;
> +	var->height = var->width;
>   	var->accel_flags = 0;/* FB_ACCELF_TEXT; */
>   
>   	/* check if current fb's video memory big enough to hold the onscreen*/
> @@ -723,7 +725,8 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
>   		0x800f0 + (int)crtc->channel * 0x140;
>   
>   	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
> -	crtc->cursor.max_h = crtc->cursor.max_w = 64;
> +	crtc->cursor.max_w = 64;
> +	crtc->cursor.max_h = crtc->cursor.max_w;
>   	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
>   	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
>   
> @@ -1027,7 +1030,8 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
>   	if (!sm750_dev)
>   		return err;
>   
> -	sm750_dev->fbinfo[0] = sm750_dev->fbinfo[1] = NULL;
> +	sm750_dev->fbinfo[1] = NULL;
> +	sm750_dev->fbinfo[0] = sm750_dev->fbinfo[1];
>   	sm750_dev->devid = pdev->device;
>   	sm750_dev->revid = pdev->revision;
>   	sm750_dev->pdev = pdev;


Hi,

the subsystem and the device is missing in the Subject.

I propose you look into https://kernelnewbies.org/FirstKernelPatch to 
read about the Subject.

I personally prefer more this:

 > +	sm750_dev->fbinfo[1] = NULL;
 > +	sm750_dev->fbinfo[0] = NULL;

That gives a better overview.

Thanks for your support.

Bye Philipp

