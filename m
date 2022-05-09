Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5A951F907
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiEIJh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238243AbiEIJfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:35:40 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587D11E028C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:31:47 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 7so11528465pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 02:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JpCRaDNZYevpLkY4KOz+K7YSl/uzka5d9oakp3W77tc=;
        b=HCmVcQ84A1B0mzXMIys8FhK9PENXHAKemAfPPPxoXKFdSh1QQXAzaPKVIqUEZLBs3/
         H3pOb5uEAcuA5+F3hsUEogfhE/lRjNABeErSGu86+1ArNxEujpz8rVgWRX6v8tqEHwvx
         0Xqpg/6Ry0GYJyosH55MLUfXrVeFOeBbGMK0uDInQXOaKGgdh2bcfZdABop9RngLLwa+
         byDloH8cGSO4Dgs0GAKgT2GGWD3uNvjIr77nTWojR1RPoerG/QTxBZopGJZ/enkgNXjI
         JKPl1sWprQahCNAmvlKDtaIJKpENBTMrQIA16/z2HPN40vin7eLoO7VkkbrQPSCVNvLk
         7pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JpCRaDNZYevpLkY4KOz+K7YSl/uzka5d9oakp3W77tc=;
        b=Da2vqOaAz6xpoPlB77z104oVMzlC0el2QH+f+VohjxQSUnDWKgBsb2tgD+0wsHXxxg
         4EuBflnZplsvHH3DRyeAA6ZvBHh+HlTRy8SbUllnvbyhWD48zygJjLET4ZT6YWQEzusp
         M7VopKecLjuHl3/VFnfAus4k9S9DRlIo3EcvTi4Egp++IiZPlqF6dhddyMk8Alh+fYWl
         S13vhGhhC52BRJv+zSA/k3MT0RtesWxnDSLX09w/gizWUgFK1A+dyRtAbqGHxX6ZJUeM
         duQzQIQoXidAK8YFhgZ63W+DH9FTwI1L8NmJr73vnoza8cOssL8Ybf3HAZz410YzEoAE
         K24g==
X-Gm-Message-State: AOAM530bFgkZZ6ZElUCDN8gho7XNWXmyaN4eEDlG+1+8uFlNBUulb+7i
        SJdUNMIbTDnss6umpMnauT0qVQ==
X-Google-Smtp-Source: ABdhPJxdD04mCtOjOZoG59KlHgaCvKklPPxlk10wG2ZHb2KCQ4qNWZv9oKioDl7bTyyCDTPNP632lQ==
X-Received: by 2002:a63:ad0c:0:b0:374:50b4:c955 with SMTP id g12-20020a63ad0c000000b0037450b4c955mr12237883pgf.530.1652088692871;
        Mon, 09 May 2022 02:31:32 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id n28-20020a056a000d5c00b0050dc7628148sm8110335pfv.34.2022.05.09.02.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 02:31:32 -0700 (PDT)
Date:   Mon, 9 May 2022 15:01:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     qianfanguijin@163.com, linux-sunxi@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] drivers: cpufreq: sun8i-r40: Add cpufreq support
Message-ID: <20220509093130.jegqpe6m7xtbouqa@vireshk-i7>
References: <20220509084853.17068-1-qianfanguijin@163.com>
 <20220509091125.tps3zwaq276jlgh3@vireshk-i7>
 <20220509092306.22ttfunrislztbvh@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509092306.22ttfunrislztbvh@houat>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-05-22, 11:23, Maxime Ripard wrote:
> Hi,
> 
> On Mon, May 09, 2022 at 02:41:25PM +0530, Viresh Kumar wrote:
> > On 09-05-22, 16:48, qianfanguijin@163.com wrote:
> > > From: qianfan Zhao <qianfanguijin@163.com>
> > > 
> > > OPP table value is get from allwinner lichee 3.10 kernel.
> > > 
> > > Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> > > ---
> > >  arch/arm/boot/dts/sun8i-r40.dtsi     | 47 ++++++++++++++++++++++++++++
> > >  drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
> > >  2 files changed, 48 insertions(+)
> > 
> > Applied. Thanks.
> 
> Shouldn't you wait for the maintainers feedback for the DT bits at least?

I should have, will drop it.

-- 
viresh
