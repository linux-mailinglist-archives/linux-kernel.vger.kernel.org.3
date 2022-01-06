Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7159485D0D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343682AbiAFAWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343660AbiAFAW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:22:27 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A7BC061212
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 16:22:27 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id e128so1182554iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 16:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=Rox93wEnNMf5nANlOWyQ8Wb69Q5gjXkzmo9qfquSj4s=;
        b=XZm0H9Vbf/ELvSy3+ZDXXMvhlkeVfUDxUn+DnfU3Ei2kdeazgqU45nK8m3W8hku8k3
         uJwEcRMG2lxwDsuucd3Z6IWwcOLofh4c0CbSb2zZnZhkGWNAeY0pVRaYTc22J4naiu/E
         a0YyLEzvTPMuqfj+xmcrhpjNoOaNDm6O1M1iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=Rox93wEnNMf5nANlOWyQ8Wb69Q5gjXkzmo9qfquSj4s=;
        b=RwQHlsge24rsLaocqxhLg7jaxakuT0vzV5buvTik7u7+XkZmQZhwulIG93gf35UVSe
         qkwZDXYlYTDUmwbynH7XpvmJbpvVJH24/0FLV+E7SOuhUXCf6kiL9MMQFGtZIJENo36r
         /8YSYRjwj6dmN9y1lyUHMcMBayl3KkzlPmS4cpQqkocG1EsVS3pedfTk2tPMuFlyzJlU
         yabu0QdB03FfsU2jOIwZdFnrP8MJccIRW/s9vw1KlxENkBfxBwGYfBArMBVj9frYGN6w
         i1KWwjai27aSOJ8yYHUPrQkbATwTQcPHAlljUKbGoCSbOy4fMo8QRPIjveriRUMV4Y/+
         NSDw==
X-Gm-Message-State: AOAM532YmYTdcx3EXkHyIlOJPmDpC3UeRAN+aZrRQ68G4lvRHKa0G1FI
        PCUTYmU8mDEG51B5mjCTJ5uKoCpDJlwRwg==
X-Google-Smtp-Source: ABdhPJxG7pXJKlc4Ea+pVPrtOs4FGggqMLAvX8O4aYdkHg+DyQDbj0eti1uBdOwLLe8xek1pVW5g/Q==
X-Received: by 2002:a02:a517:: with SMTP id e23mr25687956jam.35.1641428546547;
        Wed, 05 Jan 2022 16:22:26 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id x5sm319881iov.32.2022.01.05.16.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 16:22:26 -0800 (PST)
Message-ID: <cf56733b-7c5d-e5f9-70c4-6f262fa2853b@ieee.org>
Date:   Wed, 5 Jan 2022 18:22:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
From:   Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 02/20] bus: mhi: Move common MHI definitions out of host
 directory
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
 <20211202113553.238011-3-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
In-Reply-To: <20211202113553.238011-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 5:35 AM, Manivannan Sadhasivam wrote:
> Move the common MHI definitions in host "internal.h" to "common.h" so
> that the endpoint code can make use of them. This also avoids
> duplicating the definitions in the endpoint stack.
> 
> Still, the MHI register definitions are not moved since the offsets
> vary between host and endpoint.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/bus/mhi/common.h        | 182 ++++++++++++++++++++++++++++++++
>   drivers/bus/mhi/host/internal.h | 154 +--------------------------
>   2 files changed, 183 insertions(+), 153 deletions(-)
>   create mode 100644 drivers/bus/mhi/common.h
> 
> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
> new file mode 100644
> index 000000000000..0f4f3b9f3027
> --- /dev/null
> +++ b/drivers/bus/mhi/common.h
> @@ -0,0 +1,182 @@
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

I know that the "new" code here is basically moved here as-is.  But
I'll take this opportunity to mention some things.

Command ring elements have a pretty well-defined structure.  I think
the code could be more readable if you defined it that way.

/* MHI commands only use the last two bytes of the structure */
struct mhi_cmd_tre {
     __le64	reserved0;	/* reserved fields must be zero */
     __le32	reserved1;
     __le16	reserved2;
     u8		channel_id;
     u8		command;
};

This isn't as good an example as is the TRE and event ring element
definitions though.

> +/* No operation command */

No need for parentheses for (0).

