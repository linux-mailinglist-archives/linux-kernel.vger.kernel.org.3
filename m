Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB4350A272
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389335AbiDUOah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389297AbiDUOaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:30:18 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0AE3ED2D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:27 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v65so1064841oig.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Y+rGBJub4hUelqG6Wh/GRTU8FsHwDE9p9sZ9nEoVKQ=;
        b=i8Jw5blRNpNTEopLw35Y+TQC2A2+Nrm9Hwa8Jp4lGm9FN73TIJiwgUuEtHVw7BwA/k
         pdHr6K4ZAqp+eck+SqZkrX7w9Xkvmn//IUxnGY4NMunZRWKf9VmHwiDS9IrndGfJYGTV
         sEQUUT+ycI/iBAez7xuA1bR6uECYMdeKAty07R7HiTkUk4K7iBrWu2PCPVHt9thRYj14
         FxdmcqVlO0mWT0Fsey71UPB0083xxV+I8GI6dLygQmGXieIfXC7U5SPwA8wwFeqcnO1i
         MR9yBMVKD4xiCD+/mELhhSfilMNfQejDwP193E9Or1ZoNxWmSNhPFpHpCkfOuDYFx0pt
         1tHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Y+rGBJub4hUelqG6Wh/GRTU8FsHwDE9p9sZ9nEoVKQ=;
        b=21NNJcuMLhEVTxDloN1cF7wbdEG4TQgAzpXTw+r5De41ZfYUIBJTiKu3wOlDc+Gt8O
         vbE82BLb4DZcQ2W21s9nCSYkOsAB1w8Y9swoZSVa4LE3DkQ/+VxeaE1a3meZTl0Qg2bH
         i00+QxZUloQGXyvyLCjbyzRvjX8veK4fg50mBCrNBPgHLLrsnWhG1hp5lp5BIVug7hDK
         Vvr985d0oGAPReZafyAaiQY7hUJs7b3i0W3TbNyNtz6DSrydzqgtpmj0LI1WSB2QXjxL
         0GtxWlBOOfipbMYaUKsM2hN9R3czOEwiv0vu06tRSy+F3pHoH8s4S2HKcJB01iOFmtl/
         vFJQ==
X-Gm-Message-State: AOAM532+9wwg0IM8JZu5FEAJ637mdd5CPV+ZSLKovYE3By9N0Xs7E0hD
        yvvegn8wKhA/lyK9BVn9zxZGiA==
X-Google-Smtp-Source: ABdhPJz+s/MnXFjAWX/wh2CCqvIrZgal3PVDIV6DOYifyt8dsIAkB6QhDTzoqVpGUZrI+GfQdsiTLA==
X-Received: by 2002:a05:6808:2189:b0:322:e874:e8f2 with SMTP id be9-20020a056808218900b00322e874e8f2mr3632255oib.289.1650551246360;
        Thu, 21 Apr 2022 07:27:26 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s14-20020a0568302a8e00b006054e841915sm4296295otu.73.2022.04.21.07.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:27:25 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-arm-msm@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH] soc: qcom: socinfo: Sort out 8974PRO names
Date:   Thu, 21 Apr 2022 09:27:02 -0500
Message-Id: <165055095990.2574292.14922414539179554766.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220415195449.617040-1-luca@z3ntu.xyz>
References: <20220415195449.617040-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 21:54:49 +0200, Luca Weiss wrote:
> MSM8974PRO is commonly used for referring to Snapdragon 801, compared to
> MSM8974 which is Snapdragon 800.
> 
> The Snapdragon 801 has three variants with different clock speeds, with
> the -AA, -AB and -AC suffix.
> 
> Adjust the names in socinfo to reflect this.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: socinfo: Sort out 8974PRO names
      commit: a555b382e7640b80b20816cf9179d091dd7716eb

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
