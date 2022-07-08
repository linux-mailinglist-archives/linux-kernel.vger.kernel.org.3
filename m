Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A43356C2B9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbiGHXGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 19:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbiGHXG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:06:27 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A056D3C14C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 16:06:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x10so196775edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V3uz7RiSt5a+7sv4FuEPnm/V9cAp31RU7bmEVl/UAKU=;
        b=NbxlYbo0ChI5HUxdUBq2tJosu3oGmwg0l1hnY6SU/ljs8+u3vBB5ftr5Imm/S80DY/
         QnZGBRV5hId49A/g/Dxn0q23wvCNYOkiW9pvPXHQpYqDXfB3TsqHl/Q06GRgVMDCAasG
         PRahrkew9qwtfInL3ibU2bdLxX78tIfILAChmOf4iWzSGb6FPk0DKyJlPY3kTpslM4t6
         3Lt1L/MwWVpyg+APSV/UoVluFNzc0TPaNGTG6uA/apy5q7YEBqXyYPdhHJDwrSQYDoG7
         uAdlNHbdcUXAi1t5nhAQE8tnHfs2GQgFpDfZ117UzfmTd4zIrES2hBL906ai85hHLlTa
         TN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V3uz7RiSt5a+7sv4FuEPnm/V9cAp31RU7bmEVl/UAKU=;
        b=cJ8NDYbEkyVcoXObWJR5lY+FIRvgma3IMUvTMogT1tnXQqxzUD7rLJ0WKeIh9v8B5I
         J1Bfb+T7lJXaLaVrH68NsqPITsPtaeu9F03qMm4kk2WVKy3xn4PSvkA3vlY//mn1WtSG
         tpARMpUJygnD2MlYYpBSGjoQg5DvGhvkEM5wVKml5/qqxdHJKN2OX8M8e9LZLzMF8RrG
         AesXKjFz0MUR8m+04p3PJmQ/GoO1K1BsVu/38cHYloYf3d/l741TB45IwmkdEMmIxwbT
         HmY0KfMol5Okl6alHR448PZvIwMKa3pbHhFb2Ksn7baYHbkaAuSIKt14QC0b8rGNO3nc
         UdUQ==
X-Gm-Message-State: AJIora/pp/S166tk1CEebaHlTsW8YynoONAKUJk8FzBvNDCWln0vpR02
        E4JMrBJjroi6ytIuMYcFcjEyG3ofVTkdyg==
X-Google-Smtp-Source: AGRyM1uLgto2yfj0h3khFhGJbsldnlro7C5X3/QY65CXDn7bY4dYJxsrfchHRxJtv903jIvCXqyAzQ==
X-Received: by 2002:a05:6402:5303:b0:435:7c46:e411 with SMTP id eo3-20020a056402530300b004357c46e411mr8265105edb.221.1657321583123;
        Fri, 08 Jul 2022 16:06:23 -0700 (PDT)
Received: from localhost (cable-89-216-134-246.dynamic.sbb.rs. [89.216.134.246])
        by smtp.gmail.com with ESMTPSA id j8-20020a170906094800b006feed200464sm15500033ejd.131.2022.07.08.16.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 16:06:22 -0700 (PDT)
Date:   Sat, 9 Jul 2022 01:06:18 +0200
From:   Aleksa =?utf-8?B?VnXEjWtvdmnEhw==?= <aleksav013@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: dmesg tracedumps on rtsx_usb module loading during boot
Message-ID: <20220708230618.rlqa7azb6q7asvds@artix.localdomain>
References: <20220708134942.r3nhwzgh4nchaebi@artix.localdomain>
 <Ysg20t2t/S11idyx@kroah.com>
 <0fc74c07-791e-a6f2-de43-510852a3517c@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fc74c07-791e-a6f2-de43-510852a3517c@linuxfoundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/08 01:09PM, Shuah Khan wrote:
> On 7/8/22 7:53 AM, Greg Kroah-Hartman wrote:
> > On Fri, Jul 08, 2022 at 03:49:42PM +0200, Aleksa Vučković wrote:
> > > [1.] One line summary of the problem:
> > > dmesg tracedumps on rtsx_usb module loading during boot
> > 
> > This should be fixed in linux-next now, right?
> > 
> > Shuah (on cc:) send in some commits to resolve this, look at this
> > thread:
> > 	https://lore.kernel.org/all/cover.1656642167.git.skhan@linuxfoundation.org/
> > 
> > If you could test those 2 patches, that would be great.

I just applied these two patches into staging tree and it seems to fix
dma mapping error. There is no trace dump in dmesg now.

> 
> Yes. Please test these patches and send me the trace you are seeing
> as well. It will help us confirm if it is the same problem or a new
> one.
> 
> thanks,
> -- Shuah

However, I mistakenly assumed that dmesg trace was also only indicator
that SD card reader does not work. It seems like these two issues are
not connected, both 37fcacb50be7071d146144a6c5c5bf0194b9a1cf (last
commit that does not have trace dump) and this version after patch do
not register SD card.

I will do another bisect to find out which commit actually causes SD
card reader to not register SD cards. I will contact you after I do more
testing.

Sincerely,
Aleksa Vuckovic
