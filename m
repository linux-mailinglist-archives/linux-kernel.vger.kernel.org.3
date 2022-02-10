Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5285D4B1811
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344905AbiBJWXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:23:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344803AbiBJWXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:23:44 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869322188
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:23:45 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id c5-20020a17090a1d0500b001b904a7046dso8518352pjd.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uZb8A9AI0nYcmR3emfHhRyCRQnOFPI9ygBt/5g8ieDo=;
        b=MmAyLBkp3VKD5xxEzAoAN1dd9nlGJ18JOzm2gEnGMX/bUZ0F8v2eIaPFmfExASxD6M
         k6oJtlunX60kdBxveZFzaotG8eHfz2K1FMu+x/2yZR0rOzRLV9BxCExkVtFd8Wu7ETD7
         suN9HuxJEMrSQfwXJxy8WdyxtOahLKLGAespCCkHtd9oYOds5t47hZkuMcI4ttL/ikyi
         ImQfvi+IfZrTw7878r0mVJto6oF+BwHrhRKVePDXEnVJal62ciq+RNy0rbE0sZHivEoB
         wNwkQEtHL4sZVuilhyvKjlCRDugG+E2MYEFbcvM6vHobOARRfMcA0yAqDl1uI45+zYc0
         drxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uZb8A9AI0nYcmR3emfHhRyCRQnOFPI9ygBt/5g8ieDo=;
        b=iPs1NlmuoJlA526leavT+1T5+q0pfuxJV0ikEsCqlqrWxZJrtGYKBVLXJ+3OWE2Nob
         2/E6SxLp79Ov5nbLC4tDMDyNGncpwQ9VQreWeAQZ/mSULgTuXJ36Xeb53cSQpahEsJHJ
         x2xNlg+1s481T1G6Ll5DcbH9wv8Zcnfz/foZcPElTbjwCDTzRmv6iSUjstH3YRBLfxP7
         y8Nx9EkM8UHf9noADPGcyyzFl6N0M85T4rHsqRc9H3YIThXORWOrhdAzwCS4HaSaDnsG
         FwuONBN+oOBVap8mAIrXG3nG0+XS8E7jaPRI3QkIk24PETkgTJos5lcnMRUlVY4LflAp
         wEFg==
X-Gm-Message-State: AOAM532wDzMxXSI1/xEed4lsHQspm5RTBmHEsyfe4FS3DzBADP0d3dTR
        v4SMEZhfl/ubAkB1UDtDJQdl9Cbc0wGs72ju
X-Google-Smtp-Source: ABdhPJyHn629reGfgzluma3I+JETESh177YFt33nuw8/UDxsxTH88vG7+5xa7HP7EHxjxvj7dMkvRA==
X-Received: by 2002:a17:902:6b8c:: with SMTP id p12mr9684224plk.51.1644531825020;
        Thu, 10 Feb 2022 14:23:45 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id g5sm24321021pfv.22.2022.02.10.14.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:23:44 -0800 (PST)
Date:   Fri, 11 Feb 2022 07:23:42 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Arnd Bergmann' <arnd@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
Message-ID: <YgWQbpBX6eJNozGM@antec>
References: <20220209144910.1484686-1-arnd@kernel.org>
 <80c6df0717014472aa81093ae3894d39@AcuMS.aculab.com>
 <CAK8P3a3tZEc30AaiNENbHKf8+x5VOw7Q=4dVDMNwz0F6+v9YrQ@mail.gmail.com>
 <cc2a0d0eb77b4ace872263db7bf0c115@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc2a0d0eb77b4ace872263db7bf0c115@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 02:21:07PM +0000, David Laight wrote:
> From: Arnd Bergmann
> > static inline int __range_ok(unsigned long addr, unsigned long size)
> > {
> >         return size <= TASK_SIZE && addr <= (TASK_SIZE - size);
> > }
> > 
> > since 'size' is usually constant, so this turns into a single comparison
> > against a compile-time constant.
> 
> Hmmm... maybe there should be a comment that it is the same as
> the more obvious:
> 	(addr <= TASK_SIZE && addr <= TASK_SIZE - size)
> but is better for constant size.
> (Provided TASK_SIZE is a constant.)

Ah, this makes sense that.  I might as well revert the OpenRISC patch for this.
Though, we shall move to the generic version in the end.

With ideal compare:

    -rwxrwxr-x. 1 shorne shorne 6011932 Feb  9 17:57 vmlinux

With comparing (size <= TASK_SIZE && addr <= TASK_SIZE - size):

    -rwxrwxr-x. 1 shorne shorne 6003556 Feb 11 07:18 vmlinux

-Stafford