> +#define MHI_TRE_CMD_NOOP_PTR (0)
> +#define MHI_TRE_CMD_NOOP_DWORD0 (0)
> +#define MHI_TRE_CMD_NOOP_DWORD1 (MHI_CMD_NOP << 16)
> +
> +/* Channel reset command */
> +#define MHI_TRE_CMD_RESET_PTR (0)
> +#define MHI_TRE_CMD_RESET_DWORD0 (0)
> +#define MHI_TRE_CMD_RESET_DWORD1(chid) ((chid << 24) | \
> +					(MHI_CMD_RESET_CHAN << 16))
> +
> +/* Channel stop command */
> +#define MHI_TRE_CMD_STOP_PTR (0)
> +#define MHI_TRE_CMD_STOP_DWORD0 (0)
> +#define MHI_TRE_CMD_STOP_DWORD1(chid) ((chid << 24) | \
> +				       (MHI_CMD_STOP_CHAN << 16))
> +
> +/* Channel start command */
> +#define MHI_TRE_CMD_START_PTR (0)
> +#define MHI_TRE_CMD_START_DWORD0 (0)
> +#define MHI_TRE_CMD_START_DWORD1(chid) ((chid << 24) | \
> +					(MHI_CMD_START_CHAN << 16))
> +
> +#define MHI_TRE_GET_CMD_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
> +#define MHI_TRE_GET_CMD_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
> +
> +/* Event descriptor macros */
> +/* Transfer completion event */
> +#define MHI_TRE_EV_PTR(ptr) (ptr)
> +#define MHI_TRE_EV_DWORD0(code, len) ((code << 24) | len)
> +#define MHI_TRE_EV_DWORD1(chid, type) ((chid << 24) | (type << 16))

An event ring element could look like a bit like this:

struct mhi_event {
     __le64	tre_pointer;		/* refers to channel entry */
     u8		completion_code;	/* enum mhi_ev_ccs */
     u8		reserved0;
     u8		channel_id;
     u8		event_type;		/* enum mhi_pkt_type (?) */
     __le16	reserved1;
};

But different events have slightly different format (EE
events use byte in the "completion_code" position to hold
the EE number, for example).  So it could be a union of
structs.  You get the idea though.

The following macros operate on events, not TREs, so their names
and argument names should reflecvt that.

> +#define MHI_TRE_GET_EV_PTR(tre) ((tre)->ptr)
> +#define MHI_TRE_GET_EV_CODE(tre) (((tre)->dword[0] >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_LEN(tre) ((tre)->dword[0] & 0xFFFF)
> +#define MHI_TRE_GET_EV_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
> +#define MHI_TRE_GET_EV_STATE(tre) (((tre)->dword[0] >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_EXECENV(tre) (((tre)->dword[0] >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_SEQ(tre) ((tre)->dword[0])
> +#define MHI_TRE_GET_EV_TIME(tre) ((tre)->ptr)
> +#define MHI_TRE_GET_EV_COOKIE(tre) lower_32_bits((tre)->ptr)
> +#define MHI_TRE_GET_EV_VEID(tre) (((tre)->dword[0] >> 16) & 0xFF)
> +#define MHI_TRE_GET_EV_LINKSPEED(tre) (((tre)->dword[1] >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_LINKWIDTH(tre) ((tre)->dword[0] & 0xFF)
> +
> +/* State change event */
> +#define MHI_SC_EV_PTR 0
> +#define MHI_SC_EV_DWORD0(state) (state << 24)
> +#define MHI_SC_EV_DWORD1(type) (type << 16)
> +
> +/* EE event */
> +#define MHI_EE_EV_PTR 0
> +#define MHI_EE_EV_DWORD0(ee) (ee << 24)
> +#define MHI_EE_EV_DWORD1(type) (type << 16)
> +
> +/* Command Completion event */
> +#define MHI_CC_EV_PTR(ptr) (ptr)
> +#define MHI_CC_EV_DWORD0(code) (code << 24)
> +#define MHI_CC_EV_DWORD1(type) (type << 16)
> +
> +/* Transfer descriptor macros */
> +#define MHI_TRE_DATA_PTR(ptr) (ptr)

The following macro assumes MHI_MAX_MTU is a mask (2^x - 1).

> +#define MHI_TRE_DATA_DWORD0(len) (len & MHI_MAX_MTU)

It's not obvious the four parameters must be 0 or 1.
What does the (2 << 16) term here represent?

> +#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) ((2 << 16) | (bei << 10) \
> +	| (ieot << 9) | (ieob << 8) | chain)

A TRE could look like this:

