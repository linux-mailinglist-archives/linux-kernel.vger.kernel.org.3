Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06424C869A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiCAIfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiCAIfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:35:46 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE0865833
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:35:05 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s24so20979028edr.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 00:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=581d5D6KA6uGeEFhWJuvM1NIBuXYywCqvyH8LTd14IA=;
        b=btbiwNi69t//ZAp+SKv0Q4ykiUFt5Vcee8OG/aZUV/3/mEL6qCooFVbyDvhieBabec
         CkXz6UGXrke98ZVvQ72UuAMxZwsIfwh+3g3tK2X0k1zbFdUDs/+/OK1fCTFFQOT7UHWN
         z0SGermy1OptrYhdNwG2SjAF8Iy2D/bC8aVmKXNdBID/wURfxVbVE+QyMV5xd5+hVU2P
         7UAkphywTA2sXS8jB/ps9Kcir4h64rEe4PhvIq8Fufb+E0teJ0kR087Xzr14Qd4KJ0DF
         Qzm9enrRJsGu4gGmyGHjbsCTvR55t8XjpjYC+HsSfTFdAdWWiDXozOXw2e3X48KoaVr6
         04YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=581d5D6KA6uGeEFhWJuvM1NIBuXYywCqvyH8LTd14IA=;
        b=O/JTurZHNV+v7OsXUCfoDskCzA6gAnBuLrYD0gjfAhLW7uZj5rRp5sSeehEbS8g+u0
         ICFYm9eIlJHOGBygRnmEKOywPrYLSDrqQPMtvwPzHQHcId4ORfrZu3SG++HlyDE1tlBu
         3JwJtcHGePvr4UCBDGGMgWBxBcLcUtjHGHA2xmRgE3oZl6agZfWwc9BEoEV6YxcHUSZx
         xpeqHgjTalaklT2MvKu31siDhCi2FK3zlF2rBMBvFMBti515bEbbOvOp5A9fUl+A8ZLO
         pAB6SME/RuiJLSBkkZ8OfzOs2S5qvTLd4coAhveIMhwv9vlVQEBBuS4Lc4c1W0F8EIDq
         dNVQ==
X-Gm-Message-State: AOAM532zC0AM9d7sfvPQ8aJ6uEdQQaCQKDNE1DR/2XxANPDgIj3gLjtw
        V/HWBTjEQ3rbrYiRpHZIFqcfJg==
X-Google-Smtp-Source: ABdhPJwubftsKZHHyeS1ZbNkCnU+nk1j6sKjNZ5wyeunS3woMMkfozT4OFVs7GF4Plw+VBgaQ0e1+g==
X-Received: by 2002:aa7:cb96:0:b0:413:8d05:ebc with SMTP id r22-20020aa7cb96000000b004138d050ebcmr14581306edt.81.1646123704506;
        Tue, 01 Mar 2022 00:35:04 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id h20-20020a1709060f5400b006d6d54b9203sm1065010ejj.38.2022.03.01.00.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 00:35:04 -0800 (PST)
References: <20220228135530.6918-1-yu.tu@amlogic.com>
 <29b34655-f820-39c9-4363-878481cd3f63@baylibre.com>
 <Yh087tJhakKHs88e@kroah.com>
 <8747c5c6-a129-3a26-8ebb-9e21a18236ec@baylibre.com>
 <96dc5932-7a4c-4f92-b33b-bfd7fc4477e8@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH V3] tty: serial: meson: Fix the compile link error
 reported by kernel test robot
Date:   Tue, 01 Mar 2022 09:33:15 +0100
In-reply-to: <96dc5932-7a4c-4f92-b33b-bfd7fc4477e8@amlogic.com>
Message-ID: <1jmtiavznx.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 01 Mar 2022 at 15:47, Yu Tu <yu.tu@amlogic.com> wrote:

> Hi Neil,
>
> On 2022/3/1 15:23, Neil Armstrong wrote:
>> [ EXTERNAL EMAIL ]
>> Hi Greg,
>> Le 28/02/2022 =C3=A0 22:21, Greg Kroah-Hartman a =C3=A9crit=C2=A0:
>>> On Mon, Feb 28, 2022 at 03:13:48PM +0100, Neil Armstrong wrote:
>>>> Hi,
>>>>
>>>> On 28/02/2022 14:55, Yu Tu wrote:
>>>>> Describes the calculation of the UART baud rate clock using a clock
>>>>> frame. Forgot to add in Kconfig kernel test Robot compilation error
>>>>> due to COMMON_CLK dependency.
>>>>>
>>>>> Fixes: ("tty: serial:meson: Describes the calculation of the UART baud
>>>>> rate clock using a clock frame=E2=80=9C)
>>>>
>>>> As I already replied on V2 of this patch, you're invited to apply these
>>>> fixes directly
>>>> on the next version of your "Use CCF to describe the UART baud rate
>>>> clock" patchset
>>>> and not as a separate patch.
>>>
>>> No, this is broken in linux-next now as the path listed here is in my
>>> tree right now.
>> Oh, I wasn't aware you took this patchset.
>>=20
>>>
>>> I need a fix for it, or I can revert the original.
>> Please revert the whole patchset, it's not ready yet, neither fully=20
>> reviewed ands buggy
>> on old SoCs.
> I have tested that there is no problem with G12A and S4 boards. Can I mer=
ge
> them first and fix them later if there is any problem?

That's called a regression. That is not how we do things in mainline
There is still a lot of people using GXL boards. Those are still sold even.

>> Thanks,
>> Neil
>>=20
>>>
>>> thanks,
>>>
>>> greg k-h
>>=20

