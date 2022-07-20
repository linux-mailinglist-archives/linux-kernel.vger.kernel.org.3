Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AF457BD73
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbiGTSJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiGTSJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:09:44 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27AC6A9CC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:09:40 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10d8880d055so2688184fac.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kunDZr9Y6JPcq1sMuH+ey+Qiy1eRk3ubp6HPIIz1jJw=;
        b=ANXR3JC3bxQuM5b1p6u7etTiV20lIiUw5xrAcZXH2blgV8GU4hVbmqn8azULJyavSE
         G6pEUsd7GbEoOApiowJ+a0vtVo5x94YuJz3mIrEUij9dvTM9tEx2V0n7YYkoLNFjvOXl
         ANkERijHrfMwW3qnJFLnj9pAAwUFijGN6E5syDVTrGG6Fo+p7xwMyRcyVhGXilO3FA25
         30MRaSbmnOyzX8DGm5cE5pXXXTNsFTDrm1UX9CkkmPiuZ4EEoBl4fkzfA3M1k76B+uV9
         QvbcexQyslF1JqQyGGRGRdSv8xc+aNnUPiIb4ZGkdos6z9O4TOEtqP4xNMIEaq7wlRRP
         aLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kunDZr9Y6JPcq1sMuH+ey+Qiy1eRk3ubp6HPIIz1jJw=;
        b=TY1cfWKiC3Akwu29wXbF5i14Xj+hVTjUsHMGhWyWwIUXufYFJeRkYybvtqHUL+zdYN
         TSYLAtPOLCSL1wXF5gZ8PWsTeK0C1DkWoZ+3xATwD57HltTnc08SDxHRQfDjCWc8F7/8
         aLxaDbRuuliVXg1BEJo4gkyMnmCb1+1i4s9X5KBFfbNt0iTbbFNaPNfBVLrfkyTMkZc4
         y3dHiS+CVEo2ur6V+6+B3fMQ07x4pJm0ZhGxuTlKafYUZORtgd0mTm46h4vyQU/O8QiM
         H3DOmXoNpipzUFLXRbSSNmZeCuzLJzaG1ozho57xnnOu5iTf+RN7zLzbSDBSY78pN0Fo
         ySTA==
X-Gm-Message-State: AJIora8w2HL+5BxqTrCPH4Epyx3R3k/Y9pA0Ba/6DkE9fA8S6aubFZCt
        MlFQfbzae88UbDYyyCqnbUHahA==
X-Google-Smtp-Source: AGRyM1spLCSSGvcDq6EqyJa5L/lKOksPme/eYbhxC3RUtEb3eGUglOjAIey/25NHx59vWCn2UekbYg==
X-Received: by 2002:a05:6870:468f:b0:10d:3fb6:bf89 with SMTP id a15-20020a056870468f00b0010d3fb6bf89mr3221549oap.176.1658340579832;
        Wed, 20 Jul 2022 11:09:39 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r131-20020acac189000000b0032e548d96e0sm1603602oif.23.2022.07.20.11.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:09:39 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     sboyd@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        newbie13xd@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: (subset) [PATCH v4 1/2] dt-bindings: arm: qcom: Document lg,judyln and lg,judyp devices
Date:   Wed, 20 Jul 2022 13:09:37 -0500
Message-Id: <165834057116.2095894.6261608097150637601.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220626164536.16011-1-newbie13xd@gmail.com>
References: <20220626164536.16011-1-newbie13xd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jun 2022 12:45:36 -0400, Stefan Hansson wrote:
> Add binding documentation for the LG G7 and LG V35 smartphones
> which are based on Snapdragon 845 (sdm845).
> 
> 

Applied, thanks!

[1/2] dt-bindings: arm: qcom: Document lg,judyln and lg,judyp devices
      commit: 1ef5a4d1d03cfcdb6ea24bece9e9c63ce97764fe

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
