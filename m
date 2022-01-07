Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943EC487C4C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiAGSpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiAGSpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:45:10 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA43C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 10:45:10 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id q14so5526192plx.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 10:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w9ypsLnISzV2puuOjG8DGvXifynHcs0yI+Cx33i9X+w=;
        b=cygrNEBmz1DyagL+MK9Smfevh5IjJuSHSuEOlVsYJY/IsYLSqwrcAwQNSk35RtzqNQ
         C2Ngafv6Of7aHLdg+JJ1h7IfZE+dlMpZhyvQVYQjpqoOEGWLjXsCzPisUq2RZG6Go3Ez
         6BR6BadHpK5krEsAYIggJBO5cVnWOHb0vPUc1YQxJnxvDwjV8w9SgzvbnjWyQgfczshx
         ISExdudMCktyvp765YZGtSHppNG5Y1zZw4P8sJPB/k2gurJwwmoNbzhrb6EWZCzAzgKu
         aVQMgcyhNKNl6Gr4aA+mRXJH/063lvSSx6t4NgOKxpZhDaqRbDx1ZTs8197f0dm546Hx
         uZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w9ypsLnISzV2puuOjG8DGvXifynHcs0yI+Cx33i9X+w=;
        b=lk93bD0mw8s3ZslWUAIW9oIvlUs+FWSyvVF3uwpC3p7bEjKtoFSSkc3pLazeX8W8TU
         zGDF+FpmlgMsmaT2C4GgWZLJwl9pAg/J4O2TO0++NhwSQ//ck+PxXqUnM4BjtJQwqA/A
         tmmvjyVlTGArBEs+cYJqdso2f/TMY/wNZG4mcOUfwoSl/ZSgmZRJN9LM6lyB4JTeitad
         vZetsXkpprWX2K3vuKekN2AAmistWfqlc+XDr9DrisEIsc40BiLND3v49ZaY3/yA8DGR
         UQVINBVpDLtmY4NFRs93BF1UgfdsQPYPlLSr4a10hya52AG7oAgIYbakMRCzFRf0YIH2
         0iHA==
X-Gm-Message-State: AOAM530n71pjSKlr2AHE5yq4sKK0gu1h+G76uOmkLetVsBAkD9zXSD4q
        IPnqWM1GNpl3RDP02jHJ0Havgx1g5RlA2bbh
X-Google-Smtp-Source: ABdhPJyKrLj0SsxFVhf0tlmH+eC9y6nJK4bslfXYvaePyZfl6eGKptmPg5yL7l0pOLb81WgTx3pmZw==
X-Received: by 2002:a17:90a:d3c8:: with SMTP id d8mr17189863pjw.189.1641581110207;
        Fri, 07 Jan 2022 10:45:10 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id x25sm6301929pfu.113.2022.01.07.10.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:45:09 -0800 (PST)
Date:   Sat, 8 Jan 2022 07:45:04 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: move get version func to where all other
 functions are
Message-ID: <20220107184504.GA2693@mail.google.com>
References: <20220106093110.GA20011@mail.google.com>
 <20220107083258.GO7674@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107083258.GO7674@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 11:32:58AM +0300, Dan Carpenter wrote:
> > Additionally, the patch below must be applied first as it was sent
> > before and touches the same file.
> > https://lore.kernel.org/lkml/20220103222334.GA6814@mail.google.com/
> 
> Put these sorts of meta commentary underneath the --- cut off

Thanks, I didn't know. Will start doing this from now onwards

> > 
> > Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> > ---
>   ^^^
> 
> here.  We don't need to preserve that information in the git log for all
> of history.
> 
> Other people have basically said all the other stuff that I was going
> to say...
> 
> regards,
> dan carpenter
> 
