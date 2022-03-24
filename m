Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC644E658D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243117AbiCXOoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239735AbiCXOoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:44:10 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA25AA029;
        Thu, 24 Mar 2022 07:42:38 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id u16so6957611wru.4;
        Thu, 24 Mar 2022 07:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PQMoVevKF2FScu3g6ZPhWCjF/L215or2YeKuSEJ/X+Q=;
        b=GfT4+Y3nsf/49O2bV/NzAGWg32R4wG4IaufphIOecOX3QK4hoeU3etMrXx4IOK0EWS
         s3zjHzuWJS4xBZ1DxiXgge0hJBVFf6GivwhxDEmxpiKC3yMeiFmTnNy19CsWBZ2YiNKj
         1tc7bHRV8C5rBNLXIDl+mw0qxvL8Syx+LMgZwOAJCU61w3z4ZTi5hDo0k6sJt0xfsCoU
         dxn0KPyOaIZ4f6wjXZXS61tF8PTrzaFZ52IAb88JUfHOIxlw438E9m9fblYk/KXyO3Nd
         JPCs7aDLF8Ez0lfgKgiRXbIky7WbNhYHFOfMIci376+7hd/O6W4iyHwVJIuGyrnCKN7Z
         OPCA==
X-Gm-Message-State: AOAM530E3kDqu0IQ+Aum5RT0YIejoIf5f/xS0rrxiURAVdFEAN5zt29O
        +LuXduklll2CWz24PUVC8iU=
X-Google-Smtp-Source: ABdhPJwgBGfPjUkgJ2azkYYT03xYB3rKxjLU69OYrP8YG6qnZcrqB/DIBhJKV40R82oZKNaLmkLdaA==
X-Received: by 2002:a05:6000:178c:b0:204:648:b4c4 with SMTP id e12-20020a056000178c00b002040648b4c4mr4919136wrg.219.1648132957406;
        Thu, 24 Mar 2022 07:42:37 -0700 (PDT)
Received: from [192.168.0.157] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id n8-20020a5d5988000000b00203d5f1f3e4sm2952039wri.105.2022.03.24.07.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 07:42:36 -0700 (PDT)
Message-ID: <bce3b04f-d0f2-62e4-e983-9c7ea74f7309@kernel.org>
Date:   Thu, 24 Mar 2022 15:42:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: clock: qcom: prevent interpret of See also:
 as keyword
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, krzk+dt@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220324143935.1117426-1-clabbe@baylibre.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220324143935.1117426-1-clabbe@baylibre.com>
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

On 24/03/2022 15:39, Corentin Labbe wrote:
> The "See also:" in description generates a DT check error since it is
> interpreted as a field. Setting description as formatted description fix
> that.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---

Already sent:
https://lore.kernel.org/linux-devicetree/b15567c7-98e9-2d01-d1a5-7675136c625d@kernel.org/T/#t


Best regards,
Krzysztof
