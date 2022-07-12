Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F645711DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 07:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiGLFgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 01:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiGLFgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 01:36:04 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F248AB15
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:36:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id g21so105043plh.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=79NKzl+Yai+0z33LsxorqsWi9aA1Lw2dK2dLMo3vcZM=;
        b=SR5K+iFw+O9zfuTYZNqGHW0N3d7Dr5GYJGiWNqjIpvlE48zNjOt1CyYLnqCoZTsEFl
         Il53QxVFUryaBDNnbrhnZjP4W6ziY8fg1OYFXN01VoBNNZBCol+4/Dj2vCGV3I5G+1ny
         nLLnkS3wATVa8SRBvUnbzAqM0Zel5BPjmuHHbqUTnzC0otY4PAsZs16ekaNVoPevX5BN
         JCB1JH02YbEwvQo7kgjs0ZPmznnLTHlpWTR0LI8dv1/oNdjVGiooZ3en2+VsfSZGIvyL
         hrPD7vOSCm+kLhIfuBHB/Xwxj2U6PdlDITgEKWfcc5p+kcim8aQb7vGcPkSDCGCOUl36
         Ekzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=79NKzl+Yai+0z33LsxorqsWi9aA1Lw2dK2dLMo3vcZM=;
        b=AxrepZsCoD7JGRHNRQlbbJMEO0MC8KzX3kniefF45arcDOWb6qi5Pd0SMLz8k07l0k
         sHU7K7H4JSzkdhug1fqCE7SDNNFCC2xE3lNpw8c1Unqw9IvDvIw1eE6Q1PAFflhTSWN3
         ltQNj5uF8ll+8loaG+ibRq+yIWBrgko7lG1LuV3WYUjeEBG9LJADSlVuVDSaSb2CiqpX
         tYGkThm4Ypb4GE1sBup0pTQavpOgqlkBXoX1iXxN+NAHrrcmg91GjATZFRXemh3xwN0P
         MU0TcEi9xGL7ONS/az9FIVYfrIDTd+2WjIlu5OqZozvVxyaAj7tgBtWiwCnkGQlTY4s3
         XWCw==
X-Gm-Message-State: AJIora9PGTj6xBBkOifGvCS15nmx9kyfgB5MwlWCMyZs2YWRPyAHNdOY
        t+VE/m2XoA2UEe+IW653yBot9/e0jA5hdw==
X-Google-Smtp-Source: AGRyM1sNxaez4rYG+S7jTRljMutnpzZ9MKjgT5WXZF4y0tQwNODWSk/m/LZU3Sgt2mbua/Q1MkELJg==
X-Received: by 2002:a17:903:2c2:b0:168:e323:d471 with SMTP id s2-20020a17090302c200b00168e323d471mr21911338plk.147.1657604163077;
        Mon, 11 Jul 2022 22:36:03 -0700 (PDT)
Received: from localhost ([116.193.141.180])
        by smtp.gmail.com with ESMTPSA id d10-20020a621d0a000000b005289f594326sm5713455pfd.69.2022.07.11.22.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 22:36:02 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Jul 2022 11:05:53 +0530
Message-Id: <CLDFMRLPIK0Q.1CNF3K0SU1PV4@ArtixLinux>
Cc:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: android: bind_alloc: asm/cacheflush to
 linux/cacheflush
From:   "Aakash Sen Sharma" <aakashsensharma@gmail.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.9.0
References: <20220711213059.7197-1-aakashsensharma@gmail.com>
 <Ys0HMXzpjZX+kVsD@kroah.com>
In-Reply-To: <Ys0HMXzpjZX+kVsD@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jul 12, 2022 at 11:01 AM IST, Greg KH wrote:
> Including the issues found by my patch bot, please consider working in
> drivers/staging/ first and not in other portions of the kernel, so that
> you can learn the proper processes and development model and not bother
> maintainers of other subsystems.
>
> Note, you also forgot to send your change to the correct people for
> review.
>
> thanks,
>
> greg k-h

Apologies.=20

I'm still trying to get a grasp of the entire process and
diving into the main tree itself feels intimidating hence I was
submitting simple cleanup patches.

I will keep your advice in mind the next time!

thanks,
Aakash Sen Sharma.
