Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413104FC161
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245375AbiDKPsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348211AbiDKPsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:48:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8166B3B02B;
        Mon, 11 Apr 2022 08:46:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i20so10547419wrb.13;
        Mon, 11 Apr 2022 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PZNKQo2SMpTLuF/HCFLVZDh+KD8HhgUzI1E+iyuY28I=;
        b=bXS+dS02vEsXF+Q1cnBUZsCHWHeL9Sh7sGdy6Dm3r0Te6wZQax7/tK9oCv6IiNHpsG
         DFAKcPbuZFq9jVyWOU5FZLKUZrl+3cm3RdzJH7MtyUe1HyAvmaVGPdTDBdDYTjuStcyb
         IUsUxIO93l/7j2Pc+y7I1+FSL55Cbq1L8zxgChDYcPXfBUWs4CHAk1Nj4wBfSB8Univ5
         stFlVCyl2HMCXEYPg65a+UD6gnWZsf7ImTij7Dixm8XxWwwvC56rcll+J0MBYkQSNu+K
         N8gzZzGKJgdHIapXevBGQfKlc66H/hFej2vpPzl81hHyCOplC7BVs/4JbxbGM6k+sWOS
         dKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PZNKQo2SMpTLuF/HCFLVZDh+KD8HhgUzI1E+iyuY28I=;
        b=OeCOggZbpz8qeu4JH+BnhItMXVn9NTze6xexIBFnNl+GOcU3Nh9EKVnfa33i0Q2vfR
         l9Rp5v6cmEPZnbzXINHB+dwzmY5Y57O4EYVrVuQLXXa2txALQlg/XrCg0JIwTPH4qUht
         adp5koy/CiOCMS4bTa+/lmZgLMQUxLFlmjUPzN6cnGVpjiWA16TPDTMLcIRRcy8ZH5ZJ
         T17hLmOrDc5+AnMJPLyDtS13TwRs8chavwRMTngMjZMGj/qhEUzsPUxPQ8qbUZX8TCS+
         szJaqtz0IqX0hXiu/ziDgiDCrpEswt4JNMdXyT7GOKCV4z6l6ArhO8CvLCu2zadBTJ+u
         G/DA==
X-Gm-Message-State: AOAM533XLgusYE1AQiuFBPSMoESkwEgAMkzCA469i4RB804wFz+RufEl
        LUR7dycpW8krefiHgabBg7w=
X-Google-Smtp-Source: ABdhPJy3L75SohiHlUZyctIqdH1tptcfYZRli0ILyyMM2zn0SdVVrK7HaM3/dAMYkL46guFeOj2hsQ==
X-Received: by 2002:adf:ef10:0:b0:205:ce51:743e with SMTP id e16-20020adfef10000000b00205ce51743emr25707328wro.522.1649691988094;
        Mon, 11 Apr 2022 08:46:28 -0700 (PDT)
Received: from localhost (92.40.202.92.threembb.co.uk. [92.40.202.92])
        by smtp.gmail.com with ESMTPSA id i31-20020adf90a2000000b00205ad559c87sm26483885wri.21.2022.04.11.08.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:46:27 -0700 (PDT)
Date:   Mon, 11 Apr 2022 16:47:15 +0100
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Zhou Yanjie <zhouyu@wanyeetech.com>
Cc:     devicetree@vger.kernel.org, krzk+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        paul@crapouillou.net, robh+dt@kernel.org
Subject: Re: [PATCH] mips: dts: ingenic: x1000: Add PWM device tree node
Message-ID: <YlRNgyc6eMTgFjdH@localhost>
References: <20220411100139.15672-1-aidanmacdonald.0x0@gmail.com>
 <8a3f88d8-3e94-1388-b1c6-b0f71d59f34c@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a3f88d8-3e94-1388-b1c6-b0f71d59f34c@wanyeetech.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 08:41:26PM +0800, Zhou Yanjie wrote:
> Hi Aidan,
> 
> On 2022/4/11 下午6:01, Aidan MacDonald wrote:
> > Copied from the jz4740 devicetree and trimmed to 5 timers, which
> > is what the hardware supports.
> >
> > Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> > ---
> >   arch/mips/boot/dts/ingenic/x1000.dtsi | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
> > index 8bd27edef216..0dcf37527c8e 100644
> > --- a/arch/mips/boot/dts/ingenic/x1000.dtsi
> > +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
> > @@ -127,6 +127,19 @@ wdt: watchdog@0 {
> >   			clocks = <&tcu TCU_CLK_WDT>;
> >   			clock-names = "wdt";
> >   		};
> > +
> > +		pwm: pwm@40 {
> > +			compatible = "ingenic,x1000-pwm";
> > +			reg = <0x40 0x80>;
> 
> 
> It seems more reasonable to use "reg = <0x40 0x80>" since the
> X1000 has only 5 PWM channels.

I think you mean "reg = <0x40 0x60>" but I'll do that, thanks!

> > +
> > +			#pwm-cells = <3>;
> > +
> > +			clocks = <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>,
> > +				 <&tcu TCU_CLK_TIMER2>, <&tcu TCU_CLK_TIMER3>,
> > +				 <&tcu TCU_CLK_TIMER4>;
> > +			clock-names = "timer0", "timer1", "timer2",
> > +				      "timer3", "timer4";
> 
> 
> One line is now allowed to hold at most 100 characters,
> so it is possible to use only one line like:
> 
>          clock-names = "timer0", "timer1", "timer2", "timer3", "timer4";
> 
> to reduce the number of lines in the dtsi file.

Sounds good to me.

> 
> 
> Thanks and best regards!
> 
> 
> > +		};
> >   	};
> >   
> >   	rtc: rtc@10003000 {

Regards,
Aidan
