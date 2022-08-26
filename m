Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0545A291A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344391AbiHZOJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344425AbiHZOJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:09:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56660C7434
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 07:09:06 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d8so2194529lfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=/jvB3Zk9Ur35ndfTH3ClegVJp3L5YsswZJHu0HBwLYs=;
        b=jQx3CjsoG4/KqyBTEu7I7zus+LfGm5o2i5DJwYB8PEnBnlqdKMQzoZvzit0d6HbeH0
         792OCLK+089fkSLzsDQuf2cforIA6vpukpmf76nehp/qDWBuiYMLjsmWpN7WNH5AxDdU
         qpnOWvv9wKrOoyONFNZu8kA2YQFNeacvY52jZO1JOzAfRuPnJ64iqc/6Bj7UjCoJT6WC
         zyeDGn0/ILk/Tj/GtHLoIKMB53JY16zqhRiRyTuqu7Y39WVoUVn4D7QLzoexl5+rPLhO
         uOcCOqIghY4npZvkgBcYBxMGS4rUzVeEnIKhbPm0++/HPXlt1SnjdlVgM4xqrUkhK7kO
         o9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/jvB3Zk9Ur35ndfTH3ClegVJp3L5YsswZJHu0HBwLYs=;
        b=hdbojvtX3RA1sKLMnDnEuDH62a6d9AScNd26c9kF/+nkyz8YkblljSb1gI3TzZkNgF
         ahaLqnrbh36/uYDs+o+nRjV0GFhhRXWYJC1xz4bQ0xuVLj6H0mwbGiA5FuoAbw9n+3KX
         CQOmg+YLmT80F1tuhw8D6LgOSh4gyS3RJivn1YZNvvQ6LN30HWRjWjqR4No8RGq8pFJX
         BVM1GSGuNQLqQ14ifuP4ObofkYfzY4UhWvs8X/0yF0/jZmU5ppMIYfDbIndYbXJQIOsZ
         EQ/8WWmGXr5qVDiI50x6gd6g3bBqLS68xFjZOsndCuN/Aj1U+KpFQMqKu4IIMDG3yTaV
         wTdQ==
X-Gm-Message-State: ACgBeo0ceSYexAKOV4YWTQ1wVSa4n7vdYayGCI++jxDj8LslNRBZBy+7
        lTjoDXKh+gMxGxbaONwAPBl7mQ==
X-Google-Smtp-Source: AA6agR7HiAAjmQ+OSdNfaAHoyknzoyrjx3MUmL1Ng+Vf6qRLQP4g75Bp3THQvj6bRqHPWOxdn6lnQw==
X-Received: by 2002:a05:6512:68d:b0:492:ec42:1dd2 with SMTP id t13-20020a056512068d00b00492ec421dd2mr2597519lfe.55.1661522944058;
        Fri, 26 Aug 2022 07:09:04 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s10-20020a19ad4a000000b00492c017de43sm390763lfd.127.2022.08.26.07.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 07:09:03 -0700 (PDT)
Message-ID: <37834264-f6a0-fe71-e4c6-2edca9475d5a@linaro.org>
Date:   Fri, 26 Aug 2022 17:09:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [v1 2/2] drm/msm/disp/dpu1: enable crtc color management based on
 encoder topology
Content-Language: en-GB
To:     Kalyan Thota <kalyant@qti.qualcomm.com>,
        "Kalyan Thota (QUIC)" <quic_kalyant@quicinc.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "Vinod Polimera (QUIC)" <quic_vpolimer@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>
References: <1655802387-15275-1-git-send-email-quic_kalyant@quicinc.com>
 <1655802387-15275-2-git-send-email-quic_kalyant@quicinc.com>
 <CAA8EJponMDAXDAZ9zpkYEZvONDAztuXhjwZ6y7rgo1HtQOMtfQ@mail.gmail.com>
 <BN0PR02MB81426CB90870085223C308A496B99@BN0PR02MB8142.namprd02.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <BN0PR02MB81426CB90870085223C308A496B99@BN0PR02MB8142.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2022 14:56, Kalyan Thota wrote:
> Thanks for the comments, Dmitry. I haven't noticed mode->hdisplay being used. My idea was to run thru the topology and tie up the encoders with dspp to the CRTCs.
> Since mode is available only in the commit, we cannot use the dpu_encoder_get_topology during initialization sequence.
> 
> The requirement here is that when we initialize the crtc, we need to enable drm_crtc_enable_color_mgmt only for the crtcs that support it. As I understand from Rob, chrome framework will check for the enablement in order to exercise the feature.
> 
> Do you have any ideas on how to handle this requirement ? Since we will reserve the dspp's only when a commit is issued, I guess it will be too late to enable color management by then.

I have been thinking about this for quite a while.

Basically I fear you have two options:
- Register the color management for all CRTCs. In dpu_rm_reserve() check 
for the ctm, allocate LMs taking the available DSPPs into account. Fail 
the atomic_check() if there are no available LMs with required 
capabilities. Additional bonus point for moving LM/DSPP resource 
allocation from dpu_encoder into dpu_crtc.

- Register CRTCs and it's colormanagement properties according to exact 
available hardware. Let the userspace composer select the CRTC for the 
connector basing on the availability of the CTM support.

I'd vote strongly against any attempt to put the policy ('e.g. enable 
CTM only for the eDP and first DSI display') into the kernel, because we 
can not predict the actual usecases the user needs. It well might be 
that the user of the laptop will work with DP displays only and thus 
require color management for DP.

> 
> @robdclark@gmail.com
> Is it okay, if we disable color management for all the crtcs during initialization and enable it when we have dspps available during modeset. Can we framework code query for the property before issuing a commit for the frame after modeset ?
> 

-- 
With best wishes
Dmitry

