Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC63B4765B3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhLOW2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhLOW1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:27:54 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD5BC061751
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:27:53 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id q25so33830899oiw.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FXiTt28DF0TNeYeqxbk1y47hagOmrR7tSgx4NkJT8Ms=;
        b=Lx8w5unfIa5EsmBOH0EWh+C8C/YoOkhaYvlKT7LF3A2fPH5W8+PQGrLrnaw5/oCtGc
         Pa3U3cvZIvxyveJSN3qhxsSW5LMZr6Gu9z6n+jgAHsLt/aVDGXWhaEBnrNhmT3mz8GXK
         yqXtIKGs1xP0dGHzBHt9fQyjQEhu3bHeR5WxoNXiPLFf+kLUYKjRDSge3NdQhNEkzl83
         4SuQ9jlSfmdmahEljDmXW29/8v1de4fCOplsg2wJwjbucmc9VVd7mCGP5lSALvgEHxEf
         PPehyLfZzrgOhQuF8hMPk2XRz7p0/dIi/zb+Oke/A51g2EVkppmQtpmvXoc/ddcdK0+2
         Keqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FXiTt28DF0TNeYeqxbk1y47hagOmrR7tSgx4NkJT8Ms=;
        b=SFWqoUtEhPhIGezXeTVOVgdL7Y3mX4Gz3NJzwhiPDkBuDDq3vFDP3DBbYScK9d2mfg
         rbZXg79nmM8ZQCfaOOg+q9E/70+55X2lQhkHoyFSoWjvxsKi8ri+szfhJ+FRsksDIo1D
         W1XVnsuyUUoSw1dj7RFYUyPOnd0T5Y1yTmfmjG661gB+efGYbBAPwqfrVM58RBD6nrVG
         W8/BXaenT4y5IkG+bYQFDiimQLfJXWspqT2MdxA26+kipTgeHMslJvsN00varEKu83am
         SXzH97ey0BZddtuxjRIvVsuoL3lJfdz57kYWSQvTUDbz29f99PWZRtRFw53w3xb99ytG
         RxFA==
X-Gm-Message-State: AOAM531/fUbFAgApbYoT8yaC8AaJ/AhDHbvEc28sxPPFOyf1N3/Cl0qB
        TzdjvPw7Ocs3TipLb9HwUBB+YQ==
X-Google-Smtp-Source: ABdhPJzvnr3AZ3ajPkvkjPQb60D5x9FrVNF5YO18grQl1pkgjr7uNDubj3nnjD7Re7MjWtfSY1jhpQ==
X-Received: by 2002:aca:a897:: with SMTP id r145mr1841533oie.136.1639607273192;
        Wed, 15 Dec 2021 14:27:53 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t14sm700500oth.81.2021.12.15.14.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:27:52 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        martin.botka@somainline.org, marijn.suijten@somainline.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        angelogioacchino.delregno@somainline.org,
        Andy Gross <agross@kernel.org>, jamipkettunen@somainline.org
Subject: Re: (subset) [PATCH] Revert "arm64: dts: qcom: sm8350: Specify clock-frequency for arch timer"
Date:   Wed, 15 Dec 2021 16:27:25 -0600
Message-Id: <163960723735.3062250.2110128471587461383.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211202004328.459899-1-konrad.dybcio@somainline.org>
References: <20211202004328.459899-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 01:43:28 +0100, Konrad Dybcio wrote:
> This reverts commit ed9500c1df59437856d43e657f185fb1eb5d817d.
> 
> The clock-frequency property was meant to aid platforms with broken firmwares
> that don't set up the timer properly on their own. Don't include it where it is
> not the case.
> 
> 
> [...]

Applied, thanks!

[1/1] Revert "arm64: dts: qcom: sm8350: Specify clock-frequency for arch timer"
      commit: 202f69cd4e1dad6c86a35d8b29fc693877c6c91d

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
