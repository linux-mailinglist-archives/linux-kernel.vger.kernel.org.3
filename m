Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A626B4AAEC2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 11:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiBFKEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 05:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBFKEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 05:04:11 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BD4C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 02:04:09 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so10539425pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 02:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MOIoKqwfHQCMUAsHpddTltswukoTQXhDVma7WV/WWoU=;
        b=S80dUuJTsqOc2QQvF3GlfJen379mRYupyFUBopkTCpjxKlb0SUVXwqX2oRcMK6NrZF
         RvEO4KAdj+F0fnwsCkreRqOxYyb9HNCvQvIzR1dyolM4rgVSytO0fbJIEyrlw0WrWuBf
         njpXnC0HuZFS786Rw0YCXD/yCVVrB4f9LqSpi4f0MyXGYLYk6ixjgSm+6k9slwzmzoHh
         qLKAJDoe2xfQonVB4A95lAjA9f//e39VAPlIeFwb0SxEBemwem1KuE5Yv1/1WcXr4p25
         ZVhzHZka/AAaAkW92Vt0bsAvZy3YzzJKi5GDIhNzAek23Rw8kl+LlhnyuWftSOWci9lD
         1fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MOIoKqwfHQCMUAsHpddTltswukoTQXhDVma7WV/WWoU=;
        b=Wf1dHMPxXWLPxMaF1Fq2Ngzdbng4REy3Wb7giUxbjIHGswqE5HTvyJ98lwWWMZ/3RB
         nE9BbkRc432eDIGyK4D0ALPC0GrOSthds8DCKLf6jUtABDMSUcHcNeXyhaKe/+WEtTBn
         7mer0+HB4Us6FP5IFvA81GRoOPZ5SvDscRJ6A17gg1JRzUPcH3ms+oGY+OBZYzd15eRv
         XWKd4oSo/cLbrUze1QryCzLHvrxpH3rkOzobsQoF5VLDepcfTusWknQcgKjqeMTRzsMx
         fpO04TLG+KPsOdTdek9MPpEYFE+kM+i7frXH4virhNJRFupLQ/iJKymxElx9dBdnjjxy
         TQQQ==
X-Gm-Message-State: AOAM532vt0lh2vbaWAln3DBSygtHrx++9EdemtbR6nGx4pCSAEqA3p9b
        6iUrR2D2N78XHil2USWXltca2YU6iPFSBTJy
X-Google-Smtp-Source: ABdhPJxUBk+I+JI6FqBfIvA4asNp+RtU2lrAsz+B9i1ILVg6qC2M7qpOxIkAa10ZMxjP56KLMzZjuA==
X-Received: by 2002:a17:90b:8cd:: with SMTP id ds13mr2779885pjb.43.1644141848450;
        Sun, 06 Feb 2022 02:04:08 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id r11sm8119251pff.81.2022.02.06.02.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 02:04:07 -0800 (PST)
Date:   Sun, 6 Feb 2022 19:04:06 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>, Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Openrisc <openrisc@lists.librecores.org>
Subject: Re: [OpenRISC] [PATCH] openrisc: remove CONFIG_SET_FS
Message-ID: <Yf+dFv1Fj3LFsaot@antec>
References: <20220206013648.3491865-1-shorne@gmail.com>
 <CAMuHMdW2bxEtaYaLN28xk2uc=OV0ecUy-N_+Ay193gZq4nH0jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW2bxEtaYaLN28xk2uc=OV0ecUy-N_+Ay193gZq4nH0jw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H Geert,

Thanks for looking after it.

On Sun, Feb 06, 2022 at 10:42:46AM +0100, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> Thanks for your patch!
> 
> On Sun, Feb 6, 2022 at 2:37 AM Stafford Horne <shorne@gmail.com> wrote:
> > Remove the address space override API set_fs() used for User Mode Linux.
> 
> Note: this doesn't have anything to do with UML...

Yes, I agree for UML, I was actually following the text from Christoph's patch
here:

    https://lore.kernel.org/lkml/20211215165612.554426-1-hch@lst.de/T/#m439e32b3ecc8404424d2d8115d49fbf27c6393e9

The wording 'User Mode Linux' was perculiar. Maybe I should remove the
misleading text and just say:

    Remove the address space override API set_fs().

-Stafford

> > User address space is now limited to TASK_SIZE.
> >
> > To support this we implement and wire in __get_kernel_nofault and
> > __set_kernel_nofault.
> >
> > The function user_addr_max is removed as there is a default definition
> > provided when CONFIG_SET_FS is not used.
> >
> > Signed-off-by: Stafford Horne <shorne@gmail.com>

