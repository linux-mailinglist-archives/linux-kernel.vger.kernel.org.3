Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F084532B98
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbiEXNsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiEXNs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:48:28 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E59954B5;
        Tue, 24 May 2022 06:48:27 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-f1d2ea701dso22268050fac.10;
        Tue, 24 May 2022 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HIJN4WlvQ8QM86SidPISiFp+9klwdRDZuztIBtO9yCQ=;
        b=YkXTtDAHpRJOG4saAljaWG223jRutpWQfbqUDddF6sa4OEFbCIq8RjrXaskO35VdcA
         bIO/6k6zUjc6FQoqmSj62PcpXAyofVM4scxxRGQ77x6soGoz+cfZmGWocukZjMzQvjZ2
         lokEZtX4LYp3K/pNPmpIiZG5EYqa7g3aBofdcj4kXFGWBhwNn4am9MYPNu8XyT7s9zB2
         5vvoJScxS1QDJLKFqiL1Ehd4dB+9XPGk1DjOOPiGfYfluv+mY0tnGkCuhQ9BNrkExw+7
         9Ed6AcX3Bn7KDWzY8eD51cF9UURBxx9e4sQIAlmfJhzuiNum9Kt7z9kYSkP4D7MdKULv
         4npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HIJN4WlvQ8QM86SidPISiFp+9klwdRDZuztIBtO9yCQ=;
        b=bAvuETGbUvgJUx/r4NqrF059etCgD23oN4hXql5wnV86WIkfMtMo8w6hqf5OVATnLu
         8PNYCArW6n2Zo8Z9SrsaZZ1ggY0xz6mVSqscnGpOWr5qh50vd67/HkHEVqQ7cReRnIcD
         XiYLq0lumhzMUYirX+yfaFyDo8iz6far15uzxgGE2B07j1YVli+JjdFMFMLR0qJLRZe5
         fbe/ko9lJOErCPv+oi1S5Z6fBwcz511t/X9Xv9h2uGu2o6rSr/x5IAD3qGfIhjdKFZlJ
         Z+r6L7YNvD01hRKZu12vvtjLYyr4mT51lkwG9lvYtQ2WflimXiPxzVVI+xRKpeSR9yN6
         XVlg==
X-Gm-Message-State: AOAM530zwHwRVsCcHV2G5oZe/9F2DY3Ft3VvSYqDsuDtT81GdML4+7tS
        mo4OdzEtnAkdu8m/v4BKUjY=
X-Google-Smtp-Source: ABdhPJxUSG7pAcNVWyh+QKZTZ7LFUcm+tqCLRf/HjZrS14Tenfn2U0zmK3ijgdVUn8Ifmzjgi4IP0g==
X-Received: by 2002:a05:6870:9686:b0:f1:8905:3210 with SMTP id o6-20020a056870968600b000f189053210mr2458651oaq.61.1653400107093;
        Tue, 24 May 2022 06:48:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m2-20020a4aab82000000b0035eb4e5a6bbsm5460752oon.17.2022.05.24.06.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 06:48:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 24 May 2022 06:48:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     bjorn.andersson@linaro.org, mani@kernel.org,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        Prasad Sodagudi <quic_psodagud@quicinc.com>
Subject: Re: [PATCH v3] mailbox: qcom-ipcc: Log the pending interrupt during
 resume
Message-ID: <20220524134825.GA4188122@roeck-us.net>
References: <1652784180-10142-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652784180-10142-1-git-send-email-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 04:13:00PM +0530, Sibi Sankar wrote:
> From: Prasad Sodagudi <quic_psodagud@quicinc.com>
> 
> Enable logging of the pending interrupt that triggered device wakeup. This
> logging information helps to debug IRQs that cause periodic device wakeups
> by printing the detailed information of pending IPCC interrupts.
> 
> Scenario: Device wakeup caused by Modem crash
> Logs:
> qcom-ipcc mailbox: virq: 182 triggered client-id: 2; signal-id: 2
> 
> >From the IPCC bindings it can further be understood that the client here is
> IPCC_CLIENT_MPSS and the signal was IPCC_MPROC_SIGNAL_SMP2P.
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Prasad Sodagudi <quic_psodagud@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> V3:
>  * Use pm_sleep_ptr and convert info to dbg [Mani]

Unfortunately, this results in

drivers/mailbox/qcom-ipcc.c:258:12: error: 'qcom_ipcc_pm_resume' defined but not used

on builds with PM disabled, as seen in next-20220524.

Guenter

>  * Fixup commit message
> 
> V2:
>  * Fix build error when ipcc is a module [Kernel Test Bot]
> 
>  drivers/mailbox/qcom-ipcc.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
> index c5d963222014..5a42bc2a1083 100644
> --- a/drivers/mailbox/qcom-ipcc.c
> +++ b/drivers/mailbox/qcom-ipcc.c
> @@ -254,6 +254,24 @@ static int qcom_ipcc_setup_mbox(struct qcom_ipcc *ipcc,
>  	return devm_mbox_controller_register(dev, mbox);
>  }
>  
> +static int qcom_ipcc_pm_resume(struct device *dev)
> +{
> +	struct qcom_ipcc *ipcc = dev_get_drvdata(dev);
> +	u32 hwirq;
> +	int virq;
> +
> +	hwirq = readl(ipcc->base + IPCC_REG_RECV_ID);
> +	if (hwirq == IPCC_NO_PENDING_IRQ)
> +		return 0;
> +
> +	virq = irq_find_mapping(ipcc->irq_domain, hwirq);
> +
> +	dev_dbg(dev, "virq: %d triggered client-id: %ld; signal-id: %ld\n", virq,
> +		FIELD_GET(IPCC_CLIENT_ID_MASK, hwirq), FIELD_GET(IPCC_SIGNAL_ID_MASK, hwirq));
> +
> +	return 0;
> +}
> +
>  static int qcom_ipcc_probe(struct platform_device *pdev)
>  {
>  	struct qcom_ipcc *ipcc;
> @@ -324,6 +342,10 @@ static const struct of_device_id qcom_ipcc_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, qcom_ipcc_of_match);
>  
> +static const struct dev_pm_ops qcom_ipcc_dev_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, qcom_ipcc_pm_resume)
> +};
> +
>  static struct platform_driver qcom_ipcc_driver = {
>  	.probe = qcom_ipcc_probe,
>  	.remove = qcom_ipcc_remove,
> @@ -331,6 +353,7 @@ static struct platform_driver qcom_ipcc_driver = {
>  		.name = "qcom-ipcc",
>  		.of_match_table = qcom_ipcc_of_match,
>  		.suppress_bind_attrs = true,
> +		.pm = pm_sleep_ptr(&qcom_ipcc_dev_pm_ops),
>  	},
>  };
>  
> -- 
> 2.7.4
> 
