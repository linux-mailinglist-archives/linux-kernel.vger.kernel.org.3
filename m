Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91E850D824
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbiDYEOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241000AbiDYELU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:11:20 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D9724091;
        Sun, 24 Apr 2022 21:07:38 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k29so12349053pgm.12;
        Sun, 24 Apr 2022 21:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T/RS4kjp9B0g3NPXTLSfahxyA66d9aAV7XBkghwCN/E=;
        b=NDYVPJ4ex/Hk2DUN+EsX9+jTACoUSLTboNubhD0Yzyw4i7emuW01uRggF76BPPonhl
         Xy0SA4s3wxUzh/qca11nolLu3A6/0sGBC0fHn59CNc4BsNAlifxxRcxU7XWS99/H3RQ7
         +zRl5LnyJidg8bArhA1XzBzgMF0at59MMJBs3eImvEBF/BrRsHcpagsX/qAxDFwV6YT/
         20rTE2rHG4k09LBmkAnFHeIR+5VhjjnvY/18Y1N2OdBgwkq08ZWbqlxd2+jOeVFsdw4O
         cGFwb3XnMmEjHAYjKBl7pxMwW7Z+G4vIwxJ2EJuO/1hu0HIHA87xlAbVPQ5VzQLKJjcm
         xFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T/RS4kjp9B0g3NPXTLSfahxyA66d9aAV7XBkghwCN/E=;
        b=aPyJSpQ0tZZZRmdJyraHYGfEOWRyPwI1Gv/89FOnOEDHHNGsXxBIjKISYvs6JOZPEA
         N/1ULVwYRGAxv4tTJple+IoH8XLx2Z2Ufs8E5C4L1QA3LgqfOYmM1/wEWvxf/GcToPWJ
         GU4f6S6vyax5mmcvIsBUi1WWn5V5nc9TN01b2Qq/PbQbtw1CIzCUMyhihPCfZ4P4c3yI
         tF1IV4c1L+qOP63ukzZ6WNV/0BSISZLgqH24wuIMZze3XDG+99Zq1ZqDKHTu5QJP4apv
         8xnR8kyFItxp7N4DKVaSop1zhUDMe0Q1aQhUodjUjS6wOyN79CnhZlRgRYkDn/zBGH5c
         vpCA==
X-Gm-Message-State: AOAM530L2bo7I1nomTaWC1RLGXM1J4zCvbaAjGIL4llrOLzMJSZlPqjC
        hk1nTOw0E/5PyvgHLss4L41HViriKQc=
X-Google-Smtp-Source: ABdhPJzcRmB19uWBDkx1hPPfE/7wMYmPC/YFu+CmSK7SgDHGMUdqjFQH3kJzkMqRynvrlqJk3J+MAw==
X-Received: by 2002:a63:290:0:b0:3aa:8b8b:1a3d with SMTP id 138-20020a630290000000b003aa8b8b1a3dmr13179262pgc.208.1650859657997;
        Sun, 24 Apr 2022 21:07:37 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:282a:d50e:e0fc:c145])
        by smtp.gmail.com with ESMTPSA id r29-20020a63441d000000b003a97e8f71e7sm8147069pga.88.2022.04.24.21.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 21:07:37 -0700 (PDT)
Date:   Sun, 24 Apr 2022 21:07:34 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     corbet@lwn.net, sre@kernel.org, robh+dt@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>
Subject: Re: [PATCH v6 5/5] input: misc: pm8941-pwrkey: simulate missed key
 press events
Message-ID: <YmYehgw3eUdRAXYp@google.com>
References: <20220422191239.6271-1-quic_amelende@quicinc.com>
 <20220422191239.6271-6-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422191239.6271-6-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 12:12:43PM -0700, Anjelique Melendez wrote:
> From: David Collins <collinsd@codeaurora.org>
> 
> The status of the keys connected to the KPDPWR_N and RESIN_N pins
> is identified by reading corresponding bits in the interrupt real
> time status register.  If the status has changed by the time that
> the interrupt is handled then a press event will be missed.
> 
> Maintain a last known status variable to find unbalanced release
> events and simulate press events for each accordingly.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>

Applied, thank you.

-- 
Dmitry
