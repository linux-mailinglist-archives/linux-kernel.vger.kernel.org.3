Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E388E4D0B4F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343813AbiCGWmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbiCGWmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:42:06 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943A213EAF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 14:41:10 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id w3-20020a4ac183000000b0031d806bbd7eso19722648oop.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 14:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u+HxVrmr9/wIVPGnqjkJowBAbXCNibxa+a47AT7FYmc=;
        b=kVk8SOVW/iiKd2v1gTN9DpvUG9WzaoGZPbr9soXaMjEt6UsjM3EwBOPNVeQCX+2CLO
         xPn23If8HwPAI5StphwjMWy7aaULGZuOK5dkKA/LYcUHxB6q1g3aNWJJSjIt5Rth6i1a
         nVbUgWAqrk67KRodYd72vRKVsL+UkDkFnE/cdrPjGqPCybaJZzkUnU5g7kUMm+wX9HIO
         M4ogM4vQyFaymIAEk7Eg+jP+Bak0vkN3J7ETbFdiyYhUIV2y3v4WRvfBedM0JB13CHZs
         H8ud1QRKr3wKt7k9+Jg22qOvEq2UMuldaUlW72Ygzag6DFDMjEVUsslOFOGWDRRA7Lxp
         haGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u+HxVrmr9/wIVPGnqjkJowBAbXCNibxa+a47AT7FYmc=;
        b=TEIArjDAv29GmUM/4cLFA6eyYTQpia9HomgQ2URFU7iWuIba6pICZ0nIG3DlkPPSwt
         ZhEMt52jVJhTmJaUgEEvKd9EUsu9pcJifJo4k+E9NrXkAXm6mVmfWVmk2KP4UGhn2wtE
         mWoWLah/9L4fiBn5ESNVC7AVgw3laMnxAXyisFUyNwZTdPqvMMICRymjv5tLAMs7U5Sq
         eDg2SJA8NzF/GX+Senga2DaG00G6NtZDBeeIAvQGHiOLFI7pKxFQhuCftBYL5m5IJ34N
         fNYXAqzyIuU9P09Jq3Qt43uM+Iou7XgX+haxHJUz7s+M95dDc51wuBB6UMi/JHgCF3NU
         Lgmw==
X-Gm-Message-State: AOAM532oS28oHIOnqo1JwbHtoGj59u9Y0kcH15uWVIo3Okjmi7ZSvL35
        WxWqGgU/qJjwdpcMTwBZ+e0f6g==
X-Google-Smtp-Source: ABdhPJynHgOD50IYhViIADKSPnv8ztHZHbrRi/3JCjkOSQU+0t0a9WCyxiSGe2Qqa3exr324JljcdQ==
X-Received: by 2002:a05:6871:1d0:b0:da:b3f:3210 with SMTP id q16-20020a05687101d000b000da0b3f3210mr680906oad.192.1646692869913;
        Mon, 07 Mar 2022 14:41:09 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id f21-20020a4ada55000000b0031c16df28f9sm6260868oou.42.2022.03.07.14.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:41:09 -0800 (PST)
Date:   Mon, 7 Mar 2022 14:42:53 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Sibi Sankar <quic_sibis@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: q6v5: Add interconnect path proxy vote
Message-ID: <YiaKbbxJ/QE7yItC@ripper>
References: <20220225033224.2238425-1-bjorn.andersson@linaro.org>
 <5a9210d9-c726-1ef9-4bf2-716f2ed1fb8b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a9210d9-c726-1ef9-4bf2-716f2ed1fb8b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07 Mar 10:35 PST 2022, Georgi Djakov wrote:

