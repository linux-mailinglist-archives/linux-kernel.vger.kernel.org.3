Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CA3538BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 09:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244429AbiEaHEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 03:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242917AbiEaHEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 03:04:11 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF4691584
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 00:04:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j7so7014229pjn.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 00:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gw0a/H85Ywnwg0/Erk/pRkOhx4pgUF8A0ud8TdLevuo=;
        b=jg2iVjlKTvOpfP0aj36HFNjPYtJWCJYKurlQMx+mbflHIf9Q/QsbjtWCVNDLYsDPhj
         58q85jThQPMK5DOf/aSFJUdu40768Bx1ze1CJqNZmaWS8Oy4e4rRCDhiWHptlpkXIKlm
         /GAY+0/AunzRpZC2ve4YThQCtSZWcaMZBjVitJp+m4D3BTvyC4W6FsvgkoRDdlKV/z94
         pB2ae9kWiktTV4B7R6X2FQwJObPBg7YXuAZkZZGyTxNv/zIOlMPGKhRbGzYTT6RAl27l
         BPgGdamyug6GB+fvF5tY8e8q1a0NcPqD5QNXV+kaGYkYD03TCHymEW3ENsyMXPqEIq/u
         rvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gw0a/H85Ywnwg0/Erk/pRkOhx4pgUF8A0ud8TdLevuo=;
        b=rO0UgEVOqzIvWMFuUXuiGbnvgE142Lfyn8SQ6uWdgacYl7CnN9+HBaJ+AwDHbrLsos
         aYRGT4aYTPYUsjUknI0LGr0o2mZYmnf0iRcGwrWgZ2jXfPMv0wLZuTJaiYatDSU5EViw
         QA0ljSkHbbEGmI29UfbngXsPFSjlgTGiOUXirzi4ekYKDX7tjjTsDCegkGNf7V3X/Zjr
         AnRVnHtPmODqtqTEZSK9vq+HDFKSpbKEgwQUqj1L/dmG9MDk0A7mO+HiIuQaNwixKnAE
         3nJq5Z8ErgTrvpmCoGCop9I33UhNmUuXpknoEkvhsYzJwU4dOwzZitw6KVZd9Dv3AaN9
         5aXQ==
X-Gm-Message-State: AOAM531cd6sNq8bjbZYIL/V73GufuDGD8bsXJjI1muRkiK16Csgwmd+S
        BnqGQVTbgCewN0ZJ6gkvb5uL
X-Google-Smtp-Source: ABdhPJwsJtC4Zc2ZOo5TfgU4D4fFAIygJh0VvLXk5fhorO6LKxxYtgZDMAtKz2zyNOEOxKuUCczhZQ==
X-Received: by 2002:a17:902:f682:b0:164:3d5:74c1 with SMTP id l2-20020a170902f68200b0016403d574c1mr2355784plg.60.1653980649668;
        Tue, 31 May 2022 00:04:09 -0700 (PDT)
Received: from thinkpad ([220.158.158.133])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902f78800b001618644d8b5sm10359989pln.154.2022.05.31.00.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 00:04:09 -0700 (PDT)
Date:   Tue, 31 May 2022 12:34:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     tglx@linutronix.de, maz@kernel.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8450: Fix the IRQ trigger type
 for remoteproc nodes
Message-ID: <20220531070405.GA15569@thinkpad>
References: <20220530080842.37024-1-manivannan.sadhasivam@linaro.org>
 <20220530080842.37024-3-manivannan.sadhasivam@linaro.org>
 <04af7d5f-a4d1-3403-c481-1cc2bb13d30f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04af7d5f-a4d1-3403-c481-1cc2bb13d30f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 01:39:32AM +0300, Dmitry Baryshkov wrote:
> On 30/05/2022 11:08, Manivannan Sadhasivam wrote:
> > The watchdog IRQ trigger type should be EDGE_RISING. So fix all remoteproc
> > nodes.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> BTW: Could you please send the same patches for sm8250/8350 too?
> 

Hmm... I thought I covered them but apparently missed. Fill fix them too.

Thanks,
Mani

> -- 
> With best wishes
> Dmitry

-- 
மணிவண்ணன் சதாசிவம்
