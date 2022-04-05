Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091694F49C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444182AbiDEWVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573514AbiDETPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:15:40 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C382ACC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 12:13:39 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e2442907a1so51731fac.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 12:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/VEnoCaZjFOo1hZqbQ7Ci/5Mc9ryrDgtQbWAG7hNyU0=;
        b=A/1qf7BbZUl1nmRh5JeC1do1E/AoxVrrESzKjs5JN8wc9kJc2jE3EKXyU26FmHYT4r
         iuDfd+Mpfwm43TRLzvNir+bbEnPdO+jPfmvCNjmPWSPYnw8bzyYc3a73jD8tKeKczzx2
         yj28F1WjiEl3py3lufVGH1pWx8bNdTTsy+/l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/VEnoCaZjFOo1hZqbQ7Ci/5Mc9ryrDgtQbWAG7hNyU0=;
        b=3XcSO7PcT1jQp7b3VVVFCZajZk/Qq9VlF3T9YDt5QOQUUapQtmCSrZwhiKgWXnoghl
         rJwRA4SnGn9OxXmAtKfpxb13AyY7n/YdbaYRugIrGdwevO8pU9g0yLHzkLXCJTlpe+ga
         OVXsQ6J/cxpeVcqIt4cWYHe4O7JdmRvTUCa6kp98e//hX5zFo9YuMripEEgkBHVztiwH
         7MIVlfLaSuw+HV0iUV5SPwQ8wAkLC5KuTsNCtE2bL0SC8c+NkxwSXAuuHojXQByPvHa3
         utWcmrGbnR461tvzVkGGoNDiVVhME2pZw2d9mG1qX2qFS/pTmLM3QpZpAox/zv4fZCYp
         0wCg==
X-Gm-Message-State: AOAM5321tha8ZT0ZjEXw2LEMGvV/sYSACja1dfu5kIYligxGMVS+TKko
        +QmUCRfBNxUT0hu2JereLdZzPUJi6u5FCN7h+iOjKQ==
X-Google-Smtp-Source: ABdhPJxMeOCBNonGhe12RIMQhBsmKmz4+eeLcXo3B3LH/I6ufXRjo0AnY+6+x4Cpq9JsTlow69/cyx8VwwptYXUvcVk=
X-Received: by 2002:a05:6870:558e:b0:e1:db7c:26aa with SMTP id
 n14-20020a056870558e00b000e1db7c26aamr2278460oao.63.1649186019201; Tue, 05
 Apr 2022 12:13:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Apr 2022 14:13:38 -0500
MIME-Version: 1.0
In-Reply-To: <1649166633-25872-7-git-send-email-quic_c_skakit@quicinc.com>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com> <1649166633-25872-7-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 5 Apr 2022 14:13:38 -0500
Message-ID: <CAE-0n53aTMTAyNXQ9p1cP59N+02xEwTmZhsVMTqNUs_ZTWGZaA@mail.gmail.com>
Subject: Re: [PATCH V9 6/6] arm64: dts: qcom: sc7280: Add pm8008 support for sc7280-idp
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-04-05 06:50:33)
> Add pm8008 infra and regulators support for sc7280 idp.
>
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
