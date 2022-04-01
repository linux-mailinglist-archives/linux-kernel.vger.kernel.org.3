Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE1C4EFAB6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351525AbiDAUK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351459AbiDAUKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:10:25 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A58926E2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:08:35 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p8so3584912pfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=lb/3ljB0Z+nyG5ugSaAJ2btRazfgku/tmL1wo62IQnM=;
        b=bdsivsEBTI/uPp3I7z2vs5Rdqn3dxYrsYVC1Eezw4DSBAI+Q4VDwVntQrvdr3ec9EP
         PY9plz3V6Kwr5eTjYSZZc2i0p5khLNi2GCuCVr8o4Mzd56iQlpvtKGBB7OkQIQvQBIeb
         lCUN8hUW9gXeryM0gYc5jY4HrlYKTzUFlCwDLbvkAs2G9Zf3F6hNKrMuQ6y1nd0FEZj+
         DUw4+qAxiRfC3+YT1WzpsHbC7bUKDVn8BZHaamNcHuJjUlL7aiJ1HfDu721XW/6TaaIw
         FvoBsof5GEuELCistCX7f8QpqVexGbOgIeEVpxLyCGNpgObECokQ6yWzqlzczTJNDs3x
         AwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=lb/3ljB0Z+nyG5ugSaAJ2btRazfgku/tmL1wo62IQnM=;
        b=uVyZx61tJgzENetb53MMuOKm4qGChh/fO+J/tkLztnbDda0cmplfc+wma3bwtspZqj
         nin/WMwjmxgvd2Uy6VtazYpnTJLkdHYB5FIY9tpz3lDTIsUrT1uXy74BGBjVgf10g1DF
         3R2lh3J9MT27p7mpqy4HQDAVgF8ho9OCv1e2VF8/eG3BwSAy3CgirnBWipaAs5OUjEJH
         +tMZMhDGjxQHSKvM8GOc/T1jxD7l13RdnoiEm5AZLUsC69jJqLYes8RIs2kvHf4L6dyj
         kS/r/2EZaLTQbFHDSL2g88UVbQdYUEQEl/wbDFlfI4W6gGaM8JdmateacgGTXbONeNEW
         MU2g==
X-Gm-Message-State: AOAM530mqe2/FaJ7ddxSm0ZVpbwLM5RXw51kpQz35KXxCDlph01Xm3fY
        BPFvfHF2cpqwj3Mdyk1giYxU2A==
X-Google-Smtp-Source: ABdhPJziEmbLprb0blXlYUPOyBkK1XbuSWyCZyHlxDi5Vvh8NROKeXLmHx886EHC2jKAi+UHKs49FQ==
X-Received: by 2002:a05:6a00:15c6:b0:4fa:aaec:ef42 with SMTP id o6-20020a056a0015c600b004faaaecef42mr12629312pfu.74.1648843714720;
        Fri, 01 Apr 2022 13:08:34 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p128-20020a625b86000000b004fa666a1327sm3925052pfb.102.2022.04.01.13.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:08:34 -0700 (PDT)
Date:   Fri, 01 Apr 2022 13:08:34 -0700 (PDT)
X-Google-Original-Date: Fri, 01 Apr 2022 13:08:32 PDT (-0700)
Subject:     Re: [PATCH] dt-bindings: Fix phandle-array issues in the idle-states bindings
In-Reply-To: <CAL_Jsq+ALvAUR5V4Fv1RohA=-PB0Ry05ETm6OqJ+f=ediGc7HA@mail.gmail.com>
CC:     anup@brainfault.org, guoren@kernel.org, lorenzo.pieralisi@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Rob Herring <robh@kernel.org>
Message-ID: <mhng-40701558-3769-432e-a22e-9a93a270868e@palmer-mbp2014>
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

On Fri, 01 Apr 2022 12:50:39 PDT (-0700), Rob Herring wrote:
> On Fri, Apr 1, 2022 at 2:32 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> As per 39bd2b6a3783 ("dt-bindings: Improve phandle-array schemas"), the
>> phandle-array bindings have been disambiguated.  This fixes the new
>> generic idle-states bindings to comply with the schema.
>>
>> Fixes: 1bd524f7e8d8 ("dt-bindings: Add common bindings for ARM and RISC-V idle states")
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>>  .../devicetree/bindings/cpu/idle-states.yaml  | 96 +++++++++----------
>>  1 file changed, 48 insertions(+), 48 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/cpu/idle-states.yaml b/Documentation/devicetree/bindings/cpu/idle-states.yaml
>> index 95506ffb816c..6f5223659950 100644
>> --- a/Documentation/devicetree/bindings/cpu/idle-states.yaml
>> +++ b/Documentation/devicetree/bindings/cpu/idle-states.yaml
>> @@ -385,8 +385,8 @@ examples:
>>              compatible = "arm,cortex-a57";
>>              reg = <0x0 0x0>;
>>              enable-method = "psci";
>> -            cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
>> -                   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
>> +            cpu-idle-states = <&CPU_RETENTION_0_0>, <&CPU_SLEEP_0_0>,
>> +                   <&CLUSTER_RETENTION_0>, <&CLUSTER_SLEEP_0>;
>
> All the Arm examples are already fixed. You need to fix just the RiscV
> examples added in your branch. Otherwise, it is a bunch of merge
> conflicts.

Sorry, I'd missed that.  I sent a v2 (still trying to figure out what's 
wrong with the checkers locally).
