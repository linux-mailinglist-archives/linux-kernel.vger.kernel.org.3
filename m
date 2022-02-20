Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D704BD292
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 00:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245205AbiBTWyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 17:54:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243011AbiBTWyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 17:54:16 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1833F89E;
        Sun, 20 Feb 2022 14:53:54 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id y24so2997464lfg.1;
        Sun, 20 Feb 2022 14:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=lrJ1JybLeaLsFNVAmzwjpCp9vU3YBmIsvmQRFGbIsFo=;
        b=K13PlyzB7OWjeZ1pDRkI8crdU86abyRnUW6hPGgC2JK72tjnpVHjOZo6oQBOspHhTp
         on5rN1S+b7f9uTRLps8OCDZQcZbIWD/D9Rm7D2ST5V6NZGUCvKGr91dojV5qbTORPM4W
         nVQ/SB4aqFAu/OcJShGjOI39CMePM0f5WGHaPlT3ZDvjUKtEqU3ZOM4aNhw0QXne9JD9
         dVqCsXfQDIa5CLugvFuIygnV03cLgkCEhJD25pdknUVB5atFevyTVMdzchdcpKqX+OSL
         N4F69eilarFOD4qBLNerLx2mRcW/BcMiuw1GcSQ7JSDeMqLJot2VlSSh7vykULMuBgYg
         WlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=lrJ1JybLeaLsFNVAmzwjpCp9vU3YBmIsvmQRFGbIsFo=;
        b=rbFcbQbTuX7+3MxVfWq+S1h3zwIJT0DfWWzv73yok35dBKC8YVoLhsoY4FOTiH5wMS
         X3kKfHaf3VMtsgKNrXqv3Zw1h9av/DevD/SHTmTrjDerqqcQ+VqETKCWy6npdvwhHiSg
         3J4/WZf+TlnIoM3f58wf6fbGfctrlZnpFlaeKaouvP+mcOG8Lfrnhz/7jZbltSE+vPqd
         R90vkJHU9JKXMfMU0dLb2XP2jibYLSaykWmLsFfpV1Yoe4qa5xYVYrrF1yPBIxFli3rT
         inK9KkCVXtu5dH3+nFwg2jKCE54UU9Guut8QCmQEC+ssmBCubJlcl/xd0nhw2jBFN5CE
         38cg==
X-Gm-Message-State: AOAM533AjJLY38rYA1Spx+VWh++8e6bWwX0dG13tA1nt+77c7xkqzfux
        0tYLPS1LA02LRmfVShlg+Ig=
X-Google-Smtp-Source: ABdhPJxMnh4SIB/X6gO4KKootcvFEKV5OuRHvzCbdfRNqOg9mqOIK4qbxcOhs4DpmlS+ICFEpfL5CQ==
X-Received: by 2002:ac2:5e69:0:b0:443:eaad:2284 with SMTP id a9-20020ac25e69000000b00443eaad2284mr2221624lfr.597.1645397633012;
        Sun, 20 Feb 2022 14:53:53 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id i28sm939540lfv.78.2022.02.20.14.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 14:53:52 -0800 (PST)
Message-ID: <92f821cd-5fff-9dca-7e63-e33dfc7b391a@gmail.com>
Date:   Mon, 21 Feb 2022 01:53:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 5/8] media: staging: tegra-vde: Bump BSEV DMA timeout
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220220204623.30107-1-digetx@gmail.com>
 <20220220204623.30107-6-digetx@gmail.com>
In-Reply-To: <20220220204623.30107-6-digetx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.02.2022 23:46, Dmitry Osipenko пишет:
> BSEV DMA timeouts if VDE is downclocked by x10. Bump the timeout to allow
> DMA to complete. We don't support freq scaling yet, this is just a minor
> improvement which may become useful sometime later.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/staging/media/tegra-vde/h264.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/tegra-vde/h264.c b/drivers/staging/media/tegra-vde/h264.c
> index a46c648a26c6..d8e5534e80c8 100644
> --- a/drivers/staging/media/tegra-vde/h264.c
> +++ b/drivers/staging/media/tegra-vde/h264.c
> @@ -135,7 +135,7 @@ static int tegra_vde_wait_bsev(struct tegra_vde *vde, bool wait_dma)
>  		return 0;
>  
>  	err = readl_relaxed_poll_timeout(vde->bsev + INTR_STATUS, value,
> -					 !(value & BSE_DMA_BUSY), 1, 100);
> +					 !(value & BSE_DMA_BUSY), 1, 1000);
>  	if (err) {
>  		dev_err(dev, "BSEV DMA timeout\n");
>  		return err;

For the reference: This is a new patch in v4/v5 and I didn't intend to
include it into this patchset, it happened by accident. On the other
hand, this patch is harmless, so it's okay to keep it.
