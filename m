Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5D458DC29
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245102AbiHIQfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245053AbiHIQez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:34:55 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EE820BCD
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 09:34:54 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10e615a36b0so14607772fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 09:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=6LR5d866oe6PIinAHHUItmicfDWEx4Jz1iksYtzFN5g=;
        b=Evi/hpBZLqwm0d4VhPxhjrQrCNOjsJcpxTkjJTmb0ttychMFqGRQziKhQC9RbzzZDB
         M+YLvlTz2Ue1ZF4Lc7qvMYfzhXY+600SSD+Myx7hqkozF7FAP+n6/XNFexcrK+rBw/jg
         aui7glwMycfA6XXUO/TfRydb5c+7229tbR0hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=6LR5d866oe6PIinAHHUItmicfDWEx4Jz1iksYtzFN5g=;
        b=ts7vrc9vdhQdbPkouFZ8gAXoOf40xeeN07ho4RZkF5Wz3Nery3y+nAxhdZzTLrkpOT
         S0q+gaMuiEEe3juNMIBplgg5mLu3SA148U6nmOKxFbr9GhEtEPVqi1FPYsct9BN+ifLH
         bnPpwUcGrNCLNiBp4I7hkEmQlHALQqi35YYR9KSeXDuRSiHTYAHPQE6gF9i/tzKiBrkJ
         KFiKqqJg2wX0Y9sOEsxdTBi3UKfUxPR783Bx4XCPkV1LhegacbUuuqdMADtus84xTWIt
         eCjt7ZCIFbHwt8fOn4y1e4d9CmRRqCRfYiaT/sA6iAYEOg8Ipti1ek57hp2MxmrxFhhw
         /8pw==
X-Gm-Message-State: ACgBeo3mGdkzQUlBqzo5HVemq/yVap0HChAuCCTSlFFoCYFnjFjsrYEE
        SulGJNI6fK3e4kUmj8MqWl7WTqbTPTzuPfnxAlBc0g==
X-Google-Smtp-Source: AA6agR58hPo6lYtBAKK8AafaLO/foW5eZ1t7LMTpy1FreZHLUbpm/8q7BOV42H1KXun+0aqIgnswlGR0XzFLk0n4pfc=
X-Received: by 2002:a05:6870:9a17:b0:e9:3d1:f91a with SMTP id
 fo23-20020a0568709a1700b000e903d1f91amr10876240oab.44.1660062893804; Tue, 09
 Aug 2022 09:34:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Aug 2022 11:34:53 -0500
MIME-Version: 1.0
In-Reply-To: <1660026909-7365-3-git-send-email-quic_c_skakit@quicinc.com>
References: <1660026909-7365-1-git-send-email-quic_c_skakit@quicinc.com> <1660026909-7365-3-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 9 Aug 2022 11:34:53 -0500
Message-ID: <CAE-0n50BqexcwfFtFL3ebVfyZ4rqh6HU05anLxt9BD5zYf17uQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/3] arm64: dts: qcom: sc7280: Update lpassaudio clock
 controller for resets
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tdas@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-08-08 23:35:08)
> From: Taniya Das <quic_tdas@quicinc.com>
>
> The lpass audio supports TX/RX/WSA block resets.
>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
