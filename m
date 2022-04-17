Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E9350497A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 22:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbiDQUwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 16:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbiDQUwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 16:52:31 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC195F79
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 13:49:54 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id n11so9873951qvl.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 13:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ofmszlcyf7yX+uAYXy8RK5mMYEQfM2GF5ksPIibzvA4=;
        b=mQ4y6rZsU8aFE+nbIUOJM99oQjKbOER5NGwNRqBddx9G1u9vf1Ua0z4tJIYvcwKsxz
         xbXbPWsYRFwnaKfPzn/iM7Kp6K4nx1cY1JbRLx+Ybo6H/6Y5yiyeTsyHvdNmSiG33qJB
         GNOJKP3IX2WHx6PNMv/bffy6MtuCBNfoTE0wH9d5M17lAOCO6trcbAWRmChjzUieEKnJ
         TYsr+t1S4i7X2yCfGmVPxevvannGkOZDt2/b2AaYoPtKNm6nDLYPTKOi1wBOAUaIVMVJ
         /nxGPLT/RyQ9iT9Go/8n/Fy5zpJ/izXN7sXu30IsFFS99FNlQi4OLdiNjlNcNQCcq3ig
         NIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ofmszlcyf7yX+uAYXy8RK5mMYEQfM2GF5ksPIibzvA4=;
        b=njlgl8n6mNEnF1HdWBl0tliAzMNJhpzBpKevOwpB7ThPcuL4W6WahqS7jyN8pnE2HX
         9XZvMIfdZChwtajsJyPlFbW7TZGSZLDGy86RWQQLgiEL/9FEmYbN8kiNkSc9P+Wreakv
         KEb1riyrTUwSzejR0fWCLu2xJlUQ+magmWP8dZ67xP5d8k13Ulf3Ulq9QO51NaWQjC1j
         lGStOqCvFwnrgx6REeFqqaTHXdxrsbEbXHnBtvbqF7g4K3knhcyggPBMI0KccWZHoa/g
         9BmjR1OuIm7E9ziHrsHXMv+nY30EOxlB2ZykTwyTZgyGQvMakdnCESONLIndgi3MBqAQ
         W0Cw==
X-Gm-Message-State: AOAM533OczhBBtb/SUZ+9y7AiDaPMjnyv/llwWkNz+JUfi3DSWJq/f1c
        u/vS2uOwaYUe7aTS2ZcJTIc=
X-Google-Smtp-Source: ABdhPJyAqe9ETikkHL2arPI2VeYUke76O3gh94yEez1/EUSyYufKF2PW7+QnRLUyXwTDctursVwsxw==
X-Received: by 2002:ad4:5969:0:b0:446:636c:9fb1 with SMTP id eq9-20020ad45969000000b00446636c9fb1mr320373qvb.88.1650228593048;
        Sun, 17 Apr 2022 13:49:53 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([2607:fb90:50e6:61ed:4df2:ed9f:52ea:476e])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a0d5500b0069c59fae1a5sm5552385qkl.96.2022.04.17.13.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 13:49:52 -0700 (PDT)
Date:   Sun, 17 Apr 2022 16:49:49 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH v2 3/6] staging: r8188eu: remove 'added by' author
 comments
Message-ID: <20220417204949.GA238538@jaehee-ThinkPad-X1-Extreme>
References: <cover.1649990500.git.jhpark1013@gmail.com>
 <c0eaa7cbc61d89967d81ef864c1a791f4adb1978.1649990500.git.jhpark1013@gmail.com>
 <6925e230-b816-ea9a-067f-60cefecd8af7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6925e230-b816-ea9a-067f-60cefecd8af7@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 11:23:03PM +0300, Pavel Skripkin wrote:
> Hi Jaehee,
> 
> On 4/15/22 05:48, Jaehee Park wrote:
> > Author comments "Added by Albert" and "Added by Annie" are sprinkled
> > through the file. These comments are not useful and can be removed.
> > 
> > Reviewed-by: Pavel Skripkin <paskripkin@gmail.com>
> 
> I don't remember giving that tag, but now I am OK with it, since patch looks
> good
> 
> Please, don't put random Reviewed-by tags in your commit message, since it's
> not how Reviewed-by tags work

Got it. Thanks

> 
> > Suggested-by: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> 
> 
> 
> 
> With regards,
> Pavel Skripkin
