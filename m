Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564CA5399A5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348509AbiEaWpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348370AbiEaWpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:45:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E00A941B0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 15:45:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c2so74262plh.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 15:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=soARJzRFwOfhwTqrBSydFb3eTupZIjHh8aanzENDqGo=;
        b=DaKQfesYBWgMZS7l6hauTnBkeXrAsQpWA/SrcfUqCE0Jk4qdRiF75ZMTR83iBzuuYb
         fZRaI6d6CGmjdZvTf1XfnpxRg6+9uxbyuYj8W212jJKJwO0H5Q8JCZsEUXaTgbnncO8e
         68/DQDnpbAPHgVI4YRXeZEkkotc9NHonbRnCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=soARJzRFwOfhwTqrBSydFb3eTupZIjHh8aanzENDqGo=;
        b=3BebNQCgYgN9eWs3x8eFnzh2yHmQJV5cYrrnRvYPB/KMyTi3aNEkBM6+728czZzeDe
         Qv4PdoAMcjByQZih5aJGDbSKOufVChmT8vBVvniCzjewMwf171zLrf+boilQmeqYMO3i
         B2jnAtkDhgodRNKzUDq8J9VJWuHCW4AVue4wvt4ea5rLzmukx4LL/QwiJqDtcwJulCDF
         TGX8okSucu5k/fvI/MSF600hplhfp3fVCK1JMpqkZyFJAtWYWXoKal/AmYDmh0kJDzc2
         btWfrF/fMeU5qaRwYQEm6QZxRr6+jsRPO06g1cfyXQK7FsbOECRUJ2ainvhwGvZJQU72
         P3RA==
X-Gm-Message-State: AOAM5315r7d82qgF/n/Xyarg+uAIn0LVIvIqS36GeGyhichGqv0gUVHw
        WLn7VX4HvfsQl/+SwjOq4K4CwQ==
X-Google-Smtp-Source: ABdhPJyTCi9SCIMWA8MxQeCs0arVYqIWniU4YSwlTCDLay/lcWhIyE3cl9uw5pVBbFSzBMIbvLLvjg==
X-Received: by 2002:a17:902:f70a:b0:153:88c7:774 with SMTP id h10-20020a170902f70a00b0015388c70774mr62719133plo.166.1654037121967;
        Tue, 31 May 2022 15:45:21 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:e69e:f483:e751:7c7c])
        by smtp.gmail.com with UTF8SMTPSA id 19-20020a170902e9d300b0015e8d4eb1b6sm87043plk.0.2022.05.31.15.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 15:45:21 -0700 (PDT)
Date:   Tue, 31 May 2022 15:45:20 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Taniya Das <quic_tdas@quicinc.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette =?utf-8?B?wqA=?= <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: Add resets for LPASS audio
 clock controller for SC7280
Message-ID: <YpaagHNk38FLWLVO@google.com>
References: <20220526042601.32064-1-quic_tdas@quicinc.com>
 <20220526042601.32064-2-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220526042601.32064-2-quic_tdas@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 09:55:59AM +0530, Taniya Das wrote:
> Add support for LPASS audio clock gating for RX/TX/SWA core bus clocks
> for SC7280. Update reg property min/max items in YAML schema.
> 
> Fixes: 57405b795504 ("dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280").

git show 57405b795504
fatal: ambiguous argument '57405b795504': unknown revision or path not in the working tree.

I suppose you mean:

4185b27b3bef dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280
