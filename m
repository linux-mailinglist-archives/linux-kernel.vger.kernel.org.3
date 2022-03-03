Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15304CC1AF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbiCCPmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiCCPmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:42:20 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB33195316;
        Thu,  3 Mar 2022 07:41:35 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 12so5116615oix.12;
        Thu, 03 Mar 2022 07:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UkHMEQWO9jTM74a5At67rWZxBXWSHZgLI2GDyhLMShE=;
        b=g5QV0tH1fwOXvEz/lY4cLuKdG0gfhCb0ZPdtzeO0gXKftZcoRKXjLWqx5kRpj4h9ay
         gnWfCvayE+QX83ohJu0M4jMgNV9AtPuCv1u/hxQXAkNZKJGjvFQlwdXMkrmF2yppUmsp
         crdY6DW0mpFm6F53cRStsKbEufb8TBUQV49AoJHhXTaYniaVTER70dSJUySOTSX/F9DK
         r7gnY4JYxaad/T+PEYyhA0VwxlKZbXDdsMjxexJ48kp3jpCICmCweuNRcnEJmnslfLye
         RB9Cb1PPRL/CEjssCtiJS3LF5uNC0egIeYxkrAxN676TTq9g21FMN7QQzCiCGWk7DTRb
         YpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=UkHMEQWO9jTM74a5At67rWZxBXWSHZgLI2GDyhLMShE=;
        b=Q/dIffnInk72ZWANu+WPoZBVdLNxjHpjAGU2IHZEUgu3SJXj4cUZo4zHwYsgWAuxNr
         iLxpgvc5VuGqRsP7RG0EXvNayUhqLrfMMWi3ZoKUKkl56/k10my3peRAluGVApUZoHBH
         OEXE3nQ9rqsQTeJ8KYEDwiY7iMwHALk2dWkpO5BYmPbP7Gb/WS7R57yl5j+ynJloNLfD
         XWsckGe/ea55yQGNLD99mIOjJBqDVUrsaV4Dr+99p/8+Uixmkz2TbKEcdOeEMmBcijye
         dPzf/7Be4XEel1jeQ/wtb9Qa1QESMH20I8EI9OvPuPHbH8DCChBSDdiiODRD33ZOPwZV
         SaAQ==
X-Gm-Message-State: AOAM530sll193AWxbKsuXoxH3MLLpeKeqSYONznUgwQlLyYXCPDLiIfw
        OtHbmvbj4rtwJjNBlle/cqc=
X-Google-Smtp-Source: ABdhPJxvcjNbNP9xGnJVPNmC0mn1UHYAeho4sP1SuqkQerf9EB5WgdjG6oFIFm4I9z8mFv/w+ybQYQ==
X-Received: by 2002:aca:90e:0:b0:2d4:8fb3:2674 with SMTP id 14-20020aca090e000000b002d48fb32674mr5063906oij.124.1646322094628;
        Thu, 03 Mar 2022 07:41:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a12-20020a9d5c8c000000b005ad51592bd8sm1083522oti.49.2022.03.03.07.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:41:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 3 Mar 2022 07:41:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Agathe Porte <agathe.porte@nokia.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>
Subject: Re: [PATCH v7 2/2] hwmon: Add driver for Texas Instruments TMP464
 and TMP468
Message-ID: <20220303154132.GA3408592@roeck-us.net>
References: <20220222223610.23098-1-linux@roeck-us.net>
 <20220222223610.23098-2-linux@roeck-us.net>
 <20220302175941.GA2523098@roeck-us.net>
 <9e868438-c0ad-464f-358c-5ee77bfb7f4f@nokia.com>
 <abde8dce-810b-fd39-b0aa-4f1b2ec8f8d7@roeck-us.net>
 <c3a9b340-34b1-4bed-4810-4c5f39a8554b@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3a9b340-34b1-4bed-4810-4c5f39a8554b@nokia.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 04:31:39PM +0100, Agathe Porte wrote:
> Le 3/3/2022 à 4:00 PM, Guenter Roeck a écrit :
> > On 3/3/22 00:57, Agathe Porte wrote:
> > > Hi Guenter,
> > > 
> > > Le 02/03/2022 à 18:59, Guenter Roeck a écrit :
> > > > Any review / test feedback on this patch ? I would like to apply it
> > > > before the commit window opens, but the time is getting short.
> > > 
> > > I thought that you did receive the TMP464 samples and had the
> > > opportunity to test on it. I will test v7 on our hardware equipped
> > > with TMP464, verify that DT support works fine, and will reply to
> > > this email with my findings.
> > > 
> > 
> > Yes, I did, and thanks a lot for it! I even wrote a qemu emulation
> > for the chip to be able to test the devicetree code.
> 
> Great!
> 
> > Still, I need to have someone else confirm that I didn't mess up.
> 
> I tested v7 on our hardware and the behavior seems to be the same as our
> previous, in-house driver, if that gives you a point of comparison. We only
> use temp*_input sysfs though.
> 
> No compilation warnings.
> 
> I can disable and enable sensors fine at runtime:
> 
> > # cat temp*_input
> > 43063
> > 35813
> > 34938
> > 39313
> > 29125
> > # echo 0 | tee temp*_enable
> > 0
> > # cat temp*_input
> > cat: temp1_input: No data available
> > cat: temp2_input: No data available
> > cat: temp3_input: No data available
> > cat: temp4_input: No data available
> > cat: temp5_input: No data available
> > # echo 1 | tee temp*_enable
> > 1
> > # cat temp*_input
> > 43063
> > 35750
> > 34875
> > 39313
> > 29188
> 
> For what it's worth:
> 
> Tested-by: Agathe Porte <agathe.porte@nokia.com>
> 

Thanks a lot! 

I applied the series to hwmon-next.

Guenter
