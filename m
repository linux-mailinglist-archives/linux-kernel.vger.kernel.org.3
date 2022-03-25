Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DCB4E6B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 01:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357037AbiCYAMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 20:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345328AbiCYAMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 20:12:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1563460ABF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 17:10:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n7-20020a17090aab8700b001c6aa871860so6732092pjq.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 17:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rMGZP29VwwjXomMCTf7RGAwUINqnAGDMVSSvjpH9al4=;
        b=Vym1Xh3qa0ZprnVR1uru2iEVUaw7NyQFjEhcWVWVhDdqaJkuRO2fyK0FbIYLRPH5V+
         01Cyp2smpovhZd/g8431KXzr9m849gVd/6ZEcitOZq4L6uUuro+ZLE9jg/kuZUK0ejWQ
         D8pvy+kK1fJAxzZBpXoG+RKQY1bmRBiIKnAdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rMGZP29VwwjXomMCTf7RGAwUINqnAGDMVSSvjpH9al4=;
        b=zpnCYZRZY6up4bdGMKWDrj02NNxTowRC+/AQpjGb3yrqcAOVHNCKXJUwbPhS1ifj7O
         1NNA6cqftXisd17YtBo1hOkp6zQ2U9tk5RSqFSp6ihm19K38TQwm/yHEq3I5jKN9tYHU
         UfFV0bhxIlZo7wmLhcxvGF5jZCrp1IRBK3vDWDBOPTpHS/i0OdloeGq+L7yYEwDLPguu
         JCOBMYiklLnWD/y4Y87JtzJftXpt4DNtgQhIo8c9WWi2LT3i4Vvv5aWLdKcxypm6b5av
         oLQOenlxhprqw7lmwnwak2GgBfHTiTrajceMjzl0Vj37tbQxQjl9v65JiZmGsMAfAdG6
         OD+A==
X-Gm-Message-State: AOAM533B2GHKMEfifWwyNvkq50lvxhkolnFHg3i1qiODcREjfsAUInCP
        ixzUzyJF4YkTktxf6H13eOcrWw==
X-Google-Smtp-Source: ABdhPJx7bPQzmPejtWLkEa1qC2B68NiDAIf/YgPQNk+wTLMjw+cO/5oZp/bsBm97IUBY3CFXffARng==
X-Received: by 2002:a17:90a:6849:b0:1c7:5640:9c0d with SMTP id e9-20020a17090a684900b001c756409c0dmr9252762pjm.188.1648167028665;
        Thu, 24 Mar 2022 17:10:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:690f:642:3ebe:c89d])
        by smtp.gmail.com with UTF8SMTPSA id t2-20020a63a602000000b0038062a0bc6fsm3423678pge.67.2022.03.24.17.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 17:10:28 -0700 (PDT)
Date:   Thu, 24 Mar 2022 17:10:27 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Fix sar1_irq_odl node name
Message-ID: <Yj0IcyYn2hvNeBig@google.com>
References: <20220324223331.876199-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220324223331.876199-1-swboyd@chromium.org>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 03:33:31PM -0700, Stephen Boyd wrote:
> This node should be named sar1-irq-odl, not sar0-irq-odl. Otherwise
> we'll overwrite the settings for sar0 with what is intended for sar1,
> leading to probe failures for sar1 that are quite confusing.
> 
> Fixes: 116f7cc43d28 ("arm64: dts: qcom: sc7280: Add herobrine-r1")
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
