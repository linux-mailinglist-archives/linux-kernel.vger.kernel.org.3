Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8550C5912A7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbiHLPKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238574AbiHLPKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:10:46 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E228D6AA22
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 08:10:44 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso8618767pjo.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 08:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=zzbpyiki3NleilhfwCj9lkX5sCoprPIj72OmtlYgi0A=;
        b=TgjhKVmtuJxPQV4CZFyvOAo9j/BYqDYL4o/QhhJHMTjJodzTk7EYoUGM6mB9znKkEo
         wrbPNttEkfw9W2/3jA2hjpY+7TnN5xb3Fj4oVTa9tOlEXbf50oINyijo6FZEqIhKbgqH
         jm7mR17BcBMp9Ky9l/1n6ZublpsuZCK7fhRZU6mABa0ImZejkepfk793YS0idYAYektq
         Eq+zyyBJvGiiEWoJghFvrLUqQkdyjE3Z1ti7DhFjzo7F4SQ5c4HiWJRwDD5ShLhiE2sc
         GhEdpYG79CBKJTFxHtzGn1mB3rRUepPUupDN4vcZosG/ElvEzNQGtPmcrLoV93u6BY5W
         eDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=zzbpyiki3NleilhfwCj9lkX5sCoprPIj72OmtlYgi0A=;
        b=4TMSCHrYpnEsI27A0XgKgac1t/IZxZwFNJV2bbVMOhtaYITspjnT/xkR1DikZEUxW0
         XevdEHaGP1V2BXj1Ez34DXYUDMqICOUKprd3zK/zVWM8AjxtL6ziyDQsOja2HAyY6Ku+
         A9s+FnMTGL+A/8RUIg8cdCJaJi0PEw+EO6JIFKdHD0iLaHfgXrU3xzmwDXG8o0Dx+jDp
         yxsKOC8MhoqUHQD8YGxGiOrdR4sbV5QuMYSqgQGZO6M8toSxM/FEiE8vO58PCqlhvX8b
         VJRRjuPR932GW6wW7HHKVCO59Stb1rrrlGEYdQiaAxJMS4maXD7lJXB18231Cqh2+dY8
         la7Q==
X-Gm-Message-State: ACgBeo1lXingZxxG8lXX56E12AF2aZp8HVJE1JM/Ajsj9IbOUWKwAQno
        eCm4PeG2mz+ISSL6MdzQIuwqsg==
X-Google-Smtp-Source: AA6agR52a8ZV7ZcymiQ5xW9p2OqUonP+NtZlYjd6vNYwb0BqZxt5lsnsAlWG7AoqZ3eO6IKks2b1AQ==
X-Received: by 2002:a17:902:ea03:b0:170:a235:b72b with SMTP id s3-20020a170902ea0300b00170a235b72bmr4486201plg.13.1660317044201;
        Fri, 12 Aug 2022 08:10:44 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090a134900b001f766b6a879sm5452486pjf.44.2022.08.12.08.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:10:43 -0700 (PDT)
Date:   Fri, 12 Aug 2022 08:10:43 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Aug 2022 08:10:38 PDT (-0700)
Subject:     Re: [PATCH 4/6] dt-bindings: riscv: Add DT binding documentation for Renesas RZ/Five SoC and SMARC EVK
In-Reply-To: <1aa477b2-1d91-066e-5fcd-849ece62388d@linaro.org>
CC:     geert@linux-m68k.org, biju.das.jz@bp.renesas.com,
        prabhakar.csengg@gmail.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com, magnus.damm@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     krzysztof.kozlowski@linaro.org
Message-ID: <mhng-16e843f9-aba2-41fe-9027-8362472fc7d7@palmer-mbp2014>
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

On Thu, 11 Aug 2022 23:23:10 PDT (-0700), krzysztof.kozlowski@linaro.org wrote:
> On 11/08/2022 18:42, Geert Uytterhoeven wrote:
>> At the DT validation level, I think the proper solution is to
>> merge Documentation/devicetree/bindings/arm/renesas.yaml and
>> Documentation/devicetree/bindings/riscv/renesas.yaml into a single
>> file under Documentation/devicetree/bindings/soc/renesas/.
>>
>> What do other people think?
>
> I am ok with it.

Seems reasonable to me too, but I pretty much always err on the side of 
keeping SOC stuff split out from the RISC-V stuff.  Just looking at 
Documentation/devicetree/bindings/riscv/, it's pretty much all SOC stuff 
-- should we just move everything but cpus.yaml over?