struct mhi_tre {
     __le64	transfer_pointer;	/* dma_addr_t */
     __le16	len;
     __le16	reserved;
     __le32	flags;
};
#define MHI_TRE_FLAGS_CHAIN	cpu_to_le32(BIT(0))
#define MHI_TRE_FLAGS_IEOB	cpu_to_le32(BIT(8))
#define MHI_TRE_FLAGS_IEOT	cpu_to_le32(BIT(9))
#define MHI_TRE_FLAGS_BEI	cpu_to_le32(BIT(10))


> +
> +/* RSC transfer descriptor macros */
> +#define MHI_RSCTRE_DATA_PTR(ptr, len) (((u64)len << 48) | ptr)
> +#define MHI_RSCTRE_DATA_DWORD0(cookie) (cookie)
> +#define MHI_RSCTRE_DATA_DWORD1 (MHI_PKT_TYPE_COALESCING << 16)
> +
> +enum mhi_pkt_type {
> +	MHI_PKT_TYPE_INVALID = 0x0,

This is personal choice, but I like aligning the numeric
values assigned to symbols, by aligning the "=" in a
column.  Maybe use 0x01, 0x02 for single-digits too.

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

These fields should all be explicitly marked as little endian.
It so happens Intel and ARM use that, but defining them as
simple unsigned values is not correct for an external interface.

This comment applies to the command and channel context structures
also.

> +	__u32 intmod;
> +	__u32 ertype;
> +	__u32 msivec;
> +

I think you can just define the entire struct as __packed
and __aligned(4) rather than defining all of these fields
with those attributes.

> +	__u64 rbase __packed __aligned(4);
> +	__u64 rlen __packed __aligned(4);
> +	__u64 rp __packed __aligned(4);
> +	__u64 wp __packed __aligned(4);
> +};
> +
> +#define CHAN_CTX_CHSTATE_MASK GENMASK(7, 0)
> +#define CHAN_CTX_CHSTATE_SHIFT 0

Please eliminate all the _SHIFT definitions like this,
where you are already defining the corresponding _MASK.
The _SHIFT is redundant (and could lead to error, and
takes up extra space).

You are using bitfield operations (like FIELD_GET()) in
at least some places already.  Use them consistently
throughout the driver.  Those macros simplify the code
and obviate the need for any shift definitions.

					-Alex

