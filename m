Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135D24A8D25
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354019AbiBCUYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbiBCUYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:24:19 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB26C061714;
        Thu,  3 Feb 2022 12:24:18 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x23so8534159lfc.0;
        Thu, 03 Feb 2022 12:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rx0Z3OZF6cdCvnNOFKcvDv4fh1yVj/gL1s1KEoNipV0=;
        b=q1e/O08IwI8RzNptGiEsgHPC0MgRunmHl07k0HQXYytegHHRqVauUTkdafucC36X+f
         Gv0dT65WI0X6RF3+NCaSNjlDzu0lJEFyDoekDJbE/m/Ch/sgOhFG2W90CGQ9erhWG7VC
         jSXgf6KbxYxCxidao1jmYY3kmPYkS8MMk8j2Z+h1Xkq0lYAKzLup5soP85aP1t9WvUOw
         zp6ae8qYfISWE4/VvOUBZU35ksDftO6ij2d0DMJoVK/x62v/YanFkJFlW0XA4ryfdlLc
         lQlIrxLbMmf2gzGcTnPWwV/zkqbQnhmcHrBJQMhWpCwiUmreS9hP39FcAGzUQx2Kmp10
         L2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rx0Z3OZF6cdCvnNOFKcvDv4fh1yVj/gL1s1KEoNipV0=;
        b=SehqcCqtiQh+bDfCDCERfS+tXtVG810FnQf3Q2r4pQW9BQWS3e8PRY1wp4XLS4mxZK
         fd4SQn5On1xd/LFzjS0Re2nfoXs3npnKaGhmG1Q50cr+xDeGd3x8h5DOQqzgN5qhhbbP
         /R1qJrLc6Vzj8SqwBxDDbSt7U2QR69XJqulVSN+tvw82g/r5ykS7IdQLMKIfOrINEzqb
         kal5q8DXc74H242mCOxydU5klthoAdPe24xXZVokVajWWeSsNBHO7lrleoI1ETu9KBn8
         xP43uQkinKUmyf5hj6LxBrLrC+8x/5acU2PSWKIqQ+Dud7mY9aGS3rux3s0zw2W7g7fS
         AM8Q==
X-Gm-Message-State: AOAM531qA+9P6n2rj6xzS2uwnezPwZBEMSihSrlNhlk2lv3mGnGGgXyj
        soTXOLdxpDj7+I49ZUoYCbE5/O0G/45G9Q==
X-Google-Smtp-Source: ABdhPJxFpVox1E9TWI44exKhGjHJS2MwhEQ2QcOo/FjH7tH8Y+OKw9kx9t+lSINF1E0/bWMt23niDA==
X-Received: by 2002:a05:6512:3f8f:: with SMTP id x15mr14461735lfa.363.1643919856967;
        Thu, 03 Feb 2022 12:24:16 -0800 (PST)
Received: from netbook-debian ([94.179.41.53])
        by smtp.gmail.com with ESMTPSA id o17sm3774802lfl.16.2022.02.03.12.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 12:24:16 -0800 (PST)
Date:   Thu, 3 Feb 2022 22:24:10 +0200
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Subject: Re: [ASUS EC Sensors v8 0/3]
Message-ID: <20220203222310.6a025c5d@netbook-debian>
In-Reply-To: <CAB95QATUK+q01TLuubqR9D1fLJM=C6VjxpabnkseQRUvsd-9YA@mail.gmail.com>
References: <20220124015658.687309-1-eugene.shalygin@gmail.com>
        <7c8f311f-a2e4-584f-eb29-7f0d2a335e8f@roeck-us.net>
        <CAB95QARyz_sp9MoMsakfAK+PRBnVVnyOQzm2ZwJwwLE5vvAUFg@mail.gmail.com>
        <8022383.T7Z3S40VBb@natalenko.name>
        <13a9d0fd-1b2c-b9c1-24a7-ff4fc5f4b8cc@roeck-us.net>
        <CAB95QATUK+q01TLuubqR9D1fLJM=C6VjxpabnkseQRUvsd-9YA@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2022 21:01:32 +0100
Eugene Shalygin <eugene.shalygin@gmail.com> wrote:

> > >> Oleksandre, could you, please, let us know did you actually test
> > >> the v8 code and if so provide us with the Tested-by: tag?  
> > >
> > > Yes, I do run this version now, and it works fine for me.
> > >
> > > Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > >  
> >
> > Ok, based on that I'll apply the series on top of hwmon-next with
> > your Tested-by:.
> >  
> 
> Great! Thank you both!
> 
> Eugene

I have also retested code, it works for my case.

Tested-by: Denis Pauk <pauk.denis@gmail.com>

What about other B550/X570 boards?

We have such candidates with same WMI methods in nct6775:
	"ROG STRIX B550-A GAMING",
	"ROG STRIX B550-E GAMING",
	"ROG STRIX B550-F GAMING",
	"ROG STRIX B550-F GAMING (WI-FI)",
	"ROG STRIX B550-I GAMING",

B550-A does not support asus-wmi-ec-interface("ERROR: Can't get value
of subfeature fan1_input: I/O error"), but what about others? 

Best regards,
             Denis.
