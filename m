Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11E65A6BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiH3SCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiH3SC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:02:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F24DD8E35
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:02:01 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z25so16611341lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=rV2P84xUNVqPVFjIY/cfJG8wQFz15z4LYz2+mwi8MTk=;
        b=FarRtnmEy48IlMNA8DVfP5dXOKXx6+oFNTbl26BMkBhHapWuTcz1A6ndPgAv2suwOs
         peqJZ+9Oo8NjfAdohCLJAqq2Do9EY5QHn5N3TYhb8bdCujmKYANOMpvGXT0KsNc4HtLV
         sADxUwXtb3wjhKsakKyeObDDzsvqo6CG+zPSOu8MMIVSJ7JoOIT4h0dKG+XtP/M3JwTh
         B1kaXbgkSC/SwANsvduYcFKhEjvZ1CSx4qScQOpDZqxnzDEAFLI8VeNvDIPqj00UAtIi
         5c94ERhd5s9gjO6yFJlCPlXJKFusUwPufkaiCZH7x8PeMLf5h9Np4JCoAOn+dxc9iUFy
         Ky1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=rV2P84xUNVqPVFjIY/cfJG8wQFz15z4LYz2+mwi8MTk=;
        b=z1lzjdWJuf7fVxmD1Yiq+dr79NQNSPWNAMl5b2b5MW2a8trxKVC74jZMcvp1k/T1pb
         zzSGnvD1rz4UlYJQre/m8G1aTkpTeS79b9TF4WgS8xHG3mRuBeY8bPd8EHBj64+NtRw0
         dwvBOOUDCZMdBy523lnV+N4GXf+lPZMAdHfWR4uywqtz1J9IqovRuum7U/iVfZWbKuTM
         PtW7ttr/X5gtPy7ddLLvLBJkxbkWwn9vgBLCVDCmP70YkLkFuQbGH+KCLrqSnqiKb5U3
         ut8OzD0IrAbWqgGImwvgmh+mrXqg9axoP/L1GK970TY4FoCFIgbeh1gnSdCL3fILnQyx
         mc/g==
X-Gm-Message-State: ACgBeo0Def2wITZNQ+EIOIr3UhtBhylO7D3PIGXRMGDzOKC1gW8l1g9z
        1GEMwcEpeKk95fF4P9/LAjVC/f9DQ4Nhh3aT
X-Google-Smtp-Source: AA6agR6rihyNh2OTVB2Soxv/9rxjDuRwTpQGYYqAH/bv7lG+iiyLHWzk3r9pTzfPFx75VqSWvMULCg==
X-Received: by 2002:a05:6512:3d19:b0:492:ee00:eb16 with SMTP id d25-20020a0565123d1900b00492ee00eb16mr7472510lfv.60.1661882518647;
        Tue, 30 Aug 2022 11:01:58 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id n25-20020a05651203f900b0048abf3a550asm1676499lfq.224.2022.08.30.11.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:01:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, qinjian@cqplus1.com,
        krzysztof.kozlowski@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: sunplus: sp7021: drop incorrect spi-max-frequency
Date:   Tue, 30 Aug 2022 21:01:54 +0300
Message-Id: <166188251001.15253.12015913287653354511.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220810111131.281262-1-krzysztof.kozlowski@linaro.org>
References: <20220810111131.281262-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022 14:11:31 +0300, Krzysztof Kozlowski wrote:
> spi-max-frequency is a property of a SPI slave device, not controller:
> 
>   sunplus-sp7021-demo-v3.dtb: spi@f480: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected)
> 
> 

Applied, thanks!

[1/1] ARM: dts: sunplus: sp7021: drop incorrect spi-max-frequency
      https://git.kernel.org/krzk/linux-dt/c/a70369e1b7f6cbe818b61b37dc29bce0811226ed

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
