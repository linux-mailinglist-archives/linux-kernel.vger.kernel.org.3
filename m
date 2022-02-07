Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDA44ABE5B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 13:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbiBGMDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 07:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390513AbiBGLy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:54:56 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 03:51:47 PST
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35DDC0401F6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644234706; x=1675770706;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7XH9M6f5ZnFBTYhxWbCvgbU/xLWF0OuSXnADITZeF9E=;
  b=nTDpDxfqNYFr4GKwxMg+DEbpRNhMGm6y0TYhvMbNrkBgM0JrbXgwmzT0
   08yGvKtaccz9DOJM9j1OzafGcvD705Nd+K3VLIRaPXb/dpMkdDKna8aAX
   Gxg+mB4vLhIeC9cYYZnpbwYuVdnnZjtpiCrn94J5uWiqH9jd9dYf/KEWi
   ha9ZfxocXdMZ3hNxiWTUU3V91d98tlReG/X+YtYRON7MgvebyPvrsQJtO
   V8Al0qUnYuXA+X3n/iSIfNDx0YhhLEAwf48tQAF6aWDrmsw91Mn89tuw1
   LTOB2xGhVuEuG/ubpU+cppWuwTvFEbhFI6iVIEJIk5yLffsW4mqLWSXoG
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635177600"; 
   d="scan'208";a="197138936"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 19:50:43 +0800
IronPort-SDR: 1JKAGbDzinsfJDjEgN3iGVTOLFiuBOqsaOysoeBLuqFqgXX2+6U569d/2/UpHKWsZygJr+9L+5
 k/lh0CuJsFeTBlRAn01BAUVtnRlmdMz5dN/imI8be7XVxtHhNT0uxipmnT43A0qFHGEtrXn10M
 jG5hq6E/gBdyOeb87UO8KJRqu4MlH7SBjGMF7LNdx8i5NUkMdQg93hfZauZLJsrCqD6YQg11wt
 eZ9pD97fqzkkGDHFauQX7SQ0VMUrAVCxbk8i9Llk2YGBGXqyfKsfqx1nPvAqwNUOHgirrXyz5r
 i6SQ43Jaz347C7WHa8gYyw4F
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 03:22:34 -0800
IronPort-SDR: uhxPhUOgLcsL4kG7wpFX8JMiuPgXWtSKbYrrZnM1uwVxBh1x+0TSKXRHa+mwSRHV/1nXH+2K4V
 shrM+t1NgLOD0aOzTqAA1fvLCuBvYpQWy9/CbOgW3bBP7lkZKCsyH0VU6FmHooP+OupuGcR5MK
 79UbvIStBb1o3RbJCMQGpiTKU+WFc5PmP9wE2HFiD5u0FwpuJUDyZJBTZaUnvA7tksGYkDv9Ng
 xH+8YCaiSktSy48nu5XSRqPZYAzcT8GDSVnKFMrib+Ml8GC+h4FFx1rpscRuhgIqKDB+B2R567
 DlI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 03:50:44 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jskwz27Wzz1SVp3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:50:43 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644234642; x=1646826643; bh=7XH9M6f5ZnFBTYhxWbCvgbU/xLWF0OuSXnA
        DITZeF9E=; b=l6BQjxG19+/j/7b4G14X6H3nHREHpoz1IYZQx7VwGkiKpFP9vWM
        GR06Ii2l+xBgreRiENXNp9nFwuROrvqBNRB8XTPo2+xFgQsffJd7nQv32cM37p7f
        B48klFdlyDlCrLUrWhfOWY5vkQiKQRL7mbtvVRWavCzfvkYnCAhe/JboWTt57AZA
        Ndwkcw35fqLyNKGYj74dn5dojN2pq3gdVi+08YLUADAqzBa6vzpu3LD+Ny65/n1f
        4laTmwDEhTnKrs+tYUw05O6lOAwh7ov3mubQ2Xvh93PgiLdQneECop1nMl95ukna
        5iX7ZREDpgqyuRlLH7N4KiD+enIKFpQntjw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1DAV_pHUOqLl for <linux-kernel@vger.kernel.org>;
        Mon,  7 Feb 2022 03:50:42 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jskwx2xLKz1Rwrw;
        Mon,  7 Feb 2022 03:50:41 -0800 (PST)
