Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE3E48A115
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243911AbiAJUqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242206AbiAJUqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:46:32 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF86C06173F;
        Mon, 10 Jan 2022 12:46:32 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so692166pjf.3;
        Mon, 10 Jan 2022 12:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F3x7V2JpwBSXtCufHU5L3+PDTTEIyYTCpoey+57rJyc=;
        b=WpDKwxhs0jBf/btD5X31+eQf+8bxApAkxQykKIej66wqY0MmVaFCsmLMYc0sHYJHj1
         tTfR6pXg208/2jAjZcrsA3mZ1IY6kR6lAdUqp8FQ9pP4glZ/vPRO6oQsFU+fVthol9XX
         hCJqu1NeFe7gH9Y6LQiVLAGBkhEU0LDznon/s3BlNF7H6lvbGLRnWYok6sJpkaREEhK9
         yXddxAZxg0Ag+Yu4riLJEz5VxNDR0PacCiIhuODZGkfpru+FnxdkE/f4aLp0VoengaqF
         31AQUyVj+vR2YU83X3I1VYbXyZFXue3mi1stBfLL09xd8dvXzeV5dye75lRasgafxx5z
         8obA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F3x7V2JpwBSXtCufHU5L3+PDTTEIyYTCpoey+57rJyc=;
        b=07saU5y+VR6kRTYyAmGiRKTzS06QyekLXu5Gmf0xlTunML6MEhkatdoOwPE2A7Xhgo
         RYlTUHClqG1hl2UH3PbwOiCoClVoJEY75xZ0pe63toNNiPpofGN2ETf4RgfzkyyHWuqq
         4UroEZVIFqGWJL8/+35Qsf3ClpjgrdZdk9eC8Hxob+oXEcKNQuzH9vEq0klmhFQXYK70
         YhSJxrUbFqO+/JesZ3cM/QvnxZc/SehyWdYt9P2c3MYiF6EfxWKsjwpx4iIohQ9dZlXo
         L4h5PhZr21AvvpgtAlqn/F7WRAtEcmli3zBdrX2CAiDxEl2I71RdEeRE8vqFnPlLBNsp
         IGAw==
X-Gm-Message-State: AOAM531ywBG74CwwkbxG7RIEZ137odEe1AIIsObM6yPLIMEDkD655ApS
        B8reo5q4BUDymMhXRWvF08MKnwqDEKU=
X-Google-Smtp-Source: ABdhPJyBSRjTn5LAilwF4CBloVWb1zTUhVuhaPLVloxHJ18flXKS2ttxsWWodf4wPHYVjeLpYk99hg==
X-Received: by 2002:a17:90b:3504:: with SMTP id ls4mr454323pjb.141.1641847592159;
        Mon, 10 Jan 2022 12:46:32 -0800 (PST)
Received: from google.com ([2620:15c:202:201:1d28:509e:281:5bca])
        by smtp.gmail.com with ESMTPSA id s6sm9698898pjg.22.2022.01.10.12.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 12:46:31 -0800 (PST)
Date:   Mon, 10 Jan 2022 12:46:28 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Qinghua Jin <qhjin.dev@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ti_am335x_tsc: Fix typo
Message-ID: <YdybJEtJ79weIDYm@google.com>
References: <20220106084215.355295-1-qhjin.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106084215.355295-1-qhjin.dev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 04:42:14PM +0800, Qinghua Jin wrote:
> change 'postion' to 'position'
> 
> Signed-off-by: Qinghua Jin <qhjin.dev@gmail.com>

Applied, thank you.

-- 
Dmitry
