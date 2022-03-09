Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8634D3D54
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbiCIW4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiCIW4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:56:03 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B687DAD122
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:55:03 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id n15so3273832plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aZOIpjyxvNuoFzwnjKerwHSnop7Db1K1M/HasoxF0vc=;
        b=ifoj9rljp3PHv2JVWJZ4PLgpXpViQ+2c9oH+aQCa+x66YqYKvGJHyP5mmQ4hqWIkGb
         Mjab/aKpEYbI68s1HqadXLt2XNad2nRx/Exd1vxDWQGmCdFM07yV7eT1KWXgR2JP4lUy
         k9OI8EUaVkql8E7taiCQkafEDxZonOngZ4cXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aZOIpjyxvNuoFzwnjKerwHSnop7Db1K1M/HasoxF0vc=;
        b=1y/sK+X+39cXSaAP+XcH5LcW8KbFqaQ/bCQVCBgY/qVMRVapM4JNpHO/fcukx9wzZ6
         PHMr/tj9/aLdCH2qNKpZvQG3WsFQKo0NPKV0e1p1wg+qU/m5ijfXKxAul9PsNRweCiIR
         BV3YDlZXHxOBdUFGpQjsEGPEXHJt5WJBQr9Dg4ELgaMCJO08zVW+SSBjvrNw6GkZhUs0
         42oNEpUAytPXe6V2EAarenVwC7tnIiKZdpiedUnqVJ/s/12m08BaUziaL9Ti8bmE7ZeK
         bdW93kEO3mbgz/jckLntz7Fz4HBLdBWdOCu7c+fox77FPFNP+jP9uyyk8TDdvZuSVEXI
         8Zaw==
X-Gm-Message-State: AOAM532pDEjLi5jPKClk5ZBPEplpFyTbkzZETdttdLSqPN2ygt3e8pCc
        82T/K+uEq7MNbAGMsB19dG4g7w==
X-Google-Smtp-Source: ABdhPJy/nmWhix5nAY0WR5GX50+3cbIKMizLvlCQ65Ns/C1s9Xf1kNyr7UO73BVv/7iRrETxQTZCeg==
X-Received: by 2002:a17:903:240a:b0:14e:dad4:5ce4 with SMTP id e10-20020a170903240a00b0014edad45ce4mr1832492plo.125.1646866503325;
        Wed, 09 Mar 2022 14:55:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a001a0500b004def10341e5sm4430352pfv.22.2022.03.09.14.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:55:03 -0800 (PST)
Date:   Wed, 9 Mar 2022 14:55:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 13/13] tracehook: Remove tracehook.h
Message-ID: <202203091455.277ED26@keescook>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <20220309162454.123006-13-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309162454.123006-13-ebiederm@xmission.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:24:54AM -0600, Eric W. Biederman wrote:
> Now that all of the definitions have moved out of tracehook.h into
> ptrace.h, sched/signal.h, resume_user_mode.h there is nothing left in
> tracehook.h so remove it.
> 
> Update the few files that were depending upon tracehook.h to bring in
> definitions to use the headers they need directly.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
