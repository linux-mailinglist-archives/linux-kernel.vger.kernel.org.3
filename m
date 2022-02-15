Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24604B76B9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243921AbiBOUCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:02:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243906AbiBOUCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:02:42 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D83870876
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:02:31 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id q8so2379502iod.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ynHzX0PliJxJts1ieHPqLKfB4A1ILgzjFVQfeeSjmi4=;
        b=OKxBtdOoorZFgxKMuDpOaI/LJrEIUD8HJDWrRgx9ETmZTrKew75r7P96xF0PhkVClD
         0eQLgUbjxSVaVY6tfaeCJ6c926hTbfg7TJcAe9DkHY29bh8bFMg/upMZOyFUTjr29YE4
         PgrfOUDzOGaaM+v5jJS9flbPqHmrIGDkk9pzlJAR9RbPLaZja76/2Al9uWIj65PB7PfM
         r64aG/fzPel7BwrGaD8ijd9snp0qwe+CN+YJXOXPdt66SN52oVP0el+LUZvLtCX6O1ws
         ZUVEZEMy4xZmo0AfhwAROTtOu7fCRGKIq5mUwTbStR7nUWQUpK4yTuvXPLQEDIHadFax
         S8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ynHzX0PliJxJts1ieHPqLKfB4A1ILgzjFVQfeeSjmi4=;
        b=lQjJqtWQ+MQpfAVJS2w6gnVwY0ssz5wjPIiNghyJsIr4T3iT/Uj22IX7RhP0KoDcLo
         eg3poLpgT5THz76tvMbgPBw0NEnT54dccM8ybBouCt0GIiDOgNwEGaBLqyGCZQ9QXS89
         Ip5L41L1Nn5fyhJchVV6aNMylGcgdszt78OX/4L39qxCZsIXTPd6LDSvRhZgj4p2q3HF
         Wmr9cGJz6Zd+JgVgxwk3Kp5y+HsAa7HwtLV7VXXRHR4d5+4kBVdeuXOk53JNblZfABFr
         lkKHdxamoZmiBZ9krjgqHQmENrooUrBNGmOtpSZwlsMG35/ZPo9SDkV0/GmTyur53Set
         fZ6A==
X-Gm-Message-State: AOAM533kaSeKyo8xC/kKajfD03QCa8U/xoqlNYcjeun1Dsls9ZXYaxd1
        bTtJHaGEaEcy6IjHI1f8fwPVrw==
X-Google-Smtp-Source: ABdhPJxYFmnY6O/oqGC4HATgXr5KFf2i9LoQU/EDG2RgGioP/wlMnI5FSJG4ZwEkudd8/hTC+erV1Q==
X-Received: by 2002:a6b:b7cf:: with SMTP id h198mr325617iof.166.1644955350203;
        Tue, 15 Feb 2022 12:02:30 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id w4sm13241514ilv.13.2022.02.15.12.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 12:02:29 -0800 (PST)
Message-ID: <058a6e9f-8feb-8e66-dcc3-ffbea6ca4a4d@linaro.org>
Date:   Tue, 15 Feb 2022 14:02:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 06/25] bus: mhi: Cleanup the register definitions used
 in headers
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
 <20220212182117.49438-7-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-7-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/22 12:20 PM, Manivannan Sadhasivam wrote:
> Cleanup includes:
> 
> 1. Moving the MHI register definitions to common.h header with REG_ prefix
>     and using them in the host/internal.h file as an alias. This makes it
>     possible to reuse the register definitions in EP stack that differs by
>     a fixed offset.

I like that you're doing this.  But I don't see the point of this
kind of definition, made in "drivers/bus/mhi/host/internal.h
":

   #define MHIREGLEN	REG_MHIREGLEN

Just use REG_MHIREGLEN in the host code too.  (Or use MHIREGLEN in
both places, whichever you prefer.)


> 2. Using the GENMASK macro for masks

Great!

> 3. Removing brackets for single values

They're normally called "parentheses."  Brackets more typically []
(and {} is "braces", though that's not always the case).

> 4. Using lowercase for hex values

I think I saw a few upper case hex values in another patch.
Not a big deal, just FYI.

> 5. Using two digits for hex values where applicable

I think I suggested most of these things, so of course
they look awesome to me.

You could use bitfield accessor macros in a few more places.
For example, this:

#define MHI_TRE_CMD_RESET_DWORD1(chid)  (cpu_to_le32((chid << 24) | \
					    (MHI_CMD_RESET_CHAN << 16)))

Could use something more like this:

#define MHI_CMD_CHANNEL_MASK	GENMASK(31, 24)
#define MHI_CMD_COMMAND_MASK	GENMASK(23, 16)

#define MHI_TRE_CMD_RESET_DWORD1(chid) \
	(le32_encode_bits(chid, MHI_CMD_CHANNEL_MASK) | \	
	 le32_encode_bits(MHI_CMD_RESET_CHAN, MHI_CMD_CMD_MASK))

(But of course I already said I preferred CPU byte order on
these values...)

