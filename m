Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E2F53FE20
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243325AbiFGL5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbiFGL5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:57:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F6C35872
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:57:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z7so22640374edm.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 04:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yZDBuoVlQ71P4cKl6Kapb0clRrwsrrvDiAbyCiR8ot0=;
        b=Kmk6lPezqek4hazrchUlF3SwI3blkWE9a1Oms0ehWdjz94uADugBjeyrjtU+zCmV5N
         6QdG/2Bp5tUYJlu2RG+1e4G2I/90ULDJ5R4iK0op0G7znqXcM+7HPC1RyhkUqjPqMW11
         xOMNnKBoLfZOfZszGKbaxBrJOF6CW+upTZhvQiSoiTHqjBtbMH4IuqjBcs3dSdsvvcNc
         vWa0tpEdLOPruoTK0oK3kde6/E5DgsgRJkEGZ2tSAF773DHvMAwvo2LkxfkvTyryz/kj
         0J4KcNpXIPrTcXOEztHmQ9bQfP0haiJeLKYMQkmFraHHqEr1UpbC6clqXTdpHsk9gswm
         ecEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yZDBuoVlQ71P4cKl6Kapb0clRrwsrrvDiAbyCiR8ot0=;
        b=eqYg+FiCMGBxZTSqkwFhU0v9NGdKtsCZj5hTVQDY9ksZJFEw5cy3YAMm/NC8EA3sBb
         BJiL4xQOTDeBPgsdIQnJPgyq1BOlMZakaJO7WTzc86/wzo/clrGnHLFvdvkiFSuBHWz0
         DqXT0zc07UJZZJxO2wWaVCLAFUpqJN3+HG2+y9roKSReRHIoD1lmzpkf8xRcAGngsX1e
         /Xi4W0WRAoIs9yYnfPS9RxgKo2IQDtJbJ0VmCiqyn5ckqcGFh3N0Fhos/b8WCxHyaxhF
         PcO5hPBxcpYiiJC94nrZvzOa2vy20FMtSoOK1qvcD+89KiNb68UFhOFwlF3hHomb+6Mr
         LIFw==
X-Gm-Message-State: AOAM530RW+ZpTi5fFfb6nZZYragePFYOgY6pPOMBIC28vEKcdfG4S3su
        UKJEdaPDzAhg3HSCseZ/eKQqTQ==
X-Google-Smtp-Source: ABdhPJy5IOhjy3MQT0HkzRMlUxWQFG4EiGON9lppvA3+TQzxKlphzo1A5dyIGWXxh/ppAL7ZzunKkg==
X-Received: by 2002:a05:6402:289:b0:42d:cd82:be22 with SMTP id l9-20020a056402028900b0042dcd82be22mr32920366edv.373.1654603061912;
        Tue, 07 Jun 2022 04:57:41 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id da7-20020a056402176700b0042e032164a4sm9126964edb.61.2022.06.07.04.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 04:57:41 -0700 (PDT)
Message-ID: <7aa025a6-a08a-a11f-3931-7a1a0750a15f@linaro.org>
Date:   Tue, 7 Jun 2022 13:57:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v17 04/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Content-Language: en-US
To:     Qin Jian <qinjian@cqplus1.com>, sboyd@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        mturquette@baylibre.com, linux@armlinux.org.uk, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1654565776.git.qinjian@cqplus1.com>
 <8f5673ae8730ec117c1d8fe1e28fb50a2216e891.1654565776.git.qinjian@cqplus1.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8f5673ae8730ec117c1d8fe1e28fb50a2216e891.1654565776.git.qinjian@cqplus1.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 03:58, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 clock driver bindings.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>

Wrong address...

Best regards,
Krzysztof
