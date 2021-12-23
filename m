Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE94747E5FA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 16:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbhLWPqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 10:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349012AbhLWPoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 10:44:08 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11256C061398
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 07:44:05 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id t19so9521266oij.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 07:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1fwwSdyPDmJrjBqvgfhWwK5/B7Z6WVD41tKc+tzuI9Y=;
        b=dfU8NCEFlprLJHJEnCF6GvLWjBULr43g9OU81r0AUa9LnF5soLHnnoLtxdr8XONYSH
         C/RYV2mnCnBOKX8CGIb8QuE7kZx6jLyD1YV1fLS2L7aFzCwbD69oB0U7aIgcbXNpP46I
         +ReOE0AdcG8IMWnbJoVE0QUaHbaG65dY5qafFidaGCrazhXNSQXMYzbkBeDevFlbxlMV
         I6Vg4tviMMWeEtxI36zdQYyr3mRxOOLd8Pvjzq+DJojdMdV6ZRxczrDmxcP4gA2TtvFF
         RwfstC2ObrYklB59q0m2SSrlZsecOtXx93uleV3cIvJJBeosm+c2kG3epevi6hfc69SJ
         US8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1fwwSdyPDmJrjBqvgfhWwK5/B7Z6WVD41tKc+tzuI9Y=;
        b=4ChDmhwMvqIUUZMtP3tNezvQ08L/g45XBimXPicmbTg495WTBvqmIlg2RaaLEwyaGh
         IzKqKL+k2fPKNu5ivjQiMbotJPVFBEAT/B5EQMuHR4t4y9SgPVPceBTaoOVizF6pim+j
         AeATrv9YF2q6oGS0JdBJaAUiSQ5ZQhMQeyNOBzDoUgM3AqbWy1MtH3QNdbaWvRzTZCHa
         lX0zR3WJPQ70LVT7qq1MNNY0zvF1wKCVptIClS3HLhKoSNwfr7dsCPngc/bCAkGNcS1h
         G6AsVRggTLjPKUkz2n2A5ZqwG4GT/P/JchKciHKspXF3fvo9lNdkN6Iyclqone0Lhwc4
         toDg==
X-Gm-Message-State: AOAM531GeJNg+utCAg5Kqbf5ghj2CIq5xY7NBCLf/zhSUuJdzNT2Krti
        H+zHf5VXIg9M7ciihvFe+oUVsQ==
X-Google-Smtp-Source: ABdhPJxpfqDKnPz1DYcgUZ1ElZ07nh0if0gtDDDecukFbgK146Ktyx9xjHphpVLEvAsxxRcKVDyH5w==
X-Received: by 2002:a05:6808:aa5:: with SMTP id r5mr2081321oij.119.1640274244080;
        Thu, 23 Dec 2021 07:44:04 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a6sm1055762oil.6.2021.12.23.07.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 07:44:03 -0800 (PST)
Date:   Thu, 23 Dec 2021 07:45:11 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     agross@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        manivannan.sadhasivam@linaro.org, olof@lixom.net,
        quic_vamslank@quicinc.com, robh+dt@kernel.org,
        sboyd@codeaurora.org, soc@kernel.org
Subject: Re: [PATCH v3 0/3] Add devicetree support for SDX65 Modem and MTP
Message-ID: <YcSZh8racQsDiF5O@ripper>
References: <163960723735.3062250.7838330411965052999.b4-ty@linaro.org>
 <20211223144407.GA6503@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223144407.GA6503@standask-GA-A55M-S2HP>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23 Dec 06:44 PST 2021, Stanislav Jakubek wrote:

> Hi Bjorn, it seems to me like a patch similar to Patch 1/3 was applied
> some time ago, see 61339f368d59d25e22401731f89de44e3215508b, and applying
> this patch has caused the compatible to be documented twice.
> 

I'm confused to why git allowed me to merge patch 1 without complaining,
but that obviously shouldn't have been merged twice. Thanks for
reporting this!

Let's clean that up, would you be interested in submitting a patch for
it?

Regards,
Bjorn
