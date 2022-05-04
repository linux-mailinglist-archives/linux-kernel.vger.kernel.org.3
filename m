Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82C551B041
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378549AbiEDVV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357474AbiEDVV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:21:26 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379DF4A900
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 14:17:49 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso2333170pjj.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 14:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8el4Rk0mk4LC6bzVxN9Wiyp6vHwSjolb835IADqSIQA=;
        b=Y5V6GbrOtAzxivDyfLt5L5uZBXZlDDFBVcmRvZ3OOddanp56F72NsQK+Qec3PrNyH8
         3SyQOe7yX5XMzvHZZbFpU3shQgwuqE6Ur9/o9SiEi5lTQpRUBzF2JCLai3oDiAyr1EOb
         4usgamJAanu8dWMORqEYK6u7oaqD4PI1x3w/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8el4Rk0mk4LC6bzVxN9Wiyp6vHwSjolb835IADqSIQA=;
        b=Lty3Jnl9BBnlJAFoHnMLrEhNF1oinrlECHIcDjTRl2K1PUbnarqMhSiokcQGszinNi
         s22daYfg7FCfHoLnAND498bNaTyDeE7gvWhQIR51dJrEqq/AJ+VDgRvV21Npa+MN5iT8
         74MYbU+xJtCzFqcoCjc5KiiyCBPe9KTtgo0Q36sunVZJw5aQYJIjWrf/DexcaqBkLjnc
         nBiYKBnXdAj0MIFSEziw+lerqgHekqwBJT3tNeRjpoG1kOkeEf7MDXUdNJNLpds1yNyF
         5TAfaD6BX01ocycG5KLek9x6K8B+wztcIfr8g+A6/DMNXJuWwtuLMLqWJ53M0K4LSNIj
         OPzg==
X-Gm-Message-State: AOAM531lcNkUQnDoa1HU3ZvNo4o9PlHJJMJhcT4uIqVaWvonDaBkraxM
        qWX9Lf2+44P63AFmrhUld5ykPw==
X-Google-Smtp-Source: ABdhPJwhlBxZacPgfc5H9mWbA5FH2eaEZzDvZ33SWLjd1tzJzoZhiR0LdHYinUeTZ9WuECufN0sw3A==
X-Received: by 2002:a17:902:d4ce:b0:15e:90f7:5bf7 with SMTP id o14-20020a170902d4ce00b0015e90f75bf7mr21335093plg.98.1651699068765;
        Wed, 04 May 2022 14:17:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:35b6:c77b:be04:3bd5])
        by smtp.gmail.com with UTF8SMTPSA id o4-20020a17090ab88400b001dbf2aac185sm3739324pjr.1.2022.05.04.14.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 14:17:48 -0700 (PDT)
Date:   Wed, 4 May 2022 14:17:46 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v11 02/12] arm64: dts: qcom: sc7280: Enable digital
 codecs and soundwire for CRD 1.0/2.0 and IDP boards
Message-ID: <YnLteplwGCBheObA@google.com>
References: <1651664649-25290-1-git-send-email-quic_srivasam@quicinc.com>
 <1651664649-25290-3-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1651664649-25290-3-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 05:13:59PM +0530, Srinivasa Rao Mandadapu wrote:
> Enable rx, tx and va macro codecs and soundwire nodes on revision 3,
> 4 (aka CRD 1.0 and 2.0) and IDP boards.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

Please make sure to collect tags, for v10 you already had:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
