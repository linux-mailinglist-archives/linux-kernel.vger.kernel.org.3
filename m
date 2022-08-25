Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0C85A0AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239109AbiHYIF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237349AbiHYIFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:05:55 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A22540BEF;
        Thu, 25 Aug 2022 01:05:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y127so15990760pfy.5;
        Thu, 25 Aug 2022 01:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=heEHOjqaoZfuUKBnGqgwRXL1DFbaof5JCnXSywcr050=;
        b=d1RFGcXrwRHPrYRWhhFh+QaqBW4JEqlixPxU77fKDXR/EnFbnUShHEyAgI6enNoyfv
         jCsxfwxekr+CqXOGuupR/CZ6TPDtv3XLYmgxUzLEDTui0gvUphjJW3ZADWu6kYmWtgXz
         clglysHXpiFy/KVJcVxBj/mLruQA3dED6XXJBgfcY8kATK4yrYBuOA+vTe3Pn3qiPPut
         VxaFJuVCxzHuwNSEaEIv6NkoikvDcBgZ6VW/bgiie0hpi397OZQCgJdH8eKCFKtGbYuw
         SKyPqCXP8/07URCCajFw5zu9ulEImAAogATlLLpZOHOc1l/2C+4widbOQxwTzj91lits
         7Q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=heEHOjqaoZfuUKBnGqgwRXL1DFbaof5JCnXSywcr050=;
        b=aTxEDxWty3+V9ZGBpJdxVP90v13G/zaM7QSLw/KfA4v3LVXfS3cZz5i0JSbOlb3+ZO
         ERQNCRjPxNn67dHxY/nkCdf2/LI8rnTdqyxHKmJ6Mo/nFdTlPVaa0xjNi/yeLUThO8U0
         uLXAt36G/o+MzTfzTlWVSlFIkSqbcCCvxijeQYzCXNqg4WlMfToe2B12SRsbsUCyrUfH
         fhNBPOhzuiuAEj6T1mZwFPTvzrXUdXLAuOAObPvVls7yUJ9e80txA6QfKoBwMEkVqjQ6
         IuwINueLATnFMTo+/88sz77xGIYPaqHvsRJ3EnsoTBkr1ITLQ8U3YJKS/zakf6hEskDB
         IaUg==
X-Gm-Message-State: ACgBeo3m+h7drPLakMNmNNKNsH8CDhYnMGWR/KjxlsURFr241eUcagQN
        eIY+NZPYOhllhj36c6g9f0M=
X-Google-Smtp-Source: AA6agR4FmJGWUFbjGrMVXXNJjNWn9k5Zzxi/9fDCATJ5osMpOW1YgXdmobFgtI/HywFmm7LLRFCR1Q==
X-Received: by 2002:a63:e412:0:b0:41d:9c6a:7e with SMTP id a18-20020a63e412000000b0041d9c6a007emr2322510pgi.575.1661414751987;
        Thu, 25 Aug 2022 01:05:51 -0700 (PDT)
Received: from AA2000783-NB2.corpnet.asus (125-229-150-10.hinet-ip.hinet.net. [125.229.150.10])
        by smtp.gmail.com with ESMTPSA id z11-20020a63190b000000b0042b2311f749sm2431052pgl.19.2022.08.25.01.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 01:05:51 -0700 (PDT)
Date:   Thu, 25 Aug 2022 16:05:48 +0800
From:   PaddyKP Yao <ispaddy@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Hans de Goede <hdegoede@redhat.com>, PaddyKP_Yao@asus.com,
        acpi4asus-user@lists.sourceforge.net, andy.shevchenko@gmail.com,
        corentin.chary@gmail.com, linux-kernel@vger.kernel.org,
        luke@ljones.dev, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev
 support
Message-ID: <20220825080548.GA17321@AA2000783-NB2.corpnet.asus>
References: <d7e2a109-c1b7-9f8c-c2b2-b765f016a9a3@redhat.com>
 <20220711115125.2072508-1-PaddyKP_Yao@asus.com>
 <e120ac7c-7abb-4999-efe8-6b3b697d12d6@redhat.com>
 <20220824100622.GB1049@bug>
 <20220824105908.GA111@AA2000783-NB2.corpnet.asus>
 <20220825075547.GA28653@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825075547.GA28653@duo.ucw.cz>
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

On Thu, Aug 25, 2022 at 09:55:47AM +0200, Pavel Machek wrote:
> On Wed 2022-08-24 18:59:08, PaddyKP Yao wrote:
> > Hi Pavel,
> > 
> > On Wed, Aug 24, 2022 at 12:06:22PM +0200, Pavel Machek wrote:
> > > 
> > > It would be good to get the API right before it hits mainline release.
> > > 
> > 
> > What do you mean about API you mentioned?
> 
> We really don't want to see asus: prefix in the sysfs.
> 
> Best regards,
> 								Pavel
> -- 
> People of Russia, stop Putin before his war on Ukraine escalates.

Understand and thanks for your feedback.
I aready submited new patch to fix this.

https://lore.kernel.org/all/20220825004305.709539-1-PaddyKP_Yao@asus.com/

Best Regards, Paddy
