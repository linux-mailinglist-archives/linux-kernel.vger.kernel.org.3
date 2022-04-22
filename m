Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6696B50BC6D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449649AbiDVQD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbiDVQDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:03:50 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A62F44741
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:00:56 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u15so8393762ple.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Jr063i0klx2Xf+DxdwryXVYkOKKR7C7qzwKjJOubUc=;
        b=E7d6q8c927zlO7H5uGVvMXlb6oR+8gPYxP13oNm5AtCnNR7dObkrKGLUnWNUxOL3Vn
         JuYCViRvKvBKyl8bZuD1leC9l3tNgrFUi3ABtosqra9Gv69U0FZBBQQ8eJXdCeEU68rW
         bqxrvdYcAzNwgavsFxoxSbJ4GqHo0hRfKgNjHkl3vg4lQ3MNdp6pU5prUqjbyRbg8vKg
         4iNmIwU4DQnZo3TlImxSJw2TwLGyNZcF8Msx7Rx0I440VtFt0VVfsfQduNqA3Q5OoCr/
         51LIXZ3bToGmTMgtDYWZWNm1fHmlYb5DMYoJM6JVBvb/B3PqUcHAQn+lgotQtSrLViY0
         D+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Jr063i0klx2Xf+DxdwryXVYkOKKR7C7qzwKjJOubUc=;
        b=kEembmiefRIXhDYiGbU8H4pUnxzn4I51TXjp31EIgisv2FueoMrh7sIGP6lkH/+TuM
         02EAxiFUN+gIHz/uCkGMjDyOtDhNIJX2stI9tKo4N8ISvDvfh5qoQf/d/1/mun8skRsx
         9SkgomklWun/r8MerJgiXCYg8fcLuOo7zGE7UPIWO54+94r2JfEiH7ajhVqk7D7w+hw6
         7qTdwS7sPDHK+rfZa9ATAtqi6vStOsGeqe1ZVsDoGbNBVagJ0rpPneCo0aC/REnzAdqI
         8FExqAkwoJBoV9Tnr8HhGo4ga9CxgPzMoiCYdVCpqCVHx3kl9Nt/ri6Sb6pZI7g13+H5
         kesg==
X-Gm-Message-State: AOAM532Kt9V9g4DRVgFzrxvDBmQpbOkrYVsJe377CtzAWw3svjKF1Zrp
        BDMmld6c1Mtrhem7L11IqJs=
X-Google-Smtp-Source: ABdhPJydWu7pspaNY7825xrOie1vXOxkb5n2Pcl0JNcNUUvFiubss+muggHCMHarv73tBZZ4x5F3mQ==
X-Received: by 2002:a17:902:f545:b0:15b:e7f6:710a with SMTP id h5-20020a170902f54500b0015be7f6710amr4026889plf.71.1650643255757;
        Fri, 22 Apr 2022 09:00:55 -0700 (PDT)
Received: from ArchDesktop ([14.100.36.163])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004f1111c66afsm3365172pfl.148.2022.04.22.09.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:00:55 -0700 (PDT)
Date:   Sat, 23 Apr 2022 00:00:52 +0800
From:   Solomon Tan <wjsota@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Remove space after cast
Message-ID: <YmLRNNOKYpBQBDf+@ArchDesktop>
References: <20220419124318.8028-1-wjsota@gmail.com>
 <20220422150912.GJ2462@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422150912.GJ2462@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 06:09:12PM +0300, Dan Carpenter wrote:
> 
> The & should go on the other line actually.
> This cast is unnecessary.  Just delete it.  In a separate patch.
> Same thing delete.
> Same thing.
> Delete this cast.
> 
Hi dan. Thanks. I will work on these and see if there are similar lines
that need amending as well. I will submit a new patch for the cast and
another one for the &.

Thanks you
Cheers,
Solomon
