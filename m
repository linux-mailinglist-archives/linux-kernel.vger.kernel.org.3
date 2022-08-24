Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482B659F861
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbiHXLJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbiHXLJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:09:14 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A624179618;
        Wed, 24 Aug 2022 04:09:13 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x15so15257381pfp.4;
        Wed, 24 Aug 2022 04:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=/RND73dpDlTwC3yKj62Qk3RzbNHlxzOUk7joQsbV6ZA=;
        b=CYnvXmgqrHQoC61j7a28gaTg1/NQRXLm2AkJ9vP/vNLuvXwjumDQ/VlcoELzGFImqK
         jLvEVXl3BjMINCPI+oUwkF3ZUuMz1YIMpyFc5lVkoZcIzaWQIACeMDQW8BpW2Qc1VWbd
         M59PFsKycj4UW2pRIF+DCHidXP5q7FdOi06w+RYnP3qYKuoVCB2M1HsaNjXURwUG2DgX
         Ed+YE+z01SGhcJneUTysjentrXeB5sUHq8hPcukXhTJ8dEZ1Twgqz1fJnTIErNqBT3Oj
         I1jeRC2ZBXl71hnFgRcdmCiUlgeoCMU19VmBfJSGNwHozuNcbSf9gcxYx5rs9R+9caX1
         WzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=/RND73dpDlTwC3yKj62Qk3RzbNHlxzOUk7joQsbV6ZA=;
        b=KnOiP5ij+6hJycRdO08mxjuSEmoBT95avL3txOg4HpIRTdL4gt9MVbiXpby829C2rS
         zHvTx62aBEJXfWXafY89FeOTuucETth5LfGR8X68Y8/m2FLUv5sBZE7fmL/aIPgvQwQz
         /WTsprpEkxG+5DMA1t8/MIUmXc+paiCNbCQ7felRbrGVMI2mweKB2YFw0SjfkBPiWjV9
         L29p89l8TSuZmzmFKZa14OAtT0HrTxIZa47pBy1fSOxMWZzhWFTg62X3UMgWb62Eq7M4
         HooIaYAybK+LRE5Bpefnu+ukAdv6IXL2V1ZXDmNZTYeNRpCI3RzBNzr0mKox6AbNmE1n
         2f8Q==
X-Gm-Message-State: ACgBeo3lMRiuOg+0amWN/aR9nKXgNlMIItV97YTmORQarlWk5PjpcTP2
        Ao8tnxQDn1yWidV9C5ZQh0U=
X-Google-Smtp-Source: AA6agR6GFm+ycvsyeYPOeDq9OpN9o9LCVbUUw2n1fkG79nqzNglZpsxaVeS6EYKDEYT5hq64nineQw==
X-Received: by 2002:a65:6d19:0:b0:42a:37d7:90da with SMTP id bf25-20020a656d19000000b0042a37d790damr20935518pgb.16.1661339352905;
        Wed, 24 Aug 2022 04:09:12 -0700 (PDT)
Received: from AA2000783-NB2.corpnet.asus (125-229-150-10.hinet-ip.hinet.net. [125.229.150.10])
        by smtp.gmail.com with ESMTPSA id z12-20020aa7990c000000b00536431c6ae0sm8990417pff.101.2022.08.24.04.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 04:09:12 -0700 (PDT)
Date:   Wed, 24 Aug 2022 19:09:08 +0800
From:   PaddyKP Yao <ispaddy@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     PaddyKP_Yao@asus.com, andy.shevchenko@gmail.com,
        hdegoede@redhat.com, acpi4asus-user@lists.sourceforge.net,
        corentin.chary@gmail.com, linux-kernel@vger.kernel.org,
        luke@ljones.dev, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev
 support
Message-ID: <20220824110908.GB111@AA2000783-NB2.corpnet.asus>
References: <HK0PR04MB33636680A6DC47211560BB43FA879@HK0PR04MB3363.apcprd04.prod.outlook.com>
 <20220711024718.1700067-1-PaddyKP_Yao@asus.com>
 <20220824100615.GA1049@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824100615.GA1049@bug>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Wed, Aug 24, 2022 at 12:06:15PM +0200, Pavel Machek wrote:
> >  drivers/platform/x86/asus-wmi.c            | 25 ++++++++++++++++++++++
> >  include/linux/platform_data/x86/asus-wmi.h |  1 +
> >  3 files changed, 28 insertions(+)
> > 
> > asus->micmute_led.name = "asus::micmute";
> 
> Please see/modify well-known-leds.txt file. We want this consistent on all devices.

Thanks for your feedback.
Do you mean I should use "platform::micmute" instead of "asus::micmute"?

Best Regards, Paddy
