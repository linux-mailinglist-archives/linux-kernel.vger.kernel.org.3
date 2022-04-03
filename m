Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F944F06C7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 04:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiDCC0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 22:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiDCC0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 22:26:22 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6288726130
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 19:24:29 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t13so5449054pgn.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 19:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=32/rbrX1Jd5lpKPdnWYfmBzydcxb30MqQ50iH3f+I4U=;
        b=d/7nC43zvSnX6PspIKqsonwi1G+Eds3AVdvU93lNNnVB5RfCmas0/INW0mC1gN/B5x
         YJQv/v6IgyBRKXwboGOZ47xk0uIsnzXCLPkvUZt7EsMcDQU36ssCGrZUAAg64iXrUNYe
         EUDqf8Ew7xz2aNUz1aqmlwKldJT5dR7qjLCzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=32/rbrX1Jd5lpKPdnWYfmBzydcxb30MqQ50iH3f+I4U=;
        b=6yhaYADcLKCF57ecprJmvRycf/qZsftyu6T4PAI9NHjXSpiZ0McXgAoTeTCAkwd/tt
         nKWEUuHgWpBiS7g+vwYSXlVi7GRybucEbB3kWQHpp8o+q8+2bA15Ggxvq0cDoYbOjtmx
         J3tTFF/h5ZIIBAOoAcvUJM0M9ECZrvGTkTec9ghDsUJ4tGdLKWRGHKaSmkPOzQJ+GBmg
         PrDHoDrScMm15AmBtW9UD14rfjhwsg8whDlbgF601+2AMsCLEaWvLz0naiSWMP2UZklF
         4kQI+1TzV9AzEXuZ2RWGCyqlwIBluKBvl+y/AI54StEmnzyZ+INEcW7Avt7kFFdGDCE2
         SodQ==
X-Gm-Message-State: AOAM5333VgGrC0LfkesAcmJ9DTne5frkOJ0scHpbYHK5yNYTVDQrGjDp
        +VGSGAMToYU0D7vt4wkclhm3QrEiZUKgFw==
X-Google-Smtp-Source: ABdhPJx01i5fBwwCDsmvxhlgEmO38vEUkV+i3kHPux9hNPt9A5ZlVsrgNMY5fxNRWnnk7FLS2XxyfQ==
X-Received: by 2002:a63:3819:0:b0:398:1338:1118 with SMTP id f25-20020a633819000000b0039813381118mr20371977pga.33.1648952668880;
        Sat, 02 Apr 2022 19:24:28 -0700 (PDT)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v22-20020a056a00149600b004fb34a7b500sm7629562pfu.203.2022.04.02.19.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 19:24:28 -0700 (PDT)
Date:   Sat, 02 Apr 2022 19:24:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        James Jones <linux@theinnocuous.com>
CC:     bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Remove a.out support
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.21.2204022255430.47162@angie.orcam.me.uk>
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com> <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com> <202203151150.1CDB1D8DA@keescook> <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com> <alpine.DEB.2.21.2204022255430.47162@angie.orcam.me.uk>
Message-ID: <67CF27C5-5013-4EF4-B24C-8D9EB52536FB@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On April 2, 2022 3:14:43 PM PDT, "Maciej W=2E Rozycki" <macro@orcam=2Eme=
=2Euk> wrote:
>On Wed, 16 Mar 2022, James Jones wrote:
>
>> Probably getting a bit off topic, but I did spend a few hours searching
>> around for any existing tools to convert a binary from a=2Eout->ELF, an=
d
>> trying to come up with something myself by extracting the sections with
>> objdump and re-combining them into an ELF using a linker script placing
>> the sections at the same locations=2E I couldn't get it working in an
>> evening or two messing with it so I moved on, but I agree something lik=
e
>> this seems possible in theory=2E
>
> Chiming in late as I'm scanning outstanding mailing list traffic: if thi=
s=20
>is as you say all statically linked stuff, then converting from a=2Eout t=
o=20
>ELF might be as easy as:
>
>$ objcopy -I a=2Eout-i386-linux -O elf32-i386 a=2Eout-binary elf-binary

Based on my research (and the wrapper I ended up writing), I don't think t=
his is sufficient because entry point handling is different between ELF and=
 a=2Eout (specifically the stack layout and initial sp register value)=2E

-Kees

--=20
Kees Cook
