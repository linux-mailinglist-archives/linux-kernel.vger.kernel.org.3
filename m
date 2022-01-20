Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C6D494507
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 01:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345455AbiATAps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 19:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345135AbiATApn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 19:45:43 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB998C061574;
        Wed, 19 Jan 2022 16:45:42 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id t4-20020a05683022e400b00591aaf48277so5507284otc.13;
        Wed, 19 Jan 2022 16:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pN7lFPUXFYn0Dp5HJfunzPkw56TkeXxPA5Y7ObLojS8=;
        b=ZnOvgZEOS5BELoXMDhNsb5KgGO3zBTuHjEr0zjfl9PNJl0eu7GJcNnZD1Pm/9r3tGt
         K89hFWkLprSpCla6SFJ/zCmSbBvim3QfIIKRasxq7emN+SIUuEm2066n+1eWmUh+32Dj
         NR6UJ9FgJpELLkyICVC0BrRi8LPIbZVEiCnRJpcIG7r9+F8YU/j7HV65kTmAuLiLDQgR
         j+JduPMMhl6GinFgi0Op4zPEQvUclmVR3YKsQNYNm+aJ0pCrqGedHC9KYCN0AQc0K66Y
         0FTEyMDLL99r4oV4jNDFb9+m1t60WBg44OTtkF0HvITrkOagbDyqOPHKgAWNPj/XXjaa
         7NxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pN7lFPUXFYn0Dp5HJfunzPkw56TkeXxPA5Y7ObLojS8=;
        b=TdFXlSa39gn1Rpibgv3bfA/9ADwHl+wARAI8UvPJt3fkC8ETC1Vvu7Ac08YIM/yTu2
         NWL/pLOVlUmbuUwh+W1FLILzsH1ilkVFLlTHQo3ugHW7qt/SwfOvGq3IZBzUjwe2XrPZ
         AhcrJw/qd9TfIct6w5Xwkf9j4A+prj4No1K95Izw25rz92089NEbfl9GLnhlG/K0iYd0
         umRoW6ozcZ1s6+JJNdAi+HnzQEMYkNvDQgHDuFEYBdNA04CD6N/a0IpzuqV1yGMjygGf
         cKS1iJMGbnapC43fMFsUaWezuAqHrrjbi4qvnsgPC+5xj0zdreN7FfspRt9DjsIGbQMU
         AilQ==
X-Gm-Message-State: AOAM530Pxp32UMLZvApBKErGnvsUMzwRV6ef4oHTkF+KYA7nZJYp9RE7
        sSDNbnOFGlmGPuZ0KbQ6x2I=
X-Google-Smtp-Source: ABdhPJxq6e2FlZ6iUATfFQ33l9ZuXGWlXdRyUZ/yvgrjR5yKCQsaQoxB48P2EHNVUBmiJy1eyxxtrQ==
X-Received: by 2002:a9d:7e82:: with SMTP id m2mr14113634otp.4.1642639542143;
        Wed, 19 Jan 2022 16:45:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s11sm755368oig.55.2022.01.19.16.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 16:45:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 19 Jan 2022 16:45:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Subject: Re: [ASUS EC Sensors v7 1/3] hwmon: (asus-ec-sensors) add driver for
 ASUS EC
Message-ID: <20220120004540.GD3474033@roeck-us.net>
References: <20220118165316.412735-1-eugene.shalygin@gmail.com>
 <20220118165316.412735-2-eugene.shalygin@gmail.com>
 <CAB95QATvQPZ-s4dCWeqKcSZ9Rfx9uK1AyoM9Kk3biPfvXh5r5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB95QATvQPZ-s4dCWeqKcSZ9Rfx9uK1AyoM9Kk3biPfvXh5r5g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 04:25:41AM +0100, Eugene Shalygin wrote:
> I did not read carefully what I committed and now two small
> corrections are required (see inline). Should I resend again?
> 

Wait for a couple of days in case there is test coverage
or other feedback.

Guenter

> On Tue, 18 Jan 2022 at 17:53, Eugene Shalygin <eugene.shalygin@gmail.com> wrote:
> > +       DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-F GAMING",
> > +               SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> > +               SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET
> Redundant line break.
> > +       ),
> > +       DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-I GAMING",
> > +               SENSOR_TEMP_T_SENSOR | SENSOR_FAN_VRM_HS |
> > +               SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU),
> 
> 
> > +struct ec_sensors_data {
> > +       unsigned long board_sensors;
> > +       struct ec_sensor *sensors;
> > +       /** EC registers to read from */
> > +       u16 *registers;
> > +       u8 *read_buffer;
> > +       /** sorted list of unique register banks */
> > +       u8 banks[ASUS_EC_MAX_BANK + 1];
> > +       /** in jiffies */
> > +       unsigned long last_updated;
> > +       acpi_handle aml_mutex;
> > +       /** number of board EC sensors */
> > +       u8 nr_sensors;
> > +       /** number of EC registers to read (sensor might span more than 1 register) */
> > +       u8 nr_registers;
> > +       /** number of unique register banks */
> > +       u8 nr_banks;
> > +};
> 
> Forgot to remove doc-comments.
> 
> Thanks,
> Eugene
