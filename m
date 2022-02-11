Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20C04B2D73
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352812AbiBKTW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:22:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244330AbiBKTWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:22:49 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E6F8F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:22:47 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y7so5465835plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f1IOy/ZzCK13/sKR3/RKB4aOENTitzg5dSVI621uCks=;
        b=MHYLxLfT8NSuyPtgPycShTFl83VwYb5sqW5qHWLunkJJvZahDcUhCXBOnivWewvjzo
         q3+H54m7CjIcryI9YcFlZONOUfkjPZfwCrSPBKtvzbK9aQ7GNG3B0JlR141Q/pn9b6lJ
         XgmcLUpnbB8LHyD9+87Hterree9e1McCZryUCih8HELKulKXbLADkJb+318LULsIz/D0
         QAzTGLttV20wEeLSsPcAtuVweO5l7eEnyDzopI21s2mXl7A7Tk3Kid4A7T57iPIA40sj
         6Uc2B9T7BpWXUkzn93NfFDHp3nnuTmg2Jnj1Aq4VD4rX66SyipWqOLDJsio01rC5phqk
         TAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f1IOy/ZzCK13/sKR3/RKB4aOENTitzg5dSVI621uCks=;
        b=wF9+5ukbvnBjM4gzd4PxwyAuAN4xo2xpCpA+jheE0J84bAHsMm1QXaT7nqVnNDMc2p
         ++bywjWT1Vcr4fCcEvA+oXN+QH6ykYs1BI6YB95FEx/1Nt+dRG++MwfyMdDpaf79hN+D
         1OOQm3qyqAtZixENOjKEBOIynO4cCC+ObG1D6QDGzkVMvGnUIQs7FkMHyhruyWsOWRny
         ZkqXwcXzV7Ll5GWgHzUV9c8bah+xlUdCxsCjiNq0rHTs0F/jZ92YdZcwDwFmpmC07+ax
         7+Q8AH4DjnnmvyZuOwWnwWe2Vyn8/RZ6DB9LOYzmSGpLiH1XO3zB49GHDiTiyWouiIG6
         TK9Q==
X-Gm-Message-State: AOAM533v6HvZonuBFtVLUEh2ig0p8N0mFH1acTI+acjhni0odBZ6h/a3
        oUSvEj4GdrN6yPqx+is5Yn6Vi5Eb527Yg0hg
X-Google-Smtp-Source: ABdhPJyM5+0Y6t4Rr0lV9MiWHfp5CPdprmx2OUH822mIHo0cvaGZiZ1Z8qFHWs2Qnnxr821WTJLF4w==
X-Received: by 2002:a17:90a:af97:: with SMTP id w23mr1904303pjq.162.1644607366380;
        Fri, 11 Feb 2022 11:22:46 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id l22sm29237357pfc.191.2022.02.11.11.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 11:22:45 -0800 (PST)
Date:   Sat, 12 Feb 2022 08:22:40 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: add rf69_dbg_hex function
Message-ID: <Yga3gHm0X5UlKuXv@mail.google.com>
References: <YgYZRArwwF7Z1B4f@mail.google.com>
 <20220211142528.GO1951@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211142528.GO1951@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thanks for taking the time to review my patch

On Fri, Feb 11, 2022 at 05:25:28PM +0300, Dan Carpenter wrote:
> 
> I feel like this patch is over engineering your debug code.  Is this
> really worthwhile?  If you really prefer the new format that's fine but
> it seems like not necessarily a good use of energy.
> 

After reflecting on it for while, I think that you and Greg are right
not to like the approach taken.

> > +	}
> 
> Instead of printing lineline at a time in a loop, what happens if you
> just print size bytes?  (I honestly don't know because I have never used
> this function before).
> 

It gets truncated as hex_dump_to_buffer prints at most 32 bytes.

thanks,

Paulo Almeida