I would like to see you get rid of one-to-one definitions
I mentioned at the top.  I haven't done an exhaustive check
of all the symbols, but this looks good generally, so:

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/bus/mhi/common.h        | 243 ++++++++++++++++++++++++-----
>   drivers/bus/mhi/host/internal.h | 265 +++++++++-----------------------
>   2 files changed, 278 insertions(+), 230 deletions(-)
> 
> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
> index 288e47168649..f226f06d4ff9 100644
> --- a/drivers/bus/mhi/common.h
> +++ b/drivers/bus/mhi/common.h
> @@ -9,62 +9,223 @@
>   
>   #include <linux/mhi.h>
>   
> +/* MHI registers */
> +#define REG_MHIREGLEN					0x00
> +#define REG_MHIVER					0x08
> +#define REG_MHICFG					0x10
> +#define REG_CHDBOFF					0x18
> +#define REG_ERDBOFF					0x20
> +#define REG_BHIOFF					0x28
> +#define REG_BHIEOFF					0x2c
> +#define REG_DEBUGOFF					0x30
> +#define REG_MHICTRL					0x38
> +#define REG_MHISTATUS					0x48
> +#define REG_CCABAP_LOWER				0x58
> +#define REG_CCABAP_HIGHER				0x5c
> +#define REG_ECABAP_LOWER				0x60
> +#define REG_ECABAP_HIGHER				0x64
> +#define REG_CRCBAP_LOWER				0x68
> +#define REG_CRCBAP_HIGHER				0x6c
> +#define REG_CRDB_LOWER					0x70
> +#define REG_CRDB_HIGHER					0x74
> +#define REG_MHICTRLBASE_LOWER				0x80
> +#define REG_MHICTRLBASE_HIGHER				0x84
> +#define REG_MHICTRLLIMIT_LOWER				0x88
> +#define REG_MHICTRLLIMIT_HIGHER				0x8c
> +#define REG_MHIDATABASE_LOWER				0x98
> +#define REG_MHIDATABASE_HIGHER				0x9c
> +#define REG_MHIDATALIMIT_LOWER				0xa0
> +#define REG_MHIDATALIMIT_HIGHER				0xa4
> +
> +/* MHI BHI registers */
> +#define REG_BHI_BHIVERSION_MINOR			0x00
> +#define REG_BHI_BHIVERSION_MAJOR			0x04
> +#define REG_BHI_IMGADDR_LOW				0x08
> +#define REG_BHI_IMGADDR_HIGH				0x0c
> +#define REG_BHI_IMGSIZE					0x10
> +#define REG_BHI_RSVD1					0x14
> +#define REG_BHI_IMGTXDB					0x18
> +#define REG_BHI_RSVD2					0x1c
> +#define REG_BHI_INTVEC					0x20
> +#define REG_BHI_RSVD3					0x24
> +#define REG_BHI_EXECENV					0x28
> +#define REG_BHI_STATUS					0x2c
> +#define REG_BHI_ERRCODE					0x30
> +#define REG_BHI_ERRDBG1					0x34
> +#define REG_BHI_ERRDBG2					0x38
> +#define REG_BHI_ERRDBG3					0x3c
> +#define REG_BHI_SERIALNU				0x40
> +#define REG_BHI_SBLANTIROLLVER				0x44
> +#define REG_BHI_NUMSEG					0x48
> +#define REG_BHI_MSMHWID(n)				(0x4c + (0x4 * (n)))
> +#define REG_BHI_OEMPKHASH(n)				(0x64 + (0x4 * (n)))
> +#define REG_BHI_RSVD5					0xc4
> +
> +/* BHI register bits */
> +#define BHI_TXDB_SEQNUM_BMSK				GENMASK(29, 0)
> +#define BHI_TXDB_SEQNUM_SHFT				0
> +#define BHI_STATUS_MASK					GENMASK(31, 30)
> +#define BHI_STATUS_SHIFT				30
> +#define BHI_STATUS_ERROR				0x03
> +#define BHI_STATUS_SUCCESS				0x02
> +#define BHI_STATUS_RESET				0x00
> +
> +/* MHI BHIE registers */
> +#define REG_BHIE_MSMSOCID_OFFS				0x00
> +#define REG_BHIE_TXVECADDR_LOW_OFFS			0x2c
> +#define REG_BHIE_TXVECADDR_HIGH_OFFS			0x30
> +#define REG_BHIE_TXVECSIZE_OFFS				0x34
> +#define REG_BHIE_TXVECDB_OFFS				0x3c
> +#define REG_BHIE_TXVECSTATUS_OFFS			0x44
> +#define REG_BHIE_RXVECADDR_LOW_OFFS			0x60
> +#define REG_BHIE_RXVECADDR_HIGH_OFFS			0x64
> +#define REG_BHIE_RXVECSIZE_OFFS				0x68
> +#define REG_BHIE_RXVECDB_OFFS				0x70
> +#define REG_BHIE_RXVECSTATUS_OFFS			0x78
> +
> +/* BHIE register bits */
> +#define BHIE_TXVECDB_SEQNUM_BMSK			GENMASK(29, 0)
> +#define BHIE_TXVECDB_SEQNUM_SHFT			0
> +#define BHIE_TXVECSTATUS_SEQNUM_BMSK			GENMASK(29, 0)
> +#define BHIE_TXVECSTATUS_SEQNUM_SHFT			0
> +#define BHIE_TXVECSTATUS_STATUS_BMSK			GENMASK(31, 30)
> +#define BHIE_TXVECSTATUS_STATUS_SHFT			30
> +#define BHIE_TXVECSTATUS_STATUS_RESET			0x00
> +#define BHIE_TXVECSTATUS_STATUS_XFER_COMPL		0x02
> +#define BHIE_TXVECSTATUS_STATUS_ERROR			0x03
> +#define BHIE_RXVECDB_SEQNUM_BMSK			GENMASK(29, 0)
> +#define BHIE_RXVECDB_SEQNUM_SHFT			0
> +#define BHIE_RXVECSTATUS_SEQNUM_BMSK			GENMASK(29, 0)
> +#define BHIE_RXVECSTATUS_SEQNUM_SHFT			0
> +#define BHIE_RXVECSTATUS_STATUS_BMSK			GENMASK(31, 30)
> +#define BHIE_RXVECSTATUS_STATUS_SHFT			30
> +#define BHIE_RXVECSTATUS_STATUS_RESET			0x00
> +#define BHIE_RXVECSTATUS_STATUS_XFER_COMPL		0x02
> +#define BHIE_RXVECSTATUS_STATUS_ERROR			0x03
> +
> +/* MHI register bits */
> +#define MHIREGLEN_MHIREGLEN_MASK			GENMASK(31, 0)
> +#define MHIREGLEN_MHIREGLEN_SHIFT			0
> +#define MHIVER_MHIVER_MASK				GENMASK(31, 0)
> +#define MHIVER_MHIVER_SHIFT				0
> +#define MHICFG_NHWER_MASK				GENMASK(31, 24)
> +#define MHICFG_NHWER_SHIFT				24
> +#define MHICFG_NER_MASK					GENMASK(23, 16)
> +#define MHICFG_NER_SHIFT				16
> +#define MHICFG_NHWCH_MASK				GENMASK(15, 8)
> +#define MHICFG_NHWCH_SHIFT				8
> +#define MHICFG_NCH_MASK					GENMASK(7, 0)
> +#define MHICFG_NCH_SHIFT				0
> +#define CHDBOFF_CHDBOFF_MASK				GENMASK(31, 0)
> +#define CHDBOFF_CHDBOFF_SHIFT				0
> +#define ERDBOFF_ERDBOFF_MASK				GENMASK(31, 0)
> +#define ERDBOFF_ERDBOFF_SHIFT				0
> +#define BHIOFF_BHIOFF_MASK				GENMASK(31, 0)
> +#define BHIOFF_BHIOFF_SHIFT				0
> +#define BHIEOFF_BHIEOFF_MASK				GENMASK(31, 0)
> +#define BHIEOFF_BHIEOFF_SHIFT				0
> +#define DEBUGOFF_DEBUGOFF_MASK				GENMASK(31, 0)
> +#define DEBUGOFF_DEBUGOFF_SHIFT				0
> +#define MHICTRL_MHISTATE_MASK				GENMASK(15, 8)
> +#define MHICTRL_MHISTATE_SHIFT				8
> +#define MHICTRL_RESET_MASK				BIT(1)
> +#define MHICTRL_RESET_SHIFT				1
> +#define MHISTATUS_MHISTATE_MASK				GENMASK(15, 8)
> +#define MHISTATUS_MHISTATE_SHIFT			8
> +#define MHISTATUS_SYSERR_MASK				BIT(2)
> +#define MHISTATUS_SYSERR_SHIFT				2
> +#define MHISTATUS_READY_MASK				BIT(0)
> +#define MHISTATUS_READY_SHIFT				0
> +#define CCABAP_LOWER_CCABAP_LOWER_MASK			GENMASK(31, 0)
> +#define CCABAP_LOWER_CCABAP_LOWER_SHIFT			0
> +#define CCABAP_HIGHER_CCABAP_HIGHER_MASK		GENMASK(31, 0)
> +#define CCABAP_HIGHER_CCABAP_HIGHER_SHIFT		0
> +#define ECABAP_LOWER_ECABAP_LOWER_MASK			GENMASK(31, 0)
> +#define ECABAP_LOWER_ECABAP_LOWER_SHIFT			0
> +#define ECABAP_HIGHER_ECABAP_HIGHER_MASK		GENMASK(31, 0)
> +#define ECABAP_HIGHER_ECABAP_HIGHER_SHIFT		0
> +#define CRCBAP_LOWER_CRCBAP_LOWER_MASK			GENMASK(31, 0)
> +#define CRCBAP_LOWER_CRCBAP_LOWER_SHIFT			0
> +#define CRCBAP_HIGHER_CRCBAP_HIGHER_MASK		GENMASK(31, 0)
> +#define CRCBAP_HIGHER_CRCBAP_HIGHER_SHIFT		0
> +#define CRDB_LOWER_CRDB_LOWER_MASK			GENMASK(31, 0)
> +#define CRDB_LOWER_CRDB_LOWER_SHIFT			0
> +#define CRDB_HIGHER_CRDB_HIGHER_MASK			GENMASK(31, 0)
> +#define CRDB_HIGHER_CRDB_HIGHER_SHIFT			0
> +#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_MASK	GENMASK(31, 0)
> +#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_SHIFT	0
> +#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_MASK	GENMASK(31, 0)
> +#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_SHIFT	0
> +#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_MASK	GENMASK(31, 0)
> +#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_SHIFT	0
> +#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_MASK	GENMASK(31, 0)
> +#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_SHIFT	0
> +#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_MASK	GENMASK(31, 0)
> +#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_SHIFT	0
> +#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_MASK	GENMASK(31, 0)
> +#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_SHIFT	0
> +#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_MASK	GENMASK(31, 0)
> +#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_SHIFT	0
> +#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_MASK	GENMASK(31, 0)
> +#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_SHIFT	0
> +
>   /* Command Ring Element macros */
>   /* No operation command */
> -#define MHI_TRE_CMD_NOOP_PTR (0)
> -#define MHI_TRE_CMD_NOOP_DWORD0 (0)
> -#define MHI_TRE_CMD_NOOP_DWORD1 (cpu_to_le32(MHI_CMD_NOP << 16))
> +#define MHI_TRE_CMD_NOOP_PTR				0
> +#define MHI_TRE_CMD_NOOP_DWORD0				0
> +#define MHI_TRE_CMD_NOOP_DWORD1				cpu_to_le32(MHI_CMD_NOP << 16)
>   
>   /* Channel reset command */
> -#define MHI_TRE_CMD_RESET_PTR (0)
> -#define MHI_TRE_CMD_RESET_DWORD0 (0)
> -#define MHI_TRE_CMD_RESET_DWORD1(chid) (cpu_to_le32((chid << 24) | \
> -					(MHI_CMD_RESET_CHAN << 16)))
> +#define MHI_TRE_CMD_RESET_PTR				0
> +#define MHI_TRE_CMD_RESET_DWORD0			0
> +#define MHI_TRE_CMD_RESET_DWORD1(chid)			(cpu_to_le32((chid << 24) | \
> +							(MHI_CMD_RESET_CHAN << 16)))
>   
>   /* Channel stop command */
> -#define MHI_TRE_CMD_STOP_PTR (0)
> -#define MHI_TRE_CMD_STOP_DWORD0 (0)
> -#define MHI_TRE_CMD_STOP_DWORD1(chid) (cpu_to_le32((chid << 24) | \
> -				       (MHI_CMD_STOP_CHAN << 16)))
> +#define MHI_TRE_CMD_STOP_PTR				0
> +#define MHI_TRE_CMD_STOP_DWORD0				0
> +#define MHI_TRE_CMD_STOP_DWORD1(chid)			(cpu_to_le32((chid << 24) | \
> +							(MHI_CMD_STOP_CHAN << 16)))
>   
>   /* Channel start command */
> -#define MHI_TRE_CMD_START_PTR (0)
> -#define MHI_TRE_CMD_START_DWORD0 (0)
> -#define MHI_TRE_CMD_START_DWORD1(chid) (cpu_to_le32((chid << 24) | \
> -					(MHI_CMD_START_CHAN << 16)))
> +#define MHI_TRE_CMD_START_PTR				0
> +#define MHI_TRE_CMD_START_DWORD0			0
> +#define MHI_TRE_CMD_START_DWORD1(chid)			(cpu_to_le32((chid << 24) | \
> +							(MHI_CMD_START_CHAN << 16)))
>   
> -#define MHI_TRE_GET_DWORD(tre, word) (le32_to_cpu((tre)->dword[(word)]))
> -#define MHI_TRE_GET_CMD_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
> -#define MHI_TRE_GET_CMD_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
> +#define MHI_TRE_GET_DWORD(tre, word)			le32_to_cpu((tre)->dword[(word)])
> +#define MHI_TRE_GET_CMD_CHID(tre)			((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
> +#define MHI_TRE_GET_CMD_TYPE(tre)			((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
>   
>   /* Event descriptor macros */
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
> +/* Transfer completion event */
> +#define MHI_TRE_EV_PTR(ptr)				cpu_to_le64(ptr)
> +#define MHI_TRE_EV_DWORD0(code, len)			cpu_to_le32((code << 24) | len)
> +#define MHI_TRE_EV_DWORD1(chid, type)			cpu_to_le32((chid << 24) | (type << 16))
> +#define MHI_TRE_GET_EV_PTR(tre)				le64_to_cpu((tre)->ptr)
> +#define MHI_TRE_GET_EV_CODE(tre)			((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_LEN(tre)				(MHI_TRE_GET_DWORD(tre, 0) & 0xFFFF)
> +#define MHI_TRE_GET_EV_CHID(tre)			((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_TYPE(tre)			((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
> +#define MHI_TRE_GET_EV_STATE(tre)			((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_EXECENV(tre)			((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_SEQ(tre)				MHI_TRE_GET_DWORD(tre, 0)
> +#define MHI_TRE_GET_EV_TIME(tre)			MHI_TRE_GET_EV_PTR(tre)
> +#define MHI_TRE_GET_EV_COOKIE(tre)			lower_32_bits(MHI_TRE_GET_EV_PTR(tre))
> +#define MHI_TRE_GET_EV_VEID(tre)			((MHI_TRE_GET_DWORD(tre, 0) >> 16) & 0xFF)
> +#define MHI_TRE_GET_EV_LINKSPEED(tre)			((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_LINKWIDTH(tre)			(MHI_TRE_GET_DWORD(tre, 0) & 0xFF)
>   
>   /* Transfer descriptor macros */
> -#define MHI_TRE_DATA_PTR(ptr) (cpu_to_le64(ptr))
> -#define MHI_TRE_DATA_DWORD0(len) (cpu_to_le32(len & MHI_MAX_MTU))
> -#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) (cpu_to_le32((2 << 16) | (bei << 10) \
> -	| (ieot << 9) | (ieob << 8) | chain))
> +#define MHI_TRE_DATA_PTR(ptr)				cpu_to_le64(ptr)
> +#define MHI_TRE_DATA_DWORD0(len)			cpu_to_le32(len & MHI_MAX_MTU)
> +#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain)	(cpu_to_le32((2 << 16) | (bei << 10) \
> +							| (ieot << 9) | (ieob << 8) | chain))
>   
>   /* RSC transfer descriptor macros */
> -#define MHI_RSCTRE_DATA_PTR(ptr, len) (cpu_to_le64(((u64)len << 48) | ptr))
> -#define MHI_RSCTRE_DATA_DWORD0(cookie) (cpu_to_le32(cookie))
> -#define MHI_RSCTRE_DATA_DWORD1 (cpu_to_le32(MHI_PKT_TYPE_COALESCING << 16))
> +#define MHI_RSCTRE_DATA_PTR(ptr, len)			cpu_to_le64(((u64)len << 48) | ptr)
> +#define MHI_RSCTRE_DATA_DWORD0(cookie)			cpu_to_le32(cookie)
> +#define MHI_RSCTRE_DATA_DWORD1				cpu_to_le32(MHI_PKT_TYPE_COALESCING << 16)
>   
>   enum mhi_pkt_type {
>   	MHI_PKT_TYPE_INVALID = 0x0,
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index 622de6ba1a0b..762055a6ec9f 100644
> --- a/drivers/bus/mhi/host/internal.h
> +++ b/drivers/bus/mhi/host/internal.h
> @@ -11,197 +11,84 @@
>   
>   extern struct bus_type mhi_bus_type;
>   
> -#define MHIREGLEN (0x0)
> -#define MHIREGLEN_MHIREGLEN_MASK (0xFFFFFFFF)
> -#define MHIREGLEN_MHIREGLEN_SHIFT (0)
> -
> -#define MHIVER (0x8)
> -#define MHIVER_MHIVER_MASK (0xFFFFFFFF)
> -#define MHIVER_MHIVER_SHIFT (0)
> -
> -#define MHICFG (0x10)
> -#define MHICFG_NHWER_MASK (0xFF000000)
> -#define MHICFG_NHWER_SHIFT (24)
> -#define MHICFG_NER_MASK (0xFF0000)
> -#define MHICFG_NER_SHIFT (16)
> -#define MHICFG_NHWCH_MASK (0xFF00)
> -#define MHICFG_NHWCH_SHIFT (8)
> -#define MHICFG_NCH_MASK (0xFF)
> -#define MHICFG_NCH_SHIFT (0)
> -
> -#define CHDBOFF (0x18)
> -#define CHDBOFF_CHDBOFF_MASK (0xFFFFFFFF)
> -#define CHDBOFF_CHDBOFF_SHIFT (0)
> -
> -#define ERDBOFF (0x20)
> -#define ERDBOFF_ERDBOFF_MASK (0xFFFFFFFF)
> -#define ERDBOFF_ERDBOFF_SHIFT (0)
> -
> -#define BHIOFF (0x28)
> -#define BHIOFF_BHIOFF_MASK (0xFFFFFFFF)
> -#define BHIOFF_BHIOFF_SHIFT (0)
> -
> -#define BHIEOFF (0x2C)
> -#define BHIEOFF_BHIEOFF_MASK (0xFFFFFFFF)
> -#define BHIEOFF_BHIEOFF_SHIFT (0)
> -
> -#define DEBUGOFF (0x30)
> -#define DEBUGOFF_DEBUGOFF_MASK (0xFFFFFFFF)
> -#define DEBUGOFF_DEBUGOFF_SHIFT (0)
> -
> -#define MHICTRL (0x38)
> -#define MHICTRL_MHISTATE_MASK (0x0000FF00)
> -#define MHICTRL_MHISTATE_SHIFT (8)
> -#define MHICTRL_RESET_MASK (0x2)
> -#define MHICTRL_RESET_SHIFT (1)
> -
> -#define MHISTATUS (0x48)
> -#define MHISTATUS_MHISTATE_MASK (0x0000FF00)
> -#define MHISTATUS_MHISTATE_SHIFT (8)
> -#define MHISTATUS_SYSERR_MASK (0x4)
> -#define MHISTATUS_SYSERR_SHIFT (2)
> -#define MHISTATUS_READY_MASK (0x1)
> -#define MHISTATUS_READY_SHIFT (0)
> -
> -#define CCABAP_LOWER (0x58)
> -#define CCABAP_LOWER_CCABAP_LOWER_MASK (0xFFFFFFFF)
> -#define CCABAP_LOWER_CCABAP_LOWER_SHIFT (0)
> -
> -#define CCABAP_HIGHER (0x5C)
> -#define CCABAP_HIGHER_CCABAP_HIGHER_MASK (0xFFFFFFFF)
> -#define CCABAP_HIGHER_CCABAP_HIGHER_SHIFT (0)
> -
> -#define ECABAP_LOWER (0x60)
> -#define ECABAP_LOWER_ECABAP_LOWER_MASK (0xFFFFFFFF)
> -#define ECABAP_LOWER_ECABAP_LOWER_SHIFT (0)
> -
> -#define ECABAP_HIGHER (0x64)
> -#define ECABAP_HIGHER_ECABAP_HIGHER_MASK (0xFFFFFFFF)
> -#define ECABAP_HIGHER_ECABAP_HIGHER_SHIFT (0)
> -
> -#define CRCBAP_LOWER (0x68)
> -#define CRCBAP_LOWER_CRCBAP_LOWER_MASK (0xFFFFFFFF)
> -#define CRCBAP_LOWER_CRCBAP_LOWER_SHIFT (0)
> -
> -#define CRCBAP_HIGHER (0x6C)
> -#define CRCBAP_HIGHER_CRCBAP_HIGHER_MASK (0xFFFFFFFF)
> -#define CRCBAP_HIGHER_CRCBAP_HIGHER_SHIFT (0)
> -
> -#define CRDB_LOWER (0x70)
> -#define CRDB_LOWER_CRDB_LOWER_MASK (0xFFFFFFFF)
> -#define CRDB_LOWER_CRDB_LOWER_SHIFT (0)
> -
> -#define CRDB_HIGHER (0x74)
> -#define CRDB_HIGHER_CRDB_HIGHER_MASK (0xFFFFFFFF)
> -#define CRDB_HIGHER_CRDB_HIGHER_SHIFT (0)
> -
> -#define MHICTRLBASE_LOWER (0x80)
> -#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_MASK (0xFFFFFFFF)
> -#define MHICTRLBASE_LOWER_MHICTRLBASE_LOWER_SHIFT (0)
> -
> -#define MHICTRLBASE_HIGHER (0x84)
> -#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_MASK (0xFFFFFFFF)
> -#define MHICTRLBASE_HIGHER_MHICTRLBASE_HIGHER_SHIFT (0)
> -
> -#define MHICTRLLIMIT_LOWER (0x88)
> -#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_MASK (0xFFFFFFFF)
> -#define MHICTRLLIMIT_LOWER_MHICTRLLIMIT_LOWER_SHIFT (0)
> -
> -#define MHICTRLLIMIT_HIGHER (0x8C)
> -#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_MASK (0xFFFFFFFF)
> -#define MHICTRLLIMIT_HIGHER_MHICTRLLIMIT_HIGHER_SHIFT (0)
> -
> -#define MHIDATABASE_LOWER (0x98)
> -#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_MASK (0xFFFFFFFF)
> -#define MHIDATABASE_LOWER_MHIDATABASE_LOWER_SHIFT (0)
> -
> -#define MHIDATABASE_HIGHER (0x9C)
> -#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_MASK (0xFFFFFFFF)
> -#define MHIDATABASE_HIGHER_MHIDATABASE_HIGHER_SHIFT (0)
> -
> -#define MHIDATALIMIT_LOWER (0xA0)
> -#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_MASK (0xFFFFFFFF)
> -#define MHIDATALIMIT_LOWER_MHIDATALIMIT_LOWER_SHIFT (0)
> -
> -#define MHIDATALIMIT_HIGHER (0xA4)
> -#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_MASK (0xFFFFFFFF)
> -#define MHIDATALIMIT_HIGHER_MHIDATALIMIT_HIGHER_SHIFT (0)
> +/* MHI registers */
> +#define MHIREGLEN			REG_MHIREGLEN
> +#define MHIVER				REG_MHIVER
> +#define MHICFG				REG_MHICFG
> +#define CHDBOFF				REG_CHDBOFF
> +#define ERDBOFF				REG_ERDBOFF
> +#define BHIOFF				REG_BHIOFF
> +#define BHIEOFF				REG_BHIEOFF
> +#define DEBUGOFF			REG_DEBUGOFF
> +#define MHICTRL				REG_MHICTRL
> +#define MHISTATUS			REG_MHISTATUS
> +#define CCABAP_LOWER			REG_CCABAP_LOWER
> +#define CCABAP_HIGHER			REG_CCABAP_HIGHER
> +#define ECABAP_LOWER			REG_ECABAP_LOWER
> +#define ECABAP_HIGHER			REG_ECABAP_HIGHER
> +#define CRCBAP_LOWER			REG_CRCBAP_LOWER
> +#define CRCBAP_HIGHER			REG_CRCBAP_HIGHER
> +#define CRDB_LOWER			REG_CRDB_LOWER
> +#define CRDB_HIGHER			REG_CRDB_HIGHER
> +#define MHICTRLBASE_LOWER		REG_MHICTRLBASE_LOWER
> +#define MHICTRLBASE_HIGHER		REG_MHICTRLBASE_HIGHER
> +#define MHICTRLLIMIT_LOWER		REG_MHICTRLLIMIT_LOWER
> +#define MHICTRLLIMIT_HIGHER		REG_MHICTRLLIMIT_HIGHER
> +#define MHIDATABASE_LOWER		REG_MHIDATABASE_LOWER
> +#define MHIDATABASE_HIGHER		REG_MHIDATABASE_HIGHER
> +#define MHIDATALIMIT_LOWER		REG_MHIDATALIMIT_LOWER
> +#define MHIDATALIMIT_HIGHER		REG_MHIDATALIMIT_HIGHER
>   
>   /* Host request register */
> -#define MHI_SOC_RESET_REQ_OFFSET (0xB0)
> -#define MHI_SOC_RESET_REQ BIT(0)
> -
> -/* MHI BHI offfsets */
> -#define BHI_BHIVERSION_MINOR (0x00)
> -#define BHI_BHIVERSION_MAJOR (0x04)
> -#define BHI_IMGADDR_LOW (0x08)
> -#define BHI_IMGADDR_HIGH (0x0C)
> -#define BHI_IMGSIZE (0x10)
> -#define BHI_RSVD1 (0x14)
> -#define BHI_IMGTXDB (0x18)
> -#define BHI_TXDB_SEQNUM_BMSK (0x3FFFFFFF)
> -#define BHI_TXDB_SEQNUM_SHFT (0)
> -#define BHI_RSVD2 (0x1C)
> -#define BHI_INTVEC (0x20)
> -#define BHI_RSVD3 (0x24)
> -#define BHI_EXECENV (0x28)
> -#define BHI_STATUS (0x2C)
> -#define BHI_ERRCODE (0x30)
> -#define BHI_ERRDBG1 (0x34)
> -#define BHI_ERRDBG2 (0x38)
> -#define BHI_ERRDBG3 (0x3C)
> -#define BHI_SERIALNU (0x40)
> -#define BHI_SBLANTIROLLVER (0x44)
> -#define BHI_NUMSEG (0x48)
> -#define BHI_MSMHWID(n) (0x4C + (0x4 * (n)))
> -#define BHI_OEMPKHASH(n) (0x64 + (0x4 * (n)))
> -#define BHI_RSVD5 (0xC4)
> -#define BHI_STATUS_MASK (0xC0000000)
> -#define BHI_STATUS_SHIFT (30)
> -#define BHI_STATUS_ERROR (3)
> -#define BHI_STATUS_SUCCESS (2)
> -#define BHI_STATUS_RESET (0)
> -
> -/* MHI BHIE offsets */
> -#define BHIE_MSMSOCID_OFFS (0x0000)
> -#define BHIE_TXVECADDR_LOW_OFFS (0x002C)
> -#define BHIE_TXVECADDR_HIGH_OFFS (0x0030)
> -#define BHIE_TXVECSIZE_OFFS (0x0034)
> -#define BHIE_TXVECDB_OFFS (0x003C)
> -#define BHIE_TXVECDB_SEQNUM_BMSK (0x3FFFFFFF)
> -#define BHIE_TXVECDB_SEQNUM_SHFT (0)
> -#define BHIE_TXVECSTATUS_OFFS (0x0044)
> -#define BHIE_TXVECSTATUS_SEQNUM_BMSK (0x3FFFFFFF)
> -#define BHIE_TXVECSTATUS_SEQNUM_SHFT (0)
> -#define BHIE_TXVECSTATUS_STATUS_BMSK (0xC0000000)
> -#define BHIE_TXVECSTATUS_STATUS_SHFT (30)
> -#define BHIE_TXVECSTATUS_STATUS_RESET (0x00)
> -#define BHIE_TXVECSTATUS_STATUS_XFER_COMPL (0x02)
> -#define BHIE_TXVECSTATUS_STATUS_ERROR (0x03)
> -#define BHIE_RXVECADDR_LOW_OFFS (0x0060)
> -#define BHIE_RXVECADDR_HIGH_OFFS (0x0064)
> -#define BHIE_RXVECSIZE_OFFS (0x0068)
> -#define BHIE_RXVECDB_OFFS (0x0070)
> -#define BHIE_RXVECDB_SEQNUM_BMSK (0x3FFFFFFF)
> -#define BHIE_RXVECDB_SEQNUM_SHFT (0)
> -#define BHIE_RXVECSTATUS_OFFS (0x0078)
> -#define BHIE_RXVECSTATUS_SEQNUM_BMSK (0x3FFFFFFF)
> -#define BHIE_RXVECSTATUS_SEQNUM_SHFT (0)
> -#define BHIE_RXVECSTATUS_STATUS_BMSK (0xC0000000)
> -#define BHIE_RXVECSTATUS_STATUS_SHFT (30)
> -#define BHIE_RXVECSTATUS_STATUS_RESET (0x00)
> -#define BHIE_RXVECSTATUS_STATUS_XFER_COMPL (0x02)
> -#define BHIE_RXVECSTATUS_STATUS_ERROR (0x03)
> -
> -#define SOC_HW_VERSION_OFFS (0x224)
> -#define SOC_HW_VERSION_FAM_NUM_BMSK (0xF0000000)
> -#define SOC_HW_VERSION_FAM_NUM_SHFT (28)
> -#define SOC_HW_VERSION_DEV_NUM_BMSK (0x0FFF0000)
> -#define SOC_HW_VERSION_DEV_NUM_SHFT (16)
> -#define SOC_HW_VERSION_MAJOR_VER_BMSK (0x0000FF00)
> -#define SOC_HW_VERSION_MAJOR_VER_SHFT (8)
> -#define SOC_HW_VERSION_MINOR_VER_BMSK (0x000000FF)
> -#define SOC_HW_VERSION_MINOR_VER_SHFT (0)
> +#define MHI_SOC_RESET_REQ_OFFSET	0xb0
> +#define MHI_SOC_RESET_REQ		BIT(0)
> +
> +/* MHI BHI registers */
> +#define BHI_BHIVERSION_MINOR		REG_BHI_BHIVERSION_MINOR
> +#define BHI_BHIVERSION_MAJOR		REG_BHI_BHIVERSION_MAJOR
> +#define BHI_IMGADDR_LOW			REG_BHI_IMGADDR_LOW
> +#define BHI_IMGADDR_HIGH		REG_BHI_IMGADDR_HIGH
> +#define BHI_IMGSIZE			REG_BHI_IMGSIZE
> +#define BHI_RSVD1			REG_BHI_RSVD1
> +#define BHI_IMGTXDB			REG_BHI_IMGTXDB
> +#define BHI_RSVD2			REG_BHI_RSVD2
> +#define BHI_INTVEC			REG_BHI_INTVEC
> +#define BHI_RSVD3			REG_BHI_RSVD3
> +#define BHI_EXECENV			REG_BHI_EXECENV
> +#define BHI_STATUS			REG_BHI_STATUS
> +#define BHI_ERRCODE			REG_BHI_ERRCODE
> +#define BHI_ERRDBG1			REG_BHI_ERRDBG1
> +#define BHI_ERRDBG2			REG_BHI_ERRDBG2
> +#define BHI_ERRDBG3			REG_BHI_ERRDBG3
> +#define BHI_SERIALNU			REG_BHI_SERIALNU
> +#define BHI_SBLANTIROLLVER		REG_BHI_SBLANTIROLLVER
> +#define BHI_NUMSEG			REG_BHI_NUMSEG
> +#define BHI_MSMHWID(n)			REG_BHI_MSMHWID(n)
> +#define BHI_OEMPKHASH(n)		REG_BHI_OEMPKHASH(n)
> +#define BHI_RSVD5			REG_BHI_RSVD5
> +
> +/* MHI BHIE registers */
> +#define BHIE_MSMSOCID_OFFS		REG_BHIE_MSMSOCID_OFFS
> +#define BHIE_TXVECADDR_LOW_OFFS		REG_BHIE_TXVECADDR_LOW_OFFS
> +#define BHIE_TXVECADDR_HIGH_OFFS	REG_BHIE_TXVECADDR_HIGH_OFFS
> +#define BHIE_TXVECSIZE_OFFS		REG_BHIE_TXVECSIZE_OFFS
> +#define BHIE_TXVECDB_OFFS		REG_BHIE_TXVECDB_OFFS
> +#define BHIE_TXVECSTATUS_OFFS		REG_BHIE_TXVECSTATUS_OFFS
> +#define BHIE_RXVECADDR_LOW_OFFS		REG_BHIE_RXVECADDR_LOW_OFFS
> +#define BHIE_RXVECADDR_HIGH_OFFS	REG_BHIE_RXVECADDR_HIGH_OFFS
> +#define BHIE_RXVECSIZE_OFFS		REG_BHIE_RXVECSIZE_OFFS
> +#define BHIE_RXVECDB_OFFS		REG_BHIE_RXVECDB_OFFS
> +#define BHIE_RXVECSTATUS_OFFS		REG_BHIE_RXVECSTATUS_OFFS
> +
> +#define SOC_HW_VERSION_OFFS		0x224
> +#define SOC_HW_VERSION_FAM_NUM_BMSK	GENMASK(31, 28)
> +#define SOC_HW_VERSION_FAM_NUM_SHFT	28
> +#define SOC_HW_VERSION_DEV_NUM_BMSK	GENMASK(27, 16)
> +#define SOC_HW_VERSION_DEV_NUM_SHFT	16
> +#define SOC_HW_VERSION_MAJOR_VER_BMSK	GENMASK(15, 8)
> +#define SOC_HW_VERSION_MAJOR_VER_SHFT	8
> +#define SOC_HW_VERSION_MINOR_VER_BMSK	GENMASK(7, 0)
> +#define SOC_HW_VERSION_MINOR_VER_SHFT	0
>   
>   struct mhi_ctxt {
>   	struct mhi_event_ctxt *er_ctxt;

