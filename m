Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDAF4B02CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiBJCAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:00:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiBJB7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:59:18 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C301E237CC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:32:58 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id m10so4479249oie.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 17:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=q0gKDIsiyMqWkXyvkq/+svnrm1y23JpiuzMilVu9Ius=;
        b=DKDmTebOwujuEVOEYAIbmjmg3P3hB/e0sZkC2WNy3aKmoj6Fbhk1e+RB0DL1EvhaRd
         gYoPKtMaIn0q313Ix1AOmQcoQECjwv/dG9yk2Y74K6eoPmRTdg1BN0LEy0wfoxAAB2Ex
         Qnc8r2LK64QUAUngSXNpl7jBO9m3RU6Awim1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=q0gKDIsiyMqWkXyvkq/+svnrm1y23JpiuzMilVu9Ius=;
        b=148LGuiyf2IPLpjpovW6hO/cFkZLT57l32UwDIHyV6lPvgU68PqzbXrBm1QgrVvMPh
         PxoA+OxhPskRkC2vRxs61TtpeQIV0mi2A8SEDvg/c1uljQilwJWkp1IBp/CP8ZV7nxgW
         MsburRqnFeQxNTDw1VFfnf/a0fK3FQRZAWasEXM19S5+wgcf/Xn+ETvz1oTUqZw5PTcP
         f/yGT8goMB8JKf9CUbealqJU25UIYxx2K4SXPBTQDvYxRlXQWd6wVAxqyY6G5SjFyIHL
         Ie1/R0dOS0iM9RsmwnqzH0a/HxOPFPyIWHneOrya7aKZyakREWu+Dgy1nft3trN67v05
         ct3g==
X-Gm-Message-State: AOAM531xli5Xy3hJEgXNTjihIEng7dGaZjxMcQKQjXQ2GPvTkyM8tD9k
        4HJh57U5XFo9n4g6hh8jV8pzF/teCxvCx9NLUcvd8ej9YrA=
X-Google-Smtp-Source: ABdhPJxWIGoi2bu5HsbIoqhVEA+uTuk5expb3ePJZiNpncXPqK6tZKEzccDytwMyydD4k+qybrXLdIbxmOnYj3gsf5g=
X-Received: by 2002:aca:df82:: with SMTP id w124mr46141oig.112.1644455366752;
 Wed, 09 Feb 2022 17:09:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Feb 2022 17:09:26 -0800
MIME-Version: 1.0
In-Reply-To: <1644396932-17932-2-git-send-email-quic_sbillaka@quicinc.com>
References: <1644396932-17932-1-git-send-email-quic_sbillaka@quicinc.com> <1644396932-17932-2-git-send-email-quic_sbillaka@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 9 Feb 2022 17:09:26 -0800
Message-ID: <CAE-0n52X2k-6pA8o8cciknEPjr3uR0J50-wVmO0fmeWgrLm=fw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: display: simple: Add sharp
 LQ140M1JW46 panel
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        agross@kernel.org, airlied@linux.ie, bjorn.andersson@linaro.org,
        daniel@ffwll.ch, devicetree@vger.kernel.org, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        krzysztof.kozlowski@canonical.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        robh+dt@kernel.org, sam@ravnborg.org, seanpaul@chromium.org,
        thierry.reding@gmail.com
Cc:     quic_kalyant@quicinc.com, quic_abhinavk@quicinc.com,
        quic_khsieh@quicinc.com, quic_mkrishn@quicinc.com,
        quic_vproddut@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sankeerth Billakanti (2022-02-09 00:55:29)
> Add support for sharp LQ140M1JW46 display panel. It is a 14" eDP panel
> with 1920x1080 display resolution.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
