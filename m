Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90B253B00F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiFAUx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiFAUxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:53:24 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F204C65E4;
        Wed,  1 Jun 2022 13:53:22 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id br33so557694qkb.0;
        Wed, 01 Jun 2022 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=knVaomDMh+qFdTKX0RVE5ZaCevAlfmtvTfDnaO4g8Ak=;
        b=gmgABx2UT8bqUDlWil7waiFllyAu5qUs8xeg3ucfwQ2a2tZO33QB4CcX2tlDz7UaXt
         jV39OQ2FBhhva1oiNIWmEmY86LpPudUTfWTzr/8qYZIcvixaEzjG6MvaosB4pZeZkcnm
         cnfhEXjbBHAaxQaTBwozroM7xFkHuWYg/JbqlN3NCsb3uUCjrWbDcARKSWxySWkLhNFn
         fJMwTvZvWtnIVSmCZ9CRga12CvH2BUje9Qe53ne/NM5FczR/kk/Sn1l/mOGHUDLAUVCi
         DV0RVEW98iJ5Rfo6h/aWGkOSf8TOYC24C6OpLMVi083biplKDDhrkUzhyMhDAO49EGEE
         4LDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=knVaomDMh+qFdTKX0RVE5ZaCevAlfmtvTfDnaO4g8Ak=;
        b=J1yikAe6/aB0TBIM0pZhAlwCOSWcfTrun+7zYmwqTC2CeFN9uO9/t09+gIAOBO6tQu
         C9PCfRm7gDagl9Drw7+iaOOSqCSEOKXdKsbHNOAvZ5SHrTAm5djwU/5yNj54FMLNrEf2
         UWvmU6PSE2F6rcZ1uSH7yht8pWb7Ws4UEINycFANZIQ/uDjOXgPuuxIbVoxdkilamxmM
         yKBqnHmloBX6Lq7T9wyNzUsyLX1ZSknAqwxCVLvpC5jf9Jyku+Yu1gwfo6bFE/anTpS0
         e5dTRK0CbuUk+xzRVvuHrdApbuwns4+W9gm8pqR8kQjmhnozyxwUqvCdL+27hgqBy9zH
         w67g==
X-Gm-Message-State: AOAM532fRP7BacjOmEvQZMIH7b+tM3qsCYKMXhCrk90YEEk6BoGl/efV
        IfHNq/R5l397aKO686wuse40OANViBQIRQ==
X-Google-Smtp-Source: ABdhPJwlUy3H9oddXgMJUgzbeNl0w0TWGdgGgYBKywG3/nGh2FEoz8zYxbJRa8EK2xx9xWAkV7SN0g==
X-Received: by 2002:a05:622a:1baa:b0:303:6049:8aeb with SMTP id bp42-20020a05622a1baa00b0030360498aebmr1035126qtb.10.1654109878714;
        Wed, 01 Jun 2022 11:57:58 -0700 (PDT)
Received: from spruce (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id g27-20020a05620a109b00b006a34bdb0c36sm1747850qkk.31.2022.06.01.11.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 11:57:58 -0700 (PDT)
Date:   Wed, 1 Jun 2022 14:57:56 -0400
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] iio: Use octal permissions and DEVICE_ATTR_{RO,RW}.
Message-ID: <Ype2tDgWRVC68O//@spruce>
References: <20220531181016.76007-1-joetalbott@gmail.com>
 <CAHp75Vdei4SyC0Ph0xB3DFLgkixU2FJ1TS4og8r=b+CkiMQ5hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vdei4SyC0Ph0xB3DFLgkixU2FJ1TS4og8r=b+CkiMQ5hQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 12:01:12PM +0200, Andy Shevchenko wrote:
> On Tue, May 31, 2022 at 9:40 PM Joe Simmons-Talbott
> <joetalbott@gmail.com> wrote:
> >
> > As reported by checkpatch.pl.  Where possible use DEVICE_ATTR_RO and
> 
> DEVICE_ATTR_RO()
> 
> > DEVICE_ATTR_RW.  Change function names to be <var>_show() for read and
> 
> DEVICE_ATTR_RW()
> 
> > <var>_store() for write.
> 
> ...
> 
> >  static struct device_attribute dev_attr_length_ro = __ATTR(length,
> > +       0444, length_show, NULL);
> 
> >  static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
> > +       0444, watermark_show, NULL);
> 
> Why not __ATTR_RO() here?

Thank you for reviewing.  An updated v3 patch has been sent.

Thanks,
Joe
> 
> -- 
> With Best Regards,
> Andy Shevchenko
