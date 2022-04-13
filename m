Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B944FEBEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 02:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiDMA0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 20:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiDMA0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 20:26:38 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42642237
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 17:24:11 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h5so214917pgc.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 17:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FgyYp5VcoidQ5XbfndPuDkccCsmpD6ZwuN3H0CutGCY=;
        b=ldUuYwzP3gD/rj7ALLtG+rGst+MSW0eFQKuy35D0bSdRsQBpS//HqjbyviqsQHhkvA
         fs0ojuosBvGohhltxkgUUvr6kv7EuIjYUAFaJpmR9VP43JRS7qY7Vg83HR6QMHVZfHno
         6Nw1CHQV1PtyjJZCd4cPCdaXzqEoaf9KgR8Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FgyYp5VcoidQ5XbfndPuDkccCsmpD6ZwuN3H0CutGCY=;
        b=EXA3ZgQrE4gCpBl3dkphCnTbziTtuUEtCkf/afI+jefmK2PtE3g0HP759avfKZ6TOk
         9FsBLVNIp67CTAVbgwKRok8CIoZpW/oqyfGTocANQtFxEbYEq0xSloA75zwbktUZFoXs
         fz/N99JbzgRhGEBsn+giXUTECbTlap8WnS8agsqhPt54395bLiqp48qCMNhmuLLOMn0A
         7qj6zWGWSRwS/f59//agAsnhkve2/IHMrVTptPXtGwxX+VLgIfOshtOHrArezo7tZsGx
         wLabwMmW+U9apsn1LpMA2eGYNzI5bxN3zXubLk0QkN283+UJ+6BeW9GxCf4Z6YUZJ7XG
         o6FA==
X-Gm-Message-State: AOAM533DFbc1+kVLD+aTl11Xmfb1qaYEbMrkMGvG5ghl08jnAY1tDPmW
        sv8yLdN5GueuBKdDalvsFaQoMA==
X-Google-Smtp-Source: ABdhPJy5FJY6Q6VWd+fk6QfKqME9E6j1FuWrwXXcbGKZvBz/6FWlvHnd3hcZqchTrqP3gllEJGM/cg==
X-Received: by 2002:a05:6a00:1c63:b0:505:cc7f:a21b with SMTP id s35-20020a056a001c6300b00505cc7fa21bmr10818937pfw.9.1649809450783;
        Tue, 12 Apr 2022 17:24:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d6-20020a056a00244600b004f701135460sm42471329pfj.146.2022.04.12.17.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 17:24:10 -0700 (PDT)
Date:   Tue, 12 Apr 2022 17:24:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tom Rix <trix@redhat.com>
Cc:     luciano.coelho@intel.com, kvalo@kernel.org, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, emmanuel.grumbach@intel.com,
        ayala.beker@intel.com, johannes.berg@intel.com,
        colin.i.king@googlemail.com, gustavoars@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: mei: clean up comments
Message-ID: <202204121724.6EB95414@keescook>
References: <20220410142733.1454873-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410142733.1454873-1-trix@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 10:27:33AM -0400, Tom Rix wrote:
> SPDX
> *.h use /* */ style comments
> 
> Spelling replacements
> commnunication to communication
> adsress to address
> procotol to protocol
> addtional to additional
> kown to know
> negotiaion to negotiation
> mssage to message
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Looks good; thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
