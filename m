Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E234B75E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243912AbiBOUCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:02:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243885AbiBOUC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:02:27 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B800C70876
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:02:16 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id i62so25351394ioa.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=y3eHOZq/7gM9/505oK7Dg6QeoKde9UphKq/UEtH4Xe0=;
        b=qz+U/SztG/IeoI1GPYfChICBkKr/unnN0JFaEai6Tc4LlG6OjW7Fa8VukImhMgdAl0
         Yoox6av7u9R2705SMsj+AsTOmCudfK98YNuIPujulZwyN0JUrQ31CxeqW1bSmyLK737F
         GgyOoBdaPlA2i8l5p9caRnWqVYjM1pMOtuFQUeS7ugXTbQXxn/5rwee+y1yF1TD/Fdvj
         FsLyqHBrIbtv5i4OBq2qmGY2lpn7XbW3f7yraCnZ7e1qAKZKtQ0cQyIVqPrDyO39nxFE
         RgTSLf4Wlx93e61zDyuwB0ExxXv9IGNIJH6PGGh54eSLkQYMgWCJAqFgcozufeg7175b
         iF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y3eHOZq/7gM9/505oK7Dg6QeoKde9UphKq/UEtH4Xe0=;
        b=ioiVaBwMlI/4d8su769oiAwIDbKh2rD0zFvThRSUORUDD6RfJO5FN/JuJo/c+FZqbZ
         JrQjcgzoipvjOH5Kk+DBkD1NTK/ZcH8KIVlUqaH4CnbINitCbsKSoT4QWwWCwkvh0bNH
         AoHNl2RcJyiHxmPwlWGXVKPmczr8lmGr/U/pioVc+B75UrugC04/2kxRvLiEzJp12R4m
         XlnfOj++xk5KNUYixO9L/FhWv40DxZXMmNocE/O0JhxDQBhMl//cPWhPx0o/5ZGY7WCz
         +3sjHBRyoAyUrX4JJC2i3qFItGJzjVwO463qRVqWX91XyVA0/qXDxFIKtMWon5ad7T8Y
         QWzw==
X-Gm-Message-State: AOAM5315oj+sGXAyz1I3CpV09bB8AvCLhI/2fYBZdqYnJYiFjot2650m
        EaBqSxNcOioaQm2Llvaha2mHzQ==
X-Google-Smtp-Source: ABdhPJwfStl534+vINhq+AIZfsEPCPnS2XVsFKSwNWnkSND5GS2Rz1t+/Pq8JT/DZQqVcMhyJZxdXg==
X-Received: by 2002:a05:6638:1413:: with SMTP id k19mr372338jad.76.1644955336081;
        Tue, 15 Feb 2022 12:02:16 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id f2sm3063417ilu.79.2022.02.15.12.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 12:02:15 -0800 (PST)
Message-ID: <b1d21445-2779-ce94-b18e-953da7567735@linaro.org>
Date:   Tue, 15 Feb 2022 14:02:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 04/25] bus: mhi: Move common MHI definitions out of
 host directory
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-5-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-5-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/22 12:20 PM, Manivannan Sadhasivam wrote:
> Move the common MHI definitions in host "internal.h" to "common.h" so
> that the endpoint code can make use of them. This also avoids
> duplicating the definitions in the endpoint stack.
> 
> Still, the MHI register definitions are not moved since the offsets
> vary between host and endpoint.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

If you care to implement the following suggestion, great, but I'm
not going to demand it.

I see you did some work in patch 6 where you move the MHI register
definitions into "common.h".  This is along the lines of something
I suggested before.

I prefer to see those sort of changes *before* a patch like this.
I.e., make changes to the way the definitions are defined, *then*
move the definitions to their new location as a large block.

The result is the same, but I just find it nicer to do work that
prepares things in early patches, making later patches simpler
transformations.

Another small example of my point is in this patch, some of the
definitions are done in a different order in their new location.
As a reviewer, I'd rather see the reordering done first, then
the move to the new location done in one big batch that is easily
verified.

