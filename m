Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DE55907D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 23:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbiHKVID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 17:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiHKVHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:07:44 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FEC98C98
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:07:03 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o3-20020a17090a0a0300b001f7649cd317so6577932pjo.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=DVb1z5kbBA1ujjv+xteyYloR7hoULhfIuEQt2vBqJwI=;
        b=pNYmvDNysYVnE4y5bj1U2pPQKZhnczdw1WnTDfu9aNj1/nEdGinf042LPTih/OaFlE
         V4h26+g7TJFlK35T0cyNlZpbfK3Mv0wvUrHmErAczQbmnLnnGvLm0Hdy7G2rbWhAY99N
         7gIzo5l+Uz9j7uJ61XUPc3O1uP3nlXc4IEic3n/xnfDrqfeKp78nopWEkgHXFENdgQ10
         17Pt9pzKV1a38XwgA1ZwNNdJR+L5JYcwLBZhYaCpHBw5j+E4XTkEUtGAaiWdYIMSE6WC
         kcqJCw04jzdvuHwAd4Nr0qPOaknSJVD+aJ8gyRtaul0GqOGYqX8mP6LvqkV3aYssrBIU
         W1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=DVb1z5kbBA1ujjv+xteyYloR7hoULhfIuEQt2vBqJwI=;
        b=78rsW7uTCsegTyWOgHJwmy/qcu4kSgPVvKNFAbQcE6o8HSyC+lILzFQVC2DLSJ4yzn
         He0phz1yrVdk3mQEGK2DxWaav76nRAmigI+9TAQM+cRepEG7sX7ulNP3kEdbzQ5+/I+B
         H490+v1IUE5SZlFIs//cqiTssoUSJFEMoV21qfHFQWeubHPYbFHhyeMpMd0Z2hAM5qYA
         0iEeewRHM0IgF1DmOgaZu4NZ6qTyra5fVS6PICj/Flkday5Cp5KgTZTT32Oy/ppj8qxJ
         mFbdQQTGUJMiHZUFr0Kg5Wypu8KaqtBbj0Q8GVjONeWm4R6FBo7r2uhfORa1LrC8EZa9
         qemA==
X-Gm-Message-State: ACgBeo2EvEVpxN7lAnPJ5qGbFzODyijp5p4kXhQSs2MaVFE8G5jHxK8j
        qxx+eae8zQBiCUOPkG9kHHY8K1/WtlS9bSxI
X-Google-Smtp-Source: AA6agR721/2w32bRDonI7TCGaPitO08W/FFsdL1xIehUgwWUxXReEgXRnl8nsgo7Emy01/s6+rWZSg==
X-Received: by 2002:a17:90a:2b42:b0:1f4:fc9a:be32 with SMTP id y2-20020a17090a2b4200b001f4fc9abe32mr10310074pjc.221.1660252015738;
        Thu, 11 Aug 2022 14:06:55 -0700 (PDT)
Received: from localhost ([50.221.140.186])
        by smtp.gmail.com with ESMTPSA id y22-20020a170902b49600b0016ee4b0bd60sm107352plr.166.2022.08.11.14.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 14:06:55 -0700 (PDT)
Date:   Thu, 11 Aug 2022 14:06:55 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Aug 2022 11:35:28 PDT (-0700)
Subject:     Re: [PATCH v1 0/4] Add HiFive Unmatched LEDs
In-Reply-To: <20220717110249.GF14285@duo.ucw.cz>
CC:     emil.renner.berthing@canonical.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        plr.vincent@gmail.com, bin.meng@windriver.com,
        aurelien@aurel32.net, w6rz@comcast.net, qiuwenbo@kylinos.com.cn,
        geert@linux-m68k.org, nerdboy@gentoo.org,
        jianlong.huang@starfivetech.com, kettenis@openbsd.org,
        sven.schwermer@disruptive-technologies.com,
        andy.shevchenko@gmail.com, davidlt@rivosinc.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     pavel@ucw.cz
Message-ID: <mhng-ac0025f9-3572-432f-9e8d-64ef87730b45@palmer-ri-x1c9>
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

On Sun, 17 Jul 2022 04:02:49 PDT (-0700), pavel@ucw.cz wrote:
> Hi!
>
>> This series adds support for the two LEDs on the HiFive Unmatched
>> RISC-V board.
>> 
>> Emil Renner Berthing (4):
>>   leds: pwm-multicolor: Don't show -EPROBE_DEFER as errors
>>   dt-bindings: leds: pwm-multicolor: Add active-low property
>>   leds: pwm-multicolor: Support active-low LEDs
>
> Thank you, applied. Not taking the dts change

I took the DTS change (#4) on riscv/for-next.  Thanks!
