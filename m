Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C23C516259
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 09:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242590AbiEAGy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 02:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242543AbiEAGyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 02:54:24 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF831F638
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 23:50:59 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h85so2245978iof.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 23:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VP9iXyxMxQeJllpUxlGX1hliyGmst1J0TYd1RhCYDDk=;
        b=Zj3W+S+tGghzewnNJCRlxC9wtuKtOCx10gVUhV0JAMyODHb+1EgIP6bojPrwGGhEFx
         mM9Ae/KiDyT8UycA06WfJI+5z8l9DOFWuFfhuqdkM2OQdiSeEZAe8UR+qCa/4bXyUF4g
         YmcKnrcEaA1LjfQvIYttQ1X+7311+t5BNFUv/6BQLr4VcO6Q1foBzNXgIFBOLrD4O5ir
         TprB2pyLmi7caX6JObl1AeH6DUTUXIR+UsFrktCmSagwTnz+d2KEPwJjyn09O/r3weDY
         laQQbpl7kiM56MDBCjI0a11Qm9tW59lJxzb/uTc0lvkfZmKubXcGwkAceHkT7b5RFqkb
         vuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VP9iXyxMxQeJllpUxlGX1hliyGmst1J0TYd1RhCYDDk=;
        b=OxCnxh6HbR9coIPe6FinMpr2zHVxzL4Nwu3gojqDyMpvTqHZVzEL3epQCut7cTHnTp
         5joe8p7dj15DG8SiueaTYzTzxn3v70GizbPlKwzAcgcs1jl8mnbCWFr20dt1lO1odwXB
         wKgilS3uty9X6IeRxEKrwVEfV1rcKGYAhAHAENlb39X0kZxQe2bXsJQKhyFozXiPMQlT
         24bXg49ihY8lJCITg7TNjhmZxSNeSrpLw94gS6bBgvAhHkv07OVt4k3QbQ8Jo+DjHF1N
         p15IQL5mAggIo/4T/GAh+o3ASDj9Gup5HD0B3W9lxoC7YFThvD9lCs28tpLupnakh9+z
         ck7g==
X-Gm-Message-State: AOAM532E3AmbFUMUI9wdzXOkii3yYOus2dCiFMTQwzcmDeBFQVR5bIWR
        9zkO0nK/F2goC5MZqIvxKUP4rQ==
X-Google-Smtp-Source: ABdhPJwdrlxL4myS4vLSG3xAgNFjExpAcBG4mxrh++c3aV7BYmY6aheNfQ2x3Ro4OmnBZfOWwi0pkQ==
X-Received: by 2002:a05:6638:40ac:b0:328:6b81:f9e8 with SMTP id m44-20020a05663840ac00b003286b81f9e8mr2705810jam.153.1651387858005;
        Sat, 30 Apr 2022 23:50:58 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id q35-20020a056638346300b0032b3a781763sm2066526jav.39.2022.04.30.23.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 23:50:57 -0700 (PDT)
Date:   Sun, 1 May 2022 06:50:53 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        eauger@redhat.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v6 13/18] KVM: arm64: Support
 SDEI_EVENT_{COMPLETE,COMPLETE_AND_RESUME} hypercall
Message-ID: <Ym4tzRL0iMxyumJe@google.com>
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-14-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403153911.12332-14-gshan@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 11:39:06PM +0800, Gavin Shan wrote:
> This supports SDEI_EVENT_{COMPLETE, COMPLETE_AND_RESUME} hypercall.
> They are used by guest to notify the completion of event in its
> handler. The previously interrupted or preempted context is restored
> like below.
> 
>    * x0 - x17, PC and PState are restored to what values we had in
>      the interrupted or preempted context.
> 
>    * If it's SDEI_EVENT_COMPLETE_AND_RESUME hypercall, IRQ exception
>      is injected.

I don't think that's how COMPLETE_AND_RESUME works. The caller specifies an
address at which it would like to begin execution within the client
exception level.

SDEI spec suggests this behaves like a synchronous exception. DEN 0054C
5.2.2 'Event Resume Context' speaks more about how it is supposed to
work.

--
Thanks,
Oliver
