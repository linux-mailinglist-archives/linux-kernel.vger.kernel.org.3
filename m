Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7586353406F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241234AbiEYPfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240418AbiEYPfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:35:21 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86501A3B4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:35:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y189so4460350pfy.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8yJ8zmWYb/frhf47dyKyk6P508V51FYED+q/rbYojp8=;
        b=NLIBIFGw8WzdD4xISp5HOF7noQo/I9wqMnLnea//gErjyDuNLIh5XvbcvbBv/jS77z
         1DrKo0vMj7sxu+DVIMw0kT0Gq4+h7P2zSF2YQbJxKECb/TL0mZ63m373tva+LRM8eRvb
         SUR/A33tvLbp0EvuN8ztfB9JkbSV9Kq3jZH+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8yJ8zmWYb/frhf47dyKyk6P508V51FYED+q/rbYojp8=;
        b=PBivU0eSaIo+W4JFoK1DuY/yLBaQz525/UlZRmSSH9PgOumimiSyfv+ZbAmRwj/c4u
         QKNpiPMm/fwai1qWJqrbcZMOdGZ/1dg2fVjvkSq8nED4pyZCyLPr+CUdxHvZmmWPHiOf
         RQvBjIlkieXE57ZYl0pW+3uP7gAozZqmiwb8yKCby5vJ8m8A0mGGqCM8ZBe2l4nuZhmM
         nULf5q+qPvXYVHU5f42GbcaGzLbNbsTP/SAHUlURETtXDXbORzwTZt5AP/q+CBXnN762
         ydhVwopvFhqULBFHzWaJnErejxz/+VGAe7u5ZUijMM4etnvyQX8U/9N/NFsyJnBey+TB
         wgig==
X-Gm-Message-State: AOAM533CHNi1UgwZbOKM4ZBw9avz5zG1tp7diEqxOnaVTiakTPRjHi4C
        9PELJHcfCXPzk0oP9faAM9vLdA==
X-Google-Smtp-Source: ABdhPJzMVksqNiU4x1P1v8U0C///HyFEuqhGrs9xzkZl7KBKQ5PKzmSj42Izc3FPcsPfEal9GSTNEA==
X-Received: by 2002:a05:6a00:1487:b0:518:b952:889b with SMTP id v7-20020a056a00148700b00518b952889bmr12193598pfu.43.1653492919381;
        Wed, 25 May 2022 08:35:19 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:4d83:f549:9abd:427])
        by smtp.gmail.com with UTF8SMTPSA id g3-20020a170902d5c300b0015e8d4eb2b9sm9510599plh.259.2022.05.25.08.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 08:35:19 -0700 (PDT)
Date:   Wed, 25 May 2022 08:35:17 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, cychiang@google.com, judyhsiao@google.com,
        tzungbi@chromium.org, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 2/3] arm64: dts: qcom: sc7280: Add
 sc7280-herobrine-audio-rt5682.dtsi
Message-ID: <Yo5Mtfvmk8EZGHg8@google.com>
References: <20220525014308.1853576-1-judyhsiao@chromium.org>
 <20220525014308.1853576-3-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220525014308.1853576-3-judyhsiao@chromium.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 01:43:07AM +0000, Judy Hsiao wrote:
> Audio dtsi for sc7280 boards that using rt5682 headset codec:
> 1. Add dt nodes for sound card which use I2S playback and record
>    through rt5682s and I2S playback through max98357a.
> 2. Enable lpass cpu node and add pin control and dai-links.
> 
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