Message-ID: <8ffd81ed-2ddf-92ce-6f16-2515cfee0aa9@opensource.wdc.com>
Date:   Mon, 7 Feb 2022 20:50:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next v2] scsi: pm8001: clean up some inconsistent
 indenting
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, jejb@linux.ibm.com
Cc:     jinpu.wang@cloud.ionos.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220207081522.12111-1-yang.lee@linux.alibaba.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220207081522.12111-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 17:15, Yang Li wrote:
> Eliminate the follow smatch warning:
> drivers/scsi/pm8001/pm8001_ctl.c:760 pm8001_update_flash() warn:
> inconsistent indenting
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
> 
>   Changes in v2:
> --According to Damien's suggestion
>   1) Start multi-line comments with a line that has only "/*".
>   2) Align the conditions together to make this code more readable.
>   3) Using a local variable for value which is calculated too many times.
> 
>  drivers/scsi/pm8001/pm8001_ctl.c | 61 ++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
> index 41a63c9b719b..0d9533ba8d27 100644
> --- a/drivers/scsi/pm8001/pm8001_ctl.c
> +++ b/drivers/scsi/pm8001/pm8001_ctl.c
> @@ -727,6 +727,8 @@ static int pm8001_update_flash(struct pm8001_hba_info *pm8001_ha)
>  	u32		sizeRead = 0;
>  	u32		ret = 0;
>  	u32		length = 1024 * 16 + sizeof(*payload) - 1;
> +	u32		fc_len = 0;

I think that the "= 0" is not needed.

> +	u8		*read_buf;
>  
>  	if (pm8001_ha->fw_image->size < 28) {
>  		pm8001_ha->fw_status = FAIL_FILE_SIZE;
> @@ -755,36 +757,35 @@ static int pm8001_update_flash(struct pm8001_hba_info *pm8001_ha)
>  			fwControl->retcode = 0;/* OUT */
>  			fwControl->offset = loopNumber * IOCTL_BUF_SIZE;/*OUT */
>  
> -		/* for the last chunk of data in case file size is not even with
> -		4k, load only the rest*/
> -		if (((loopcount-loopNumber) == 1) &&
> -			((partitionSize + HEADER_LEN) % IOCTL_BUF_SIZE)) {
> -			fwControl->len =
> -				(partitionSize + HEADER_LEN) % IOCTL_BUF_SIZE;
> -			memcpy((u8 *)fwControl->buffer,
> -				(u8 *)pm8001_ha->fw_image->data + sizeRead,
> -				(partitionSize + HEADER_LEN) % IOCTL_BUF_SIZE);
> -			sizeRead +=
> -				(partitionSize + HEADER_LEN) % IOCTL_BUF_SIZE;
> -		} else {
> -			memcpy((u8 *)fwControl->buffer,
> -				(u8 *)pm8001_ha->fw_image->data + sizeRead,
> -				IOCTL_BUF_SIZE);
> -			sizeRead += IOCTL_BUF_SIZE;
> -		}
> -
> -		pm8001_ha->nvmd_completion = &completion;
> -		ret = PM8001_CHIP_DISP->fw_flash_update_req(pm8001_ha, payload);
> -		if (ret) {
> -			pm8001_ha->fw_status = FAIL_OUT_MEMORY;
> -			goto out;
> -		}
> -		wait_for_completion(&completion);
> -		if (fwControl->retcode > FLASH_UPDATE_IN_PROGRESS) {
> -			pm8001_ha->fw_status = fwControl->retcode;
> -			ret = -EFAULT;
> -			goto out;
> -		}
> +			/*
> +			 * for the last chunk of data in case file size is
> +			 * not even with 4k, load only the rest
> +			 */
> +
> +			fc_len = (partitionSize + HEADER_LEN) % IOCTL_BUF_SIZE;

I would move this line down, right above the "if" where the variable is
used.

> +			read_buf  = (u8 *)pm8001_ha->fw_image->data + sizeRead;
> +
> +			if (((loopcount-loopNumber) == 1) && fc_len) {

While at it, please add spaces around the "-" and remove the unnecessary
parenthesis:

	if (loopcount - loopNumber == 1 && fc_len) {

> +				fwControl->len = fc_len;
> +				memcpy((u8 *)fwControl->buffer, read_buf, fc_len);
> +				sizeRead += fc_len;
> +			} else {
> +				memcpy((u8 *)fwControl->buffer, read_buf, IOCTL_BUF_SIZE);
> +				sizeRead += IOCTL_BUF_SIZE;
> +			}
> +
> +			pm8001_ha->nvmd_completion = &completion;
> +			ret = PM8001_CHIP_DISP->fw_flash_update_req(pm8001_ha, payload);
> +			if (ret) {
> +				pm8001_ha->fw_status = FAIL_OUT_MEMORY;
> +				goto out;
> +			}
> +			wait_for_completion(&completion);
> +			if (fwControl->retcode > FLASH_UPDATE_IN_PROGRESS) {
> +				pm8001_ha->fw_status = fwControl->retcode;
> +				ret = -EFAULT;
> +				goto out;
> +			}
>  		}
>  	}
>  out:

With that fixed, looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
