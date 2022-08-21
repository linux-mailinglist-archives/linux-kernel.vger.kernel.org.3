Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703CB59B612
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 20:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiHUSs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 14:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHUSsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8102FB1EB;
        Sun, 21 Aug 2022 11:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0370360F54;
        Sun, 21 Aug 2022 18:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57756C433D7;
        Sun, 21 Aug 2022 18:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661107703;
        bh=AcBOpgBZsUnCwA1V1Rg63iVjEXlA1iBa+pRM1OKvD3E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mv3UpDajdmT/yivU8hnMl6NDOr7H9KhkAghdkXlwlTJzxd8VtZh3HVg8jHKSnbzi1
         Q6IBkXe/68+m677FXzOZGsOj8M7A0yQgdhXV3dT9PBmaE5ho9VBvO/UrLINAHuT/5Z
         tqpeMwHdEYVLVF8vxeKrUHKlFxE1gDn6kJv1FDi/LwzTxaABy/m8KDcboRCaghiTj+
         Kh/ZFlMhKFYkBnlIVsANHn+slleE5oGoZivkiNIPZcGwMNQfORxdA4liYWdrl9iJEX
         FO6H3wTh5nODeMgsduq69Wf0+a/6I0ONTjHm8RB56Hp4f0jCDL2enH5aE9LOCeEvTn
         p9VZgfYlRFWjA==
Received: by mail-ua1-f46.google.com with SMTP id i5so3563199uat.6;
        Sun, 21 Aug 2022 11:48:23 -0700 (PDT)
X-Gm-Message-State: ACgBeo15Jy1cQ3EVzUA1aw3F8cyg4wuw4zvvkG4sBK1XleeuNVOtNcGi
        xJ1VMILwtXI4mVgs/i9mp5MLlBRKKPav+qk2fQ==
X-Google-Smtp-Source: AA6agR6i0uUeLLNQBio7w6DlOPsfGOu53liSWmYz40/t4WTjmhzRb1jQxIhpiOmZQTs3CDt3jYhD9lrSH1QOUF87qK4=
X-Received: by 2002:ab0:1053:0:b0:391:9c29:7ca8 with SMTP id
 g19-20020ab01053000000b003919c297ca8mr6194779uab.86.1661107702267; Sun, 21
 Aug 2022 11:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220821151123.54778-1-wangjianli@cdjrlc.com>
In-Reply-To: <20220821151123.54778-1-wangjianli@cdjrlc.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 21 Aug 2022 13:48:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL4GvgFYzGUfhW5pvm4wYGrFaj6gHOYZjnOMuk2zCz67w@mail.gmail.com>
Message-ID: <CAL_JsqL4GvgFYzGUfhW5pvm4wYGrFaj6gHOYZjnOMuk2zCz67w@mail.gmail.com>
Subject: Re: [PATCH] drivers/of: fix repeated words in comments
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2022 at 10:11 AM wangjianli <wangjianli@cdjrlc.com> wrote:
>
>  Delete the redundant word 'of'.
>
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  drivers/of/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Same comments as last time I got this fix:

https://lore.kernel.org/all/20220627173825.GA2637590-robh@kernel.org/

Rob
