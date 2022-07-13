Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50728573B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbiGMQ00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237093AbiGMQ0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:26:24 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE0F197;
        Wed, 13 Jul 2022 09:26:22 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id bh13so10917322pgb.4;
        Wed, 13 Jul 2022 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=crb5cIXxi4gQ1vTPA/VLZMHirV73SnIKGrsPdVuQdLI=;
        b=WQdVZcuMsp1zBR0WXGRaAg2tM3B5oVRhw55kf06DgY443JkE0cXl6mHZYz9wj0RMwb
         gqtETEHgJuYl67U+m1DZGitFtKfI6kdx/FWnr2ofiPmpcFZ8LNzsRRcVMZS9Lc7a9+2L
         ShqAD0md/x8O8a8vDCEynjOYPN618hjDTUgnyLyoTSzKtzKcUHSoxlw5VWJLvDQIIK8W
         W5ddwNrwqd+vHq57qlHdrWNMDhVtXIB7AlJobYb1cpKTxDToUG9Yxvgw6qft9vaxg8hU
         iM1CNPsJYXEbLVB9PARKyAr9MNRn3uF6cZd6pg73NYRrUtrqiz6BdnamCA6ZhfDiK3qU
         i1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=crb5cIXxi4gQ1vTPA/VLZMHirV73SnIKGrsPdVuQdLI=;
        b=1Vo6AxgPGeCccDfCXw97uTl0rM6XeZU8tqg0iF1rsDEHt0HAGTw6i2T2pN+eg9Bb2l
         0+/fsTo9nVvubfVWGSKGpYHLaoPKUphaqwAMoOigTwxZXjoxVvCOokqvmlUGZo+rwDAN
         EHFzMiCKnkpsC54qVoylUR3tA/icqYHUay4uNQ2BHOcS3U3Bzui17glwzlO4eBJ/e5DZ
         2pGdrJXUlRs6hHAb3cQWHI/RievjdL6flWhpx4yoATbncb8b9SIhx+mmRZKHZBvRUnJQ
         n+tyPeabpfoOmCRoJuSs5084V/LgjQmbg49WnMvj9Ybi1iHNDW4rbiMvJQs20eqvzqg1
         TMcQ==
X-Gm-Message-State: AJIora9zv52PEKY1DwMxZHo4FsydAyjkXzt/2pjXBwxmKvUXmWylc/s9
        bqf53KdZ3NqymAmrjQHNH2Q=
X-Google-Smtp-Source: AGRyM1ukRYaPF/Fg0YeFLTKFaZTsCVc1GLBmxzTNqjtvqslCi/+eD2WIWwxHXXJRFBKZBYG/TyPp/w==
X-Received: by 2002:a63:3cd:0:b0:415:f76d:fb4 with SMTP id 196-20020a6303cd000000b00415f76d0fb4mr3505407pgd.587.1657729582428;
        Wed, 13 Jul 2022 09:26:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id m12-20020a63710c000000b0040d287f1378sm8155638pgc.7.2022.07.13.09.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 09:26:22 -0700 (PDT)
Message-ID: <1c3449c7-4f89-7678-f782-8cc03753f1bf@gmail.com>
Date:   Wed, 13 Jul 2022 09:26:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] clk: bcm: rpi: Add missing newline
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220713154953.3336-1-stefan.wahren@i2se.com>
 <20220713154953.3336-3-stefan.wahren@i2se.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220713154953.3336-3-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 08:49, Stefan Wahren wrote:
> Some log messages lacks the final newline. So add them.
> 
> Fixes: 93d2725affd6 ("clk: bcm: rpi: Discover the firmware clocks")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
