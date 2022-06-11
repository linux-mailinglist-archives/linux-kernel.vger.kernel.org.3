Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DD254771B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 20:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiFKSTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 14:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiFKSTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 14:19:35 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B4D2661
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 11:19:34 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-100eb6f7782so3280824fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 11:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=r17snX+1CJhT3VmJw3mp5dS1V2P55fF3SOw7ALhy79o=;
        b=Wm0Buxc1kpff5ZqSS5cNUYXQv33z8vgTxHCWjEm264FoGRHl7IufZbtu6B7zYx2cGa
         r5L6ypdpMXTZfVJpyUYBiuMpkJD6gLQ6j2YApWr9uY9fBlbgyLhF2L+2CR3OO5UpiRWP
         PcxZiX7SlnyyFrG/aqyNQuYlWDS8x6PQ5s5cA4GCSIOpWiUrQte6G5mC8Q0Yq1aG0o2C
         PnBYnHbvco8hrrqjLURKvWb6kc7BDcxbSvJ5ClCgwsk+Zkf/g9V/gRaag0lbXxWmqyaP
         VduAC8DpVUI7P5PLcBdTXj9AF1s0o+M7WKVwqV1XRzM3W+zM7biTsTvFWndHMtM3ijYp
         5Kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r17snX+1CJhT3VmJw3mp5dS1V2P55fF3SOw7ALhy79o=;
        b=KtCLMTHrAyRfjTg849TP5P3YKrb6wfaTOytnV+Pzdz8D5JTePv+upHi/JBiYPRjTi/
         6GGlROa20OAMSGH0xyYNE7weVQpF845QN1BGgfF4oZYCoraUmu8hh20hh+co9mMFxmT/
         qFzFT8anv2ngKubVYGegKcSWVeU0OLJ9vldj4dASYD62mKfJ+M0uq88LWlFdvkeVsDcq
         QjI6eA1w7gpnsvGOAdT/l9WrUViRKbRZTZEDRCyRUCx+rre7GyzOHpsRAykiPQd2CSrZ
         GrWyx2U/Gg6V9K2iY3qkQkPOfbzHFx9gq3K3llS88W+aQmYapXpew++JYJuMIhFOML3c
         T7AA==
X-Gm-Message-State: AOAM533MpBsNzG4hQ5qoa/1GL56rh40t2AzjnuNG24/M3WHynCH/6U0d
        t+CJJbkPmwtaZ2CverqnYxGOjhDn2JWH03rq
X-Google-Smtp-Source: ABdhPJw9wW0v+7X7Ti52yfdwpcIcu2d7tm+laTtRoHNn9hqddgAfa+6is/cZbU1XYjRlUedi2U3EjA==
X-Received: by 2002:a05:6870:e2cc:b0:f5:dca0:95dc with SMTP id w12-20020a056870e2cc00b000f5dca095dcmr3235200oad.160.1654971573965;
        Sat, 11 Jun 2022 11:19:33 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id bx36-20020a0568081b2400b00325cda1ffa6sm1209993oib.37.2022.06.11.11.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jun 2022 11:19:30 -0700 (PDT)
Message-ID: <03923830-c3ae-6ef8-890a-361341c18e95@kali.org>
Date:   Sat, 11 Jun 2022 13:19:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: fix runtime PM underflow
Content-Language: en-US
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220609195043.1544625-1-caleb.connolly@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20220609195043.1544625-1-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Caleb,

On 6/9/22 2:50 PM, Caleb Connolly wrote:
> When PM runtime is disabled, pm_runtime_get() isn't called, but
> pm_runtime_put() still is. Fix this by creating a matching wrapper
> on pm_runtime_put_autosuspend().
>
> Fixes: dbad41e7bb5f ("dmaengine: qcom: bam_dma: check if the runtime pm enabled")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/dma/qcom/bam_dma.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 87f6ca1541cf..a36dedee262e 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -566,6 +566,14 @@ static int bam_pm_runtime_get_sync(struct device *dev)
>   	return 0;
>   }
>   
> +static int bam_pm_runtime_put_autosuspend(struct device *dev)
> +{
> +	if (pm_runtime_enabled(dev))
> +		return pm_runtime_put_autosuspend(dev);
> +
> +	return 0;
> +}
> +
>   /**
>    * bam_free_chan - Frees dma resources associated with specific channel
>    * @chan: specified channel
> @@ -617,7 +625,7 @@ static void bam_free_chan(struct dma_chan *chan)
>   
>   err:
>   	pm_runtime_mark_last_busy(bdev->dev);
> -	pm_runtime_put_autosuspend(bdev->dev);
> +	bam_pm_runtime_put_autosuspend(bdev->dev);
>   }
>   
>   /**
> @@ -793,7 +801,7 @@ static int bam_pause(struct dma_chan *chan)
>   	bchan->paused = 1;
>   	spin_unlock_irqrestore(&bchan->vc.lock, flag);
>   	pm_runtime_mark_last_busy(bdev->dev);
> -	pm_runtime_put_autosuspend(bdev->dev);
> +	bam_pm_runtime_put_autosuspend(bdev->dev);
>   
>   	return 0;
>   }
> @@ -819,7 +827,7 @@ static int bam_resume(struct dma_chan *chan)
>   	bchan->paused = 0;
>   	spin_unlock_irqrestore(&bchan->vc.lock, flag);
>   	pm_runtime_mark_last_busy(bdev->dev);
> -	pm_runtime_put_autosuspend(bdev->dev);
> +	bam_pm_runtime_put_autosuspend(bdev->dev);
>   
>   	return 0;
>   }
> @@ -936,7 +944,7 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
>   	}
>   
>   	pm_runtime_mark_last_busy(bdev->dev);
> -	pm_runtime_put_autosuspend(bdev->dev);
> +	bam_pm_runtime_put_autosuspend(bdev->dev);
>   
>   	return IRQ_HANDLED;
>   }
> @@ -1111,7 +1119,7 @@ static void bam_start_dma(struct bam_chan *bchan)
>   			bam_addr(bdev, bchan->id, BAM_P_EVNT_REG));
>   
>   	pm_runtime_mark_last_busy(bdev->dev);
> -	pm_runtime_put_autosuspend(bdev->dev);
> +	bam_pm_runtime_put_autosuspend(bdev->dev);
>   }
>   
>   /**

I've tested this patch here and no longer see the logs filling up with 
messages about Runtime PM underflows.  Tested on the Lenovo Yoga C630.


Tested-by: Steev Klimaszewski <steev@kali.org>

