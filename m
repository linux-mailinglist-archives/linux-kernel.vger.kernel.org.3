Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF2250F387
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344559AbiDZIUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344544AbiDZIUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:20:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5131237A81
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650961045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f1REt+hbeiusJHMTUGSfGvTYu9pNhup63JNYVPMx2yE=;
        b=hIn4P9Gpm9GuK41VBis6lA9SdknkFiGkD7fAYr/i/za8FFjcPwIOK18GKE/XGv0QBFDMK1
        OmLxYrxHYou96jWx93YLKSGRB3uysbCRFHdohOzKBiz0bfVGSxGyBrccm3frxlysWQqNsZ
        qBMonzNtv0fCz1shRzPyVTjZrBGB4No=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-xPbsajsoOi2nZBioqe0W-A-1; Tue, 26 Apr 2022 04:17:23 -0400
X-MC-Unique: xPbsajsoOi2nZBioqe0W-A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00204381D8D4;
        Tue, 26 Apr 2022 08:17:23 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.193.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8440C464BD3;
        Tue, 26 Apr 2022 08:17:20 +0000 (UTC)
Date:   Tue, 26 Apr 2022 10:17:18 +0200
From:   Philipp Rudo <prudo@redhat.com>
To:     lizhe <sensor1010@163.com>
Cc:     "Baoquan He" <bhe@redhat.com>, dyoung@redhat.com,
        vgoyal@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/crash_core.c: No judgment required
Message-ID: <20220426101718.765686a9@rotkaeppchen>
In-Reply-To: <62058381.3b6e.1805f62c8f4.Coremail.sensor1010@163.com>
References: <20211210032003.16278-1-sensor1010@163.com>
        <20211214173242.192f47e8@rhtmp>
        <YmX7EW4Gs+c1ZueQ@MiWiFi-R3L-srv>
        <62058381.3b6e.1805f62c8f4.Coremail.sensor1010@163.com>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lizhe,

On Mon, 25 Apr 2022 14:22:31 +0800 (CST)
lizhe  <sensor1010@163.com> wrote:

> HI :
> 
> 
> I found the problem at the first time and gave the solution,
> 
> 
> 
> 
> Pphilipp Rudo just saw the solution to the problem and gave an explanation.
> the author of this patch should only be me

right, I only commented on the patch you sent.

Could you please update the commit message and send a v2.

Thanks
Philipp

> 
> 
> 
> 
> 
> 
> 
>                                                                                        lizhe
> 
> 
> 
> 
> 
> 
> 
> 
> At 2022-04-25 09:36:17, "Baoquan He" <bhe@redhat.com> wrote:
> >On 12/14/21 at 05:32pm, Philipp Rudo wrote:  
> >> Hi lizhe,
> >> 
> >> On Thu,  9 Dec 2021 19:20:03 -0800
> >> lizhe <sensor1010@163.com> wrote:
> >>   
> >> > No judgment required ck_cmdline is NULL
> >> > its caller has alreadly judged, see __parse_crashkernel
> >> > function
> >> > 
> >> > Signed-off-by: lizhe <sensor1010@163.com>
> >> > ---
> >> >  kernel/crash_core.c | 3 ---
> >> >  1 file changed, 3 deletions(-)
> >> > 
> >> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> >> > index eb53f5ec62c9..9981cf9b9fe4 100644
> >> > --- a/kernel/crash_core.c
> >> > +++ b/kernel/crash_core.c
> >> > @@ -221,9 +221,6 @@ static __init char *get_last_crashkernel(char *cmdline,
> >> >  		p = strstr(p+1, name);
> >> >  	}
> >> >  
> >> > -	if (!ck_cmdline)
> >> > -		return NULL;
> >> > -
> >> >  	return ck_cmdline;
> >> >  }
> >> >    
> >> 
> >> I agree that the if-block is not needed and can be removed. However, I
> >> cannot follow your reasoning in the commit message. Could you please
> >> explain it in more detail.
> >> 
> >> The reason why I think that the 'if' can be removed is that the
> >> expression can only be true when ck_cmdline = NULL. But with that the
> >> last three lines are equivalent to
> >> 
> >> 	if (!ck_cmdline)
> >> 		return ck_cmdline;
> >> 
> >> 	return ck_cmdline;
> >> 
> >> Which simply doesn't make any sense.  
> >
> >Right, the judgement actually introduces redundant codes. As Zhe
> >replied, maybe you can rewrite the log and repost with your
> >Signed-off-by, Philipp. As for Author, you two can discuss in private
> >mail.  

