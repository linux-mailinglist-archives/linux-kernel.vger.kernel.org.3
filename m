Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08636578DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbiGRW7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbiGRW73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:59:29 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7109732EFE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:24 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso4359776otb.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4kHud9mlsoAsSPgQFpekRiycMvMxnpzh8md2ULHRH8M=;
        b=UoduGzpJcG+vgnNJXPprCMScMu3l2jZnTBwG0iq8IbcBEIea2YU6fpLPi/8MLwxf9P
         ESjapwV36k/9ZVu0E9DFYUIIrywdE4t4IE6SP9nZZ3xbCKApAIOe9hgitBR7OkJg3Wik
         BBUgZ6Q00ew6MdG4y+L3iERKx+YnNABaDvfXfDV2S1jtn2ZLaoF9ROsEp8wQ7IqDrQNn
         c/Y1jwrj9QSdkhCyL2c8m2eiemm7ptCDvDxg6GMwfXzeyMYhZkDZbaBmq5D1GgO41iY8
         OSeuAZVzSvZwFp6rcLHtYNfD1qtyCY75gyVKnXuA+pxrzaZ5HlXRrXqQB0yVTi3poTiO
         au+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4kHud9mlsoAsSPgQFpekRiycMvMxnpzh8md2ULHRH8M=;
        b=c6PfcNQN4gjGRAeEJBr5GaR17wPtYk11duTqiu3KIEY9SekeXYI8v8Py8accolLvAf
         /tC1Id3+2bfzB3eXBbM9dmWvL0uEYcQvnmE5nFGl0Tld2x900Tte5Q+7t5peDsKa+Gl/
         IkO5+f0o/R1p8xPr/0Fufv7i9ph1PKkHu/oHyn0TIbTmz4l7kwlIJqa8jr1I3aU0A3Sh
         DiF2SAqOBwQuAXdSjbAQsmagTFUucLyRagMtW1HWEvr1CclOO37FBTSHgPBY7iMFE028
         +RVMGBUhMAmJvLLtNH9jq6tYOHTm2BNHy2FNkCahJs3wH6mnLT2fNJ7sPf21Yxx0lS76
         ES3w==
X-Gm-Message-State: AJIora9uT0yznHxv9lRP3lSbuWj5Q6eGG4bEcqoktBU0f7h1DU2dGqfz
        TTY2EBflA4417Q1T14s3ApoWNZqfD/Uqow==
X-Google-Smtp-Source: AGRyM1uFakFvCDT6jvma3XJcksWxbV5RTSCBSXFya7UHglFCPT1qwouMYZ7iXGz927NSgeZhMkx70g==
X-Received: by 2002:a05:6830:33c3:b0:61c:6576:667a with SMTP id q3-20020a05683033c300b0061c6576667amr12131221ott.375.1658185163443;
        Mon, 18 Jul 2022 15:59:23 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j10-20020a4a908a000000b0041ba304546csm5330931oog.1.2022.07.18.15.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 15:59:22 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        agross@kernel.org, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     sboyd@kernel.org
Subject: Re: (subset) [PATCH v2] remoteproc: qcom: correct kerneldoc
Date:   Mon, 18 Jul 2022 17:59:08 -0500
Message-Id: <165817634386.1905814.13877230220169061028.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220519073349.7270-1-krzysztof.kozlowski@linaro.org>
References: <20220519073349.7270-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 19 May 2022 09:33:49 +0200, Krzysztof Kozlowski wrote:
> Correct kerneldoc warnings like:
> 
>   drivers/remoteproc/qcom_common.c:68:
>     warning: expecting prototype for struct minidump_subsystem_toc. Prototype was for struct minidump_subsystem instead
> 
> 

Applied, thanks!

[1/1] remoteproc: qcom: correct kerneldoc
      commit: d5f8c4c66a368e21a105c42042803526cd3ccc15

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
