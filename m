Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F195461402
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242074AbhK2LpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:45:22 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47162 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242052AbhK2LnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638186001; x=1669722001;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JYH9kkRhUNRml+qYr7T1i+UPuDM6cyqwozhm5/SJTm0=;
  b=YZu2cNPfBSvhSsVG6tsGD7/ntlWZorUeUcByQOGkw3/RyotS22IhjsaK
   mkvxaglsIq9QkxV9+jRjrLVJGZLMyw3zKmGBbrRMyQaVC3n0o0tt6bqjq
   UfTNVlwv3ITditprM85C9oCgeOG4a8lzUg0001eNzkTEaIkj7IoM7iit5
   +PIE4i02kXmzHWZVZnTDym+eVDj9l5A3loTmjpm1DaVdqSHzrUsGPmGkY
   kRoSEgqNwzk8WvI+WV7fS36D/8EnF84V71Yc+mZJdTuTMgCLPzpUzom8J
   lbpohajJ77XqQ5hy+VhFwD7lTJvI9fwBH5TYXl/hglJ8C1ut6sUM5r1/+
   g==;
X-IronPort-AV: E=Sophos;i="5.87,273,1631548800"; 
   d="scan'208";a="185939028"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2021 19:38:01 +0800
IronPort-SDR: tjShVrvMsZ382mFm33RStXvLoLy35zFwji1Lxmz0UhSc3lwNJ+5OxqgiH6MJFEpmKT2D93CqP3
 rZhCHGkfjBx9hS8vk76auhFNpZo94FbVHSuooYli31F6nyY/gJx0vRVU936kCsfQZ4k6BU3Nuc
 3uSfKUjs3ZorFEN0P1RijEePnK/AqDbZVX4gCT7gNT77w5tkJ4HIURUQAAPwmh3q+4otOuq7dL
 gkjcFm3KFBsodPNPss6qqxm5jPY2r8AcHMqSkKGBX06+bDcAF3KpHMMQ1d35R8Fyg7Jn+TAXIx
 NhPQ4/c45iWRj/co9SW1RNoQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:11:15 -0800
IronPort-SDR: 5qSwq2ovKhRYnGrcTgQ8LvDljKIubUWB0pRd9DUBW/MOKpcDnH9cTvmSkVd5lSUAw2Oympq2KX
 4ZSOH6mCnKHAfZyhS96yCz48K8lPDdjX4tpt0IS5xlVn60n9faka6rHjM00WmVD9tCU2sRZ/kO
 fLfJkl93jzzmvPaDeuWTbM1R7ZQSbKw3erWmHFxJ2T2ujZ0i49g4yU/kDYfrZpSGcBnzbV3mi5
 SsawbVQv14OD9pjBBskBpTtvTlsFUbNwyANNRLEJUZek/GbwDfT5Jxlp7ElErNdlzIlCaWGqff
 W5o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:38:01 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J2jyc5h8xz1RtVv
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 03:38:00 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1638185880; x=1640777881; bh=JYH9kkRhUNRml+qYr7T1i+UPuDM6cyqwozh
        m5/SJTm0=; b=I4ZhqKpxq/GDokFdwO9J9ULr/RXB2zmkiPEmeA8SIOOsvUPi3m7
        WcTRx4t9kr69NpXARVpkD3tOkTT2xlp8+5p9Y/e0VC29MPt9k6qMxVad+0K6he9k
        YEyMquhBsjvmR0M59aZQijU2q8IqJ2TTZjuadF0omOKfJ/hiMxpeQPkEJyfJq5cl
        lMc6+KposuM9pJDnQI/UYKdiQ+oS9VHFPoaCKtdDDjO5DfoFo3sk2TfUe4UHY5Ps
        mKSB/W+dOLAKAGUNg4i8YoGqaL1gV/R5cRr6iqrm8RWoFCTQji3Ksn+0+EgSUGcN
        oG/dZLS84gE7tiMQad19dpK2tnRCDI9i5jQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gvx3p70h37KY for <linux-kernel@vger.kernel.org>;
        Mon, 29 Nov 2021 03:38:00 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J2jyb3jrBz1RtVl;
        Mon, 29 Nov 2021 03:37:59 -0800 (PST)
Message-ID: <23527f89-d098-ab6b-f3c9-a8a395e32df5@opensource.wdc.com>
Date:   Mon, 29 Nov 2021 20:37:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] sata_fsl: Use struct_group() for memcpy() region
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20211118183807.1283332-1-keescook@chromium.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211118183807.1283332-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/19 3:38, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally writing across neighboring fields.
> 
> Use struct_group() in struct command_desc around members acmd and fill,
> so they can be referenced together. This will allow memset(), memcpy(),
> and sizeof() to more easily reason about sizes, improve readability,
> and avoid future warnings about writing beyond the end of acmd:
> 
> In function 'fortify_memset_chk',
>     inlined from 'sata_fsl_qc_prep' at drivers/ata/sata_fsl.c:534:3:
> ./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
>   199 |    __write_overflow_field();
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/ata/sata_fsl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index e5838b23c9e0..fec3c9032606 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -246,8 +246,10 @@ enum {
>  struct command_desc {
>  	u8 cfis[8 * 4];
>  	u8 sfis[8 * 4];
> -	u8 acmd[4 * 4];
> -	u8 fill[4 * 4];
> +	struct_group(cdb,
> +		u8 acmd[4 * 4];
> +		u8 fill[4 * 4];
> +	);
>  	u32 prdt[SATA_FSL_MAX_PRD_DIRECT * 4];
>  	u32 prdt_indirect[(SATA_FSL_MAX_PRD - SATA_FSL_MAX_PRD_DIRECT) * 4];
>  };
> @@ -531,8 +533,8 @@ static enum ata_completion_errors sata_fsl_qc_prep(struct ata_queued_cmd *qc)
>  	/* setup "ACMD - atapi command" in cmd. desc. if this is ATAPI cmd */
>  	if (ata_is_atapi(qc->tf.protocol)) {
>  		desc_info |= ATAPI_CMD;
> -		memset((void *)&cd->acmd, 0, 32);
> -		memcpy((void *)&cd->acmd, qc->cdb, qc->dev->cdb_len);
> +		memset(&cd->cdb, 0, sizeof(cd->cdb));
> +		memcpy(&cd->cdb, qc->cdb, qc->dev->cdb_len);
>  	}
>  
>  	if (qc->flags & ATA_QCFLAG_DMAMAP)
> 

Applied to for-5.17. Thanks.


-- 
Damien Le Moal
Western Digital Research
