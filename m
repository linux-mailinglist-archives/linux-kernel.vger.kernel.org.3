Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DF850CC51
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 18:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbiDWQh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 12:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiDWQhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 12:37:25 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F7B2F025;
        Sat, 23 Apr 2022 09:34:27 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e5ca5c580fso11819032fac.3;
        Sat, 23 Apr 2022 09:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kdKMMnUA+xK7+qfwHy7L8VJH4pn19kuakHSYhLYJsME=;
        b=d8wFV5HD+2y58md+ggyQwpanQEqyF7bSzJVMjUI0q4LrIA+4CyDu3HAzuyWNH/J3Ot
         ZxuMuecmx397wyMwBkkVh47jl1PRtzRTvkuQaYa6aw87M4hUXnEhjSSbVnsR4KFg5NOz
         DV7hME+ajQekX8fP5O5+hoKL+CimiRdFqJTrOPOXE/laJ8BNUqI8tFOLIhoKSc6Ny/WH
         0reRrM6cagdlMrJ0ROvCq4Wqb5WHnPXD9Vwg6YSsvp6y3eZ6zIDeTAS4waGyWZAblsWa
         WXtz4nass82V50EW3JZNItl4zE9pyOX4gg58TclpsZ/Jvw64jRAdRaNmJHS2XZCwTWnw
         AEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kdKMMnUA+xK7+qfwHy7L8VJH4pn19kuakHSYhLYJsME=;
        b=nuc8YS+begyc3TDF6bv8zK0nubCTLOjs1cwBPRvKZk2AZzDC7xmHGBf/xI4XpOH1Fn
         s8+Cq3PKSYMyiCtx43W7uiX73xPrkWZK5LUxdSzxrIZMQiU18DZa/pTU6rTiLglPzAJ2
         95nhR9wESjVtjYBh35gOk66/3zuf97tXTKfEtLAc/plDJ+ewP874/lmr0kdIWDZPTi2f
         Rd+O5fenA98hotom2vXLrBfJfYMTXiHXsUPyCgC6OYk5eOJfFvAPDYyJuLwK/4gAuf8n
         c/ppPleeyo5up9MCCspcC8KzCS8Re7gOAshbJs3Pe1b8zZMXyzUZYuCjZ5Ti1FGp8bJ6
         tHww==
X-Gm-Message-State: AOAM533sepOEXzxu1CZWWQ2QC8Hm99wGYswKiEp01XDAQ/nEBttzXrbS
        FIA9Jp5lRlZVHBpSRw3vXV0=
X-Google-Smtp-Source: ABdhPJwGTu/C/RVu0+EetN+MLvLoyqxJzkF96/JACYVXvhk8RVWxScGB3efjBVf6t28JOrghHbzX7Q==
X-Received: by 2002:a05:6870:580e:b0:e2:7e06:e785 with SMTP id r14-20020a056870580e00b000e27e06e785mr4372716oap.38.1650731666707;
        Sat, 23 Apr 2022 09:34:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v27-20020a056870311b00b000e28bdb81e5sm1716857oaa.44.2022.04.23.09.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 09:34:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 23 Apr 2022 09:34:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer Farbwerk
Message-ID: <20220423163422.GA3964519@roeck-us.net>
References: <20220421072743.5058-1-savicaleksa83@gmail.com>
 <20220422183144.GA2637654@roeck-us.net>
 <YmQoEoU1UJ+KPhQ9@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmQoEoU1UJ+KPhQ9@fedora>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 06:23:46PM +0200, Aleksa Savic wrote:
[ ... ]
> > > +	case USB_PRODUCT_ID_FARBWERK:
> > > +		priv->kind = farbwerk;
> > > +
> > 
> > 
> > Any special reason for this empty line ? It seems kind of random.
> > 
> > Guenter
> > 
> 
> That's how code in other cases of that switch is formatted (not visible
> from this patch directly), setting priv->kind and then the appropriate
> labels.
> 
Ah, ok. Looks odd here, but makes sense.

Thanks,
Guenter
