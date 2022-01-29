Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F410E4A2B6F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 04:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352281AbiA2DbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 22:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241047AbiA2DbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 22:31:06 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5295DC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 19:31:06 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so12730091pju.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 19:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DgOT1D+Wv4LKuKGK2zVNFgZ5Xa2oIBBVn65t7kpdTTo=;
        b=OA/Rv103HDf2pylvjEkyQP9ofUar4Lt0aP0XUWTG2tV3olpZFn9ODp/bih0QPNyzKt
         zAGGxwgHEj8xf0y7nOlYFhqNnY1CxO81W8irtjqITmACM6UOEHQ2FP4J7dJV1C8ymeT2
         4UWo3vAiLMXfA2dRjX79Y9x50f1nOlLfFTi5hPhZQOIcpdFtMC0HK7m5jV5oDawtEI0Q
         7BHbMXANs4dVnHkhEjX/xVVofZu9DAtYjrom5uRzw1zVxDwNxnVv94aQfmHVNdxzH/ud
         OXyu7ghtmtZBDhf9aiAKwrPsB4CX3c1GB+byQEJjG16dkmelVq6lQhWG4M5cd8AuIcQY
         fMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DgOT1D+Wv4LKuKGK2zVNFgZ5Xa2oIBBVn65t7kpdTTo=;
        b=jg7JMw7+zbY9YZfrCCgV3AxCDPlfSDLM2kGHGAu5U7hzYMRKBHS/34CYeo1RH7z/Ne
         2x/rCWs9SiUjKvEwronSjIeDh8pamy58xDsIKQC3/a601ujphWzQyBueG6zr38Xq5JpM
         V01y+3wqWA5xkKk6XQ/+pw3J03CHzV1r/QJ2zQMeB/gIysemIc7UJufLPNTMy0/0QflC
         32C4v6zlysJ32Q9PCVyIjLSOf6OsFLdBGT326lnOrgzwEmUrkGrFcerY+gWfgXLzmWuz
         Jbj9fgDGNSecXxzlSnpD+CBGgYv0yi3LM5WO6dQPK3U0AkdFdHqbEEuOP8mpEV3ODyNW
         5/Ig==
X-Gm-Message-State: AOAM533JmCfEcO3sFjFgKZDEyfmOrZW31zXHP+tTGbFEGmsS0YJujB4L
        qkXTXcs34L89KePAmttJIEHrNfY7aRLmOtB7
X-Google-Smtp-Source: ABdhPJzoYYmD2WTeVwOsySiwKvXJDBrwyFeE17mhXds8cZqByJzkv8Q00iEa/BP+vcuUZZXrjH49sQ==
X-Received: by 2002:a17:903:31c8:: with SMTP id v8mr11552660ple.76.1643427065697;
        Fri, 28 Jan 2022 19:31:05 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id f22sm9359156pfj.206.2022.01.28.19.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 19:31:05 -0800 (PST)
Date:   Sat, 29 Jan 2022 16:30:59 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: pi433: add debugfs interface
Message-ID: <YfS087tUCqT3JAXY@mail.google.com>
References: <20220124042506.GA7662@mail.google.com>
 <20220124042721.GA8078@mail.google.com>
 <20220126132116.GA1951@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126132116.GA1951@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 04:21:16PM +0300, Dan Carpenter wrote:
> Since you're going to have to redo these anyway can you make some
> additional changes?
> ...... 
> 

Hi Dan, thanks for reviewing this patch. I will make those changes 
and submit a new version of the patch shortly.

thanks,

Paulo A.
