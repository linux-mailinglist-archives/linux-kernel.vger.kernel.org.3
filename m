Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D565AEE41
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiIFO4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiIFO4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:56:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881BDA6ADE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:11:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b5so15667705wrr.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=kCbfEqsOXR5IsgCKavZML32JAQZ8DVeK7ixryUpnXNU=;
        b=NB3EHz53hi9imr5bSDPIZSCbKTeVVr3pIJx9qtvZHWoO+HjDU3942hFYjM1TClWCif
         aWb+XJzqmwWJSPxLMzhrVPCc+sj/RfUhDWezkjEWVaBz8luitB31gzNkeT2k2sJTci6c
         5ldYm/CmZcceE7JBq+2qxAo+sU08X8SJKF7JOJyEPqayLUwqvj9CkkqZsBRIOwkXAVl+
         QGhY0446FMzEM6Vt9i6HoGfv1yn+5zV+6Shpx2wByzdEZ4GJCGS//uNfuAZnwryggzBG
         vsH6WLe1ffrapk52BRxbm8pePfITOiaxGB/9qk3vqGFng5w9XZLKMDmKWg7xWFRHVXLh
         g0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kCbfEqsOXR5IsgCKavZML32JAQZ8DVeK7ixryUpnXNU=;
        b=6q18PvlJgjRHlzd3sYeWldasaTjmoXZcZA3zb1b1lmIePDMV+aQar/OgMD+mrc0Hs4
         8ct8+tBfZvE5DlyXnd4hBdWCs11EbXUvLPmev/fftd2VqjOyMu/pmAQLSfKGAo9eBz4l
         TrTKx2cGKYQIP4dKX4xVi2Uzf0A7xIsB629nJq+spbuzg7FWPNgnqjKKledSBytDkZxm
         qycvGdf7Fpgm9hlp07W8pT6/YygQOofQMnZMlkZ4JwlAEL5e4/m2ec5gSRzO2WzE2VtP
         30SnnazNfUoqTsAdqx4BKtZv+QUtKnKgH1HBV2nmkzu9Boq4iQ7FkaOqzx3hj09SMf1d
         YQ6g==
X-Gm-Message-State: ACgBeo2wxOqMx6tpuH/pKNEHCA8f2p8e4ysAPnNqj5M7Nm6qvsuz8N8Z
        foMHftX5bahP5MxXCZuF1VgGKg==
X-Google-Smtp-Source: AA6agR5QlN1ZXAOOw3uyKxNEfHQGWWLDC1Py7LiDoS+i4oXqkzPYfnPRVtXlkzT/kOkaxC0WkjYflw==
X-Received: by 2002:a05:6000:11d0:b0:228:8d5d:f2e9 with SMTP id i16-20020a05600011d000b002288d5df2e9mr5766240wrx.207.1662473442472;
        Tue, 06 Sep 2022 07:10:42 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id z7-20020a05600c0a0700b003a5c1e916c8sm37417040wmp.1.2022.09.06.07.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 07:10:42 -0700 (PDT)
Message-ID: <200f2cc9-1747-95a3-82b1-600650cff1df@linaro.org>
Date:   Tue, 6 Sep 2022 15:10:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 07/10] misc: fastrpc: Add support for audiopd
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ekansh Gupta <quic_ekagupt@quicinc.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <20220902154900.3404524-1-abel.vesa@linaro.org>
 <20220902154900.3404524-8-abel.vesa@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220902154900.3404524-8-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Abel,
Some minor comments.

