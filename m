Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F11512EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344413AbiD1Itl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344801AbiD1Is6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:48:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9F0DED1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:41:49 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fv2so3687113pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wIdqzQenp8zuRFBiUnNUkRO/mr/GSoN96MpP4RdC2Ks=;
        b=xsSu5UkuQp97dr0n35uBtIUmJEnPrOq+7/Ht8m1e0fS41D6us0m0UdxZsuYoBM+4L/
         qyYzrP9GeLa+6aX7dVwBoEiHpKMPqehEugWifRgV5H1Xq8/A/v21RTNfffson+PMEqdH
         ejG15f5Yzg6nvPTTMcwiIaUHytZtm5yY+/LtxbPzw0uM76D3tVjrBOQScji6XW3+kpTL
         vjfvAzqMjKj8Fa/q89vqNDEUWwEWUyLQUvoZATzyJi5sP5DWq6qEWzguM9rw0/74T0TB
         iH8uoemrGokyoSu5V20+EEEyDMp9zy9aL9wwYjwcmevwmXTy6GdrMwzr6i10GIaKLoRl
         RYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wIdqzQenp8zuRFBiUnNUkRO/mr/GSoN96MpP4RdC2Ks=;
        b=hFgdq/6qdzBzbnzHZ+Y/elBltq/NVmL9NTLZLpXxLAHPvkLFOeHqEM84JSAqZKh9NU
         HO/9Vb/bWL9ztlTsgN0ZwaOojKDN4EnywjKuQw+CtZm5YS0iIBJE3GqP/CdSFT5okHji
         LmHRb5b6fzce7L6IO24DTSYjFkbWdf2P3JhDWVG3zF7pUHVcFMFDLpk6kdkfj9gGJACj
         4tLPSshlZ4a/hTSMBKSP1b4VD2+eEa5u5upyIxBpQT88UtX4j/8SlbCxZkIcEov58+96
         WktkIMf7OQtrmk3JLAcvegmFe9kwVeQoj0jMKgOIi6k8hMPViri1EbNUAqPFh4ATWRy5
         2AZA==
X-Gm-Message-State: AOAM530ZhNBcYmV0QYSQEkQkpuaQLSYKWSR1mvbCipyGQmIkDJERV4t1
        vKar78G/rFQxLKelMHcUxV+ejQ==
X-Google-Smtp-Source: ABdhPJxaBqG4DFsYcLCWvno3bHaamg3EwGl6hR804mfzJo/rqlAlnFOKP86OTA2RJ3iySYw9TMbjvw==
X-Received: by 2002:a17:90b:314a:b0:1d9:5ccf:baab with SMTP id ip10-20020a17090b314a00b001d95ccfbaabmr25208550pjb.110.1651135309119;
        Thu, 28 Apr 2022 01:41:49 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id d7-20020a62f807000000b0050d32c878f4sm15371198pfh.114.2022.04.28.01.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 01:41:48 -0700 (PDT)
Date:   Thu, 28 Apr 2022 16:41:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: msm8939: Use icc_sync_state
Message-ID: <20220428084143.GB583115@leoy-ThinkPad-X240s>
References: <20220416012634.479617-1-leo.yan@linaro.org>
 <05a7c1cc-c8f4-9303-2498-ba8709c72b4b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05a7c1cc-c8f4-9303-2498-ba8709c72b4b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 10:19:55AM +0300, Georgi Djakov wrote:
> On 16.04.22 4:26, Leo Yan wrote:
> > It's fashion to use the icc_sync_state callback to notify the framework
> > when all consumers are probed, so that the bandwidth request doesn't
> > need to stay on maximum value.
> > 
> > Do the same thing for msm8939 driver.
> 
> I assume that you tested this with some out of tree DT? Is it public?

Yes, Bryan is upstreaming for DT binding patch, see:
https://lore.kernel.org/all/20220419010903.3109514-3-bryan.odonoghue@linaro.org/

> If the consumers are not described as such in DT and/or the support
> in the client drivers is missing, paths might get disabled.

Indeed, when tested the mainline kernel on msm8939 (with several
offline patches for enabling msm8939), I observed that GPU and display
drivers are not enabled yet, so some interconnect paths are failed.
In this case, the interconnect clock stays on maximum frequency.

But I think this doesn't impact this patch; if without this patch,
icc_sync_state() will never be called and the global variable
'synced_state' is always false.

In other words, based on this patch and after initiailize all client
drivers, the clients' bandwdith request will be respected.

Thanks,
Leo

> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >   drivers/interconnect/qcom/msm8939.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
> > index f9c2d7d3100d..ca5f611d33b0 100644
> > --- a/drivers/interconnect/qcom/msm8939.c
> > +++ b/drivers/interconnect/qcom/msm8939.c
> > @@ -1423,6 +1423,7 @@ static struct platform_driver msm8939_noc_driver = {
> >   	.driver = {
> >   		.name = "qnoc-msm8939",
> >   		.of_match_table = msm8939_noc_of_match,
> > +		.sync_state = icc_sync_state,
> >   	},
> >   };
> >   module_platform_driver(msm8939_noc_driver);
> 
