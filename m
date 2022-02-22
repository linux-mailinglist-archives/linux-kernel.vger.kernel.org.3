Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5A94BF5D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiBVK3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiBVK3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:29:53 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2955015AF01
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:29:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id q11so5406251pln.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I8N9I9PwP/XCNr+2csSo/sMAacbFuh57jh3fuP7bfBA=;
        b=UXtTS1Yr7V+T77NkElhcUOujgsp4vV1rJakeOetJN6dfzyDpOhdd/j6b0npyTvJLp/
         qgoxFdMNTuwDa76gCYcxUKYecuFZoO8dAMp+DHXEB2+kQY/F7gQcfw2wkC7Uj60bByy7
         BsmG9IU5Xod0pgB5j5XNurzfiMycEo2h7FbtE8+B9a1c3R29pVLpmPmprUGbCbOySVCa
         /H83KhOTmQnYr/hYsCiF+hLU2F02mXTcQEbwro/y0DmoKfUQ84jRpND46O4BGMVwJygv
         IjJIuhlrIGXQUvzlNUbQjRmxb+SLyFP1g3+pcks34NqdVkT7SPwNxRdPyMBAx55dutXl
         znLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I8N9I9PwP/XCNr+2csSo/sMAacbFuh57jh3fuP7bfBA=;
        b=u27XHIBfJwlvhODXMEK5jbpr26FfZTCes7gQIgYgF3AiuraSU7Oe6nNHKprKaqOAQr
         rWcXkg2V3saV258437dGf6nma7uKxkSSqi/Lky/VJpc3AggkSDfKI0x/mk7IyoIDNRNS
         xvXZwHQ/hbDX9Ma59xJqfMdGYBFlxPOHzkMTt8nIzy1mePufxVr4KZnFthm28hxn2DrN
         mGq55CEI+O+C5XP6OYyNifsbnQf6Z1x5Pp59EZyuWJ8AQkqXN5kR/vkinFeZEuV8qVaO
         LO/kXcUetmKQJhol3gfiMBIrKraixL6dUcyuV0fw2IhYC8UTiTjgbNgEnT4l1geT/BYC
         K82w==
X-Gm-Message-State: AOAM532mYNC1o253TVuqME9bjUnuPSyEvr5CIDgwJHh79hAuZ45dRh7x
        PlvSEzEaIj32u5iz5z8wNcMk
X-Google-Smtp-Source: ABdhPJztFD/ewvO/vm6rTg2gkWVH+DEE1Xj7uyJ4+gJIpHCxlSPCOtCrE3yJGyZF1gdY+bT/mdI0wg==
X-Received: by 2002:a17:90a:174f:b0:1bc:66ef:d733 with SMTP id 15-20020a17090a174f00b001bc66efd733mr3454083pjm.88.1645525765550;
        Tue, 22 Feb 2022 02:29:25 -0800 (PST)
Received: from thinkpad ([117.217.186.202])
        by smtp.gmail.com with ESMTPSA id s10sm16967161pfu.186.2022.02.22.02.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 02:29:25 -0800 (PST)
Date:   Tue, 22 Feb 2022 15:59:18 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        vinod.koul@linaro.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, quic_vbadigan@quicinc.com,
        quic_cang@quicinc.com, quic_skananth@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 19/25] bus: mhi: ep: Add support for handling SYS_ERR
 condition
Message-ID: <20220222102918.GE5029@thinkpad>
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-20-manivannan.sadhasivam@linaro.org>
 <40212d64-7423-014a-2a8d-cad5cc41795f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40212d64-7423-014a-2a8d-cad5cc41795f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 04:39:55PM -0600, Alex Elder wrote:
