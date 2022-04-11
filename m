Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF8F4FB9E6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345681AbiDKKqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbiDKKqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:46:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B3242EE4;
        Mon, 11 Apr 2022 03:44:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d15so13473918pll.10;
        Mon, 11 Apr 2022 03:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PU0V5WuDYq0cmOiaa5TapdoxjKoeqSQh5yP9ORlY1MU=;
        b=RdlxXKGvVTJmMX1d/hCHNs5BN+F2sHVyVWWuIsO7x9sVpRW3cLyy+llM5td5P1uQHs
         wWi26tkD4Ae87M4PgJx+LtawV3LYB1FQXOU3qPefn5FuvQhMN5lwAnb2+OhUhJzesr3o
         SX4ObxbRvQV+vwpBEaNRo1M7CFxGLNjJPmkKy4F8gkaBlNDF7Q44qk91kCeIb1z16D81
         Tlg0VcLYcGgp/YrDoi+0JI7jKMIx3EC0s6cJbkxq1vmbqwlXa5bIXz9B3xj+v90dWVn7
         wnbUF79G0+l+B4xb851gQrZSsZyvPcOSjhmdvUzo/iKqgCEeS3h8/V2YnUU5AKMwWL9Y
         BdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PU0V5WuDYq0cmOiaa5TapdoxjKoeqSQh5yP9ORlY1MU=;
        b=AUxDBgmmIGVydW+xk9wRAl+e/ALR8fjHjqy1WaFzWwudXNkMJsF5eXrdQ1TfyVZq3v
         I0tix4IVZ3yONA1qA5uXhKE9Zw4WVxQGUoOvSb1uSIXS97tYWQojJLBRte0ayA3m/Rfh
         ThTcQJDflwNILdDwYBqAzU2qcMAlxSyL+S0py0CQQlkOxYtggNjQIDQAqOZAaZoOFCc9
         eUwyYObbQMo/vNNLwlEWMp/ZwfJjTBjUVp8fmSaeJ9tGjCDDfmDbS1unBwaM5wmrDOlU
         vTA2qUZX+EuTZs81WbYkfvbf0SFC8qBKlStDVL1/GbYvM6A1TKm/eUDDE0wAQxYNtN0J
         At5w==
X-Gm-Message-State: AOAM533u6lzq+8jIrvgFVkIq7QJet7vq5c9Et7i7hVRILHKkLhxf+nqE
        eAKXbfjVFid2dU1QFpb+hxw=
X-Google-Smtp-Source: ABdhPJwD3BHuZXB4MdexFeBhJDjISaadQa4h09XyfyNQsOUzxYg4D2VGuhqYTbbx5OUKGBn8dZaJuw==
X-Received: by 2002:a17:902:c94b:b0:158:7729:97c3 with SMTP id i11-20020a170902c94b00b00158772997c3mr1020940pla.167.1649673839863;
        Mon, 11 Apr 2022 03:43:59 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id mu1-20020a17090b388100b001c77e79531bsm20499455pjb.50.2022.04.11.03.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:43:59 -0700 (PDT)
Date:   Mon, 11 Apr 2022 16:13:54 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/6] ARM: dts: qcom: apq8064: User generic node name
 for DMA
Message-ID: <20220411104354.GA33220@9a2d8922b8f1>
References: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
 <20220410175056.79330-2-singh.kuldeep87k@gmail.com>
 <f3736e95-a712-50cd-1cbe-83ced609cd4c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3736e95-a712-50cd-1cbe-83ced609cd4c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 09:08:53PM +0200, Krzysztof Kozlowski wrote:
> On 10/04/2022 19:50, Kuldeep Singh wrote:
> > Qcom BAM DT spec expects generic DMA controller node name as
> > "dma-controller" to enable validations.
> > 
> > Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> > ---
> >  arch/arm/boot/dts/qcom-apq8064.dtsi | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> 
> All arm changes could be one commit, it's a lot of churn for just name
> renaming, but anyway:

Ok. Since changes were in different file that's why i kept them
separate.

> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks!
