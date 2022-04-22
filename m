Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE29750BDE1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380995AbiDVRI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355052AbiDVRIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:08:24 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D7078FCD
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:05:30 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q3so12192912plg.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w5Fh61tvMI9u3EP1h/xxxSiqzyNcEuilOSuCPwJLpv4=;
        b=L7NN759twCDLbvEjspSxjhn+bTpAGvk9JbCNA6/+w/LOL4u9oYeRR1Cj1oEmqIVwBX
         +wMeWY/CJ39NQBHuSDF0KY1rVyYBnG5EQg8grBxD5LRqSLkrCDoqrAqOrMFzfarbMOKB
         efcDKjChCO/J0dlaLxVRSQzzTJgVjkwZkI4mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w5Fh61tvMI9u3EP1h/xxxSiqzyNcEuilOSuCPwJLpv4=;
        b=jvjBPy9uOzWISPqT1A1W5/YzgXsP9RvNel4o4xjfxOVeCoKGGvfRXeDMLn/+TclW+0
         WuHQUCko5S6UzISsUlVYq7pl1h392dVdN/Z3yFERAAUsT9NVDkplnPEgU+QCk8AxhtoT
         6cR+9Mk/oMO8qf6vdEuZ2DJlm+T8L8DIjogv+k3pn5uupd7weXpaxh93AegZAyKzkvAc
         WWc3Jv93tQD+YtURmQVyWP3vtBvhWMm6tiaRr4quVS7El0t9kW/mWygiwraTk4WePJdY
         gYvZBcXRtV6s2ujB00rUsbS/UPdvQo3BRPuDqIFAucUwnNjjNhPtVGQJvMpLjLeIUhV6
         tmLw==
X-Gm-Message-State: AOAM533YMg88+Y9Ojd5VGJlwF0ymEckoxiNWl3TvJov2o5FqVeqNJLqb
        6efMa+hNTrpzuhVIrgHVtTxATA==
X-Google-Smtp-Source: ABdhPJwCztp9V8GVGJ09fmOY5Z3kg5VnisfuUiFpB1LNNzVLwAB6pP5WRtsauFK2kDh8h5gT9UJHFA==
X-Received: by 2002:a17:902:ccd0:b0:156:7ac2:5600 with SMTP id z16-20020a170902ccd000b001567ac25600mr5678780ple.156.1650647129217;
        Fri, 22 Apr 2022 10:05:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:404c:8721:29:87a4])
        by smtp.gmail.com with UTF8SMTPSA id m2-20020a62a202000000b0050ce7925e1esm3146631pff.35.2022.04.22.10.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:05:28 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:05:25 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v10 12/12] arm64: dts: qcom: sc7280: Add sound node for
 CRD 3.0/3.1
Message-ID: <YmLgVVYwJx9nBj8l@google.com>
References: <1650636521-18442-1-git-send-email-quic_srivasam@quicinc.com>
 <1650636521-18442-13-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650636521-18442-13-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 07:38:41PM +0530, Srinivasa Rao Mandadapu wrote:
> Add dt nodes for sound card support on rev5+ (aka CRD 3.0/3.1) boards,
> which is using WCD9385 headset playback, capture, I2S speaker playback
> and DMICs via VA macro.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