Aside from making that point, this looks fine to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/bus/mhi/common.h        | 167 ++++++++++++++++++++++++++++++++
>   drivers/bus/mhi/host/internal.h | 155 +----------------------------
>   2 files changed, 168 insertions(+), 154 deletions(-)
>   create mode 100644 drivers/bus/mhi/common.h
> 
> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
> new file mode 100644
> index 000000000000..0d13a202d334
> --- /dev/null
> +++ b/drivers/bus/mhi/common.h
> @@ -0,0 +1,167 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2021, Linaro Ltd.
> + *
> + */
> +
> +#ifndef _MHI_COMMON_H
> +#define _MHI_COMMON_H
> +
> +#include <linux/mhi.h>
> +
> +/* Command Ring Element macros */
> +/* No operation command */
> +#define MHI_TRE_CMD_NOOP_PTR (0)
> +#define MHI_TRE_CMD_NOOP_DWORD0 (0)
> +#define MHI_TRE_CMD_NOOP_DWORD1 (cpu_to_le32(MHI_CMD_NOP << 16))
> +
> +/* Channel reset command */
> +#define MHI_TRE_CMD_RESET_PTR (0)
> +#define MHI_TRE_CMD_RESET_DWORD0 (0)
> +#define MHI_TRE_CMD_RESET_DWORD1(chid) (cpu_to_le32((chid << 24) | \
> +					(MHI_CMD_RESET_CHAN << 16)))
> +
> +/* Channel stop command */
> +#define MHI_TRE_CMD_STOP_PTR (0)
> +#define MHI_TRE_CMD_STOP_DWORD0 (0)
> +#define MHI_TRE_CMD_STOP_DWORD1(chid) (cpu_to_le32((chid << 24) | \
> +				       (MHI_CMD_STOP_CHAN << 16)))
> +
> +/* Channel start command */
> +#define MHI_TRE_CMD_START_PTR (0)
> +#define MHI_TRE_CMD_START_DWORD0 (0)
> +#define MHI_TRE_CMD_START_DWORD1(chid) (cpu_to_le32((chid << 24) | \
> +					(MHI_CMD_START_CHAN << 16)))
> +
> +#define MHI_TRE_GET_DWORD(tre, word) (le32_to_cpu((tre)->dword[(word)]))
> +#define MHI_TRE_GET_CMD_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
> +#define MHI_TRE_GET_CMD_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
> +
> +/* Event descriptor macros */
> +#define MHI_TRE_EV_PTR(ptr) (cpu_to_le64(ptr))
> +#define MHI_TRE_EV_DWORD0(code, len) (cpu_to_le32((code << 24) | len))
> +#define MHI_TRE_EV_DWORD1(chid, type) (cpu_to_le32((chid << 24) | (type << 16)))
> +#define MHI_TRE_GET_EV_PTR(tre) (le64_to_cpu((tre)->ptr))
> +#define MHI_TRE_GET_EV_CODE(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_LEN(tre) (MHI_TRE_GET_DWORD(tre, 0) & 0xFFFF)
> +#define MHI_TRE_GET_EV_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
> +#define MHI_TRE_GET_EV_STATE(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_EXECENV(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_SEQ(tre) MHI_TRE_GET_DWORD(tre, 0)
> +#define MHI_TRE_GET_EV_TIME(tre) (MHI_TRE_GET_EV_PTR(tre))
> +#define MHI_TRE_GET_EV_COOKIE(tre) lower_32_bits(MHI_TRE_GET_EV_PTR(tre))
> +#define MHI_TRE_GET_EV_VEID(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 16) & 0xFF)
> +#define MHI_TRE_GET_EV_LINKSPEED(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_LINKWIDTH(tre) (MHI_TRE_GET_DWORD(tre, 0) & 0xFF)
> +
> +/* Transfer descriptor macros */
> +#define MHI_TRE_DATA_PTR(ptr) (cpu_to_le64(ptr))
> +#define MHI_TRE_DATA_DWORD0(len) (cpu_to_le32(len & MHI_MAX_MTU))
> +#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) (cpu_to_le32((2 << 16) | (bei << 10) \
> +	| (ieot << 9) | (ieob << 8) | chain))
> +
> +/* RSC transfer descriptor macros */
> +#define MHI_RSCTRE_DATA_PTR(ptr, len) (cpu_to_le64(((u64)len << 48) | ptr))
> +#define MHI_RSCTRE_DATA_DWORD0(cookie) (cpu_to_le32(cookie))
> +#define MHI_RSCTRE_DATA_DWORD1 (cpu_to_le32(MHI_PKT_TYPE_COALESCING << 16))
> +
> +enum mhi_pkt_type {
> +	MHI_PKT_TYPE_INVALID = 0x0,
> +	MHI_PKT_TYPE_NOOP_CMD = 0x1,
> +	MHI_PKT_TYPE_TRANSFER = 0x2,
> +	MHI_PKT_TYPE_COALESCING = 0x8,
> +	MHI_PKT_TYPE_RESET_CHAN_CMD = 0x10,
> +	MHI_PKT_TYPE_STOP_CHAN_CMD = 0x11,
> +	MHI_PKT_TYPE_START_CHAN_CMD = 0x12,
> +	MHI_PKT_TYPE_STATE_CHANGE_EVENT = 0x20,
> +	MHI_PKT_TYPE_CMD_COMPLETION_EVENT = 0x21,
> +	MHI_PKT_TYPE_TX_EVENT = 0x22,
> +	MHI_PKT_TYPE_RSC_TX_EVENT = 0x28,
> +	MHI_PKT_TYPE_EE_EVENT = 0x40,
> +	MHI_PKT_TYPE_TSYNC_EVENT = 0x48,
> +	MHI_PKT_TYPE_BW_REQ_EVENT = 0x50,
> +	MHI_PKT_TYPE_STALE_EVENT, /* internal event */
> +};
> +
> +/* MHI transfer completion events */
> +enum mhi_ev_ccs {
> +	MHI_EV_CC_INVALID = 0x0,
> +	MHI_EV_CC_SUCCESS = 0x1,
> +	MHI_EV_CC_EOT = 0x2, /* End of transfer event */
> +	MHI_EV_CC_OVERFLOW = 0x3,
> +	MHI_EV_CC_EOB = 0x4, /* End of block event */
> +	MHI_EV_CC_OOB = 0x5, /* Out of block event */
> +	MHI_EV_CC_DB_MODE = 0x6,
> +	MHI_EV_CC_UNDEFINED_ERR = 0x10,
> +	MHI_EV_CC_BAD_TRE = 0x11,
> +};
> +
> +/* Channel state */
> +enum mhi_ch_state {
> +	MHI_CH_STATE_DISABLED,
> +	MHI_CH_STATE_ENABLED,
> +	MHI_CH_STATE_RUNNING,
> +	MHI_CH_STATE_SUSPENDED,
> +	MHI_CH_STATE_STOP,
> +	MHI_CH_STATE_ERROR,
> +};
> +
> +enum mhi_cmd_type {
> +	MHI_CMD_NOP = 1,
> +	MHI_CMD_RESET_CHAN = 16,
> +	MHI_CMD_STOP_CHAN = 17,
> +	MHI_CMD_START_CHAN = 18,
> +};
> +
> +#define EV_CTX_RESERVED_MASK GENMASK(7, 0)
> +#define EV_CTX_INTMODC_MASK GENMASK(15, 8)
> +#define EV_CTX_INTMODC_SHIFT 8
> +#define EV_CTX_INTMODT_MASK GENMASK(31, 16)
> +#define EV_CTX_INTMODT_SHIFT 16
> +struct mhi_event_ctxt {
> +	__le32 intmod;
> +	__le32 ertype;
> +	__le32 msivec;
> +
> +	__le64 rbase __packed __aligned(4);
> +	__le64 rlen __packed __aligned(4);
> +	__le64 rp __packed __aligned(4);
> +	__le64 wp __packed __aligned(4);
> +};
> +
> +#define CHAN_CTX_CHSTATE_MASK GENMASK(7, 0)
> +#define CHAN_CTX_CHSTATE_SHIFT 0
> +#define CHAN_CTX_BRSTMODE_MASK GENMASK(9, 8)
> +#define CHAN_CTX_BRSTMODE_SHIFT 8
> +#define CHAN_CTX_POLLCFG_MASK GENMASK(15, 10)
> +#define CHAN_CTX_POLLCFG_SHIFT 10
> +#define CHAN_CTX_RESERVED_MASK GENMASK(31, 16)
> +struct mhi_chan_ctxt {
> +	__le32 chcfg;
> +	__le32 chtype;
> +	__le32 erindex;
> +
> +	__le64 rbase __packed __aligned(4);
> +	__le64 rlen __packed __aligned(4);
> +	__le64 rp __packed __aligned(4);
> +	__le64 wp __packed __aligned(4);
> +};
> +
> +struct mhi_cmd_ctxt {
> +	__le32 reserved0;
> +	__le32 reserved1;
> +	__le32 reserved2;
> +
> +	__le64 rbase __packed __aligned(4);
> +	__le64 rlen __packed __aligned(4);
> +	__le64 rp __packed __aligned(4);
> +	__le64 wp __packed __aligned(4);
> +};
> +
> +extern const char * const mhi_state_str[MHI_STATE_MAX];
> +#define TO_MHI_STATE_STR(state) ((state >= MHI_STATE_MAX || \
> +				  !mhi_state_str[state]) ? \
> +				"INVALID_STATE" : mhi_state_str[state])
> +
> +#endif /* _MHI_COMMON_H */
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index fa64340a8997..622de6ba1a0b 100644
> --- a/drivers/bus/mhi/host/internal.h
> +++ b/drivers/bus/mhi/host/internal.h
> @@ -7,7 +7,7 @@
>   #ifndef _MHI_INT_H
>   #define _MHI_INT_H
>   
> -#include <linux/mhi.h>
> +#include "../common.h"
>   
>   extern struct bus_type mhi_bus_type;
>   
> @@ -203,51 +203,6 @@ extern struct bus_type mhi_bus_type;
>   #define SOC_HW_VERSION_MINOR_VER_BMSK (0x000000FF)
>   #define SOC_HW_VERSION_MINOR_VER_SHFT (0)
>   
> -#define EV_CTX_RESERVED_MASK GENMASK(7, 0)
> -#define EV_CTX_INTMODC_MASK GENMASK(15, 8)
> -#define EV_CTX_INTMODC_SHIFT 8
> -#define EV_CTX_INTMODT_MASK GENMASK(31, 16)
> -#define EV_CTX_INTMODT_SHIFT 16
> -struct mhi_event_ctxt {
> -	__le32 intmod;
> -	__le32 ertype;
> -	__le32 msivec;
> -
> -	__le64 rbase __packed __aligned(4);
> -	__le64 rlen __packed __aligned(4);
> -	__le64 rp __packed __aligned(4);
> -	__le64 wp __packed __aligned(4);
> -};
> -
> -#define CHAN_CTX_CHSTATE_MASK GENMASK(7, 0)
> -#define CHAN_CTX_CHSTATE_SHIFT 0
> -#define CHAN_CTX_BRSTMODE_MASK GENMASK(9, 8)
> -#define CHAN_CTX_BRSTMODE_SHIFT 8
> -#define CHAN_CTX_POLLCFG_MASK GENMASK(15, 10)
> -#define CHAN_CTX_POLLCFG_SHIFT 10
> -#define CHAN_CTX_RESERVED_MASK GENMASK(31, 16)
> -struct mhi_chan_ctxt {
> -	__le32 chcfg;
> -	__le32 chtype;
> -	__le32 erindex;
> -
> -	__le64 rbase __packed __aligned(4);
> -	__le64 rlen __packed __aligned(4);
> -	__le64 rp __packed __aligned(4);
> -	__le64 wp __packed __aligned(4);
> -};
> -
> -struct mhi_cmd_ctxt {
> -	__le32 reserved0;
> -	__le32 reserved1;
> -	__le32 reserved2;
> -
> -	__le64 rbase __packed __aligned(4);
> -	__le64 rlen __packed __aligned(4);
> -	__le64 rp __packed __aligned(4);
> -	__le64 wp __packed __aligned(4);
> -};
> -
>   struct mhi_ctxt {
>   	struct mhi_event_ctxt *er_ctxt;
>   	struct mhi_chan_ctxt *chan_ctxt;
> @@ -267,109 +222,6 @@ struct bhi_vec_entry {
>   	u64 size;
>   };
>   
> -enum mhi_cmd_type {
> -	MHI_CMD_NOP = 1,
> -	MHI_CMD_RESET_CHAN = 16,
> -	MHI_CMD_STOP_CHAN = 17,
> -	MHI_CMD_START_CHAN = 18,
> -};
> -
> -/* No operation command */
> -#define MHI_TRE_CMD_NOOP_PTR (0)
> -#define MHI_TRE_CMD_NOOP_DWORD0 (0)
> -#define MHI_TRE_CMD_NOOP_DWORD1 (cpu_to_le32(MHI_CMD_NOP << 16))
> -
> -/* Channel reset command */
> -#define MHI_TRE_CMD_RESET_PTR (0)
> -#define MHI_TRE_CMD_RESET_DWORD0 (0)
> -#define MHI_TRE_CMD_RESET_DWORD1(chid) (cpu_to_le32((chid << 24) | \
> -					(MHI_CMD_RESET_CHAN << 16)))
> -
> -/* Channel stop command */
> -#define MHI_TRE_CMD_STOP_PTR (0)
> -#define MHI_TRE_CMD_STOP_DWORD0 (0)
> -#define MHI_TRE_CMD_STOP_DWORD1(chid) (cpu_to_le32((chid << 24) | \
> -				       (MHI_CMD_STOP_CHAN << 16)))
> -
> -/* Channel start command */
> -#define MHI_TRE_CMD_START_PTR (0)
> -#define MHI_TRE_CMD_START_DWORD0 (0)
> -#define MHI_TRE_CMD_START_DWORD1(chid) (cpu_to_le32((chid << 24) | \
> -					(MHI_CMD_START_CHAN << 16)))
> -
> -#define MHI_TRE_GET_DWORD(tre, word) (le32_to_cpu((tre)->dword[(word)]))
> -#define MHI_TRE_GET_CMD_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
> -#define MHI_TRE_GET_CMD_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
> -
> -/* Event descriptor macros */
> -#define MHI_TRE_EV_PTR(ptr) (cpu_to_le64(ptr))
> -#define MHI_TRE_EV_DWORD0(code, len) (cpu_to_le32((code << 24) | len))
> -#define MHI_TRE_EV_DWORD1(chid, type) (cpu_to_le32((chid << 24) | (type << 16)))
> -#define MHI_TRE_GET_EV_PTR(tre) (le64_to_cpu((tre)->ptr))
> -#define MHI_TRE_GET_EV_CODE(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
> -#define MHI_TRE_GET_EV_LEN(tre) (MHI_TRE_GET_DWORD(tre, 0) & 0xFFFF)
> -#define MHI_TRE_GET_EV_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
> -#define MHI_TRE_GET_EV_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
> -#define MHI_TRE_GET_EV_STATE(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
> -#define MHI_TRE_GET_EV_EXECENV(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
> -#define MHI_TRE_GET_EV_SEQ(tre) MHI_TRE_GET_DWORD(tre, 0)
> -#define MHI_TRE_GET_EV_TIME(tre) (MHI_TRE_GET_EV_PTR(tre))
> -#define MHI_TRE_GET_EV_COOKIE(tre) lower_32_bits(MHI_TRE_GET_EV_PTR(tre))
> -#define MHI_TRE_GET_EV_VEID(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 16) & 0xFF)
> -#define MHI_TRE_GET_EV_LINKSPEED(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
> -#define MHI_TRE_GET_EV_LINKWIDTH(tre) (MHI_TRE_GET_DWORD(tre, 0) & 0xFF)
> -
> -/* Transfer descriptor macros */
> -#define MHI_TRE_DATA_PTR(ptr) (cpu_to_le64(ptr))
> -#define MHI_TRE_DATA_DWORD0(len) (cpu_to_le32(len & MHI_MAX_MTU))
> -#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) (cpu_to_le32((2 << 16) | (bei << 10) \
> -	| (ieot << 9) | (ieob << 8) | chain))
> -
> -/* RSC transfer descriptor macros */
> -#define MHI_RSCTRE_DATA_PTR(ptr, len) (cpu_to_le64(((u64)len << 48) | ptr))
> -#define MHI_RSCTRE_DATA_DWORD0(cookie) (cpu_to_le32(cookie))
> -#define MHI_RSCTRE_DATA_DWORD1 (cpu_to_le32(MHI_PKT_TYPE_COALESCING << 16))
> -
> -enum mhi_pkt_type {
> -	MHI_PKT_TYPE_INVALID = 0x0,
> -	MHI_PKT_TYPE_NOOP_CMD = 0x1,
> -	MHI_PKT_TYPE_TRANSFER = 0x2,
> -	MHI_PKT_TYPE_COALESCING = 0x8,
> -	MHI_PKT_TYPE_RESET_CHAN_CMD = 0x10,
> -	MHI_PKT_TYPE_STOP_CHAN_CMD = 0x11,
> -	MHI_PKT_TYPE_START_CHAN_CMD = 0x12,
> -	MHI_PKT_TYPE_STATE_CHANGE_EVENT = 0x20,
> -	MHI_PKT_TYPE_CMD_COMPLETION_EVENT = 0x21,
> -	MHI_PKT_TYPE_TX_EVENT = 0x22,
> -	MHI_PKT_TYPE_RSC_TX_EVENT = 0x28,
> -	MHI_PKT_TYPE_EE_EVENT = 0x40,
> -	MHI_PKT_TYPE_TSYNC_EVENT = 0x48,
> -	MHI_PKT_TYPE_BW_REQ_EVENT = 0x50,
> -	MHI_PKT_TYPE_STALE_EVENT, /* internal event */
> -};
> -
> -/* MHI transfer completion events */
> -enum mhi_ev_ccs {
> -	MHI_EV_CC_INVALID = 0x0,
> -	MHI_EV_CC_SUCCESS = 0x1,
> -	MHI_EV_CC_EOT = 0x2, /* End of transfer event */
> -	MHI_EV_CC_OVERFLOW = 0x3,
> -	MHI_EV_CC_EOB = 0x4, /* End of block event */
> -	MHI_EV_CC_OOB = 0x5, /* Out of block event */
> -	MHI_EV_CC_DB_MODE = 0x6,
> -	MHI_EV_CC_UNDEFINED_ERR = 0x10,
> -	MHI_EV_CC_BAD_TRE = 0x11,
> -};
> -
> -enum mhi_ch_state {
> -	MHI_CH_STATE_DISABLED = 0x0,
> -	MHI_CH_STATE_ENABLED = 0x1,
> -	MHI_CH_STATE_RUNNING = 0x2,
> -	MHI_CH_STATE_SUSPENDED = 0x3,
> -	MHI_CH_STATE_STOP = 0x4,
> -	MHI_CH_STATE_ERROR = 0x5,
> -};
> -
>   enum mhi_ch_state_type {
>   	MHI_CH_STATE_TYPE_RESET,
>   	MHI_CH_STATE_TYPE_STOP,
> @@ -411,11 +263,6 @@ extern const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX];
>   #define TO_DEV_STATE_TRANS_STR(state) (((state) >= DEV_ST_TRANSITION_MAX) ? \
>   				"INVALID_STATE" : dev_state_tran_str[state])
>   
> -extern const char * const mhi_state_str[MHI_STATE_MAX];
> -#define TO_MHI_STATE_STR(state) ((state >= MHI_STATE_MAX || \
> -				  !mhi_state_str[state]) ? \
> -				"INVALID_STATE" : mhi_state_str[state])
> -
>   /* internal power states */
>   enum mhi_pm_state {
>   	MHI_PM_STATE_DISABLE,