> 
> On 25.02.22 5:32, Bjorn Andersson wrote:
> > Many remoteproc instances requires that Linux casts a proxy vote for an
> > interconnect path during boot, until they can do it themselves. Add
> > support for voting for a single path.
> > 
> > As this is a shared problem between both PAS and MSS drivers, the path
> > is acquired and votes casted from the common helper code.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Sibi posted recently a patch to add interconnect votes from the modem driver,
> > today I needed the same feature for one of the PAS remoteprocs. After
> > essentially duplicating Sibi's patch I realized that it doesn't look too bad to
> > put this in the common Q6V5 code.
> > 
> > The main difference is that this would be messy if we need to support multiple
> > paths, so we probably would have to push it out to the individual drivers at
> > that point.
> > 
> > Sibi's patch can be found here.
> > https://lore.kernel.org/all/1644813252-12897-3-git-send-email-quic_sibis@quicinc.com/
> > 
> > 
> > This makes the implementation pick up one path, relevant DT bindings would
> > still need to be updated in order be allowed to this in the DeviceTree files.
> > 
> >   drivers/remoteproc/qcom_q6v5.c | 21 ++++++++++++++++++++-
> >   drivers/remoteproc/qcom_q6v5.h |  3 +++
> >   2 files changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
> > index 442a388f8102..5280ec9b5449 100644
> > --- a/drivers/remoteproc/qcom_q6v5.c
> > +++ b/drivers/remoteproc/qcom_q6v5.c
> > @@ -8,6 +8,7 @@
> >    */
> >   #include <linux/kernel.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/interconnect.h>
> >   #include <linux/interrupt.h>
> >   #include <linux/module.h>
> >   #include <linux/soc/qcom/qcom_aoss.h>
> > @@ -51,9 +52,17 @@ int qcom_q6v5_prepare(struct qcom_q6v5 *q6v5)
> >   {
> >   	int ret;
> > +	ret = icc_set_bw(q6v5->path, 0, UINT_MAX);
> > +	if (ret < 0) {
> > +		dev_err(q6v5->dev, "failed to set bandwidth request\n");
> > +		return ret;
> > +	}
> > +
> >   	ret = q6v5_load_state_toggle(q6v5, true);
> > -	if (ret)
> > +	if (ret) {
> > +		icc_set_bw(q6v5->path, 0, 0);
> >   		return ret;
> > +	}
> >   	reinit_completion(&q6v5->start_done);
> >   	reinit_completion(&q6v5->stop_done);
> > @@ -78,6 +87,9 @@ int qcom_q6v5_unprepare(struct qcom_q6v5 *q6v5)
> >   	disable_irq(q6v5->handover_irq);
> >   	q6v5_load_state_toggle(q6v5, false);
> > +	/* Disable interconnect vote, in case handover never happened */
> > +	icc_set_bw(q6v5->path, 0, 0);
> > +
> >   	return !q6v5->handover_issued;
> >   }
> >   EXPORT_SYMBOL_GPL(qcom_q6v5_unprepare);
> > @@ -160,6 +172,8 @@ static irqreturn_t q6v5_handover_interrupt(int irq, void *data)
> >   	if (q6v5->handover)
> >   		q6v5->handover(q6v5);
> > +	icc_set_bw(q6v5->path, 0, 0);
> > +
> >   	q6v5->handover_issued = true;
> >   	return IRQ_HANDLED;
> > @@ -332,6 +346,11 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
> >   		return load_state ? -ENOMEM : -EINVAL;
> >   	}
> > +	q6v5->path = devm_of_icc_get(&pdev->dev, NULL);
> > +	if (IS_ERR(q6v5->path))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(q6v5->path),
> > +				     "failed to acquire interconnect path\n");
> > +
> >   	return 0;
> >   }
> >   EXPORT_SYMBOL_GPL(qcom_q6v5_init);
> 
> Probably we should also call icc_put(q6v5->path) in qcom_q6v5_deinit().
> 

The use of devm_of_icc_get() should take care of that for us. Or am I
missing something?

> Reviewed-by: Georgi Djakov <djakov@kernel.org>
> 

Thanks,
Bjorn
