Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A401531E38
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiEWVuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiEWVus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:50:48 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7404726ACE
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:50:47 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id j137so8449018oih.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PrIU1gcRB8dmQ65bmWWWNZIOcHETarJSBHB2kE+QF+I=;
        b=LtEMLEBk9c/QEpm/uus7HwOM7klph6uVq/ukoHJUBsdWu/9q51vcvTw6f6R8Hfq88k
         2qaZlAZmIxaxbUEDhJxkooU0oWB5G8ogNlDmUghAtSD6S5gD5L3Hf5I5S0/sUEAkxXG8
         R2JJHpCvrlUoO300qtXN72s/l907Zj5W0+Iq8I5Yip5FGU/cGYB1niQByjnaUftjNLaX
         BH86Lga7vWkDWTGRpkLdqb0vaMDtUXNUpqef0d1Cmk0x9xnjukShREsAuoOAWIbD3mAC
         OIp5OWE8U/EyXABbBuYTHIfrVekV+M/V0okSwmHTafOU77qzI3Dv/Iuze/rOe7M3PIun
         i+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PrIU1gcRB8dmQ65bmWWWNZIOcHETarJSBHB2kE+QF+I=;
        b=Og2MrSqlO7bce1NDG9kBOFsduychAIIjRpCTlQw+fQdt7uciDdBNjr8uKqE0bfq1O4
         kHVkUhagh015DGvYOICE8LllMGiK0yakHI4T2tv25ZI6xfwlM13o+ighTk6cC2+bZVPl
         qV6NBA00DnL3dnQajf9CYKow+coPWz5gaBXSK44B0s66SM9yOtAtEQ+BUIKycYSeePqb
         GDHMQ/exCn6WO3z/l7yU/HOF4gPNS0f1mQxy8mcA/SOOzxp5LZZ8H38LObIG1O8/73IN
         B0dZGtmVtD4wuDdEMIcoKe9UQvsM9qKTu9lZByh1hVtO9VF/VV7ujtmLsUpXlQ2HvmQz
         T7DQ==
X-Gm-Message-State: AOAM532YHFEbyB6kARubnH1KPGTXsFMAZNyJgE9XS+HJtnjA1mmtiRFw
        CvJuisjXRbMDFJy+2KbXjrKvpg==
X-Google-Smtp-Source: ABdhPJwdvAAXCoWTlQKC78e1ucFkB7MkXixv02NwxoluxSAsYLkOCFdJXX2bFlakX9l1BRRlRd6EgQ==
X-Received: by 2002:aca:f188:0:b0:326:160e:590a with SMTP id p130-20020acaf188000000b00326160e590amr586026oih.209.1653342646754;
        Mon, 23 May 2022 14:50:46 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p13-20020a0568301d4d00b0060603221236sm4402693oth.6.2022.05.23.14.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 14:50:45 -0700 (PDT)
Date:   Mon, 23 May 2022 16:50:44 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>, agross@kernel.org,
        arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, robh@kernel.org, sboyd@kernel.org
Subject: Re: Removal of qcom,board-id and qcom,msm-id
Message-ID: <YowBtNkZ678ns4Ob@builder.lan>
References: <a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org>
 <20220522195138.35943-1-konrad.dybcio@somainline.org>
 <53d5999b-88ee-24db-fd08-ff9406e2b7b7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53d5999b-88ee-24db-fd08-ff9406e2b7b7@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23 May 02:21 CDT 2022, Krzysztof Kozlowski wrote:

> On 22/05/2022 21:51, Konrad Dybcio wrote:
> > Hi,
> > 
> > removing these properties will not bring almost any benefit (other than making
> > some checks happy any saving some <200 LoC) and will make the lives of almost
> > all people doing independent development for linux-on-msm harder. There are
> > almost unironically like 3 people outside Linaro and QUIC who have
> > non-vendor-fused development boards AND the sources to rebuild the
> > bootloader on their own. Making it harder to boot is only going to
> > discourage people from developing on these devices, which is already not
> > that pleasant, especially with newer platforms where you have to fight with
> > the oh-so-bright ideas of Android boot chain..
> > 
> > This only concerns devices released before sm8350, as the new ones will not
> > even boot with these properties present (or at least SONY Sagami, but I
> > doubt it's an isolated case), so other than completing support for older
> > devices, it won't be an issue going forward, anyway. But there are give
> > or take 50 locked down devices in mainline right now, and many more waiting
> > to be upstreamed in various downstream close-to-mainline trees that should
> > not be disregarded just because Qualcomm is far from the best at making
> > their BSP software stack clean.
> 
> I actually wonder why do you need these properties for community work on
> such boards? You ship kernel with one concatenated DTB and the
> bootloader does not need the board-id/msm-id fields, doesn't it?
> 

During the last years all reference devices that I know of has allowed
us to boot Image.gz+dtb concatenated kernels without
qcom,{board-msm}-id.

There's however been several end-user devices that for some reason
refuse to accept the concatenated dtb unless these values matches.

> Not mentioning that in the past bootloader was actually not using these
> properties at all, because it was the dtbTool who was parsing them. So
> in any case either your device works fine without these properties or
> you have to use dtbTool, right?
> 

Unfortunately not. There are the devices which accepts a single appended
dtb without these properties, but beyond that it's been a large mix.

I've seen cases where dtbTool packs up a number of dtbs, but the loaded
one still need to have these properties, and there are devices out there
that supports multiple appended dtbs etc.


Last but not least, forcing everyone to use dtbTool adds a
non-standardized tool to everyone's workflow, a tool that has to be kept
up to date with the compatible to msm/board-id mapping.

> > 
> > One solution is to chainload another, (n+1)-stage bootloader, but this is
> > not ideal, as:
> > 
> > 1) the stock bootloader can boot Linux just fine on most devices (except
> > for single exceptions, where beloved OEMs didn't implement arm64 booting or
> > something)
> > 
> > 2) the boot chain on MSM is already 3- or 4- stage and adding to that will
> > only create an unnecessary mess
> > 
> > 3) the job of kernel people is not to break userspace. If the
> > device can not even exit bootloader after a kernel upgrade, it's a big
> > failure.
> 
> The job of kernel people is to follow bindings and since they were
> introduced 7 years ago, I would say there was plenty of time for that.
> 

We're following the bindings and don't pick board-id or msm-id unless
there's a particular reason for it - which typically is that the
downstream bootloader requires it - we don't use the properties on the
kernel side.

> If the dtbTool support for the bindings is there, then there is no
> breakage, because you had to use dtbTool before so you have to use now.
> 

Among all the platforms I maintain, MSM8916 (db410c) is the only one
where I use dtbTool - because it refuses to accept the concatenated
dtb.

Regards,
Bjorn

> > 
> > If you *really really really* want these either gone or documented, we can
> > for example use them in the SOCID driver, read the values from DTB and
> > compare against what SMEM has to say and for example print a warning when
> > there are inconsistencies or use it as a fallback when it fails for any
> > reason, such as using a newer SoC on an older kernel, without updates
> > for SOCID read (which are sometimes necessary, which was the case for 8450
> > recently, iirc).
> > 
> > My stance is to just leave them as is, as moving them anywhere, or removing
> > them at all will cause unnecessary mess and waste time that could have been
> > spent on more glaring issues..
> > 
> > Konrad
> 
> 
> Best regards,
> Krzysztof
