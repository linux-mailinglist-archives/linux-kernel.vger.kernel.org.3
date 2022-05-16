Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7EC528310
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbiEPLWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiEPLWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:22:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4CD36E08;
        Mon, 16 May 2022 04:22:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg25so8483543wmb.4;
        Mon, 16 May 2022 04:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xRQD9okv6pCRuhdD2Ev4lqdq+NiQcQKauHb9Si4I5AY=;
        b=UIrbuHSGZgvRTRYLyIThlQQTa2F/xVWll/DExMs/ReDofS9sHpJXMo4zQGc3z67wqb
         G9Y0RZ/pMjXfAU7rpDcm1NUOVvinQwtsCOc2lzgl9IwgzPvBgslxgobmLrDetHbZzXia
         XXWfgkCH8aedhk7iEkeTG+zyTrY7it8/LRG7tpMe9AXy7E4Nj7TRUZDATB/AmTwolzvt
         ULbebZwrl8BamS3mTe05dL9UjGJhKZzDT6vDbUIOa1WylvDWHoTGUiW2k2vBUSTjUErA
         MSSM5qZuOzXcfmeAhQBhO0WltUkbuWPU3Yu9hl0GnABIcANK9q0IKdwcZEV6KlYjPSjJ
         ayJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xRQD9okv6pCRuhdD2Ev4lqdq+NiQcQKauHb9Si4I5AY=;
        b=R/qz4VfpdXLolCI2yQYb+uRn1vqdVSA93h0h2eZ8wo5IaM8XDS5nXryymk/l4ClSaz
         17m4h9LrfTHDb/yNYZ+ZUEzxi8Bkfvi3Ny1AuW7rb8q+BtB1pA9ML7fPImMbF8CH7+d2
         1ClRVeyXX4hrpNvfkUN8w7B4eE7TBgdXG7IAs1pkL8zpReMVhhF1c93Zqe7NyOloM8NG
         EhhgvAAZ09xtx5pzQinWgKTZQlDh26DxT5frm3c6uRmusq5jFPO7b0eNMunIn/ameIbE
         slPgNm9xxkT7xufFKqr7ZKd8T+xZ2eJaUJDq4pE2RHbKEeqIRG2juA9yVsYXVnNB7B1O
         xMrg==
X-Gm-Message-State: AOAM5306oE+8o2Xl5ttXZH7W8KqFjXRyKUgsclTcHuspxE0rEwRSn0XS
        wVnvJ+vIPtVFyWUxAUxkuY4=
X-Google-Smtp-Source: ABdhPJwMcfCA7vMag5vL9bP6oBjOMaKc5Z6P6CEbF5uwePd5wD3VxizOMCVoFud2PQcaMYaik8AUhQ==
X-Received: by 2002:a7b:c10d:0:b0:393:fbff:24a9 with SMTP id w13-20020a7bc10d000000b00393fbff24a9mr16348404wmi.53.1652700125779;
        Mon, 16 May 2022 04:22:05 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id e3-20020a05600c4e4300b003942a244ec5sm9805901wmq.10.2022.05.16.04.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:22:05 -0700 (PDT)
Date:   Mon, 16 May 2022 13:21:59 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Stefan Berzl <stefanberzl@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Status on hid xppen patch
Message-ID: <20220516112159.GA74406@elementary>
References: <941a793a-d2f7-9c2c-59be-b3930e1acfec@gmail.com>
 <20220423172330.32585-1-jose.exposito89@gmail.com>
 <95576534-1f5e-c2e3-4f73-c1b0a8300b56@gmail.com>
 <20220424093239.GA4380@elementary>
 <20220512205952.GA8936@elementary>
 <ebb6d627-4974-beed-1dc6-60634ab2f034@gmail.com>
 <20220516090829.GA20623@elementary>
 <140fe69a-c37a-cce4-c7c1-0344de6f1bf1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <140fe69a-c37a-cce4-c7c1-0344de6f1bf1@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 12:45:48PM +0200, Stefan Berzl wrote:
> Yo José,
> 
> > Also, I don't know if you have seen this error after connecting the
> > tablet:
> > 
> >   xhci_hcd 0000:2a:00.3: WARN urb submitted to disabled ep
> >   usb 3-2: reset full-speed USB device number 6 using xhci_hcd
> >   usb 3-2: reset full-speed USB device number 6 using xhci_hcd
> >   [...]
> > 
> > It happens with the Deco Mini 4, even when using the hid-generic
> > driver. I need to rebase my patches on 5.19 and test again, just to
> > make sure the problem is not somewhere else.
> 
> Can't say I have seen it. The only thing I can think of is that I was
> using the async urb functions and that delay did something about it.

Thanks, I'll give it a try. I hope is not some kind of time based
condition.

By the way, I only see the error when the tablet is connected. If I run
"usbhid-dump" or unload and load the driver, it works as expected.
I don't know if this could be related to the driver failing to process
the response to the magic data... Investigating.

Thanks,
Jose

