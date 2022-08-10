Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFCB58F413
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiHJWBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiHJWBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:01:42 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD9B8277C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:01:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x10so15422087plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=jp9l0Ro/JdxDhmDJRS2kwEBWz37R0gfYtLWESZmTTdo=;
        b=pR/Uz73diROtKoK45pSsnr9gDkyqdToZ6bxo/wDiwdfGMSRghz3CDbk46kMtQwAFO3
         x22iXNjmkw6auGPluUNkD2GpzL9z734QfkCy9bn0Gv+2AgX5bsK1CBg+TTz2q4Lb8a0u
         3T6PRK5CoElkC2XrFW0em//AvrYpm+7+C4IJZVYZJR71jicazAfVHoEokRhkpuEu2OiY
         CCXQUmnc6fWyvGdzopEWFni24vLVkD1UncUMn+2pHen8sb5PGlGazWUWsWvcPabpO10+
         F1qMKGxOoXI3JW1qYA6ANnXZml7AHYP11NQa0uG/wg33C4hNlUfavJ68c6gZ3kNZaK36
         SQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=jp9l0Ro/JdxDhmDJRS2kwEBWz37R0gfYtLWESZmTTdo=;
        b=0RhL1WrlqZMiXgDL2qFtyIvuF7bysTJkfptE7uKQ1YW6BYoblzqRFau2iIqymZU8jm
         JDOgiuP7byAEI7vX31Mi3iuG+sEOuHOTPIGXTtl/yskHPYzvuV0Ae6SVSG40pcaTOvBG
         z3X99SayOWxDzd0j9oVY78EPGgB6BQ3tvv2gLi4bo55tTzS1mvhCIGitIx5z7iAO6XLZ
         Ks/rFbMlCw/hQpXBTu+GpKRNPFcMFWzNVrTeWeoLWR3nq2DhO7foio1ED6DkT14dSB7x
         npUvGQzlYttpcRLjdvdRjfXAawDZZAzHaJ91OSWhkvd2LX2YtUnQc6aQgaaumOdpop1t
         j4/Q==
X-Gm-Message-State: ACgBeo1w60SWoJaG6+HBv3N963uaUj75bg9MSG8f2sySm2hF6smDTFSP
        sjP8o9cSYnwf21KYVQklJL/5tw==
X-Google-Smtp-Source: AA6agR7JMJRtaF35vTSx4M/wwukmZAy0p6XS3yEu9BKdT7sblcvfXr74D3tJ4lir0IU2VY1RyB2MJQ==
X-Received: by 2002:a17:902:dac7:b0:16f:13c6:938d with SMTP id q7-20020a170902dac700b0016f13c6938dmr29705635plx.11.1660168900898;
        Wed, 10 Aug 2022 15:01:40 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902da8600b001618b70dcc9sm13779572plx.101.2022.08.10.15.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 15:01:40 -0700 (PDT)
Date:   Wed, 10 Aug 2022 15:01:40 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Aug 2022 14:38:28 PDT (-0700)
Subject:     Re: [PATCH v5 00/13] Canaan devicetree fixes
In-Reply-To: <338e4fd5-9d6d-6f83-30fb-3ab3ed0ead31@microchip.com>
CC:     airlied@linux.ie, robh+dt@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel@ffwll.ch,
        thierry.reding@gmail.com, sam@ravnborg.org,
        Eugeniy.Paltsev@synopsys.com, fancer.lancer@gmail.com,
        daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, masahiroy@kernel.org,
        damien.lemoal@opensource.wdc.com, geert@linux-m68k.org,
        niklas.cassel@wdc.com, dillon.minfei@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor.Dooley@microchip.com
Message-ID: <mhng-1373d9c2-ae29-488e-b2c1-032ab2cd52ba@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Aug 2022 10:51:00 PDT (-0700), Conor.Dooley@microchip.com wrote:
> On 14/07/2022 23:11, Conor Dooley - M52691 wrote:
>> On 14/07/2022 23:04, Palmer Dabbelt wrote:
>>> I'm trying to sort out how to merge this one.  I'm not opposed to taking it through the RISC-V tree as Rob's reviewed/acked the bindings, but just figured I'd say something before putting anything on for-next to try and minimize confusion.
>>>
>>> Unless I'm missing something it's just patch 3 that's been taken so far, via Vinod's tree.  I've dropped that one and put the rest on palmer/riscv-canaan_dt_schema, if that looks good then I'll take it into riscv/for-next when this loops back to the top of my queue.
>>>
>>> Thanks!
>> 
>> Patches 1 & 2 never got review from the DRM side and patch 12
>> depends on those. If it comes to it, you could drop those three
>> (and patch 3 that Vinod took). The only other one is patch 4,
>> which has Krzysztof's ack as memory-controller maintainer, so
>> that one should be okay.
> 
> Hey Palmer,
> These fixes have been sitting on palmer/riscv-canaan_dt_schema for
> a few weeks now, without an autobuilder complaint etc. Could you
> move it onto for-next?

These are on for-next.
