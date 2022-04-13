Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893C64FF303
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiDMJLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiDMJLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:11:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC06527F4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:08:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t1so1650928wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o4zB36RMxDLunDbuld3ECmBOvmX9u3/GDy+FlEXNdz0=;
        b=WBv+T+YkswybocW2g4FPyJnWFtpRidF6EP2r6rxboU8nbVYzGUqoMl8jJO/hBntOLj
         GAZ4kDsNpSWpNJtm7UXMM/i08CeaxaLnYAr3KR4e5JNGeOQwskj3xjlclb+vvoG7jL0S
         AAZBPNwh96CNpWCb4BC++xFjtGlW97PMQ5oPHr6QmcZoi4O7UsaV6T2dqb5hA+Q3takV
         Z9ZXfS5qzKsFpCgAdFht/JYMzRtsacs/2nAMasI9HCXhSwjBVNB5RpW8EW3zSx8yuDdA
         jDj/gAVfDeeq03a/YsvT0A0b3BnaN4g94s0ACILcuCQxruWVvUXc5YbO4Mpsh0rCRKBT
         jK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4zB36RMxDLunDbuld3ECmBOvmX9u3/GDy+FlEXNdz0=;
        b=MpZH8IjGwXsGW9DrOLTFtFwsKYO36/Topw9Yy8GMyRXZ0x/M9LoHXsbCL61qLMHciS
         jif+wtP0f1FuoUTXWGTTE6JrgCr/6ukqzeMQD7h+6z/iaOEkLdvmiH6e2ULGEqRTd17H
         dy6piy+RnWdCzToyn43xE7oLRI+F9k7RnbcX3B5Fp3gtW8/oBDtE+gzrKz0nvuu2c9tY
         oNBhDWVmLzNLhZPY+3MfOiJQbw4hg08UVfKKsiHnau4nKxpgyGQIh85rYnqziAECbxf0
         fzsgxvkyUh3BB0d7rPCWuDoJY+2OmeZhVNQns5Hz585DQd7LbNR2ftbJI38AqjFWxPJ/
         UR3g==
X-Gm-Message-State: AOAM530q42WfIy6tTjLF/s9C4aL/m1SGHUqk9Ys9sAuZExisC8MxahoY
        W3doILjiWm3UaEeyBF27XGA/D4NE2qoizA71L4zF2g==
X-Google-Smtp-Source: ABdhPJxphYtH1eV30Zzzy4z1n3y2xcF+U98AkSimcSUucdFFV8yGUwAx4BgW3gX5+6fnO1yMv0gpGqwNaoP7rRZX1Xc=
X-Received: by 2002:a05:6000:18e:b0:207:a221:302c with SMTP id
 p14-20020a056000018e00b00207a221302cmr14327494wrx.120.1649840923258; Wed, 13
 Apr 2022 02:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220413030307.133807-1-heiko@sntech.de> <20220413030307.133807-6-heiko@sntech.de>
In-Reply-To: <20220413030307.133807-6-heiko@sntech.de>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Wed, 13 Apr 2022 11:08:31 +0200
Message-ID: <CAAeLtUDOhmUmp+XODm9Y1DFHKPEMXbH018qYODBWMd3gOFg-fg@mail.gmail.com>
Subject: Re: [PATCH v9 05/12] riscv: extend concatenated alternatives-lines to
 the same length
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 at 05:03, Heiko Stuebner <heiko@sntech.de> wrote:
>
> ALT_NEW_CONTENT already uses same-length assembler lines, so
> extend this to the other elements as well.
>
> This makes it more readable when these elements need to be extended
> in the future.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
