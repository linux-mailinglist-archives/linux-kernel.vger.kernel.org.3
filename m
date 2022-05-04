Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1745B51A2A6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351527AbiEDO5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245006AbiEDO5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:57:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA08919C35
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 07:53:37 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.94]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N33AR-1nycCJ2lsj-013PzA; Wed, 04 May 2022 16:53:02 +0200
Message-ID: <60a0ad1e-92d5-5032-7672-3da9ea606348@i2se.com>
Date:   Wed, 4 May 2022 16:53:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] staging: vchiq_arm: add reference to vchiq device in
 vchiq_state
Content-Language: en-US
To:     Adrien Thierry <athierry@redhat.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20220502183045.206519-1-athierry@redhat.com>
 <20220502183045.206519-2-athierry@redhat.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220502183045.206519-2-athierry@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4cx/fI0q0KQihxnCwEmGDzKTjM9ADUWFfTLZ70HcPtSmBPtzahB
 tzLsZgHMfnal8Gkulfc3wqdhrUtbyCt+x/LY2fmxFFGIJ5S/eJEKsXmkd32xqciBBYjxpgR
 0S7xAdvzXOcpEU2me8qm9YZoAo7qFrB82C2kdLMlkSTReFEQRqiJwx/yv6M6GfZa4xwDdTq
 zM9dCAUSc/piWdx9EKCgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lOcrTv35cJQ=:RHlZO0yymYI3yjUoZtDKn+
 ofNSiUS/KnFs0t/BNFDxNipWThxlBnVdoi3XwxbQn0oupM6HCW519Ptma1i5Z0g04oyGpxLvT
 XregvIGc+RF6b/Cvg10bgHzuxf4pg+PzBBGQkWd+bNrbmlwtsSTkaJzFvvuYPkFI77/P5JFED
 zPOCgWVvv4EjcVSEQT9qYQi/41s1nFQB1vi6NWEL9EXdRZHD5ps0DzvExam+6uoLgLWBn0lO3
 R08+rxP67KfaR2oFL6ZHXvFuH1iOutci2fzQadt8FFoqd4TC23wEZJqGAC9hPIvCSROpAwcQT
 QGE8EQrf/KN7feUFSXmmqL1Fut/NSL/0H8kG7cUWlpYGwKS8O/e3n33UDwjq3Bns2QHcSqtrf
 xtcMlda88JzWNwXvs21KAcxgAXnD/Go96t8Bca9qGb9bgGgft8DMTWE93I+zTw/v43hhO6W+x
 QbFtsa/FxQEjILqH510c0GsQduSd95iit/sfP/S7amXClId3yX8SiRVPrm2fioiqxktRuErP8
 uQ8Vfjg7jvth3iI+2IWegWUw4VLOAwLt053ySVkR3TGkI6jslVtiGFol22u05K+Ye5Wb2fSew
 DkOfFFymcfQ7og18CRe+TetTy4K+zf6E9G5nUsDJ2rzW/egKgs78xOWwbUUSeT8mnOOgXfWju
 +2OSxrVIDnxKa2YyxhvRiuNLvfhWQjBv2LiLSUJ6cqB3gqsBmuCBSQ8BejWNh6V+dUdwyaBsC
 31acJXmjlojhvzto
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrien,

Am 02.05.22 um 20:30 schrieb Adrien Thierry:
> Add a reference to the vchiq device in the vchiq_state structure. This
> allows the device structure to be passed around, which will be useful in
> order to get rid of the global g_dev structure.

the patch looks good to me. It would be nice to mention that with adding 
the device reference it would possible to introduce common kernel logging.

Best regards

>
> Signed-off-by: Adrien Thierry <athierry@redhat.com>
> ---
>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
>   .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c    | 4 +++-
>   .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h    | 3 ++-
>   3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 0596ac61e286..e6e0737c85fc 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -519,7 +519,7 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
>   	*(char **)&g_fragments_base[i * g_fragments_size] = NULL;
>   	sema_init(&g_free_fragments_sema, MAX_FRAGMENTS);
>   
> -	err = vchiq_init_state(state, vchiq_slot_zero);
> +	err = vchiq_init_state(state, vchiq_slot_zero, dev);
>   	if (err)
>   		return err;
>   
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index 8f99272dbd6f..0d5c39d7c6e2 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -2142,7 +2142,7 @@ vchiq_init_slots(void *mem_base, int mem_size)
>   }
>   
>   int
> -vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero)
> +vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, struct device *dev)
>   {
>   	struct vchiq_shared_state *local;
>   	struct vchiq_shared_state *remote;
> @@ -2169,6 +2169,8 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero)
>   
>   	memset(state, 0, sizeof(struct vchiq_state));
>   
> +	state->dev = dev;
> +
>   	/*
>   	 * initialize shared state pointers
>   	 */
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> index 82b7bd7b54b2..352017ff5309 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> @@ -315,6 +315,7 @@ struct vchiq_slot_zero {
>   };
>   
>   struct vchiq_state {
> +	struct device *dev;
>   	int id;
>   	int initialised;
>   	enum vchiq_connstate conn_state;
> @@ -458,7 +459,7 @@ extern struct vchiq_slot_zero *
>   vchiq_init_slots(void *mem_base, int mem_size);
>   
>   extern int
> -vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero);
> +vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, struct device *dev);
>   
>   extern enum vchiq_status
>   vchiq_connect_internal(struct vchiq_state *state, struct vchiq_instance *instance);
