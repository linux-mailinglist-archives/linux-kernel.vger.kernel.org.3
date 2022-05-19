Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669BB52D9CF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241764AbiESQHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241745AbiESQHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:07:35 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980C636691
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:07:33 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n18so5212441plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vCPJKfu2oCo3i3xfxQhF4mnOjWu7Adqh9L+m1Zagfr0=;
        b=GaqVQKsxA6ix9Bsatt+I5CsjaAIQEaSZbzLk9E1xDSCgs0QZQNX+z/1BGz4/N4qGU2
         FUsGHNI3UZZcPeYGbFu400r/YKfLxm6JLeUq/lUS/1O87JVFh/LPzyXkA8CW3/gOVW81
         +15tbkWi0q+owvBHGj9l2DYhTXl1PqNkQzPtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vCPJKfu2oCo3i3xfxQhF4mnOjWu7Adqh9L+m1Zagfr0=;
        b=zLpmwUj/T1kserzaIUBcl9h9naeBWKXVBkszfFYZVeOD0PTvDWbgbGDmwChkQoo1uw
         GwH8ti6RkFi8Yk7mNJGP6QcrNIIDFXFFE9+gGlbvGZcHXxdGLRHZs/+H7bXm6TU/Hzd9
         dBBOe4UHUQBrTY/w5UxIG66OJZGTIQnW6pEPba52imGOqLIV5jfk8mp3AAj+lRL9k8uN
         7hDL+yBo84Bo5sXHxVcInr2afR+b0mpCBKVZ34MJ+JU4rA/la5ij4+tcR0LPm3VYz3Gm
         JLWMUNGmmcpFZ2Hc9fZjXYCX9H7Xjm4G8w5CYNs7FUdA3al93OmEF+7QkV8ZAlLNjd07
         8Ojg==
X-Gm-Message-State: AOAM532Q2iAr4e/0QeKZ+qGCMl+3NSpGBDXkGG18b0S2yu9xQXi9bxZT
        Es2WzekAv90EmcJ8RMUl2mqfCQ==
X-Google-Smtp-Source: ABdhPJwLsJF8qU7yTq05vzlOk9lTd0uC0zK41oeCXBlgmhVRtr/qW6q2lxRAhULfDPPc4BNK/MrikA==
X-Received: by 2002:a17:903:1c1:b0:161:aa16:f279 with SMTP id e1-20020a17090301c100b00161aa16f279mr5496491plh.88.1652976452932;
        Thu, 19 May 2022 09:07:32 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:e229:79ea:227e:d9dd])
        by smtp.gmail.com with UTF8SMTPSA id d132-20020a621d8a000000b0050dc76281bcsm4290876pfd.150.2022.05.19.09.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 09:07:32 -0700 (PDT)
Date:   Thu, 19 May 2022 09:07:31 -0700
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
Subject: Re: [v1 3/3] arm64: dts: qcom: sc7280: include
 sc7280-herobrine-audio-rt5682.dtsi in villager and herobrine-r1
Message-ID: <YoZrQ0kkNoqtPHU0@google.com>
References: <20220519084119.675990-1-judyhsiao@chromium.org>
 <20220519084119.675990-4-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220519084119.675990-4-judyhsiao@chromium.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 08:41:19AM +0000, Judy Hsiao wrote:
> Include sc7280-herobrine-audio-rt5682.dtsi in villager and herobrine-r1 as
> these boards use rt5682 codec.
> 
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
