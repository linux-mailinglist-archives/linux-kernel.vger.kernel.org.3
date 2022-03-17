Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BE14DD034
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiCQVaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiCQVaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:30:05 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF74642E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:28:49 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id t8-20020a0568301e2800b005b235a56f2dso4382405otr.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Wxg6FN4fidpdw1pUe2v+Gv21R1xMKjCVI2Ma6qmxE+s=;
        b=YI0XmL/YEuCwf0gr7y2Jn0qOvFsTIVkrGn7O2oXnejI1FzWaaAXICnzW6eT0NGBp0/
         t5S3QB5hQ5GCTqzWxSIARnPm/lnGHIa5r+7HF8e9E/1MY22QKIGbjLDP0pZWa/36heFc
         PB3PqmNMOxM64rqIgvtk5bgg6An62is7W7S3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Wxg6FN4fidpdw1pUe2v+Gv21R1xMKjCVI2Ma6qmxE+s=;
        b=1VR6Fz/VPklkcctOoQ1wx3vKtzyut/TrpskQEXv864KHdnxCxZAk3e6+j8PfATyMe3
         8tYrvTRuGaLuJdLwjFc6cPJA3gFkAjfcwnNv2wCW2OaKPwA+e73IS/+m3wmJRnmjJBm0
         QXhnLj/OjoGYm0lsv6ytkQUij8uXnMZGAc1rdbl4aOZPdkgp0jx5Izq/HQJg4+ujoxBK
         KYSm5l16QOCvVvnwCj45U8tp6gLH/9wM3PelfiadZrDTO0D2X0FYgxd9WiZvEcYD5NHS
         QrDNRNKRGpmdkC4NO0UCymsX7/q1CFNLK4RYsZWicxCIfsoZfO5HOQerqCPpppYEWH8L
         6fnw==
X-Gm-Message-State: AOAM531Wcx4KApYhWCinysF0N0IBgE07kanwV/thyaa2rdiTzPfauvof
        K2qX/12tIPpGw7f/rmZ8jIubTGN0r8yQBDuFsKocJw==
X-Google-Smtp-Source: ABdhPJzfKwOyCQB89/1kypJLAVwmpsZBjI2HMBT6fk9/KnCBqKd71dAxcwXBdFRDHPmVXDNHWkl2g1s53kSR7dGQ/iM=
X-Received: by 2002:a9d:5a01:0:b0:5b2:5b6c:232b with SMTP id
 v1-20020a9d5a01000000b005b25b6c232bmr2272582oth.159.1647552528145; Thu, 17
 Mar 2022 14:28:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Mar 2022 17:28:47 -0400
MIME-Version: 1.0
In-Reply-To: <1647452154-16361-5-git-send-email-quic_sbillaka@quicinc.com>
References: <1647452154-16361-1-git-send-email-quic_sbillaka@quicinc.com> <1647452154-16361-5-git-send-email-quic_sbillaka@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 17 Mar 2022 17:28:47 -0400
Message-ID: <CAE-0n51YMT76PTkfMV0dZ2d7e3mbObPvTo+AyuaTn4j0R3OwUw@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] drm/panel-edp: add LQ140M1JW46 edp panel entry
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     robdclark@gmail.com, seanpaul@chromium.org,
        quic_kalyant@quicinc.com, quic_abhinavk@quicinc.com,
        dianders@chromium.org, quic_khsieh@quicinc.com, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        thierry.reding@gmail.com, sam@ravnborg.org,
        dmitry.baryshkov@linaro.org, quic_vproddut@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sankeerth Billakanti (2022-03-16 10:35:49)
> Add panel identification entry for the sharp LQ140M1JW46 eDP panel
> with power sequencing delay information.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
