Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8346C50CCD2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 20:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiDWSMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 14:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbiDWSMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 14:12:39 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9868331506;
        Sat, 23 Apr 2022 11:09:41 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id bo5so11005581pfb.4;
        Sat, 23 Apr 2022 11:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gc8OMd0WK3EM7XKyqfhBxSqSzVvH1RI2L8p7UF4ZJKI=;
        b=MyUXP+nPMRFKM7KBij5V88Kadq9Cwb7ilo8gbWXugPkKu7ikueR9ODe6XCBXllhxRY
         t2K8iWM25L4tG714asQxh4jn1WE+DTMldXp4hP0NjZh4DlsI2Lce9fAVrGCJE2IAk5bn
         mcluZM0dTwvueSqr6ZKAFDmwkkkeM5f0knRO+HYmVsY2DSpq7WXBMeIICt6CxarFRm/h
         CkfpmtPCETh72phJrMtNxuWwjA7JYDWCWRtOz9nGwFskEGdWLm/v0sXyoVkC3tV0wJzj
         e2QN8Jwu/YI1shN4tYpzMYf4BQzQJ6r17qyzAyEBlQC9+A/bgq36/wF+alXhTUlGEY20
         c9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gc8OMd0WK3EM7XKyqfhBxSqSzVvH1RI2L8p7UF4ZJKI=;
        b=sLgxowHxZU9sUdqePPomny9wa/Ze15gm4QTs+KJbKaUcie/qeNYHyX0O8wqGYPyhbV
         Ri5vtj/3AJzP2fC/jHRd7Ro6T4QqkHipCCY59D1DMSTzpklJ2ihH0u9ndqSB0TAamSiV
         MqQGUZZ3pSZufFGnxHwN3HGD1P407gWf/iOZ2pY4QTkgKKDvVcB7PwjAUKi67ZOkScyz
         mt6rkxI+Cpvq0AExqyHlILLOLGN4smneti9nDaxZR5AbnVGdHh8Jyuyx+hk5nO46pNw/
         0fSZtQVNwD1m80LjwL54NnlWEI88A7dMEg6RgIxmr7aiAAqdtL7aIXVglw9uMtIyswWB
         M8XA==
X-Gm-Message-State: AOAM5331Wu5ZcYsGidkjK7HplxtQElxTKBw6C7JTdXDtXmAT/ml14wdV
        nJo2Yvpq/pwBuZ8O6t1KadhuqMbj4t8=
X-Google-Smtp-Source: ABdhPJy0lWuLN5chYofeTD/QFGdPthlPalxZFhXI/z3NQ82KN26+XmYuzgNMa5g69QhIOJ01KrK6ng==
X-Received: by 2002:a63:2cc3:0:b0:39d:a9af:bc5b with SMTP id s186-20020a632cc3000000b0039da9afbc5bmr8884062pgs.3.1650737381059;
        Sat, 23 Apr 2022 11:09:41 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id x23-20020a17090a0bd700b001cd498dc152sm9799317pjd.2.2022.04.23.11.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 11:09:40 -0700 (PDT)
Date:   Sat, 23 Apr 2022 23:39:34 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/4] ARM: dts: qcom: apq8064: Use generic node name
 for DMA
Message-ID: <20220423180934.GA35431@9a2d8922b8f1>
References: <20220421171809.32722-1-singh.kuldeep87k@gmail.com>
 <20220421171809.32722-2-singh.kuldeep87k@gmail.com>
 <YmQjW4OYe5rTBP/Q@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmQjW4OYe5rTBP/Q@ripper>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 09:03:39AM -0700, Bjorn Andersson wrote:
> On Thu 21 Apr 10:18 PDT 2022, Kuldeep Singh wrote:
> 
> > Qcom BAM DT spec expects generic DMA controller node name as
> > "dma-controller" to enable validations.
> > 
> > Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> It seems that I picked up v3, but patchwork-bot didn't send out any
> notifications.

Yes, somehow there was no notification for this series as well as geni
uart/i2c patches also.

>
> Please double check linux-next to confirm that we got them all sorted
> out.

I checked dma dts patches[1] and they are in next/linux-next.
I hope I checked the right tree, please correct me if it's wrong.

Please note, there was one small typo fix from v3->v4 in commit
header(s/User/Use). Not sure if it's worth updating as it's already in
next tree, upto you. Thanks!

-Kuldeep
[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=fb1bdb7e787a6037f501869b5aaf9e5cabe7a7bc
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=fbf64afd16b9581ae5a89c6924b50f83041463e0
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=095a7137ba3630bcca11e6017bfd4ab48b7fc12e
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=a86efc02b34104b93a0f9707d1e61577671fc4ad
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=7224013d4b5a64c43be23204bcfb4070dbd7fd76
