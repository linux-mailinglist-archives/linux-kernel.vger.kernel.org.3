Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF16D5745F4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbiGNHqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiGNHqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:46:13 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED89E32074;
        Thu, 14 Jul 2022 00:46:11 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id z25so1485722lfr.2;
        Thu, 14 Jul 2022 00:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EhSSJXEhZEMBp4Pn5sTwK0oED0S/y3gQS+mDbRM7VjI=;
        b=3RlDL1cXMDE2Yo9HBu9BnqWEfFtkRopdUAFO4trLevTIaUqDAWFv2odqt4cOwk8n2p
         1zZqLFEtPGMLkgRyAp5gQiBjtqFqGTYuKG3YDIBz1bWQhCTwnAWGkGanzS/zJyEegR7P
         8b6/MYAFMzncA7ozO2m0PHHJQQ/zVv7cKqXyHzdITj4k0NoLkSq1r8/5+QHU2Xpw9QtO
         GwnjhuiGRqitxbtuwDnHYpHgbi9EqnMrs5stuPdTQmUBIqU/kofB5TBph8gbZQWv93g4
         bMy5kDx4mQZm9wB6jRKk9xa9BTff5P54+xHVXEAyUsd6jiotj1oBi6AUtz7UuNSYveNd
         xEOQ==
X-Gm-Message-State: AJIora8sQ1Nset6c+WyWYfT4PO4+Vk1ube38mBcU8xk5SVetAuwlzqdq
        DKRaySPftOQ1D1cGtTzecl4=
X-Google-Smtp-Source: AGRyM1vOgwI11l8kxmqHOrANiN2wD3HJe9fQsLc/YTrQ4ryDJ04ME6sxbvvvOSwzFn8oFF61HH58Ag==
X-Received: by 2002:a05:6512:16a6:b0:47f:74b5:2704 with SMTP id bu38-20020a05651216a600b0047f74b52704mr4381285lfb.54.1657784770209;
        Thu, 14 Jul 2022 00:46:10 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.googlemail.com with ESMTPSA id r8-20020a2e80c8000000b00253d4db8a92sm132936ljg.63.2022.07.14.00.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 00:46:09 -0700 (PDT)
Message-ID: <2014e1bf-a8c7-a41b-cddc-dda25ef1d567@kernel.org>
Date:   Thu, 14 Jul 2022 09:46:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] soc: qcom: icc-bwmon: Remove unnecessary print
 function dev_err()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220714072253.63052-1-yang.lee@linux.alibaba.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220714072253.63052-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2022 09:22, Yang Li wrote:
> Eliminate the follow coccicheck warning:
> ./drivers/soc/qcom/icc-bwmon.c:349:2-9: line 349 is redundant because platform_get_irq() already prints an error
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>

This was reported by coccinelle, not a robot, so the tag is not appropriate.

This is an open source work and public collaboration. The "Reported-by"
usually means that the issue was reported to us, in some way, usually in
public. Can we see the report?
Otherwise adding non-public, non-verifiable reports is useless and
clutters our report-credit-system.


Best regards,
Krzysztof
