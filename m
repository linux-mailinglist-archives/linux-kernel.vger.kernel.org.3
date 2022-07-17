Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7825C577593
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 11:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiGQJmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 05:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiGQJmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 05:42:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760691581E;
        Sun, 17 Jul 2022 02:42:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l68so5404566wml.3;
        Sun, 17 Jul 2022 02:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QN+UydeVw4+Kplm7t+2D97K65XedGkpyFuIH1+Gy87A=;
        b=PuC4cnmnIkR60xThLcQFoHhnSPg+cgTVm+MCmDo8sUYtlJEwAHTIADYR2s8cdS9H4A
         6rmruUF/VQbDUf67WSWAWcN/q2g9LHaJLZ0APvW0NUgo4AQPvMrev3i6LhoB+IY7as/u
         c0T9ZB4332J2dggv0iv3I2BeXBYnz2gqEzy4khgduyvS0B246n3DnE0AHEJ+TiqhOchY
         NTWrHpj/jWr7Hwn0ss9mSNHsPOJ3FEUfjjD8mhd9fFUsGiZSrAeYnkmSOwq+nXvVNg/h
         S52VAcAwLzsg5kjOY+9rpNW4Rtqi77A5NtL7wCnY7r8QYB2b8X/N4MgNMMHN8nVxp9kz
         ARyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QN+UydeVw4+Kplm7t+2D97K65XedGkpyFuIH1+Gy87A=;
        b=kuyFAZybfNPdlGskdBvS7aD1oUB94PjwA1FBLoVJ3CBoTVpbPPr3hn2Eo536dqY+J3
         nLuAhTaCaXRfU7f6PVXzVa5Wt4V466KD/aDXxEm9n1Rb0bHmSzN1LXuUgEvZaIhKQ1Yw
         0l79pNdeBDtue55OU+T1U0I8hYoFLTXnHGLnKihaDr6+Xs6gvrEoayVOMyAqBwcrQBHu
         P2kBTZzgPIrVBnVP74rnrgrEBAhDt97pNxzdZanjKfCxGgEzaommYJ9Mor8x3Oz4XXAF
         1asJrk5ThpwhTAPSF64yxlUVhIE7El8pX90FNigYSeztjc9bd0TxwTKAAgNd+xJIhuDU
         rOiA==
X-Gm-Message-State: AJIora/nuVguvkWSebnOPwO0XnN+1gHGvY2dI8E54HfNc+9zb85n7PcQ
        X7WeMJ0TJ93xfNuCfyuV7DPzmLp17Lw=
X-Google-Smtp-Source: AGRyM1s2Acsbb0SZDUiHrxfXTe4Pu36OTFpURGLRukN4BeDnSHEKkcP/flDDBQpQiLkuZG36kJHLJg==
X-Received: by 2002:a05:600c:1c93:b0:3a0:579e:9f44 with SMTP id k19-20020a05600c1c9300b003a0579e9f44mr22456467wms.82.1658050928966;
        Sun, 17 Jul 2022 02:42:08 -0700 (PDT)
Received: from opensuse.localnet (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b003a310631750sm7155186wmq.35.2022.07.17.02.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 02:42:07 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     martin.petersen@oracle.com, Jason Wang <wangborong@cdjrlc.com>
Cc:     jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: Re: [PATCH] scsi: qlogicpti: Remove unneeded semicolon
Date:   Sun, 17 Jul 2022 11:42:06 +0200
Message-ID: <3462006.iIbC2pHGDl@opensuse>
In-Reply-To: <20220716183843.65193-1-wangborong@cdjrlc.com>
References: <20220716183843.65193-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sabato 16 luglio 2022 20:38:43 CEST Jason Wang wrote:
> The semicolon after the `}' in line 1152 is unneeded.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/scsi/qlogicpti.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
> index 57f2f4135a06..4f777ca9730b 100644
> --- a/drivers/scsi/qlogicpti.c
> +++ b/drivers/scsi/qlogicpti.c
> @@ -513,7 +513,7 @@ static int qlogicpti_load_firmware(struct qlogicpti 
*qpti)
>  		       qpti->qpti_id);
>  		err = 1;
>  		goto out;
> -	}		
> +	}

Why did you delete and then put back braces?

>  	sbus_writew(SBUS_CTRL_RESET, qpti->qregs + SBUS_CTRL);
>  	sbus_writew((DMA_CTRL_CCLEAR | DMA_CTRL_CIRQ), qpti->qregs + 
CMD_DMA_CTRL);
>  	sbus_writew((DMA_CTRL_CCLEAR | DMA_CTRL_CIRQ), qpti->qregs + 
DATA_DMA_CTRL);
> @@ -563,7 +563,7 @@ static int qlogicpti_load_firmware(struct qlogicpti 
*qpti)
>  		       qpti->qpti_id);
>  		err = 1;
>  		goto out;
> -	}		
> +	}

Same question.

>  	/* Load it up.. */
>  	for (i = 0; i < risc_code_length; i++) {
> @@ -1135,7 +1135,7 @@ static struct scsi_cmnd 
*qlogicpti_intr_handler(struct qlogicpti *qpti)
>  
>  	if (!(sbus_readw(qpti->qregs + SBUS_STAT) & SBUS_STAT_RINT))
>  		return NULL;
> -		
> +

Why did you delete and then put back an empty line?

>  	in_ptr = sbus_readw(qpti->qregs + MBOX5);
>  	sbus_writew(HCCTRL_CRIRQ, qpti->qregs + HCCTRL);
>  	if (sbus_readw(qpti->qregs + SBUS_SEMAPHORE) & 
SBUS_SEMAPHORE_LCK) {
> @@ -1149,7 +1149,7 @@ static struct scsi_cmnd 
*qlogicpti_intr_handler(struct qlogicpti *qpti)
>  		case COMMAND_ERROR:
>  		case COMMAND_PARAM_ERROR:
>  			break;
> -		};
> +		}
>  		sbus_writew(0, qpti->qregs + SBUS_SEMAPHORE);
>  	}
>  
> @@ -1363,7 +1363,7 @@ static int qpti_sbus_probe(struct platform_device 
*op)
>  		printk("(FCode %s)", fcode);
>  	if (of_find_property(dp, "differential", NULL) != NULL)
>  		qpti->differential = 1;
> -			
> +

Again :-)

>  	printk("\nqlogicpti%d: [%s Wide, using %s interface]\n",
>  		qpti->qpti_id,
>  		(qpti->ultra ? "Ultra" : "Fast"),
> -- 
> 2.35.1
> 
> 

I guess that things went the following way (please check yourself):

1) You made a patch with some mistakes (i.e., deleted _necessary_ braces 
and lines).
2) You realized your own mistakes.
3) You made a second patch on your first patch (because you forgot to git-
reset the first version - you probably now see two patches with git-log).
4) You didn't look at git-diff before committing and sending.

If so, please notice that this is not the right way to fix mistakes. 
Maintainers don't want to see that, for instance, you deleted a line and 
then you put it back. Patches must show only net changes, not the entire 
story of trial, errors, fixes.

Please learn and use Git properly. I'd suggest you to work on drivers/
staging, otherwise you may risk that patches coming from your address 
become ignored by Maintainers and other developers working in more mature 
parts of Linux (this means everywhere but drivers/staging).

Thanks,

Fabio


