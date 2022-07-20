Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E36157B5F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbiGTLxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiGTLxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:53:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9192158843
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:53:37 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d12so29803148lfq.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=09cWl3V96TWQv3d8UHsR2lliOx8OltZ+KZfcngmtCW4=;
        b=N9v7s5gt9H7j18ZEyfZik9iw2gBwdQwR/2ukekKGILcD8t35jqrpYxfsoF0xnboSqk
         QaKXQCI+RNeA4P+eFQDlAm+22SwMsnepBVbXN78TyDjrsd4SQZc9XHcMTDrM2PN94y8u
         VNca1DMjxaq98huzT4sPmCkafIq8Lq8xYvUETSMcGKPChJin0T3YONB18QkVufztSV2G
         WscjwykjxAg5RbwJI3ZXatB3Il5W5hldkJ2FNi28h1JjDwWX0va4D4p/3i2f2n8JElWo
         J14WLmBcNeQ2bylnLf65oaCZMTW0kCVgSTub4GVctUKW/+GSZ9AK1NVMB1XhpoZoqNuZ
         y71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=09cWl3V96TWQv3d8UHsR2lliOx8OltZ+KZfcngmtCW4=;
        b=6ojCPdPZtLpcHMe/UAIdMLs2g44ZKC3eyWw8NYCJWbsLjMlbgLPk8drh621xqIY0N2
         wKAbuf1grUs9jPWQd8UOHGWe9Oc/C29QhLDYB56yecm56BUJKOPosMoLG8lfxqIXahoo
         8JKaqE2Jl+mQyji3q/ECgAe4pSDy5HWW4p6fpUYz92xFC5X0wHv0OZyzn1rN+oISKLR4
         gbcX7/F9qBnb6StWMQem95sF9zB042wTkL2AuoJ4/1oicgv5O25LOmQ3ZSLm9Q2kKtPC
         yWnGanidxKA5PRNtXEhuYPV1vQQrVhYL5Jwjhw5g21OI7rU9HQwx8fy5eFHPDEBtafWD
         wC8Q==
X-Gm-Message-State: AJIora/6hdpJe5FS1XuYNaE5pSUenXEQrd+fRoe9OmTaS+ThHkqkDI/3
        TpYE/jqRZnSdIfyuETknyMiB53jMFNcBwOAP
X-Google-Smtp-Source: AGRyM1u46E2HoQ11nl19eIMCT3ArSeDlAAeDBSwXdxdgCYVtIRUyx1+W+o72Qr8KxDlotQZ4+fAq4A==
X-Received: by 2002:a05:6512:2308:b0:489:e0cd:7ce6 with SMTP id o8-20020a056512230800b00489e0cd7ce6mr19323193lfu.145.1658318015925;
        Wed, 20 Jul 2022 04:53:35 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id m7-20020a056512114700b0047a0300746fsm3759497lfg.304.2022.07.20.04.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 04:53:35 -0700 (PDT)
Message-ID: <aff0b666-44ea-b8e4-20d0-548b4e568f53@linaro.org>
Date:   Wed, 20 Jul 2022 13:53:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: clock: Fix typo in comment
Content-Language: en-US
To:     Slark Xiao <slark_xiao@163.com>
Cc:     david <david@lechnology.com>, nsekhar <nsekhar@ti.com>,
        mturquette <mturquette@baylibre.com>, sboyd <sboyd@kernel.org>,
        robh+dt <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt" <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220720113139.17982-1-slark_xiao@163.com>
 <b605fc88-a0f7-b914-0d4d-49c8415e1016@linaro.org>
 <3f675161.7fa0.1821b7088ee.Coremail.slark_xiao@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3f675161.7fa0.1821b7088ee.Coremail.slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2022 13:48, Slark Xiao wrote:
> Hi,
>  I also want to commit the changes only once. But the maintainers or
> reviewers are different for each file.

Maintainers of dt-bindings (which is considered the subsystem here) are
not different each time. Individual bindings are different thing, but
they do not pick up patches.

>  This typo exists not only in Document folder, but also for other c
> files or header files.

You send it for bindings and I did not comment other cases. Although my
comment applies there as well - one commit per subsystem.

P.S. Avoid top-posting.

Best regards,
Krzysztof
