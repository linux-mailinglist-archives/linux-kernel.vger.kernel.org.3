Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6810B46A697
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244480AbhLFUPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349384AbhLFUPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:15:02 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C2DC0611F7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 12:11:33 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so15110355otu.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 12:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ypDUIho7eWHCZJ7Rm8us7oavNNmEtNxG3tY05fvu+RY=;
        b=XyUZEWbAbyTD3x8dQ0p4NuyJAKpyRvj+HcEOYnANI8nHWL+EDMYBkNOYd8KkvNo7rr
         H7aODQqhN0WeBX86PxnV6HGVSJQ8tugnbzyQYFmtDECQgYqjhF3Oxoh25iq+Jt2LBjJd
         S1c1GUR6Z/a+4ww8MN0HudJG+cJfdlrC/yydAMmDrxz057uJxYXNVHnigGxiMOqih+ql
         YWgsgm9xIDs/jeZ/snxT8AOdXJXIjk5cvgaTfpBX92Pt8p74dNz1WkiSgKKJIy6JYm/a
         0Qv8Kjx3FlVasKJ2TpLwvfHxWo7Vu16ubsK9o+AsZzuCcUtriZbw79MyZ8Ovhzbk/qjr
         ZILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ypDUIho7eWHCZJ7Rm8us7oavNNmEtNxG3tY05fvu+RY=;
        b=MEiO7a/l+0KDEA1egr1e1gyVaGwj+1WOl8vyeC37rGklDQpUYGW381UjwM82HvUV9y
         7RHD1mxBI6gPC6V45g9tURH83JIGhLuzMcoH1th5avbuTxWZb+ff8Bx0m30r2JWJcK9N
         NfmAIxhzU+IIwFGMQRvBG3918dPOBK4WHrxPri3kjnmhTJUxyll60g5Y/OZeh38IT+TC
         H0ZMek7HaK5XR6S0PDsOWSMpR6dQtraeA25JhNauLasLYpHZ32pfB3WUPAPnkvKcT9DK
         rmFAZ6PJUcZnSfUtGAhwK8U3wGHEUH8kI708U//rdAkN6+izDN6dE626xVOvc95qJBOd
         OFTw==
X-Gm-Message-State: AOAM532hA4Xy9ujN4rTBzdCOYMeJNp8P1nV6+0k/QsGqrYObcoRkBz4v
        UUkZjmEGmeKcUZovdAVRqr6h/w==
X-Google-Smtp-Source: ABdhPJxquBRAhZlmEi8XL4TUa6etjEftnBL+pcRWhwWyPPZUItxs0BtS0PUQYihYDzhMNEPZEIkxBw==
X-Received: by 2002:a9d:7f91:: with SMTP id t17mr30910146otp.197.1638821492818;
        Mon, 06 Dec 2021 12:11:32 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q2sm2478175otg.64.2021.12.06.12.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:11:32 -0800 (PST)
Date:   Mon, 6 Dec 2021 14:11:29 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] remoteproc: Fix remaining wrong return formatting in
 documentation
Message-ID: <Ya5ucVAGf/qFpVbx@builder.lan>
References: <20211206191858.10741-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206191858.10741-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06 Dec 13:18 CST 2021, Arnaud Pouliquen wrote:

> kernel documentation specification:
> "The return value, if any, should be described in a dedicated section
> named Return."
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks,
Bjorn

> ---
>  drivers/remoteproc/mtk_scp_ipi.c   | 4 ++--
>  drivers/remoteproc/st_slim_rproc.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
> index 6dc955ecab80..00f041ebcde6 100644
> --- a/drivers/remoteproc/mtk_scp_ipi.c
> +++ b/drivers/remoteproc/mtk_scp_ipi.c
> @@ -23,7 +23,7 @@
>   *
>   * Register an ipi function to receive ipi interrupt from SCP.
>   *
> - * Returns 0 if ipi registers successfully, -error on error.
> + * Return: 0 if ipi registers successfully, -error on error.
>   */
>  int scp_ipi_register(struct mtk_scp *scp,
>  		     u32 id,
> @@ -150,7 +150,7 @@ EXPORT_SYMBOL_GPL(scp_ipi_unlock);
>   * When the processing completes, IPI handler registered
>   * by scp_ipi_register will be called in interrupt context.
>   *
> - * Returns 0 if sending data successfully, -error on error.
> + * Return: 0 if sending data successfully, -error on error.
>   **/
>  int scp_ipi_send(struct mtk_scp *scp, u32 id, void *buf, unsigned int len,
>  		 unsigned int wait)
> diff --git a/drivers/remoteproc/st_slim_rproc.c b/drivers/remoteproc/st_slim_rproc.c
> index 22096adc1ad3..4ed9467897e5 100644
> --- a/drivers/remoteproc/st_slim_rproc.c
> +++ b/drivers/remoteproc/st_slim_rproc.c
> @@ -216,7 +216,7 @@ static const struct rproc_ops slim_rproc_ops = {
>   * obtains and enables any clocks required by the SLIM core and also
>   * ioremaps the various IO.
>   *
> - * Returns st_slim_rproc pointer or PTR_ERR() on error.
> + * Return: st_slim_rproc pointer or PTR_ERR() on error.
>   */
>  
>  struct st_slim_rproc *st_slim_rproc_alloc(struct platform_device *pdev,
> -- 
> 2.17.1
> 