> On 2/12/22 12:21 PM, Manivannan Sadhasivam wrote:
> > Add support for handling SYS_ERR (System Error) condition in the MHI
> > endpoint stack. The SYS_ERR flag will be asserted by the endpoint device
> > when it detects an internal error. The host will then issue reset and
> > reinitializes MHI to recover from the error state.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> I have a few small comments, but this look good enough for me.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> 
> > ---
> >   drivers/bus/mhi/ep/internal.h |  1 +
> >   drivers/bus/mhi/ep/main.c     | 24 ++++++++++++++++++++++++
> >   drivers/bus/mhi/ep/sm.c       |  2 ++
> >   3 files changed, 27 insertions(+)
> > 
> > diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
> > index ee8c5974f0c0..8654af7caf40 100644
> > --- a/drivers/bus/mhi/ep/internal.h
> > +++ b/drivers/bus/mhi/ep/internal.h
> > @@ -241,6 +241,7 @@ int mhi_ep_set_mhi_state(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state mhi_stat
> >   int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl);
> >   int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl);
> >   int mhi_ep_set_ready_state(struct mhi_ep_cntrl *mhi_cntrl);
> > +void mhi_ep_handle_syserr(struct mhi_ep_cntrl *mhi_cntrl);
> >   /* MHI EP memory management functions */
> >   int mhi_ep_alloc_map(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, size_t size,
> > diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> > index ddedd0fb19aa..6378ac5c7e37 100644
> > --- a/drivers/bus/mhi/ep/main.c
> > +++ b/drivers/bus/mhi/ep/main.c
> > @@ -611,6 +611,30 @@ static void mhi_ep_reset_worker(struct work_struct *work)
> >   	}
> >   }
> > +/*
> > + * We don't need to do anything special other than setting the MHI SYS_ERR
> > + * state. The host issue will reset all contexts and issue MHI RESET so that we
> 
> s/host issue/host/
> 
> > + * could also recover from error state.
> > + */
> > +void mhi_ep_handle_syserr(struct mhi_ep_cntrl *mhi_cntrl)
> > +{
> > +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> > +	int ret;
> > +
> > +	/* If MHI EP is not enabled, nothing to do */
> > +	if (!mhi_cntrl->is_enabled)
> 
> Is this an expected condition?  SYS_ERR with the endpoint
> disabled?
> 

I hit a case during bringup but I don't exactly remember where. So I'll probably
remove this check.

> > +		return;
> > +
> > +	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
> > +	if (ret)
> > +		return;
> > +
> > +	/* Signal host that the device went to SYS_ERR state */
> > +	ret = mhi_ep_send_state_change_event(mhi_cntrl, MHI_STATE_SYS_ERR);
> > +	if (ret)
> > +		dev_err(dev, "Failed sending SYS_ERR state change event: %d\n", ret);
> > +}
> > +
> >   int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
> >   {
> >   	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> > diff --git a/drivers/bus/mhi/ep/sm.c b/drivers/bus/mhi/ep/sm.c
> > index 68e7f99b9137..9a75ecfe1adf 100644
> > --- a/drivers/bus/mhi/ep/sm.c
> > +++ b/drivers/bus/mhi/ep/sm.c
> > @@ -93,6 +93,7 @@ int mhi_ep_set_m0_state(struct mhi_ep_cntrl *mhi_cntrl)
> >   	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_M0);
> >   	if (ret) {
> > +		mhi_ep_handle_syserr(mhi_cntrl);
> >   		spin_unlock_bh(&mhi_cntrl->state_lock);
> >   		return ret;
> >   	}
> > @@ -128,6 +129,7 @@ int mhi_ep_set_m3_state(struct mhi_ep_cntrl *mhi_cntrl)
> >   	spin_lock_bh(&mhi_cntrl->state_lock);
> >   	ret = mhi_ep_set_mhi_state(mhi_cntrl, MHI_STATE_M3);
> 
> Are there any other spots that should do this?  For example, in
> mhi_ep_set_ready_state() you don't check the return value of
> the call to mhi_ep_set_mhi_state().  It seems to me it should
> be possible to preclude bogus state changes anyway, but I'm
> not completely sure.
> 

The check should be there, I will add it to ready_state() also.

Thanks,
Mani

> >   	if (ret) {
> > +		mhi_ep_handle_syserr(mhi_cntrl);
> >   		spin_unlock_bh(&mhi_cntrl->state_lock);
> >   		return ret;
> >   	}
> 
