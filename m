Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0172F58C5C0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242532AbiHHJkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiHHJkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:40:11 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1D513D5B;
        Mon,  8 Aug 2022 02:40:10 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v5so4524073wmj.0;
        Mon, 08 Aug 2022 02:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc;
        bh=E3bObQeNWfAS5QLgPfg7sUMtK4GVNOyK0s/0eKslo1E=;
        b=n4xUNwYQrBnm7yU1iGLZpKf4avwTo8LzGpGAFml+IcMOCih7ZytxcIj9i12FoTpbfb
         WmSv0fBhNWf99Ds83zZpeHzXoq+lR7ADgY4GVgMQHrTdlIeueoc6V7uIjfnvWdNrhibY
         G6lqnpTzuOb7h7Yjs2jryiol0LrYnS99GndSFqzE8eTQrqFUbSq3ZdS5tLZ5+j9j+l/X
         FjZgcy/qWFxw1RzKasEYON1VI+W9MmW77utx3YtqVea75CKjEiUCU1XdkfPI5QRmojWh
         uB1GxDQLxnlB0PqsZebMAvLZiZ+E7PORCaJhDzYHzdCgMZVYITpi8qNRTXTL+MOf8R+c
         +6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc;
        bh=E3bObQeNWfAS5QLgPfg7sUMtK4GVNOyK0s/0eKslo1E=;
        b=RtT/UdKGDwR1t4djcbAZ3Qwv+VLYIn/djrfsQ//JFv3T06sh9FdZMfBP6UedNJ2MZE
         Qbws6lal1lNpOpiJabLqf7P2+3L9bsM0oZloTJf+jHTPDUvB6gF1zByTxpoGpNP68sVm
         c0e7AclDzctUIZdJoYjAEkNYAy2zbYxs1ll0K1CArFFj8Ep8ym4q2aOGj/6EEUPXAzvv
         ctJb1DZyEfRZoujetT4vblL8NpKyH20W5UKNioRh/alITeasmAgDx6radVyU/BjVd5UW
         5YCfhyGToMIcDwr4MUgMtPKzQEhSncPO+2928pbOEUwVfPlhH94hd8yzE422G80I1jCl
         l8uQ==
X-Gm-Message-State: ACgBeo3fmOKYsg7zrxcRfOBZ79oZj9JehOxciOEJ3RE2tMgQkIKxn4fJ
        UfYjT3XsmDcbK73XGCIgVuWlZbPHrdE=
X-Google-Smtp-Source: AA6agR4/6G3DlxLmRq8Mu7z7qLd96SSuOojjEF8KqJN4qHkHKABstR7DeLNpfNf3cJEbffptuI11bw==
X-Received: by 2002:a05:600c:509:b0:3a5:2c2:fb40 with SMTP id i9-20020a05600c050900b003a502c2fb40mr15355763wmc.163.1659951608773;
        Mon, 08 Aug 2022 02:40:08 -0700 (PDT)
Received: from [192.168.187.232] ([105.235.133.28])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c4fc600b003a32490c95dsm18724131wmq.35.2022.08.08.02.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 02:40:08 -0700 (PDT)
Date:   Mon, 08 Aug 2022 10:39:47 +0100
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH 0/8] power: supply: Add driver for Qualcomm SMBCHG
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <BUIAGR.NIMOFVJH9GVZ1@gmail.com>
In-Reply-To: <a233730b-6ac3-2cb9-cc5c-21ca6289fadc@linaro.org>
References: <20220808073459.396278-1-y.oudjana@protonmail.com>
        <a233730b-6ac3-2cb9-cc5c-21ca6289fadc@linaro.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Aug 8 2022 at 11:41:26 +03:00:00, Krzysztof Kozlowski 
<krzysztof.kozlowski@linaro.org> wrote:
> On 08/08/2022 10:34, Yassine Oudjana wrote:
>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>>  This series adds a driver for the switch-mode battery charger found 
>> on PMICs
>>  such as PMI8994, and referred to in the vendor kernel[1] as 
>> smbcharger or
>>  SMBCHG. More details on this block can be found in the last patch 
>> message.
>> 
>>  This driver currently supports the charger blocks of PMI8994 and 
>> PMI8996.
>>  PMI8950 was also to be supported, but it was dropped due to some 
>> last minute
>>  issues, to be brought back at a later time once ready.
>> 
>>  The OTG regulator remains unused on devices where the charger is 
>> enabled in
>>  this series due to lack of a consumer. Applying a patch[2] adding 
>> vbus-supply
>>  to DWC3 allows it to enable the OTG regulator making USB host 
>> without
>>  external power possible.
>> 
>>  [1] 
>> https://github.com/android-linux-stable/msm-3.18/blob/kernel.lnx.3.18.r34-rel/drivers/power/qpnp-smbcharger.c
>>  [2] 
>> https://lore.kernel.org/linux-usb/20200805061744.20404-1-mike.looijmans@topic.nl/
> 
> How is it different from PMI8998? I expect not that much, so this 
> should
> be based on existing work:
> https://lore.kernel.org/linux-arm-msm/20220706194125.1861256-1-caleb.connolly@linaro.org/
> 
> Unless they are different, but then please create common parts and
> explain the differences.
> 
> Best regards,
> Krzysztof

This driver has been in slow developement for a long time before that 
one existed, which was why no initial attempt at a common driver was 
made. With that said however, I've been watching its development even 
before it was sent for review, and It seems that the hardware is 
actually quite different. For example, the original charger entirely 
lacks the type-c functionality that exists on the second gen one. There 
are a couple of similar registers like CMD_APSD (same address and 
function) CHGR_CFG2 (same/similar function, different address), but 
other than that there don't seem to be any major similarities. While I 
guess it would technically be possible to force them into one driver 
with multiple register tables and separate functions for most tasks, I 
think it would just unnecessarily complicate things. One thing that is 
common however is the secure register unlock sequence, which I have 
separated in patch 6 to allow for its use in other drivers (the fuel 
gauge block has secure registers too so it will also be used in an 
upcoming fuel gauge driver).


