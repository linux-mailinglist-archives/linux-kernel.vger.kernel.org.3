Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED9352A764
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350640AbiEQPx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345790AbiEQPxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:53:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA4FB83
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:53:18 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ev18so7127736pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Hs0EGDgiC/nheHQjay4f7d4Madw5Vg5K/0RTksKnNSc=;
        b=viw4C9/ootWzvMXVM/iHkeQImM8GisZFZ0TUqXoBE9zK6OjPuTxbFKVlQLtZ4bF4KA
         C8PaogOzBoJCm44PVbijfogy8HSlLmI0WQCKGNuy7tUYLvL3gYICpoII0EeHCI/ethJ0
         HI1kYg+HH4gDRhwwjv/j03aKITL6+IUfisvTAMjthrpeqX7YCWniPtAnOiORvreozlbv
         4IY/wSFj3HJ9G0alg8ssJpSx6WHPzMY7+m+YvPXHTHoiC2ACHuFLAzpA5LbBgTBgjGrF
         sM3Cn9HZTj+gGHGKEM9XO+34k/eeOVT/WRX3FRkWcVs44PbpX0Ehm0z8ieU+wKZ7UeGO
         VMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Hs0EGDgiC/nheHQjay4f7d4Madw5Vg5K/0RTksKnNSc=;
        b=v4+6y/TKKQ5IW0Nzf//Ju0hggKic9r+nDUo0TfbBrOagAjGOtMZ2eciEd3UESyAnhS
         CyeMksaqEL4S8a2imUn1RVrUKRsATKcXETad5j5FFQmZMwO2aIXQnGE8ywuZLy8vN9Kx
         tlt9QQr/8EyF7LxhtJn+uSXIuGRL71nlgZLkJU74NTaVY2mYBQ6xWkMJ/58biO0vGsz3
         7STuoyq3w6vfPh/22a5UDclkHTWuY/S6/ntZ4TH5Gtv0ipAMd0fSLhbatONeE6K2tJF/
         GJnn8TLi33fLFozzxITWoGnBMvb4hNTJC8+q2EQgN2VuTG8D6xRMxsbOF9n8zd+f4IA+
         kDKw==
X-Gm-Message-State: AOAM5304pEL5/49fEikowrV3CsaxLGsZLtxb5c19loAFUAbSjebidt69
        43T2gLiGuTqszGfUfR0hdpidhQGGxf4i0w==
X-Google-Smtp-Source: ABdhPJyCnhFvvuk6ZClBb8fG7LYd4wXxtM1aHKMyOUTynr2YG2isxqa1mMxyv/2NdJpo4oXMmj9yKg==
X-Received: by 2002:a17:902:d4ce:b0:15e:8d66:d20d with SMTP id o14-20020a170902d4ce00b0015e8d66d20dmr22875474plg.70.1652802798296;
        Tue, 17 May 2022 08:53:18 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id cq24-20020a17090af99800b001df1f7c5941sm1875114pjb.16.2022.05.17.08.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 08:53:17 -0700 (PDT)
Date:   Tue, 17 May 2022 08:53:17 -0700 (PDT)
X-Google-Original-Date: Tue, 17 May 2022 08:53:15 PDT (-0700)
Subject:     Re: [PATCH] riscv: dts: microchip: fix gpio1 reg property typo
In-Reply-To: <0f9398aa-ab7d-44e4-033a-e13bf57f88d2@linaro.org>
CC:     conor.paxton@microchip.com, conor.dooley@microchip.com,
        lewis.hanly@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     krzysztof.kozlowski@linaro.org
Message-ID: <mhng-3ddeb279-a369-4eef-b74f-5a4597852519@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022 07:51:32 PDT (-0700), krzysztof.kozlowski@linaro.org wrote:
> On 17/05/2022 12:40, Conor Paxton wrote:
>> Fix reg address typo in the gpio1 stanza.
>>
>> Signed-off-by: Conor Paxton <conor.paxton@microchip.com>
>> ---
>>  arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 2 +-
>
> Pressed send to fast...
>
> Please add Fixes tag, unless fixed commit SHA is not considered stable.

Conor might be asleep, and as it's late in the cycle I figured I'd just 
chime in directly.  This LGTM, I usually add fixes myself if there 
aren't any.  Unless there's any objections to

Fixes: 528a5b1f2556 ("riscv: dts: microchip: add new peripherals to icicle kit device tree")

I'll put this on fixes.

Thanks!


>
>
> Best regards,
> Krzysztof
