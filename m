Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04F84EFCCA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 00:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbiDAW2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 18:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349165AbiDAW2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 18:28:25 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB735DE72
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 15:26:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f10so3596333plr.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 15:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=hL8EOWPJGWOqw+OHvmJ0rPyDC9uu4lp7w06UAGgNiYQ=;
        b=OkaLEE9Ea//1wCZe8xLT6rX0RxVQuguU88/Yg5GMBlQYc3WWhpRhzHBBvs5pHf74bW
         ttLfcpl2y9uTuycVMewYQfXsF/m+nBt67aatHkJF6avXRL3HVENqJAD/GuJcjCmnttoJ
         zsMQ62F9aqSz8SuuWnUNiPHG2jnSBtaJZBYH7Y/xI0iQs38MWjHp7jNvCBY6dJQfO3ez
         05OkUZ3mjypCpq5yi/bU4eCX0CnShL0m1CylQfJxbTa/pteU+eg+DOh8lc6Zs/bRgcbl
         6Tpm7y77yEawxzwEmB6d7GWXw1EWxb2P0ZtdGstQ4V8Xe0dPZVBqlBvzP6aIvVXYI89n
         8qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=hL8EOWPJGWOqw+OHvmJ0rPyDC9uu4lp7w06UAGgNiYQ=;
        b=00o9cdFQEmIfDBpiGkwSoIdcbxDnpE3y2yvJZrdbf0FGseyh3ujR3yEG9W/QDr5/Ge
         mm81syW4+zZeMnE8iuonA2TioAJU/Hi18ngQ731OA4bbSARKzAuxGVxPb6vUCLwg4g15
         h3tOD48DLhl7DjuRLVd9wfXnIbfxGuM84XCie1gMxeowk9mbglKEwdAjIstzuD6Nev2H
         S/Lr698PN3YX8t161TqDG9Gr8rXrFkB5cHA5aJKbwj9llSQ95fN1EnHaroWWDs53oKYg
         ch5DxNSWlKQ3XVARL8VxiIDGIjZa1s6YsBUf6PRgGDO+TMEgxU0y7R4+RYELk6Xt8mDK
         Q+9g==
X-Gm-Message-State: AOAM533G29W/WqeWup3//Ly7a1EqFATiL8lM2mGUFqL+iMR90SyPmPwH
        bPW6sYiOSGIotWULFlDraBQi/w==
X-Google-Smtp-Source: ABdhPJx2DXYwk/E1pfjC95cynZA4QLNpg8tA47jB2+kLAG2H20ot637Xai8u+Ufjg7FGFOlOwDzxoA==
X-Received: by 2002:a17:902:d4cc:b0:154:3a3b:4172 with SMTP id o12-20020a170902d4cc00b001543a3b4172mr47834031plg.165.1648851994639;
        Fri, 01 Apr 2022 15:26:34 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b17-20020a056a000a9100b004e1b7cdb8fdsm4446449pfl.70.2022.04.01.15.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 15:26:34 -0700 (PDT)
Date:   Fri, 01 Apr 2022 15:26:34 -0700 (PDT)
X-Google-Original-Date: Fri, 01 Apr 2022 15:26:32 PDT (-0700)
Subject:     Re: [PATCH v3] dt-bindings: Fix phandle-array issues in the idle-states bindings
In-Reply-To: <CAL_JsqL8swP_NuMUiBeRrYhQ2XQct4uPxinOaE4dnn0K8mB1Wg@mail.gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, guoren@kernel.org, krzk@kernel.org,
        lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Rob Herring <robh@kernel.org>
Message-ID: <mhng-fa8b59bd-f4b0-46c4-90e6-4dd41151afc2@palmer-mbp2014>
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

On Fri, 01 Apr 2022 14:39:24 PDT (-0700), Rob Herring wrote:
> On Fri, Apr 1, 2022 at 4:36 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> As per 39bd2b6a3783 ("dt-bindings: Improve phandle-array schemas"), the
>> phandle-array bindings have been disambiguated.  This fixes the new
>> RISC-V idle-states bindings to comply with the schema.
>>
>> Fixes: 1bd524f7e8d8 ("dt-bindings: Add common bindings for ARM and RISC-V idle states")
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>> Changes since v2:
>>
>> * Add the missing schema requirement to riscv/cpus.yaml
>>
>> Changes since v1:
>>
>> * Only fix the RISC-V bindings, to avoid a merge conflict.
>>
>> ---
>>  .../devicetree/bindings/cpu/idle-states.yaml     | 16 ++++++++--------
>>  .../devicetree/bindings/riscv/cpus.yaml          |  2 ++
>>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> Reviewed-by: Rob Herring <robh@kernel.org>
>
> Thanks for fixing quickly.

Well, sorry for breaking it.  I've got the DT checks running locally 
now, we've got a handful of errors in RISC-V land.  I'll clean those up 
and then get something blocking my merges, so stuff like this is less 
likely to happen.

Looks like Linus just merged my Part 2, I'll send along the Part 3 just 
containing this as a fix.
