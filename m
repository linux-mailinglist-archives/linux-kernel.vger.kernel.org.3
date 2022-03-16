Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079B54DB947
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346635AbiCPUYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiCPUYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:24:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78AE2A25F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:23:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w4so4141671edc.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/W5laBTZHdKIhPFdmxssAJ/PyZmpniDY63SyfCg8328=;
        b=m92o9PYDH2Pqko8Jg5f/4xBxboNuVcCi05N5Z1C883GeytGPj65qh0BEAk1u10aSnV
         dfaAMMeRsQC/TAaxyiIOWqQKRSWb1yxJ603+SW+QjRXfbag83sfMfwgLhh0F8JHbkNlG
         usP+N+nazlXyrHWY1l7vI/bS20wK1YND8MPmA3KLK8/aS3RaO28+0mAKMA6OsMEMKaeL
         IZncXP+RvYJ5Reg5zdmKDqTSL42/VnFjc7Ngsyjt+cYYUVz/joGRXVc9KTVMnTjc0bMz
         zhVuKHoiMkREpc/5V5w7JYm07Ns+ffWHc5NSOpUh69hf4jkPKRAVviOvU8uOd6X1R6nB
         vbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/W5laBTZHdKIhPFdmxssAJ/PyZmpniDY63SyfCg8328=;
        b=6RsKvLWDYpRbA1/Ev/k7ulqsZFlfoELZKb/nJXrExP5mDt/mUN5eD1B0dl8ARVE0xr
         Ml8Nfi7tbwRobxRUZh1tE9c1lHW4EpUvIl4YuE9Yt95fcM304l2kskGlFC1hUXiiNp6J
         AvvS8STdT0H6bNZRJ4+4VPTBrtorZIgrSPnc6GD61CDFbONG1xmSTcQ39fd4KKDReKAY
         STvBBInjTx/GA8JpnS2dRuCqD5UehBJSkuvk3l6gu0HF3IJld36PZjlQS/3Raknog2Q6
         UHaIQyhXT73yUvtwaJodLRAUPdMSCtyuMLOqIaFM5nFYSJZ5GVgBy1JNlphGkKeSfb/v
         MUTw==
X-Gm-Message-State: AOAM532IZZJugmY/dawtNHzBUr0ePCY6xVpro9e1fQ5WRH6Ft3ehaUrE
        2eqZQXuDbjwvfR+lTKRdRMQePoVjHUqk7arI
X-Google-Smtp-Source: ABdhPJzXsMB8mZpAwg03dI85wTVY9KB/446Yl7/fe+M1GEUQN35mtGFiShQYS+jcP2KIlFVpFfIrsQ==
X-Received: by 2002:a05:6402:278f:b0:416:a887:9853 with SMTP id b15-20020a056402278f00b00416a8879853mr1231698ede.44.1647462217169;
        Wed, 16 Mar 2022 13:23:37 -0700 (PDT)
Received: from nam-dell (dslb-002-203-132-165.002.203.pools.vodafone-ip.de. [2.203.132.165])
        by smtp.gmail.com with ESMTPSA id d11-20020a170906c20b00b006d584a09b9fsm1374872ejz.98.2022.03.16.13.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 13:23:36 -0700 (PDT)
Date:   Wed, 16 Mar 2022 21:23:35 +0100
From:   Nam Cao <cvn249@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix CamelCase naming style
Message-ID: <20220316202335.GB7346@nam-dell>
References: <20220316113228.21243-1-cvn249@gmail.com>
 <YjHu0FjaHRoqfZ+y@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjHu0FjaHRoqfZ+y@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 03:06:08PM +0100, Greg KH wrote: 
> Why are you keeping "pfn_"?  You do not need to say that this is a
> "pointer to a function" anymore, right?
> 
> thanks,
> 
> greg k-h

Thanks for the feedback. As newcomer, I really appreciate it.

I will send updated patch soon.

Best regards,

Nam

