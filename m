Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B8C5A059F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 03:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiHYB3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 21:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiHYB3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 21:29:13 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C636C8034F;
        Wed, 24 Aug 2022 18:29:12 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id f17so12051713pfk.11;
        Wed, 24 Aug 2022 18:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=JZ6jUZFJ3GusaHzs6nel0cSD6BnzpjxW/8u8oueO9BU=;
        b=dPkkN7qA1dAk49xU+KV7QjMFftVxzOc0rkxg4EKsfjYWjpoZWwRRWkf/S/GAT6QBDI
         b7zecXTTLbeKalI+ldikqTnDVelQZ1cm3x+F1WHPWbPGCGv1nPw5jCxgoauSFK4aIU54
         1P0KOcFCfEj76D7stx43k3EXsqB/VBl2tCkLDP1PkWo4ieYC694eP/uFKO0ctjddYG5U
         o4Ml58bTvrfd8OSn21+Ma9NlKnLbBH7E9/68TgLvhmmnvlIMewlzCv0yXvs0aRS/FG4O
         g1CTIVQFIoltV3PmlxTsA4hUmHLYEAlOo9PA+JiRAQLCIVa2UMkXEf0i/5nZHtaXUUaA
         utNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=JZ6jUZFJ3GusaHzs6nel0cSD6BnzpjxW/8u8oueO9BU=;
        b=ht7qzXt7xqj4dkDUrneF2H605yIsBptIDtbUwfTAbjPlJCKC4LjzBDpG9JWcvEi1zm
         pFw1Cn1ovrwOEDEmcNUrmXSE5Ts0xfwKxiS6Ex3PUN3vSV2Hcgc2uKDn5j5IegPXOS2n
         8OLUWF4VuzRk/S4NDeJZfMne4+pfeQ+3EyM1bx4oYi623ez6hIcsJxM4m8hfww8IuzIF
         ydVg1BMOQ/rLVHxXGVFREY/4N6MvpIStZrig9/oAC0avQmjlExvKlbqWDwNWprvJ2RFX
         xP/RCv8JSSA/AxhgrELwU6b8+GGSbL6InKh0wBZ6d8YUXUyaHie8EmOrnK7YYAW3TB9G
         ijIw==
X-Gm-Message-State: ACgBeo2+c3T0mpADC19EQ5Lfk9qRK2HbH23xK0bYqmkACQ8PoDb+XNCi
        NLU89z2+mmntUUsZUb1Pnnw=
X-Google-Smtp-Source: AA6agR7TtU/PKiAEbgLU6Y7PA8FIy+3PQBYu0PJIWzcsVd+rwTZL72ApIlWHpsysT4xLcdq27gLgRw==
X-Received: by 2002:a05:6a00:2446:b0:528:5da9:cc7 with SMTP id d6-20020a056a00244600b005285da90cc7mr1813772pfj.51.1661390951982;
        Wed, 24 Aug 2022 18:29:11 -0700 (PDT)
Received: from paddy-ASUS-EXPERTBOOK-B1400CBA (61-216-65-192.hinet-ip.hinet.net. [61.216.65.192])
        by smtp.gmail.com with ESMTPSA id s17-20020a63e811000000b00429ffc18e5csm11608982pgh.59.2022.08.24.18.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 18:29:11 -0700 (PDT)
Date:   Thu, 25 Aug 2022 09:29:06 +0800
From:   PaddyKP Yao <ispaddy@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>, PaddyKP_Yao@asus.com,
        andy.shevchenko@gmail.com, acpi4asus-user@lists.sourceforge.net,
        corentin.chary@gmail.com, linux-kernel@vger.kernel.org,
        luke@ljones.dev, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev
 support
Message-ID: <YwbQYlqZ3H0NgaUu@paddy-ASUS-EXPERTBOOK-B1400CBA>
References: <HK0PR04MB33636680A6DC47211560BB43FA879@HK0PR04MB3363.apcprd04.prod.outlook.com>
 <20220711024718.1700067-1-PaddyKP_Yao@asus.com>
 <20220824100615.GA1049@bug>
 <20220824110908.GB111@AA2000783-NB2.corpnet.asus>
 <ca13b742-7bb9-da20-4e50-2d04233aaf93@redhat.com>
 <20220824111734.GA8434@AA2000783-NB2.corpnet.asus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824111734.GA8434@AA2000783-NB2.corpnet.asus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Wed, Aug 24, 2022 at 07:17:34PM +0800, PaddyKP Yao wrote:
> Hi Hans,
> 
> On Wed, Aug 24, 2022 at 01:11:32PM +0200, Hans de Goede wrote:
> > Yes. Since I have already merged your original patch can you please make
> > this a new patch on top of your original patch ?  In other words just
> > make this 1 small change in the new patch:

Thanks for your help. I already submited new patch by below mail.
And may I use author PaddyKP_Yao@asus.com instead of my gmail account for
this new patch?

# mail for new patch:
Subject: [PATCH v1 1/1] platform/x86: asus-wmi: Fix name of mic-mute LED classdev
Date: Thu, 25 Aug 2022 08:43:05 +0800
Message-Id: <20220825004305.709539-1-PaddyKP_Yao@asus.com>

Best Regards, Paddy
