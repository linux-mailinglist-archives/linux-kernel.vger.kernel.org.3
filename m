Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2685158A017
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 19:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiHDR60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 13:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiHDR6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 13:58:23 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4189121E0D;
        Thu,  4 Aug 2022 10:58:23 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id m10so162197qvu.4;
        Thu, 04 Aug 2022 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=W987ISPP8Bt+GvPSaheTpa/RjLogy82MS47AqufvqOQ=;
        b=i+nKXSYOOUP/QJ93RLbSO+PMCjXUtJ+kPrAa9KZPCL1LkhEzJ56hUheHuSZ7FGEMWf
         gYnclTUYeh3Sl/4F0utuI+BBJ4xPZiJRjriAd2bx5AVkT7RCuW8Wm/BifQuopk1Eaqi0
         wO9H/Zb5Jg9YYTfmvLFZH2RQv51rarFphZrW7Lcv7WTgUEiZ8ldOLZeulBSb1+RBtq+a
         3uiwRFggCR3IdrWJUOGSHKPkYZMd/tnbXHIkbLxB/gNJCav0QgTV4A835bgLvPn5Lmv4
         TOOWGEfcmH1LpQ+DNCgSDgmiw2ekwJSfM2kByzwCBC/EO6OsuhksAhjpW6oKwIKd406E
         TQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=W987ISPP8Bt+GvPSaheTpa/RjLogy82MS47AqufvqOQ=;
        b=oejE7Sp7ngk+Bh6AtcDxNEGk8/NwlZ41UfOmKT4iE3Gy+Ug1XDdzFoIhKX/oJ3qGIq
         3h4uvZVuTPirKkUrN034p1emwl+RFGm1iF12Q1hz5MiIMwGRSGOQrLLIc1hTFuZyFxiU
         vNDiar/y5Tf8tTsjxboqUwq5sBvg9eRdcbMQ3fQMTY4N9/4sBnD1nGV4tAevnl72x10I
         dHOuM3DVY+LZWTZojeny+fLjaXAbL23GW//7N61rrbNUursWK2R2izmn5XsKM7Kdee5A
         /GVYvFM/Bs4MNx8oDlPGi6CEnx4cLzwy/3zJLIRqHUtGu7fEacgQkhL0p0n3TLmMuFFV
         9BdA==
X-Gm-Message-State: ACgBeo1OeZisYmeTLRBuWHESgiKOezV7teVq2IL2r05XBUF9y/3lTSkq
        rgKNOgntY9ms5MluHHeUV9s=
X-Google-Smtp-Source: AA6agR6RRgiCyOQAc1M8ENCbjusdjVFACKzmkbSQThj9jB1ZNRgwciNDNoRM0AXgGnKcQKjrAOOd8Q==
X-Received: by 2002:a05:6214:e86:b0:476:6129:25fc with SMTP id hf6-20020a0562140e8600b00476612925fcmr2507126qvb.9.1659635902279;
        Thu, 04 Aug 2022 10:58:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e13-20020a05622a110d00b00339163a06fcsm1131062qty.6.2022.08.04.10.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 10:58:21 -0700 (PDT)
Message-ID: <c7fea2e5-eeb7-cd66-dc42-9fea98cfda9d@gmail.com>
Date:   Thu, 4 Aug 2022 10:58:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] clk: bcm: rpi: Fixes and improvement
Content-Language: en-US
To:     "Ivan T. Ivanov" <iivanov@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220713154953.3336-1-stefan.wahren@i2se.com>
 <20220725081838.nd2tsjcw4uiapl5k@suse>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220725081838.nd2tsjcw4uiapl5k@suse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/22 01:18, Ivan T. Ivanov wrote:
> Hi,
> 
> On 07-13 17:49, Stefan Wahren wrote:
>>
>> This series tries to fix and improvement the Raspberry Pi firmware clock
>> driver. This mostly focus on clock discovery mechanism.
>>
>> Just a note patch #3 depends on patch #2.
>>
>> Stefan Wahren (3):
>>   clk: bcm: rpi: Prevent out-of-bounds access
>>   clk: bcm: rpi: Add missing newline
>>   clk: bcm: rpi: Show clock id limit in error case
>>
> 
> Maybe is little bit late, but still :-)
> 
> Reviewed-by: Ivan T. Ivanov <iivanov@suse.de>

Stephen, can you apply those patches? Thanks! 
-- 
Florian
