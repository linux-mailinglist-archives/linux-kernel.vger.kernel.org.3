Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5B556980D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 04:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiGGCbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 22:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiGGCbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:31:34 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5D92E697
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 19:31:33 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10bffc214ffso12960661fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 19:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a2fsWEYDy5HVGsxX1nYjTzR5R0rzwCTEFX3d1N+MLTI=;
        b=qc2sJ22ZsnoeotICjEWAb51bRikbbNwwrB8mFNdJBPzTDPZZdeK5bmnhmtWMmxc2w1
         Yr4D5UqwTdy/Y8s5b57b6cEclhg3kn1P973pZGDjkQS3Sq05P3A2i5LlLRe88aNz/Cx/
         gPGgvOGgJW7Tvi/+0lpI3RqTF4tqbDmnxKp4UKh5FQL/oTBGCkB0JrTTUtbuXEJxPhUo
         ZX+MKPz+Os+Qrpksf5yIlTPkhDNgECorVR8UmaKc5BE3kmIas3dx2vaiKCE/nsv/UWeh
         dR9JSyrg+Tqy4t+guUlvjUq2QsexEWCjCH2DKj0H+3BCeHZ8Y2PAudVw6go4UKilJsBG
         lrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a2fsWEYDy5HVGsxX1nYjTzR5R0rzwCTEFX3d1N+MLTI=;
        b=wtpA5CtC8eISM6aAIEG/lQpwZbUIAmOSPmj1uJ84DZbDgK3HqTyyrpiiNSEDGKsHKx
         cbC923bzsq4opMlDQI45V5l1Qn4/PhZhDp2pmK5W1NXOKLVjxi5Z340qRp57/7OEz8OB
         53tTlls4tgqFHluyEBWJf57iEm441LETjNYEeWsNB8a5n4J8Kd7WDtIngTZNmKwQ8N/6
         mbmQfei6wtxpnzzgaqCscInHrt9E18hKYdmIK9pJpxEfJOZ/zLaXeiWhzUAOuPqmMtrn
         cXzPrdXoej07gJMkUC2QeKc9N/02C0jgeMzxhDw2aS2/77Fd+DT96IK9arRfl+Ra5I3w
         y0Og==
X-Gm-Message-State: AJIora9ezFtWFwqAnImLkvUocXbJHQxT25avfuO/fdjUmpI47rTHUcfZ
        r3IZ+gZynOveowFLctQ5ACHocg==
X-Google-Smtp-Source: AGRyM1sXCgqsVNj0bWlzx7mvQYO7A7NtC7TFwgnHORKj7G9N7grp5+VF6lKUhrJY1285aUOqIPn2Fw==
X-Received: by 2002:a05:6870:73d1:b0:101:a857:67f1 with SMTP id a17-20020a05687073d100b00101a85767f1mr1281508oan.28.1657161092802;
        Wed, 06 Jul 2022 19:31:32 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x48-20020a056830247000b006168c71ca4asm17024469otr.56.2022.07.06.19.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 19:31:32 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        Andy Gross <agross@kernel.org>, marijn.suijten@somainline.org,
        jamipkettunen@somainline.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] soc/qcom: Make QCOM_RPMPD select PM_GENERIC_DOMAINS/_OF
Date:   Wed,  6 Jul 2022 21:31:10 -0500
Message-Id: <165716107314.864223.6479279277048954413.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220701073700.17124-1-konrad.dybcio@somainline.org>
References: <20220701073700.17124-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022 09:37:00 +0200, Konrad Dybcio wrote:
> The driver uses generic genpd OF APIs and with a very minimal config
> where nothing else selects them, this driver will not probe, as
> of_genpd_add_provider_onecell will return -EOPNOTSUPP.
> 
> Make sure to select these in Kconfig to prevent that.
> 
> 
> [...]

Applied, thanks!

[1/1] soc/qcom: Make QCOM_RPMPD select PM_GENERIC_DOMAINS/_OF
      commit: 7d0221fb59125181a31ef3a561306c70fb238bc7

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
