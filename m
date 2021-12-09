Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7EE46EC62
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbhLIQCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbhLIQCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:02:33 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3781CC0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 07:59:00 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id be32so9209493oib.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 07:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WEBXCg63/1ndpAn4Hf4CWTdEmyqEB2Cq5tKcfasSKaM=;
        b=MTMyKanHvXgcpD5Y4aoLcpiV9BABi6Fv9K3SZSoi81WY3g4hxC5xr5SD/DIRE68C9g
         a6yR80YU3CaktwS99Yxx74NFE+PFP/ItG9o9HXMSVbSxqkxy1Dlw5bTyziPsh8t8FFa8
         ksYoetY4N7bxfS81/IKH6BqFarz7fiMqUmagKWw+0D+VBm5x1x2NT3tnGmFdqyGONXLW
         8AHFZdDWbjGR4Egw5gju/fxBnjqCb0gZMj4UolHhoMp0rTqU8h/RZWZ1amXlZu9Bp43S
         UZo5wFbo6vEUkrXDRqQ/SOvHkKrYClGmOJ1J8iodXEklJVLd5Et0P9H82YoyfptiHMNV
         KQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WEBXCg63/1ndpAn4Hf4CWTdEmyqEB2Cq5tKcfasSKaM=;
        b=l3CPvOSO8d5BIGvAZ6sUl5lCa7n+q56zJuMq3RX0QpekxcAti3wlmUgLfwsMwA4UTr
         xTNEzOqP8YLpxyt2Wj21kJdjTw/N4pjz9Ajv20tnwQ7OVSaVK47Z8kltJNNVIIJQoCn2
         yYWSX55ix0ZQwO70Sh/JLRE3EvfSAolR0H8DrnfkXQH/VqknldXRld+gKFjBi4x7BFsQ
         2sCcQ97JgHAfjFWrIeXRDE26DTXu54TM1Bo1bMuyDHRgkFvsJncwVPR3jVXYFcesfW4N
         xwP8AG0ms+7VK7NZVRKtCRFPorC2QHP4JJ2U1Hja/Y0WtRVEbjJ06Ag7xZ5S8tz+oyMn
         xYVQ==
X-Gm-Message-State: AOAM530tov8KFqJQ7kCnUsKkkFuRKKw5OdVlnP1NI7gaBQcn9csMJmmk
        abesz8BfnJClu2ohdazUgcT/oA==
X-Google-Smtp-Source: ABdhPJzGy18u+6jGOo7I/JChqTU/nV/2Mtb8tEVBIKC9A/gytWXK4d97gYg2XHqPsCXWke/d2zZQ4Q==
X-Received: by 2002:a05:6808:1210:: with SMTP id a16mr6470172oil.161.1639065539512;
        Thu, 09 Dec 2021 07:58:59 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a17sm55207oiw.43.2021.12.09.07.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 07:58:59 -0800 (PST)
Date:   Thu, 9 Dec 2021 08:00:22 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org, mka@chromium.org
Subject: Re: [PATCH v2 2/3] soc: qcom: rpmhpd: Remove mx/cx relationship on
 sc7280
Message-ID: <YbIoFjh9QbdsPnQh@ripper>
References: <1638871712-18636-1-git-send-email-quic_rjendra@quicinc.com>
 <1638871712-18636-3-git-send-email-quic_rjendra@quicinc.com>
 <YbEYyGHqaHGeRXsV@builder.lan>
 <7e9f6cbe-17c9-53ff-95a8-2f2bbdeb1d23@quicinc.com>
 <7b8f359f-de8d-4ace-d28d-8242683e1f8c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b8f359f-de8d-4ace-d28d-8242683e1f8c@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09 Dec 07:37 PST 2021, Rajendra Nayak wrote:

> 
> On 12/9/2021 12:29 PM, Rajendra Nayak wrote:
> > 
> > On 12/9/2021 2:12 AM, Bjorn Andersson wrote:
> > > On Tue 07 Dec 04:08 CST 2021, Rajendra Nayak wrote:
> > > 
> > > > While the requirement to specify the active + sleep and active-only MX
> > > > power-domains as the parents of the corresponding CX power domains is
> > > > applicable for most SoCs, we have some like the sc7280 where this
> > > > dependency is not applicable.
> > > > Define new rpmhpd structs for cx and cx_ao without the mx as
> > > > parent and use them for sc7280.
> > > > 
> > > > Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> > > > ---
> > > >   drivers/soc/qcom/rpmhpd.c | 18 ++++++++++++++++--
> > > >   1 file changed, 16 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> > > > index c71481d..4599efe 100644
> > > > --- a/drivers/soc/qcom/rpmhpd.c
> > > > +++ b/drivers/soc/qcom/rpmhpd.c
> > > > @@ -120,6 +120,20 @@ static struct rpmhpd cx_ao = {
> > > >       .res_name = "cx.lvl",
> > > >   };
> > > > +static struct rpmhpd cx_ao_no_parent;
> > > > +static struct rpmhpd cx_no_parent = {
> > > 
> > > There are multiple variations of how each of these can be parented, but
> > > only one way they can be without a parent. So how about we turn this the
> > > other way around?
> > > 
> > > I.e. let's name this one "cx" and the existing one "cx_w_mx_parent".
> > > 
> > > 
> > > This will be particularly useful when you look at mmcx, which on
> > > 8150/8180 has mx as parent and on 8450 has cx as parent.
> 
> I noticed mmcx on 8150/8180 does not have mx as parent, nevertheless
> I went ahead and moved to the _w_<parent-name>_parent suffix because
> it made sense if we did run into a situation like this in the future.
> 

You're correct, the 8150/8180 mmcx are wrong, let's fix that once your
patches has settled (probably later today).

Thanks for cleaning up the driver!

Regards,
Bjorn

> > > 
> > > 
> > > PS. Unfortunately I had merged 8450 since you wrote this series, I tried
> > > to just fix it up as I applied your patch, but noticed 8450_cx and
> > > 8450_mmcx and wanted to get your opinion on this first.
> > 
> > I agree that sounds like a reasonable thing to do, I hadn't looked at 8450
> > so did not notice it, I will rebase my patches on top and repost.
> > 
> > > 
> > > Regards,
> > > Bjorn
> > > 
> > > > +    .pd = { .name = "cx", },
> > > > +    .peer = &cx_ao_no_parent,
> > > > +    .res_name = "cx.lvl",
> > > > +};
> > > > +
> > > > +static struct rpmhpd cx_ao_no_parent = {
> > > > +    .pd = { .name = "cx_ao", },
> > > > +    .active_only = true,
> > > > +    .peer = &cx_no_parent,
> > > > +    .res_name = "cx.lvl",
> > > > +};
> > > > +
> > > >   static struct rpmhpd mmcx_ao;
> > > >   static struct rpmhpd mmcx = {
> > > >       .pd = { .name = "mmcx", },
> > > > @@ -273,8 +287,8 @@ static const struct rpmhpd_desc sc7180_desc = {
> > > >   /* SC7280 RPMH powerdomains */
> > > >   static struct rpmhpd *sc7280_rpmhpds[] = {
> > > > -    [SC7280_CX] = &cx,
> > > > -    [SC7280_CX_AO] = &cx_ao,
> > > > +    [SC7280_CX] = &cx_no_parent,
> > > > +    [SC7280_CX_AO] = &cx_ao_no_parent,
> > > >       [SC7280_EBI] = &ebi,
> > > >       [SC7280_GFX] = &gfx,
> > > >       [SC7280_MX] = &mx,
> > > > -- 
> > > > 2.7.4
> > > > 
