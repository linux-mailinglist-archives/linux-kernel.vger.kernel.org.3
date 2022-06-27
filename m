Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B34B55D3FC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242357AbiF0WNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242343AbiF0WNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:13:40 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9A16258;
        Mon, 27 Jun 2022 15:13:37 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id k9so1040528pfg.5;
        Mon, 27 Jun 2022 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Oqo3K7zHjFdCbILfPRjw81EDQvPRT6gIpYwbe6wYk2M=;
        b=YyFUqGx6YgnpcnOapY+ZZIzHpxIBA+lujxk7pm+JSYlQ8QQHVP7LQ60xR0jeQ5FS34
         kFjt+XkSKTe/TpIbSUkNal41PJ86kRjei954QhHswYkwtay9FoYFtL5ifimJKoKcDz10
         yQ7J/eQ6+f0gehmwSdV+d+CO//BuFrE3ZGESvEthqO9Vcurpc0QvxRM5g/ckklTm4oC7
         YIAR+Lq6MOP1bfHGWBjS0/HWiMqsOQdDXsXChFMNi1O+y6y3o3OgMGERZlqIiUISH+y0
         cOOYpZ7K4QsNFjjdKuXO14mK87+oHsTAG3O1CmaJ9kJzfQ4WKme7Q2NgyoxBFClIzKcx
         IoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oqo3K7zHjFdCbILfPRjw81EDQvPRT6gIpYwbe6wYk2M=;
        b=TPyChA57A6Ko6IosE5xGWrM9Hj4v2xLt1KBQ5UTRKMVXaRRr8X4AoU5fS4VeyQutzn
         Y4s9T6H/WljmB6J8ofDjyB33DC7hPPh0RXz1gQQdovFRwB00lpTXuBjR5TF5LZFZitI6
         PQgsmoXCM7pIUKDtULoqUgaykG0pCEsSlXBJx43s9eki+CenD/rM5GVXiaN5VDkzhuhI
         DG2LpF7soakq97jjCVWtgMVviom6rTc7UjBMAcSPc8gjJoT46WAinyxjQ+s8vEF354SK
         D4I5+e7aVqDe/+YfNEWyOAB0OK4tThFeu6JwnrS2MrAdbItVyFKbsMVzyZFVMaN2d7js
         ZyYQ==
X-Gm-Message-State: AJIora/ZA0tY5pu2fj8RM6eSaujTENfDSXhRFNFHgE/IaFrq2qgQskPU
        k+8XSoimG9GXV6Blt54asTA=
X-Google-Smtp-Source: AGRyM1t72pdnfDBVZ1BqKnt+j/zteig4qqQ4dtYiK10qVzBGLbZVqm/Pg1sQbJtoYPnf130LQcF4Kw==
X-Received: by 2002:a62:5b06:0:b0:525:451b:bf31 with SMTP id p6-20020a625b06000000b00525451bbf31mr1256967pfb.61.1656368017350;
        Mon, 27 Jun 2022 15:13:37 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:8319:8d76:976e:108f])
        by smtp.gmail.com with ESMTPSA id g19-20020a62e313000000b0051ba8b742e4sm7867353pfh.69.2022.06.27.15.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:13:35 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:13:33 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: usbtouchscreen - add driver_info sanity check
Message-ID: <YrorjZDRXMgITIjZ@google.com>
References: <20220623062446.16944-1-johan@kernel.org>
 <YrSN+DYQun/IOPh7@google.com>
 <YrlgU6A+WYZRYjEn@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrlgU6A+WYZRYjEn@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 09:46:27AM +0200, Johan Hovold wrote:
> On Thu, Jun 23, 2022 at 08:59:52AM -0700, Dmitry Torokhov wrote:
> > On Thu, Jun 23, 2022 at 08:24:46AM +0200, Johan Hovold wrote:
> > > Add a sanity check on the device id-table driver_info field to make sure
> > > we never access a type structure (and function pointers) outside of the
> > > device info array (e.g. if someone fails to ifdef a device-id entry).
> > > 
> > > Note that this also suppresses a compiler warning with -Warray-bounds
> > > (gcc-11.3.0) when compile-testing the driver without enabling any of
> > > the device type Kconfig options:
> > > 
> > >     drivers/input/touchscreen/usbtouchscreen.c: In function 'usbtouch_probe':
> > >     drivers/input/touchscreen/usbtouchscreen.c:1668:16:warning: array subscript <unknown> is outside array bounds of 'struct usbtouch_device_info[0]' [-Warray-bounds]
> > >      1668 |         type = &usbtouch_dev_info[id->driver_info];
> > > 
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > ---
> > > 
> > > Changes in v2
> > >  - use ARRAY_SIZE() for the sanity check (Dmitry)
> > >  - drop the dummy entry and combine the two patches as the sanity check
> > >    itself is enough to suppress the compiler warning (Dmitry)
> > >  - use -ENODEV instead of -EINVAL even if this means no error will be
> > >    logged in the unlikely event of a future driver bug
> > 
> > Is this on purpose or because I happened to have used this error code
> > when I suggested the change? I'm fine with returning -EINVAL there.
> 
> It was on purpose. Returning -EINVAL (invalid argument) here just
> doesn't seem quite right. I skimmed the errno list for a better
> alternative, but decided -ENODEV works as well.
> 
> If there's ever a driver bug that triggers this, you could say the
> device isn't supported in that configuration. ;)
> 
> If you prefer -EINVAL, I'll change it back.

No, that is fine, I was simply making sure. Applied, thank you.

-- 
Dmitry
