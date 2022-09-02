Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DB95AAB7A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiIBJbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbiIBJbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:31:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABD5C0B5E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:31:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id d5so905527wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1gh2cH8+/vu9+O44Ntzb/QjlvRTOJYihF+Y3Qm1SXrI=;
        b=X4/4Zk55Ukbyir5IW5L08w5Q+fBtLNiG6CONxZPYH5OrhlCyRaaYThfUPWsbJipvYT
         swTNjLlHybyUWC/dfqbdAW5Ah7r6Ymh4/g/oVrerD+13326oWvDv3zz6rydOMv/zNWXn
         LtHud4zBf5xTIhynm9koMjOkNsLG74eqnxnm8RKGFRPGx7mBVVLJnC9rPLFS1X7yRHuD
         1yX57RVfuS/GckEUMvFGVsy+Mf5mTMSC+0BUZDK65PEfhodItsbyEKzD56Ku/yT7NOR6
         3oT1E3kXSyaBiSKfL1ykhnf13PQkgJjtaV8uIpotOq7DBSYoGzbS6ubAJ3YQ7hxyMo0X
         wobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1gh2cH8+/vu9+O44Ntzb/QjlvRTOJYihF+Y3Qm1SXrI=;
        b=KDVisJSMBh5O1cCakcEDUqrfgrkqdDLCxFRV+EdMN9KwrzHXdVq5W/u55GU3Vio3jA
         8SzpOnp1cb1vqND86m+LpE7UMOytcrrc9V36t9D4YeLsbWzrMXPrQJdcqM3gCK4V7bbl
         4vSZ8q+RL474kNbMmZR3SiPLxareToVIsPqFhxQ1PP6qRG8N/2+/CvtgVHRgIFtybINm
         NqHmuFHReuwxZUJH0yNWU2FvBqXOCGiZK8uo0W7fzCvaImHiOWE5E3Ktf/YjDigLbNSJ
         JVJJ9ISnU/Ufd1PZOr2E/subSTy1z6TB2Rjj8ZDhKqYkalpGbCb6OdhDEBFeYZC+OCfn
         RrgA==
X-Gm-Message-State: ACgBeo1kK68gBg46vWv76hlYnHwJQr4owQORet6T784nYSENsGjmTYr6
        B45q0sWqROKJIDaAIBtWjKCcYw==
X-Google-Smtp-Source: AA6agR7RmSVyjAeQGFw3MIw2xrxrUVQiVxAzEY6jcgGsEMR0UnpBnCqr/mnb1uGpwjcB9GCyqvs1tA==
X-Received: by 2002:a1c:7703:0:b0:3a5:aefa:68e3 with SMTP id t3-20020a1c7703000000b003a5aefa68e3mr2239820wmi.158.1662111089219;
        Fri, 02 Sep 2022 02:31:29 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id g40-20020a05600c4ca800b003a4f1385f0asm1537794wmp.24.2022.09.02.02.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 02:31:28 -0700 (PDT)
Message-ID: <c22a8724-4a1c-dcc5-816d-32faedf6dee2@linaro.org>
Date:   Fri, 2 Sep 2022 10:31:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 11/21] misc: fastrpc: Prepare to dynamic dma-buf
 locking specification
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robdclark@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
        Qiang Yu <yuq825@gmail.com>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        linux-rdma@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20220831153757.97381-1-dmitry.osipenko@collabora.com>
 <20220831153757.97381-12-dmitry.osipenko@collabora.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220831153757.97381-12-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/08/2022 16:37, Dmitry Osipenko wrote:
> Prepare fastrpc to the common dynamic dma-buf locking convention by
> starting to use the unlocked versions of dma-buf API functions.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---

LGTM,

Incase you plan to take it via another tree.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini
>   drivers/misc/fastrpc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 93ebd174d848..6fcfb2e9f7a7 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -310,8 +310,8 @@ static void fastrpc_free_map(struct kref *ref)
>   				return;
>   			}
>   		}
> -		dma_buf_unmap_attachment(map->attach, map->table,
> -					 DMA_BIDIRECTIONAL);
> +		dma_buf_unmap_attachment_unlocked(map->attach, map->table,
> +						  DMA_BIDIRECTIONAL);
>   		dma_buf_detach(map->buf, map->attach);
>   		dma_buf_put(map->buf);
>   	}
> @@ -726,7 +726,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
>   		goto attach_err;
>   	}
>   
> -	map->table = dma_buf_map_attachment(map->attach, DMA_BIDIRECTIONAL);
> +	map->table = dma_buf_map_attachment_unlocked(map->attach, DMA_BIDIRECTIONAL);
>   	if (IS_ERR(map->table)) {
>   		err = PTR_ERR(map->table);
>   		goto map_err;
