Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EEF54B2D5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240816AbiFNOMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbiFNOMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:12:15 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFDF32EF0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:12:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e24so8625170pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wt50VBwjqpTS+/G8tO4GidOfAF7iUzFpw0Pr+oMctoQ=;
        b=w17NCk5v7hTrKT98JalJHGiwkZUnysDrIOt0xIL+ZfgmulN2Pe7Y44CgfGG9uiWDQf
         t4E+EOVCM04+uOCFXCRa7SS1ehi2ga6R8OqpTHT45228US8eYJ4w+wIIbwc9UIdi2Lf6
         q7iU/oCE7khTKZk0S9NTDBXTOQcrOPEflJqIEmIaB0o+J8JOGvp//Wv9utdmXloEgDkY
         0UEXuitlJReGMKuUpICVPV/DgSXwnVwIHtKQ3xm8ffsyJIQYFRDqQRRHooKvg80U4fdG
         G+eMNmTEaXA85UFcw6A1FGTbgP2hIKYKLBFTwzyopOTYKUAKWW/TzSVtM0VIU3CoNGAw
         L1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wt50VBwjqpTS+/G8tO4GidOfAF7iUzFpw0Pr+oMctoQ=;
        b=K/O0lIGQ1gP88Sn/c2p9b01rxyPaQ1okbh5oxhZ6PVFPpmbUalAldbXQXgly8TAV+Q
         EuynfvhmaQ5hO+psD8laaweE9kP7qudX6LYF/WvvLc9jPykHi7/XunhboCIvZMEAiW9k
         c6CwZdDVhGRYpWMqfmA3XmVfsBXLEQuRHQYgs3DuEwDQImpMgal+emQdUbKctWPU7i3M
         +uXmt/88RcIv2G/CiPqnHqCvzL9+2kgxmmW5wL1Lh3pDQerVh6138FbmxA0fnulB7HkX
         PZ2eWSOlxBE7uD7e1skdTsWBasQEik1AfopTgubVubMRePGUC2e++BA+594CK+cGiUYo
         7PgA==
X-Gm-Message-State: AJIora/XTAZ4LULEoIje2MbgV9Do1DAGn8HmgfFkRNW9Qt5KhECtmrQq
        SI11G3LmEJLY0TolCNkaFUSOkQ==
X-Google-Smtp-Source: AGRyM1vSg+8mvYVjkbD5Gsw8tnb163S1V8imKaSefeB3v7oLpzERW0jK7HH6HZfBDLZE1BSvuu2sJw==
X-Received: by 2002:a17:902:eccd:b0:166:3e34:4d05 with SMTP id a13-20020a170902eccd00b001663e344d05mr4493060plh.75.1655215933716;
        Tue, 14 Jun 2022 07:12:13 -0700 (PDT)
Received: from [10.20.0.186] ([199.101.192.9])
        by smtp.gmail.com with ESMTPSA id v13-20020a637a0d000000b003fad46ceb85sm7920085pgc.7.2022.06.14.07.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 07:12:13 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] crypto: hisilicon/qm - defining the device
 isolation strategy
To:     Kai Ye <yekai13@huawei.com>, gregkh@linuxfoundation.org,
        herbert@gondor.apana.org.au
Cc:     linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com, linux-crypto@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org
References: <20220614122943.1406-1-yekai13@huawei.com>
 <20220614122943.1406-4-yekai13@huawei.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <82ce379f-73f4-0e57-ec32-e1ab1d3ef04d@linaro.org>
Date:   Tue, 14 Jun 2022 22:12:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220614122943.1406-4-yekai13@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/14 下午8:29, Kai Ye via Linux-accelerators wrote:
> Define the device isolation strategy by the device driver. if the
> AER error frequency exceeds the value of setting for a certain
> period of time, The device will not be available in user space. The VF
> device use the PF device isolation strategy. All the hardware errors
> are processed by PF driver.
>
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> ---
>   drivers/crypto/hisilicon/qm.c | 157 +++++++++++++++++++++++++++++++---
>   include/linux/hisi_acc_qm.h   |   9 ++
>   2 files changed, 152 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
> index ad83c194d664..47c41fa52693 100644
> --- a/drivers/crypto/hisilicon/qm.c
> +++ b/drivers/crypto/hisilicon/qm.c
> @@ -12,7 +12,6 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/seq_file.h>
>   #include <linux/slab.h>
> -#include <linux/uacce.h>
>   #include <linux/uaccess.h>
>   #include <uapi/misc/uacce/hisi_qm.h>
>   #include <linux/hisi_acc_qm.h>
> @@ -417,6 +416,16 @@ struct hisi_qm_resource {
>   	struct list_head list;
>   };
>   
> +/**
> + * struct qm_hw_err - structure of describes the device err
> + * @list: hardware error list
> + * @tick_stamp: timestamp when the error occurred
> + */
> +struct qm_hw_err {
> +	struct list_head list;
> +	unsigned long long tick_stamp;
> +};
> +
>   struct hisi_qm_hw_ops {
>   	int (*get_vft)(struct hisi_qm *qm, u32 *base, u32 *number);
>   	void (*qm_db)(struct hisi_qm *qm, u16 qn,
> @@ -3278,6 +3287,7 @@ static int hisi_qm_uacce_get_queue(struct uacce_device *uacce,
>   	qp->event_cb = qm_qp_event_notifier;
>   	qp->pasid = arg;
>   	qp->is_in_kernel = false;
> +	atomic_inc(&qm->uacce_ref);
>   
>   	return 0;
>   }
> @@ -3285,7 +3295,9 @@ static int hisi_qm_uacce_get_queue(struct uacce_device *uacce,
>   static void hisi_qm_uacce_put_queue(struct uacce_queue *q)
>   {
>   	struct hisi_qp *qp = q->priv;
> +	struct hisi_qm *qm = qp->qm;
>   
> +	atomic_dec(&qm->uacce_ref);

Can we use qm state or qp state instead?

enum qm_state {
         QM_INIT = 0,
         QM_START,
         QM_CLOSE,
         QM_STOP,
};

enum qp_state {
         QP_INIT = 1,
         QP_START,
         QP_STOP,
         QP_CLOSE,
};

Thanks

