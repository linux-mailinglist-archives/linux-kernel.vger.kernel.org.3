Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB165518A4B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbiECQrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbiECQq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:46:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3752F2C11C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651596204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MESNkmbc31OWDMvCjlLvlqJdtq0VvYtBE6ynLs6E5Wk=;
        b=TQJFZNTwmwcYoHHCP54L2u2oKtaQAhPME+ywp5cVkSOPintpcygqjFUvktMNsTdvTfLEVf
        Vkcp60eqXkqB6A4O2JRhI6H59AAR42AvHTr1testhD/efntoKiMSrkIsxoWc9kltFVw1EJ
        k4N3J2SBXqTFwFWQWz5sCqfKCfeNPa4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-mF_Dm1KAN7y0E2FTfvjvUg-1; Tue, 03 May 2022 12:43:15 -0400
X-MC-Unique: mF_Dm1KAN7y0E2FTfvjvUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83CC886B8AE;
        Tue,  3 May 2022 16:43:14 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.192.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85D7D40CFD19;
        Tue,  3 May 2022 16:43:13 +0000 (UTC)
Date:   Tue, 3 May 2022 18:43:11 +0200
From:   Philipp Rudo <prudo@redhat.com>
To:     lizhe <sensor1010@163.com>
Cc:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/crash_core.c : Remove redundant checks for
 ck_cmdline is NULL
Message-ID: <20220503184311.1d8c20a1@rotkaeppchen>
In-Reply-To: <6a0fa9cc.19d4.1808440ca50.Coremail.sensor1010@163.com>
References: <20220425153857.21922-1-sensor1010@163.com>
        <20220426103952.0a080eb8@rotkaeppchen>
        <6a0fa9cc.19d4.1808440ca50.Coremail.sensor1010@163.com>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lizhe,

On Mon, 2 May 2022 18:11:20 +0800 (CST)
lizhe  <sensor1010@163.com> wrote:

> HI Philipp Rudo.
> 
> 
>       When ck_cmdline is NULL. The last three lines of this function are equivalent to : 
>           if ( !  NULL)
>                  return NULL;
>           return NULL;
>      This is obviously a redundant check.
> 
> 
>        I will use the above description to  describe the patch,

the explanation looks good to me.

Thanks!
Philipp


>  
>                                                                             thanks.
>                                                                             lizhe
>       
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> At 2022-04-26 16:39:52, "Philipp Rudo" <prudo@redhat.com> wrote:
> >Hi lizhe,
> >
> >On Mon, 25 Apr 2022 08:38:57 -0700
> >lizhe <sensor1010@163.com> wrote:
> >  
> >>  When ck_cmdline is NULL, the only caller of get_last_crashkernel()
> >>  has already done non-NULL check(see __parse_crashkernel()),
> >>  so it doesn't make any sense to make a check here  
> >
> >sorry, but I still don't like the description. What I don't understand
> >in particular is why you are mentioning the caller (__parse_crashkernel)
> >here. ck_cmdline is a local variable to get_last_crashkernel. So the
> >caller cannot perform any check on the variable but only the return
> >value of the function. So the patch description should describe why we
> >can remove the additional return NULL without changing the behavior of
> >the function.
> >
> >Thanks
> >Philipp
> >  
> >> Signed-off-by: lizhe <sensor1010@163.com>
> >> ---
> >>  kernel/crash_core.c | 3 ---
> >>  1 file changed, 3 deletions(-)
> >> 
> >> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> >> index 256cf6db573c..c232f01a2c54 100644
> >> --- a/kernel/crash_core.c
> >> +++ b/kernel/crash_core.c
> >> @@ -222,9 +222,6 @@ static __init char *get_last_crashkernel(char *cmdline,
> >>  		p = strstr(p+1, name);
> >>  	}
> >>  
> >> -	if (!ck_cmdline)
> >> -		return NULL;
> >> -
> >>  	return ck_cmdline;
> >>  }
> >>    

