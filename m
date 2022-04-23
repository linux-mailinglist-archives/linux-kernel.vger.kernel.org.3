Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769DE50C8D9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 11:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiDWJ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 05:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbiDWJ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 05:57:28 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5081399B5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:54:31 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p8so10241393pfh.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yUtsnYBIm01JXZecNVsIjjwJM9zeU9bP2sYqdVupyhs=;
        b=s2hZa+V1gBmYvlkiakilXv/njbEHD3uo6Q+veU65MapnY7ergLjc0EcstslsKTuDem
         hD2Wplm+D+hYzgFz8tTKyb8mPGn8vUiEoBTwSVEGDzjr0PyhnhO1IH/oj1P3dMPowB7e
         gm3GW9ARiqEkLnCJKY/9cPqA8wzFbxL/6N2jkww8i6OdbOqRAYnJoEednmjHsfwH8FHV
         Oxuun+ZFtniPOU33RGtU9DUjZAajYIbtXzLR/BM5bGjCa5645s544KVtpZC+NDqFM/ax
         ocgK4S8RBm0qTosF5SXoAu5HWGRx0F0Myp1y6NUIb8gYu9sG35NhLTXdTisEOdY0viOW
         GTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yUtsnYBIm01JXZecNVsIjjwJM9zeU9bP2sYqdVupyhs=;
        b=Cz6oHKBMM2YyjDNjQqqAbIQuDemBkHXN/ERppc7NM5DUIwWauaM3X4pc3R8+nIEnNd
         tX4xmcCCrYOhr0G1xMFh+pr3OdkwsaAwoMBFknRWyRi5kgj6Gxyh9qP20Q/seU4pFQSQ
         LtGCzGI9EtgrePh49z7ttRV3dGbyIyh3aUoSsYML2qPqExmwL5Kzf+nhjtRefCKgJN4b
         kpcZr7hzatq0NOeMv5CrbAImOc8VvuUHO8IxIX9YqWpytEPMvX+wdj6zOXCy6GzstHw8
         +3Ispv05wSQtmXxcCIE0U9KHSZXr9HFUu/vSTrldXIZcT7gVzRmHtlWBPjslCkfV4sQE
         Wq8Q==
X-Gm-Message-State: AOAM531Uxw8e+IJfvvfhXZjCglQipVQ7cjeB95ojmbK9ymgJcSHad1su
        IAsumMlG/EnZK9yEa9db/Zki
X-Google-Smtp-Source: ABdhPJyUD2+pddHG8R+pE+ymvssOE4dR8B16cM/ywDRUpHhIwOAvha9/v9gMtwZJBfeuBUslOAaECg==
X-Received: by 2002:aa7:90d5:0:b0:4e1:307c:d94a with SMTP id k21-20020aa790d5000000b004e1307cd94amr9292303pfk.38.1650707671128;
        Sat, 23 Apr 2022 02:54:31 -0700 (PDT)
Received: from thinkpad ([117.207.28.196])
        by smtp.gmail.com with ESMTPSA id iy2-20020a17090b16c200b001d75aabe050sm6309658pjb.34.2022.04.23.02.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 02:54:30 -0700 (PDT)
Date:   Sat, 23 Apr 2022 15:24:23 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] scsi: ufs: qcom: Fix acquiring the optional reset
 control line
Message-ID: <20220423095423.GA374560@thinkpad>
References: <20220422132140.313390-1-manivannan.sadhasivam@linaro.org>
 <20220422132140.313390-2-manivannan.sadhasivam@linaro.org>
 <20220422154010.2cxk4qy5eikxujb2@halaneylaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422154010.2cxk4qy5eikxujb2@halaneylaptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 10:40:10AM -0500, Andrew Halaney wrote:
> On Fri, Apr 22, 2022 at 06:51:36PM +0530, Manivannan Sadhasivam wrote:
> > On Qcom UFS platforms, the reset control line seems to be optional
> > (for SoCs like MSM8996 and probably for others too). The current logic
> > tries to mimic the `devm_reset_control_get_optional()` API but it also
> > continues the probe if there is an error with the declared reset line in
> > DT/ACPI.
> > 
> > In an ideal case, if the reset line is not declared in DT/ACPI, the probe
> > should continue. But if there is problem in acquiring the declared reset
> > line (like EPROBE_DEFER) it should fail and return the appropriate error
> > code.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/scsi/ufs/ufs-qcom.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> > index 0d2e950d0865..5db0fd922062 100644
> > --- a/drivers/scsi/ufs/ufs-qcom.c
> > +++ b/drivers/scsi/ufs/ufs-qcom.c
> > @@ -1002,13 +1002,13 @@ static int ufs_qcom_init(struct ufs_hba *hba)
> >  	host->hba = hba;
> >  	ufshcd_set_variant(hba, host);
> >  
> > -	/* Setup the reset control of HCI */
> > -	host->core_reset = devm_reset_control_get(hba->dev, "rst");
> > +	/* Setup the optional reset control of HCI */
> > +	host->core_reset = devm_reset_control_get_optional(hba->dev, "rst");
> >  	if (IS_ERR(host->core_reset)) {
> >  		err = PTR_ERR(host->core_reset);
> > -		dev_warn(dev, "Failed to get reset control %d\n", err);
> > -		host->core_reset = NULL;
> > -		err = 0;
> > +		if (err != -EPROBE_DEFER)
> > +			dev_err(dev, "Failed to get reset control %d\n", err);
> 
> Could we use dev_err_probe() here?
> 

Yes. Will do the same for patch 2/5 as well.

Thanks,
Mani

> Otherwise, looks good to me.
> 
> > +		goto out_variant_clear;
> >  	}
> >  
> >  	/* Fire up the reset controller. Failure here is non-fatal. */
> > -- 
> > 2.25.1
> > 
> 