> +#define CHAN_CTX_BRSTMODE_MASK GENMASK(9, 8)
> +#define CHAN_CTX_BRSTMODE_SHIFT 8
> +#define CHAN_CTX_POLLCFG_MASK GENMASK(15, 10)
> +#define CHAN_CTX_POLLCFG_SHIFT 10
> +#define CHAN_CTX_RESERVED_MASK GENMASK(31, 16)
> +struct mhi_chan_ctxt {
> +	__u32 chcfg;
> +	__u32 chtype;
> +	__u32 erindex;
> +
> +	__u64 rbase __packed __aligned(4);
> +	__u64 rlen __packed __aligned(4);
> +	__u64 rp __packed __aligned(4);
> +	__u64 wp __packed __aligned(4);
> +};
> +
> +struct mhi_cmd_ctxt {
> +	__u32 reserved0;
> +	__u32 reserved1;
> +	__u32 reserved2;
> +
> +	__u64 rbase __packed __aligned(4);
> +	__u64 rlen __packed __aligned(4);
> +	__u64 rp __packed __aligned(4);
> +	__u64 wp __packed __aligned(4);
> +};
> +
> +extern const char * const mhi_state_str[MHI_STATE_MAX];
> +#define TO_MHI_STATE_STR(state) ((state >= MHI_STATE_MAX || \
> +				  !mhi_state_str[state]) ? \
> +				"INVALID_STATE" : mhi_state_str[state])
> +
> +#endif /* _MHI_COMMON_H */
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index 3a732afaf73e..a324a76684d0 100644
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
> -	__u32 intmod;
> -	__u32 ertype;
> -	__u32 msivec;
> -
> -	__u64 rbase __packed __aligned(4);
> -	__u64 rlen __packed __aligned(4);
> -	__u64 rp __packed __aligned(4);
> -	__u64 wp __packed __aligned(4);
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
> -	__u32 chcfg;
> -	__u32 chtype;
> -	__u32 erindex;
> -
> -	__u64 rbase __packed __aligned(4);
> -	__u64 rlen __packed __aligned(4);
> -	__u64 rp __packed __aligned(4);
> -	__u64 wp __packed __aligned(4);
> -};
> -
> -struct mhi_cmd_ctxt {
> -	__u32 reserved0;
> -	__u32 reserved1;
> -	__u32 reserved2;
> -
> -	__u64 rbase __packed __aligned(4);
> -	__u64 rlen __packed __aligned(4);
> -	__u64 rp __packed __aligned(4);
> -	__u64 wp __packed __aligned(4);
> -};
> -
>   struct mhi_ctxt {
>   	struct mhi_event_ctxt *er_ctxt;
>   	struct mhi_chan_ctxt *chan_ctxt;
> @@ -267,108 +222,6 @@ struct bhi_vec_entry {
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
> -#define MHI_TRE_CMD_NOOP_DWORD1 (MHI_CMD_NOP << 16)
> -
> -/* Channel reset command */
> -#define MHI_TRE_CMD_RESET_PTR (0)
> -#define MHI_TRE_CMD_RESET_DWORD0 (0)
> -#define MHI_TRE_CMD_RESET_DWORD1(chid) ((chid << 24) | \
> -					(MHI_CMD_RESET_CHAN << 16))
> -
> -/* Channel stop command */
> -#define MHI_TRE_CMD_STOP_PTR (0)
> -#define MHI_TRE_CMD_STOP_DWORD0 (0)
> -#define MHI_TRE_CMD_STOP_DWORD1(chid) ((chid << 24) | \
> -				       (MHI_CMD_STOP_CHAN << 16))
> -
> -/* Channel start command */
> -#define MHI_TRE_CMD_START_PTR (0)
> -#define MHI_TRE_CMD_START_DWORD0 (0)
> -#define MHI_TRE_CMD_START_DWORD1(chid) ((chid << 24) | \
> -					(MHI_CMD_START_CHAN << 16))
> -
> -#define MHI_TRE_GET_CMD_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
> -#define MHI_TRE_GET_CMD_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
> -
> -/* Event descriptor macros */
> -#define MHI_TRE_EV_PTR(ptr) (ptr)
> -#define MHI_TRE_EV_DWORD0(code, len) ((code << 24) | len)
> -#define MHI_TRE_EV_DWORD1(chid, type) ((chid << 24) | (type << 16))
> -#define MHI_TRE_GET_EV_PTR(tre) ((tre)->ptr)
> -#define MHI_TRE_GET_EV_CODE(tre) (((tre)->dword[0] >> 24) & 0xFF)
> -#define MHI_TRE_GET_EV_LEN(tre) ((tre)->dword[0] & 0xFFFF)
> -#define MHI_TRE_GET_EV_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
> -#define MHI_TRE_GET_EV_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
> -#define MHI_TRE_GET_EV_STATE(tre) (((tre)->dword[0] >> 24) & 0xFF)
> -#define MHI_TRE_GET_EV_EXECENV(tre) (((tre)->dword[0] >> 24) & 0xFF)
> -#define MHI_TRE_GET_EV_SEQ(tre) ((tre)->dword[0])
> -#define MHI_TRE_GET_EV_TIME(tre) ((tre)->ptr)
> -#define MHI_TRE_GET_EV_COOKIE(tre) lower_32_bits((tre)->ptr)
> -#define MHI_TRE_GET_EV_VEID(tre) (((tre)->dword[0] >> 16) & 0xFF)
> -#define MHI_TRE_GET_EV_LINKSPEED(tre) (((tre)->dword[1] >> 24) & 0xFF)
> -#define MHI_TRE_GET_EV_LINKWIDTH(tre) ((tre)->dword[0] & 0xFF)
> -
> -/* Transfer descriptor macros */
> -#define MHI_TRE_DATA_PTR(ptr) (ptr)
> -#define MHI_TRE_DATA_DWORD0(len) (len & MHI_MAX_MTU)
> -#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) ((2 << 16) | (bei << 10) \
> -	| (ieot << 9) | (ieob << 8) | chain)
> -
> -/* RSC transfer descriptor macros */
> -#define MHI_RSCTRE_DATA_PTR(ptr, len) (((u64)len << 48) | ptr)
> -#define MHI_RSCTRE_DATA_DWORD0(cookie) (cookie)
> -#define MHI_RSCTRE_DATA_DWORD1 (MHI_PKT_TYPE_COALESCING << 16)
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
> @@ -409,11 +262,6 @@ extern const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX];
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
> 