On 02/09/2022 16:48, Abel Vesa wrote:
> In order to be able to start the adsp listener for audiopd using adsprpcd,
> we need to add the corresponding ioctl for creating a static process.
> On that ioctl call we need to allocate the heap. Allocating the heap needs
> to be happening only once and needs to be kept between different device
> open calls, so attach it to the channel context to make sure that remains
> until the RPMSG driver is removed. Then, if there are any VMIDs associated
> with the static ADSP process, do a call to SCM to assign it.
> And then, send all the necessary info related to heap to the DSP.
> 
> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/misc/fastrpc.c      | 126 ++++++++++++++++++++++++++++++++++++
>   include/uapi/misc/fastrpc.h |   7 ++
>   2 files changed, 133 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 7c364c58e379..2c656da4ca5e 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -37,8 +37,20 @@
>   #define FASTRPC_DSP_UTILITIES_HANDLE	2
>   #define FASTRPC_CTXID_MASK (0xFF0)
>   #define INIT_FILELEN_MAX (2 * 1024 * 1024)
> +#define INIT_FILE_NAMELEN_MAX (128)
>   #define FASTRPC_DEVICE_NAME	"fastrpc"
> +
> +/* Add memory to static PD pool, protection thru XPU */
> +#define ADSP_MMAP_HEAP_ADDR  4
> +/* MAP static DMA buffer on DSP User PD */
> +#define ADSP_MMAP_DMA_BUFFER  6
> +/* Add memory to static PD pool protection thru hypervisor */
> +#define ADSP_MMAP_REMOTE_HEAP_ADDR  8
> +/* Add memory to userPD pool, for user heap */
>   #define ADSP_MMAP_ADD_PAGES 0x1000
> +/* Add memory to userPD pool, for LLC heap */
> +#define ADSP_MMAP_ADD_PAGES_LLC 0x3000,
> +
>   #define DSP_UNSUPPORTED_API (0x80000414)
>   /* MAX NUMBER of DSP ATTRIBUTES SUPPORTED */
>   #define FASTRPC_MAX_DSP_ATTRIBUTES (256)
> @@ -72,6 +84,7 @@
>   		FASTRPC_BUILD_SCALARS(0, method, in, out, 0, 0)
>   
>   #define FASTRPC_CREATE_PROCESS_NARGS	6
> +#define FASTRPC_CREATE_STATIC_PROCESS_NARGS	3
>   /* Remote Method id table */
>   #define FASTRPC_RMID_INIT_ATTACH	0
>   #define FASTRPC_RMID_INIT_RELEASE	1
> @@ -261,6 +274,7 @@ struct fastrpc_channel_ctx {
>   	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
>   	struct fastrpc_device *secure_fdevice;
>   	struct fastrpc_device *fdevice;
> +	struct fastrpc_buf *remote_heap;
>   	bool secure;
>   	bool unsigned_support;
>   };
> @@ -1167,6 +1181,7 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>   		spin_unlock(&fl->lock);
>   		fastrpc_context_put(ctx);
>   	}
> +

new line not relevant to this patch.

>   	if (err)
>   		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
>   
> @@ -1191,6 +1206,111 @@ static bool is_session_rejected(struct fastrpc_user *fl, bool unsigned_pd_reques
>   	return false;
>   }
>   
> +static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
> +					      char __user *argp)
> +{
> +	struct fastrpc_init_create_static init;
> +	struct fastrpc_invoke_args *args;
> +	struct fastrpc_phy_page pages[1];
> +	char *name;
> +	int err;
> +	struct {
> +		int pgid;
> +		u32 namelen;
> +		u32 pageslen;
> +	} inbuf;
> +	u32 sc;
> +
> +	args = kcalloc(FASTRPC_CREATE_STATIC_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
> +	if (!args)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(&init, argp, sizeof(init))) {
> +		err = -EFAULT;
> +		goto err;
> +	}
> +
> +	if (init.namelen > INIT_FILE_NAMELEN_MAX) {
> +		err = -EINVAL;
> +		goto err;
> +	}
> +
> +	name = kzalloc(init.namelen, GFP_KERNEL);
> +	if (!name) {
> +		err = -ENOMEM;
> +		goto err;
> +	}
> +
> +	if (copy_from_user(name, (void __user *)(uintptr_t)init.name, init.namelen)) {
> +		err = -EFAULT;
> +		goto err_name;
> +	}
> +
> +	if (!fl->cctx->remote_heap) {
> +		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
> +						&fl->cctx->remote_heap);
> +		if (err)
> +			goto err_name;
> +
> +		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
> +		if (fl->cctx->vmcount) {
> +			unsigned int perms = BIT(QCOM_SCM_VMID_HLOS);
> +
> +			dev_dbg(fl->sctx->dev, "Assinging memory with phys 0x%llx size 0x%llx perms 0x%x, vmperms %x, vmcount %x\n",
> +				fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size,
> +				perms, fl->cctx->vmperms, fl->cctx->vmcount);

Please remove this debug, do we really need this?

> +			err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
> +							(u64)fl->cctx->remote_heap->size, &perms,
> +							fl->cctx->vmperms, fl->cctx->vmcount);
> +			if (err) {
> +				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
> +					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
> +				goto err_map;
> +			}
> +		}
> +	}
> +
> +	inbuf.pgid = fl->tgid;
> +	inbuf.namelen = init.namelen;
> +	inbuf.pageslen = 0;
> +	fl->pd = USER_PD;
> +
> +	args[0].ptr = (u64)(uintptr_t)&inbuf;
> +	args[0].length = sizeof(inbuf);
> +	args[0].fd = -1;
> +
> +	args[1].ptr = (u64)(uintptr_t)name;
> +	args[1].length = inbuf.namelen;
> +	args[1].fd = -1;
> +
> +	pages[0].addr = fl->cctx->remote_heap->phys;
> +	pages[0].size = fl->cctx->remote_heap->size;
> +
> +	args[2].ptr = (u64)(uintptr_t) pages;
> +	args[2].length = sizeof(*pages);
> +	args[2].fd = -1;
> +
> +	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_STATIC, 3, 0);
> +
> +	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
> +				      sc, args);
> +	if (err)
> +		goto err_invoke;
> +
> +	kfree(args);
> +
> +	return 0;
> +err_invoke:
What happens to the secure mappings here, if invoke failed should we not 
cleanup that part?
Or may be a not saying that we will be reusing this would be nice.

