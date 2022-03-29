Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5934EB680
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbiC2XLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239470AbiC2XLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:11:39 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F918EA76B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:09:55 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id g8so15384029qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aEhUDD4h6uAblZYdEqK3WfYH78cRJFucwHHJvJpj9po=;
        b=w8xu9XnmFHc5caQlAGfwzcIkBfTpogJyC/Z8FpIG+9cIP3gR2zRYtoUaWiHzPZuBsG
         HQneZzTbvoXPu2yMmtyeQNis5QeWwbocvt4HHrIwN1RV7UyzTATwZqwmcVPtC3dwZslc
         9PIYisICUth6zmHVftQ0am2evsMdXpXbWvEdj0OMz2hq3Z69aKjuLLiB6H1NHl8H61pt
         DxIR5dTh4zN8XlngUUjGIa8DNvHTNSNAmPEAIF/kooUnJlwwjGwjm5vQgiu93BCwCMln
         DoFcFIGw+hHrOX0v52ma/X2KnyWqF/28Q3ofS1EWuLHZpJ6K3IsfC17RX2fsgBu/RWf8
         uOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aEhUDD4h6uAblZYdEqK3WfYH78cRJFucwHHJvJpj9po=;
        b=OL8XgzbesH1FotojmFXTSsNwpGSUWXlcb60wj5CHwKpsXtx2LVM4tzlGPuosTu0lmH
         h93IwHHe9rhNCm2EchAwBdkpd/mklzNxn3uvigwu0cSAJyMCsn43kKVxrM8q/ZY0NETS
         a+0rRf0IHE5KlpbpIRVB0uu+qdkwZqkko855vNWqTAGo3jsGNcVuA2gcqv/TdeY2EQWl
         hso225McCklUZnIBrFhs4ydxjRuvlzfICz0CsvtVakiMvYCL6GfjdK2kvfzIJMCiLXd8
         S+YUtTeykx8+8qDxuu9HqkoYuU07upxgasIcKPwwWYnpYVe5M8JZp7MYkwDMr2+b172H
         XtiQ==
X-Gm-Message-State: AOAM531psD5fbxbHWK6Rk0arrycXyvO+MQSfucHgChGgb/CJgMFc7ajR
        +5QaNqdgdLcYpJ1oKZ+CNbEwl+MGvF3NJFVwNs8+PtIwLwE=
X-Google-Smtp-Source: ABdhPJyLdObA37xboAWKWrjWol8cD8HdyMOGLCYHULnJO8ksydrxdWJIytU1sr7bpMvVWokokD9NAS8l5HilJGmwql4=
X-Received: by 2002:a05:620a:2442:b0:67f:65f6:bad2 with SMTP id
 h2-20020a05620a244200b0067f65f6bad2mr22390896qkn.203.1648595394698; Tue, 29
 Mar 2022 16:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220329230105.601666-1-robdclark@gmail.com> <20220329230105.601666-2-robdclark@gmail.com>
In-Reply-To: <20220329230105.601666-2-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 30 Mar 2022 02:09:43 +0300
Message-ID: <CAA8EJpqnS1qJS9CkR6s7nBSJcfL=i-gvX+PSpajoQOK6FmuWjg@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/msm/gem: Move prototypes
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 at 02:00, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> These belong more cleanly in the gem header.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



-- 
With best wishes
Dmitry
