Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C5F5284E4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243563AbiEPNCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbiEPNCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:02:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BAD39B8A;
        Mon, 16 May 2022 06:02:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14F13612B4;
        Mon, 16 May 2022 13:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB71C36AE3;
        Mon, 16 May 2022 13:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652706153;
        bh=QxrYnzxLkpBboiWbk+tZIWKBZNB1aGowNNS2JwNCBZY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=eECbBPbd/CwUGSHea5TMEEiO7RapzXxStNpbfSByJLhUUerce3Eqt5rk1+4EyBgWd
         J8Lfq+S86WuE8+Glx49oeOitauYLsnxlm3oX8qD2hT0m8E1px5uSaf4spe+61vMrdo
         C4udux4s1uotPACaR6Z8jR7Dk8Ibi+1Hh883MJd7s9Wv33VpWyADMuWIxJtYTJszgL
         eARUl1C5s+RMHC5bCPQdLwpkvsd52ywuwXp2SN27ujdefo2Fn90Y5BYS55/dxYIjFU
         vSq1ENMFTZFzDfXYse1eZkWQOIfGTqpYD92MbobQrg29OhnyZPMhkQPI92PO4yfjDi
         dHw4muV+AIdIQ==
Received: by mail-wr1-f46.google.com with SMTP id j25so19412769wrc.9;
        Mon, 16 May 2022 06:02:33 -0700 (PDT)
X-Gm-Message-State: AOAM531AylIOox6ltyUvDBpjIk1MmqEHQj+CIfcQBl0pYf0OxpdA2LMH
        wt5UkEOBCcmFYRLusW62qeBeY0qDazwYWhM3cOU=
X-Google-Smtp-Source: ABdhPJyppBouNKjqRj9f/zuZU9s1i4dLd2e/drF3XJg3+HmjYs+p3oQblbVJf1G8KltxMRgiQcwslacmFaYs8RlwNz4=
X-Received: by 2002:a5d:584a:0:b0:20c:5bad:11c1 with SMTP id
 i10-20020a5d584a000000b0020c5bad11c1mr14323809wrf.62.1652706151753; Mon, 16
 May 2022 06:02:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:f344:0:0:0:0:0 with HTTP; Mon, 16 May 2022 06:02:31
 -0700 (PDT)
In-Reply-To: <20220512075605.34240-1-yang.lee@linux.alibaba.com>
References: <20220512075605.34240-1-yang.lee@linux.alibaba.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 16 May 2022 22:02:31 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9wzMPn0MWYDSveg2rdpaAWyg7RD5TOyyzbcu7nvUXHmg@mail.gmail.com>
Message-ID: <CAKYAXd9wzMPn0MWYDSveg2rdpaAWyg7RD5TOyyzbcu7nvUXHmg@mail.gmail.com>
Subject: Re: [PATCH -next] ksmbd: Fix some kernel-doc comments
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     sfrench@samba.org, hyc.lee@gmail.com, senozhatsky@chromium.org,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-05-12 16:56 GMT+09:00, Yang Li <yang.lee@linux.alibaba.com>:
> Remove some warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
>
> fs/ksmbd/misc.c:30: warning: Function parameter or member 'str' not
> described in 'match_pattern'
> fs/ksmbd/misc.c:30: warning: Excess function parameter 'string'
> description in 'match_pattern'
> fs/ksmbd/misc.c:163: warning: Function parameter or member 'share' not
> described in 'convert_to_nt_pathname'
> fs/ksmbd/misc.c:163: warning: Function parameter or member 'path' not
> described in 'convert_to_nt_pathname'
> fs/ksmbd/misc.c:163: warning: Excess function parameter 'filename'
> description in 'convert_to_nt_pathname'
> fs/ksmbd/misc.c:163: warning: Excess function parameter 'sharepath'
> description in 'convert_to_nt_pathname'
> fs/ksmbd/misc.c:259: warning: Function parameter or member 'share' not
> described in 'convert_to_unix_name'
> fs/ksmbd/misc.c:259: warning: Function parameter or member 'name' not
> described in 'convert_to_unix_name'
> fs/ksmbd/misc.c:259: warning: Excess function parameter 'path'
> description in 'convert_to_unix_name'
> fs/ksmbd/misc.c:259: warning: Excess function parameter 'tid'
> description in 'convert_to_unix_name'
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks for your patch!
