Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AFE493684
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbiASIpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:45:39 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:55260 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiASIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642581937; x=1674117937;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IEZehArqSRfDu1om0RxzkqeXHEosIMsn3Mhn/j3uOEg=;
  b=fuU99awGdySAiroMfNkEgIF/Qb/Px2FQ/gn8L6yleG/zqhrlnCBk25Pf
   Shaok4iIJ0SVoilqX9CLDSb0NIeFjPnGLo+DKTQKsNzHPDhvN5sBMHdur
   DNVDxIY0y32N7XTcT7iYAXQClR1FwlKaK4fYsFAfJZnEZlvV16lWNd7Ml
   JufBAKA0Am4Y2huVDwN8NAY+nuwF/4CKfsPHX4YvvxG2+MvZ9WV8i88KF
   mek5qNZu6pXQe3uXJj3xjPwBIR/88KOcl4b1lXg4mYVvJF0YURD6Qzgs8
   ao53Sav03i/aOM4pUl+gkdNzVgU9ga3eGSXzsGQUhkOTUK8AjXoN2V1d2
   A==;
X-IronPort-AV: E=Sophos;i="5.88,299,1635177600"; 
   d="scan'208";a="302699561"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2022 16:45:36 +0800
IronPort-SDR: vl/1gF+1OAcZJ49NVYtOyWpG5cuDuVqlIIil01e9tNlMy0BsSS+LSYvv99SK/Gh5uX4b0dC2rI
 YNlyFodMdObR2F2ikxzygnt8QXzDSzIcIvbk1575XNMU/i3tjFpmZAwPoOf1bbCUX/088ebguy
 0h1dg0ZtUh9Zev6yhiAJkMBfipsJPxj3QucG0l1o6t7isR2PMqoca6+hX94j8TLRXFIzGbD8oY
 +fAOW3Etc+zk095QXVmYxcMoO6ihmJqzTTJ86chtl85KHzQmVPilpW96mkRdyoV+baXjm+fAui
 GjBLSBqX0sGdr//JB2ofrPJu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 00:19:07 -0800
IronPort-SDR: 871rBpCXuf+nHZj5yDmEu/GINjauAKhsLMmP45oQxRxjZ9P9jbPy1HagmGpZ0/4jKAdpP10hXh
 4LMKkQBF8eVKxiDC2M6Mkjrafi1xueFdXFINRH6rYuUP+TpiwJ3gNc8cwf/9Rhd+7T/uH67JLX
 sVp7QdLH8nAkZMy3eJZ1dA6YSIeLrA29MR67vL4b8iBEAwHguaUwprSs7OrcNgFkeRQleukD1l
 T9bisBskfPxWpNc5qSu9gugm7AceU8NoVwA4yGM57JW/y9L7PigA/wiVjS7Gp8Za29G3CsID20
 pCk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 00:45:37 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jdzk83Wx9z1SVp1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:45:36 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1642581936; x=1645173937; bh=IEZehArqSRfDu1om0RxzkqeXHEosIMsn3Mh
        n/j3uOEg=; b=TAI1GPPnm4Yrm63eyBaWkVwLWel6SLEUZ3FSYHlN2g7PoYdfFVV
        ThiLLw0vOahxz8ZefdyLucfjTAvWyoDQ5bnAZhYltptoT9dA0yFWkLHeT9CK31Ll
        rXpbyrfpI+f2uiEhY5UVR7PL4QNW9w8gc/hSX48NeiXi+lJYiS3st6eB1h8iBa3x
        lzuk+y2kzY/9xg1jrTGPXlOEV3Triettpl1fmdqec0s2Cb3enKy3ZPMh+GzXTqC5
        Hi3SmNlKF+jjbAli73w7s4VuR3YnUEsL2J0/JtAYg1Tw/gchgk2iS4IwitUMXmzF
        B06IW+nrvBYBdIMBJPgYFCQJ0+dh1oksB8w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eakHIHB5S3mF for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jan 2022 00:45:36 -0800 (PST)
Received: from [10.225.163.50] (unknown [10.225.163.50])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jdzk65nclz1Rwrw;
        Wed, 19 Jan 2022 00:45:34 -0800 (PST)
Message-ID: <f68657d6-027c-c842-ce35-5524cd782c7e@opensource.wdc.com>
Date:   Wed, 19 Jan 2022 17:45:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] drivers/scsi/csiostor: do not sleep with a spin lock held
Content-Language: en-US
To:     cgel.zte@gmail.com, jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220119055955.931355-1-chi.minghao@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220119055955.931355-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/22 14:59, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> The might_sleep_if function in the mempool_alloc
> may cause a sleep lock.We can't mempool_alloc()
> with a spin lock held, so bring it up front.

But the allocation is GFP_ATOMIC, which does not have
__GFP_DIRECT_RECLAIM, so how come mempool_alloc() triggers the
might_sleep() warning ?

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> ---
>  drivers/scsi/csiostor/csio_attr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/csiostor/csio_attr.c b/drivers/scsi/csiostor/csio_attr.c
> index 200e50089711..3d4ab439c756 100644
> --- a/drivers/scsi/csiostor/csio_attr.c
> +++ b/drivers/scsi/csiostor/csio_attr.c
> @@ -424,8 +424,8 @@ csio_fcoe_alloc_vnp(struct csio_hw *hw, struct csio_lnode *ln)
>  
>  	/* Issue VNP cmd to alloc vport */
>  	/* Allocate Mbox request */
> -	spin_lock_irq(&hw->lock);
>  	mbp = mempool_alloc(hw->mb_mempool, GFP_ATOMIC);
> +	spin_lock_irq(&hw->lock);
>  	if (!mbp) {
>  		CSIO_INC_STATS(hw, n_err_nomem);
>  		ret = -ENOMEM;
> @@ -505,8 +505,8 @@ csio_fcoe_free_vnp(struct csio_hw *hw, struct csio_lnode *ln)
>  	/* Issue VNP cmd to free vport */
>  	/* Allocate Mbox request */
>  
> -	spin_lock_irq(&hw->lock);
>  	mbp = mempool_alloc(hw->mb_mempool, GFP_ATOMIC);
> +	spin_lock_irq(&hw->lock);
>  	if (!mbp) {
>  		CSIO_INC_STATS(hw, n_err_nomem);
>  		ret = -ENOMEM;


-- 
Damien Le Moal
Western Digital Research
