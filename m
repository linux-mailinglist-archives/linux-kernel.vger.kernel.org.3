Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E06577753
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 18:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiGQQhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 12:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGQQhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 12:37:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3C9F59F;
        Sun, 17 Jul 2022 09:37:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id k30so12407413edk.8;
        Sun, 17 Jul 2022 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fnHOU5H0h54e4hmVEYXh4fffVBg0SrfLMy1uXRyX8Fc=;
        b=fOOq6yIKprD57x4+UWAJb88fD+Uj2AtOPlvaSHUZVbBExCmhUiJPU6m2P9RCfS5h6b
         lLBMhM6wIF10d9oeV2dGiKeEwl4DodSVgugThnn4Y1tBXsUuwHfOg2iIR7jNae8NU15q
         E2IejwS/gxBzXfie1vgdfjmAPv//gS78Qy5b92yvCICAseRu01stzysmhHrYKU02HTiA
         LH+huUNirycECmnlcibFw6eL+zlY/2bD0re3ZKzXRszdZaQSZE3gxJW+EtX/dgv3oVsN
         wlvlireWXSSO6PxCd09fl69smxWqWW+/MSsiE6QRzbC0IBxYq+fUcYb5wqR09EFICHzL
         bNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fnHOU5H0h54e4hmVEYXh4fffVBg0SrfLMy1uXRyX8Fc=;
        b=G7AIjdLhN/00/8791qGn+Rx68SzTOr8koCjNiRBOECmewSG1Wu0jXmyLgvkN2GOPb7
         //Ooo9G4vKIo1lrHp9bn2DmzSm+c/nLdXo4h7YcjdSH/rfK+gI4EHbrB63/+6yzRbz/e
         QYYYxN4pfBI5JqCNNKTtyCDKQEnRxyZrNrF8iKsnXZ4WtJzLzDjXVsEoAzJZcgqKCNj5
         hmqisnVMMlpZCNaWbjs+PaIA+KZwgUSkLjcDCTiUulB+7q2m2MFoOimAMdxonpP85F08
         CDpM7qPIVtDsd51YXISITGpDeQ7biA/Lw8QoOqvQaH3X74qGsauG3KDxoxHYDDuK5Kxl
         FgZQ==
X-Gm-Message-State: AJIora9RHrYlIxojR5/TsuN3bOKp0lDWg0wMir3BrtSswy8qugU9khhd
        Bm/8/iBsylIMNh0t0viJtdVvf9ISwl6vIA==
X-Google-Smtp-Source: AGRyM1vE2DMkPrFV880xiQgE5ci6m7CXIzNdwOS++naJLKKSZxQLlNDeMBE3LcmSjq7wXM//KrqVww==
X-Received: by 2002:a05:6402:6c2:b0:43b:b89:3c31 with SMTP id n2-20020a05640206c200b0043b0b893c31mr32105014edy.239.1658075848986;
        Sun, 17 Jul 2022 09:37:28 -0700 (PDT)
Received: from DESKTOP-A98GP49 (cable-178-148-254-8.dynamic.sbb.rs. [178.148.254.8])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906311100b0072b7d76211dsm1540597ejx.107.2022.07.17.09.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 09:37:28 -0700 (PDT)
Date:   Sun, 17 Jul 2022 18:37:26 +0200
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add D5 Next fan control
 support
Message-ID: <YtQ6xg60lYNrgF0V@DESKTOP-A98GP49>
References: <20220717154114.7545-1-savicaleksa83@gmail.com>
 <4141c603-a153-adc1-ee08-f0ba0d99ade7@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4141c603-a153-adc1-ee08-f0ba0d99ade7@roeck-us.net>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 09:14:13AM -0700, Guenter Roeck wrote:
> On 7/17/22 08:41, Aleksa Savic wrote:
> > Define pump and fan speed register offsets in
> > D5 Next control report, as well as its size, to expose PWM fan control.
> > 
> > Signed-off-by: Jack Doan <me@jackdoan.com>
> > Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> 
> This suggests that Jack Doan was the author of this patch, not
> Aleksa Savic. However, that is not reflected in the patch itself.
> Please either use Originally-from: instead of Signed-off-by:
> or make sure that the original author is listed correctly.
> 
> Thanks,
> Guenter
>

Thanks for the clarification. I'll send a v2.

Aleksa

> > ---
> >   drivers/hwmon/aquacomputer_d5next.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> > index 0e56cc711a26..997d72ea6182 100644
> > --- a/drivers/hwmon/aquacomputer_d5next.c
> > +++ b/drivers/hwmon/aquacomputer_d5next.c
> > @@ -71,8 +71,12 @@ static u8 secondary_ctrl_report[] = {
> >   #define D5NEXT_PUMP_OFFSET		0x6c
> >   #define D5NEXT_FAN_OFFSET		0x5f
> >   #define D5NEXT_5V_VOLTAGE		0x39
> > +#define D5NEXT_CTRL_REPORT_SIZE		0x329
> >   static u8 d5next_sensor_fan_offsets[] = { D5NEXT_PUMP_OFFSET, D5NEXT_FAN_OFFSET };
> > +/* Pump and fan speed registers in D5 Next control report (from 0-100%) */
> > +static u16 d5next_ctrl_fan_offsets[] = { 0x97, 0x42 };
> > +
> >   /* Register offsets for the Farbwerk RGB controller */
> >   #define FARBWERK_NUM_SENSORS		4
> >   #define FARBWERK_SENSOR_START		0x2f
> > @@ -667,9 +671,11 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >   		priv->num_fans = D5NEXT_NUM_FANS;
> >   		priv->fan_sensor_offsets = d5next_sensor_fan_offsets;
> > +		priv->fan_ctrl_offsets = d5next_ctrl_fan_offsets;
> >   		priv->num_temp_sensors = D5NEXT_NUM_SENSORS;
> >   		priv->temp_sensor_start_offset = D5NEXT_COOLANT_TEMP;
> >   		priv->power_cycle_count_offset = D5NEXT_POWER_CYCLES;
> > +		priv->buffer_size = D5NEXT_CTRL_REPORT_SIZE;
> >   		priv->temp_label = label_d5next_temp;
> >   		priv->speed_label = label_d5next_speeds;
> 