> +err_map:
> +	fastrpc_buf_free(fl->cctx->remote_heap);
> +err_name:
> +	kfree(name);
> +err:
> +	kfree(args);
> +
> +	return err;
> +}
> +
>   static int fastrpc_init_create_process(struct fastrpc_user *fl,
>   					char __user *argp)
>   {
> @@ -1918,6 +2038,9 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
>   	case FASTRPC_IOCTL_INIT_ATTACH_SNS:
>   		err = fastrpc_init_attach(fl, SENSORS_PD);
>   		break;
> +	case FASTRPC_IOCTL_INIT_CREATE_STATIC:
> +		err = fastrpc_init_create_static_process(fl, argp);
> +		break;
>   	case FASTRPC_IOCTL_INIT_CREATE:
>   		err = fastrpc_init_create_process(fl, argp);
>   		break;
> @@ -2183,6 +2306,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>   	if (cctx->secure_fdevice)
>   		misc_deregister(&cctx->secure_fdevice->miscdev);
>   
> +	if (cctx->remote_heap)
> +		fastrpc_buf_free(cctx->remote_heap);
> +
>   	of_platform_depopulate(&rpdev->dev);
>   
>   	cctx->rpdev = NULL;
> diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
> index 5e29f2cfa42d..2cdf2f137d33 100644
> --- a/include/uapi/misc/fastrpc.h
> +++ b/include/uapi/misc/fastrpc.h
> @@ -16,6 +16,7 @@
>   #define FASTRPC_IOCTL_MEM_MAP		_IOWR('R', 10, struct fastrpc_mem_map)
>   #define FASTRPC_IOCTL_MEM_UNMAP		_IOWR('R', 11, struct fastrpc_mem_unmap)
>   #define FASTRPC_IOCTL_GET_DSP_INFO	_IOWR('R', 13, struct fastrpc_ioctl_capability)
> +#define FASTRPC_IOCTL_INIT_CREATE_STATIC _IOWR('R', 15, struct fastrpc_init_create_static)
>   
>   /**
>    * enum fastrpc_map_flags - control flags for mapping memory on DSP user process
> @@ -87,6 +88,12 @@ struct fastrpc_init_create {
>   	__u64 file;	/* pointer to elf file */
>   };
>   
> +struct fastrpc_init_create_static {
> +	__u32 namelen;	/* length of pd process name */
> +	__u32 memlen;
> +	__u64 name;	/* pd process name */
> +};
> +
>   struct fastrpc_alloc_dma_buf {
>   	__s32 fd;	/* fd */
>   	__u32 flags;	/* flags to map with */
