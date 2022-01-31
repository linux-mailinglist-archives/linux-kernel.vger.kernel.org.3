Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125634A4F76
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376626AbiAaTal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376540AbiAaTak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:30:40 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00315C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 11:30:39 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso112503pjm.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 11:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gyaD8qPhQQxiUsgl19Fa58voK0du9zBveZZ7eFx9ZSw=;
        b=Q90Y79EwEqu8irEhc7lCqS3XLtYpcSC5ckBzDm3uVDccGuXzfSGxsn+66JeDKmaX7I
         iwWBdqGIZLWAOZMIUA1g0VLlpYhhhL8a+IPRZmgZzcystG5a9lZhMBfP54judzI+heoI
         mEF7IgR0cVsxj0PFC8ldh7CDT4kzXSWxvnoSsXKMAXfGpoWS0fYO86bRnJi5Cs8Xljmd
         4hMXEkvaAm5N+dHJOYmxT1L+oFXbcD9XK7H4R3BsG1e+cyPSOirbCBZG5Ud7vIa83F+K
         Gti1FZAO/GPjEepInLYX3UQ9TwrjYdYx647ppxb6XdM8OFmiBw/cUBYr7+gYmbn/Sg9Y
         bVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gyaD8qPhQQxiUsgl19Fa58voK0du9zBveZZ7eFx9ZSw=;
        b=gJ/j0Y8MXy6WkfxSQKyEM0K/uar67ylIG9d707OH4A7u/yyhXNCKysQkhQH+Eb4Ow2
         u7KuZ0QAjRb7qDUVg5HOQH7Sh24/ZS+ROJMiv18+DWAKFtARr3tG37qAueJN2OTwKSxD
         BConVLJgvaFLT/sinb3mOF19meFMpwj6BNj3nhrEVuYAH3dbpDNWhknHxtBFfp7r1YGQ
         z65JFgZb7f96uyy0vKX1pMRQNIBcgJ8PfNyfEWkUJXNR57V32WqxsT/VZql5On3zduVe
         9CHVOrPEenQIe6QyiGTzERzL8U8BwyUkJvvYLmEi+q/gzeNQzg/sILQw5KcSvhiRt37p
         zV3g==
X-Gm-Message-State: AOAM532g/Odb0iiGipJwsG3fSkS6OhQNw0sSp0R6Ya4jAf/WA0fkoGuy
        nuVPoRhS7tQkGZPHnRcwf8c=
X-Google-Smtp-Source: ABdhPJwNsCxuqEhd5yXAbRuAC5lW4mCRMrzmSRJSBBgLI8ltKiluxcg8U2txtKFdQV0d8kPGciQrsw==
X-Received: by 2002:a17:90a:1784:: with SMTP id q4mr36207945pja.3.1643657439462;
        Mon, 31 Jan 2022 11:30:39 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id q1sm114942pjd.48.2022.01.31.11.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 11:30:38 -0800 (PST)
Date:   Tue, 1 Feb 2022 08:30:32 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: remove unnecessary new line escape
 sequence characters
Message-ID: <Yfg42KS3sQ8PZmo1@mail.google.com>
References: <YfYtsiKbOXghIN+5@mail.google.com>
 <20220131104020.GI1951@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131104020.GI1951@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 01:40:20PM +0300, Dan Carpenter wrote:
> >  	if (device->irq_state[DIO0] == DIO_PACKET_SENT) {
> >  		device->free_in_fifo = FIFO_SIZE;
> > -		dev_dbg(device->dev, "DIO0 irq: Packet sent\n");
> > +		dev_dbg(device->dev, "DIO0 irq: Packet sent");
> 
> Both the old and new code will do the same thing.  You are correct.
> However in terms of style, I believe the preference is to add a newline.
> 
> I don't remember the reasoning behind this.  But a lot of these style
> rules are just decided by consensus.  If you do a
> `git grep -w dev_dbg | grep \;$` then it is 12391 places that add a
> new line and 622 which don't.  Adding a newline is the clear winner.
> 

it makes sense. I will send a different patch adding the newline escapes
instead. 

Thanks heaps! 

Paulo Almeida
