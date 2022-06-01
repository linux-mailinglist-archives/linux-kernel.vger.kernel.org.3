Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4700A53ACF9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 20:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiFASnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 14:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiFASnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:43:21 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0366CA81
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 11:43:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d12-20020a17090abf8c00b001e2eb431ce4so2874755pjs.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 11:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CylZr84lNM4w3HdFBlt6SOrJM7582Y3Dp242aVUdYDw=;
        b=ftb+nI02XlOPJXHTuaCLRci64mITA4Omfb/UUtLIC1sXgKoZUnJeCFbeUk7ni7ghht
         9yUXBo+ObvjCXB+H7YHfFLQMHeayMiGA4fq8pjQZ7Qk/1Qq2ZJxJRJVZ5BIQvZQs7zVW
         rtMZDxS9Xx5l+e9aEAa5p/z6/cas7TtS8xSBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CylZr84lNM4w3HdFBlt6SOrJM7582Y3Dp242aVUdYDw=;
        b=uHPMFDfdT7mSDSuKWd26VD8Xan246wLDT/sydeOQWs4Xrl5Vk1SThjTGoZMqDAQ0B2
         zzHN9CB9BvP4iuGGwHkLQaTBG5nBeFfsD+vyF7Bh7gRkX9yw23mUrgZ+imWAv4ngvF/E
         o5uNXp2rXKlCiFOlLnzgoZ5H7FHwt/BekcHegK8wqXKnXU11/hBtGcIJpaBrKKWbkmlu
         rJLi0tvS0Pb6WEE5tJsy1ubXfCqHns/J+1AMDCnDJTQfiyyV3xjeAd30g3Xqyi9fqOI+
         dY1mRmJ/PiD/crTXs7+FinZvbSDaqWdXYP6qyoNE+uDvZJJ0V3FLRVJBRUnDy5d94KpU
         10Rg==
X-Gm-Message-State: AOAM531hsxBHfO2x3tydE+ZG8HKRxjbs5jzlxYc+ZN1UBKFfEmYtqhYR
        HMGuJloAQoNqW0Pum7hJlwMdWg==
X-Google-Smtp-Source: ABdhPJwLE5i5A07i5SgY07uY/UOCAYp5F1osDKzp7pdDjaN8DDsYjIkyNUSDef3lAjYbk0rLYGQu4w==
X-Received: by 2002:a17:902:b10e:b0:165:7c1b:67fc with SMTP id q14-20020a170902b10e00b001657c1b67fcmr776571plr.77.1654108998830;
        Wed, 01 Jun 2022 11:43:18 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:e69e:f483:e751:7c7c])
        by smtp.gmail.com with UTF8SMTPSA id t1-20020a63f341000000b003fc4cc19414sm1648304pgj.45.2022.06.01.11.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 11:43:18 -0700 (PDT)
Date:   Wed, 1 Jun 2022 11:43:14 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Taniya Das <quic_tdas@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio
 clock controllers
Message-ID: <YpexqxRtnMEFUki7@google.com>
References: <20220523100058.26241-1-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220523100058.26241-1-quic_tdas@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 03:30:58PM +0530, Taniya Das wrote:
> Add the low pass audio clock controller device nodes. Keep the lpasscc
> clock node disabled and enabled for lpass pil based devices.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>

Why is this series still evolving? v3 landed in Bjorn's tree some time ago:

9499240d15f2 arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio clock controllers

If what landed is not correct or needs to be adapted you should send a patch
that is based on the current QCOM tree and makes the necessary changes. The
versioning of that patch should start with v1.
