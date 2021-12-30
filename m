Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6287A481DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbhL3Pxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhL3Pxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:53:49 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3716C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:53:49 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id b22so21670367pfb.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fcSYNuva57n7+RnRM9rr3l2aKQTdRJZrel3PVRDc1lY=;
        b=IJrlJgNd68JU2aUjwQjpEYSJi9psL6tTrpM33svuR4K6mxHJ5yIY9vZLAvrkbIpYKj
         9qV6hYIFzZN7fNIs6ucwcx2HP89qp8O6QfigtMOivWkDNUniXMJt4Stc6Myz//AXY/AB
         6Ebw/b/ADbqu5vV9YQOg3kfv0Qu/tkvR5PoRTp+QTuTFfWoaNT2JbrMqOhpn7RuhJyFp
         YiOzyGxWRG/Pz9dayQPXf7vZOJSt0N2XO+TG/9ORrWnKJ2BJ6k6F4Ymzy4a9tGTUBKwT
         y/JMW+trI7bi6/pbP3vzp25ARjqUTNZA3We6o7RKHAkgTXoodsmBIj4meTloVG5fEh80
         GS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fcSYNuva57n7+RnRM9rr3l2aKQTdRJZrel3PVRDc1lY=;
        b=xzXiJfYdCgEerBrt2Cebpa3M4YLt0Agco3kLFkU4jcp7LjLcqo4ut9FMR0T1J96HTz
         zuh6DBBhV7lFSrxJewhHA6ymsc2/06KbX8JCJCMgQaV1qm5v4AWAXPdZioaOinAaSErt
         tMxSW/3WzTOXJ4iUo1wNmRhwKytiAXe0fY0HrReLeJEZl8UHcysxdH2+u4nzuEG9QeN4
         0G4FEamZarQKv8uh9WuYAXANQOki3/0EZEmA9V4hQghcXg36aB+WK9eoE/AYq8IB4vkF
         A3MJFkL9Yz6MXwGggIZ/BU//JqbyhTYR2HNAUUZILmIiLMS3feqdjUstNzgHe+E48HW9
         ZrvQ==
X-Gm-Message-State: AOAM5321UtCCS05l3jBmSQqorT2mHJ+ZN8hjWe225u8qdOjcIkyMd5HS
        1lpQUOTY1v9qZdv9nHf3tzs=
X-Google-Smtp-Source: ABdhPJxDjMGStn4l9DdX1W+2e7/z92qOtnCCzyxn+ensNfAlIjFuGx4dpJ1h2qGycXvr3YNbzyZyow==
X-Received: by 2002:aa7:8e44:0:b0:4ad:55c6:6376 with SMTP id d4-20020aa78e44000000b004ad55c66376mr32230187pfr.71.1640879629441;
        Thu, 30 Dec 2021 07:53:49 -0800 (PST)
Received: from localhost.localdomain (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id 22sm28057209pfv.173.2021.12.30.07.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 07:53:49 -0800 (PST)
Date:   Fri, 31 Dec 2021 04:53:44 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: add docs to packet_format and
 tx_start_condition enum
Message-ID: <20211230155344.GA5404@localhost.localdomain>
References: <20211229094713.GA28795@localhost.localdomain>
 <Yc2QrMecuVQFRcBZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yc2QrMecuVQFRcBZ@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 11:57:48AM +0100, Greg KH wrote:
> > +/*
> > + * Defines the packet format used.
> 
> What "Defines"?  This is an odd sentence.

Noted. I will change that.

> > + * In both modes the length of the payload is limited to 255 bytes if AES
> > + * is not enabled or 64 bytes otherwise.
> 
> What does this have to do with the format type?
> 

The rationale was that I wanted the developer to know straight away how
much info would be possible to transfer given the combination of
encryption + packet_format settings. 

But now that you mentioned it, I can see that this info/obs could be 
misplaced. I will remove it.

> > +    /* at least one byte in the FIFO */
> >  	fifo_not_empty
> >  };
> 
> Also, always run your patches through scripts/checkpatch.pl before
> sending them out.  I couldn't take this patch for that reason alone :(
>

My apologies, I will be extra careful next time.

thanks,

Paulo A.
