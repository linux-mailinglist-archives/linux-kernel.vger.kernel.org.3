Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE2059BA91
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiHVHsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbiHVHr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:47:58 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7D3F597
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:47:42 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3376851fe13so237028267b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wKlbRSkpVlRwtCLX0mwrPVGrcxPNmPGYkB8qt5FFx90=;
        b=DceuZphh2rFNT4MI5c0n4gVI5k+aLeHoqbfZSpNOugIO04lJ4Mx2mvic2ACS5kq5+i
         FsYxYFkrAdVSYt6vZCHU1w9PEJJYS9k86ElH548QcgiO++34pfnDvGNq4BJowa6CVtnA
         ufq4158mISPaJmGZ08lRJ3J86R3XJd82mn0eeuJnvh1abDq/vSS+Z8hHKrWN0SQ/Y30i
         e2epG3oJrC/NOrjAKSSYtzV4GSm7CGdSLcqUKP59BsvnwCoUbEmlPVaXCfOVL+C9wvr/
         FBKjuo0IbhIEyWVkSyA1LMg4ugXyyIg77MUeJvT2Nl0hFA5wS2HjiqaeHMFD2nrlSPQM
         Pi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wKlbRSkpVlRwtCLX0mwrPVGrcxPNmPGYkB8qt5FFx90=;
        b=BrpCirSJGBpLYD0TYSngRHvZWqu3GpanXmS0/g0iJ/PRxALblNtEkeP3hkMgyeD8Q7
         XFVMSwIYXr0/prGRSHXfO1xaOBGoW+sL8pB/KT9DJItZasN1+UMBdqrqls4zoal+E4i1
         ax5NRZL5YvzQC2LGAYnXXTWvG39kEon43uJwbWQiVVqcMX483h6ubt3c/y6+ybDC6Z+6
         zGSSvRYwTp4vzNNiszuMYYH6Xf/OzUxTUUx1BFRFJ+b+mftzzE3cBhepCWWjXh0HgGNf
         bpSp35Fgvsn5h/8gaGxssSmV7HNwLU62tTQXJuk0ldt97qDCCyDLXyBrVgpEs7afNEXt
         JsdQ==
X-Gm-Message-State: ACgBeo1DeMJokMIaVTTRhVYAueonNIvZNWOTlBGObZt7vqwur6INec6B
        x7kmQSM0zGiaKZsjGF7Y9ttFQj/TuWytKrjYlq8=
X-Google-Smtp-Source: AA6agR4ohKjpbJQP3GkDP0pnjwN8sZsDo5H0BGBNw6m2rx5n/RZe9E/2cqeLg0ZG0Ccc6xUkzobxz+dDpNk7rrN5H9s=
X-Received: by 2002:a25:2e11:0:b0:665:746:6ac5 with SMTP id
 u17-20020a252e11000000b0066507466ac5mr17664814ybu.481.1661154461373; Mon, 22
 Aug 2022 00:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660916523.git.namcaov@gmail.com> <7ff2d658863db4fd5eecc1a53f682510c2765c3f.1660916523.git.namcaov@gmail.com>
 <20220822073352.GA2695@kadam>
In-Reply-To: <20220822073352.GA2695@kadam>
From:   Nam Cao <namcaov@gmail.com>
Date:   Mon, 22 Aug 2022 09:47:30 +0200
Message-ID: <CA+sZ8B-HzLbLdBP5dMQg3j-201Ca6QxjiRjO=20hMADbMCgEOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] staging: rtl8723bs: remove function rtw_odm_dbg_comp_msg
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     lkp@intel.com, Larry.Finger@lwfinger.net,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you so much for letting me know. I will try to make it more readable in
the future.

Best regards,
Nam

On Mon, Aug 22, 2022 at 9:34 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Fri, Aug 19, 2022 at 03:49:35PM +0200, Nam Cao wrote:
> > because this function is not used.
> >
> > Signed-off-by: Nam Cao <namcaov@gmail.com>
>
> This patch is fine, but in the future can you please treat the subject
> as separate from the commit message.  "because it is not used" is a
> sucky commit message.  What is not used?  What are you doing to it?  It
> doesn't start with a capital letter.
>
> Here is how your email looks like on lore.
>
> https://lore.kernel.org/all/7ff2d658863db4fd5eecc1a53f682510c2765c3f.1660916523.git.namcaov@gmail.com/
>
> Try to find the subject in the middle of the block of text.  People are
> often only going to read the body of the email.
>
> [PATCH v2 1/8] staging: rtl8723bs: remove rtw_odm_dbg_comp_msg()
>
> The rtw_odm_dbg_comp_msg() function is not used.  Delete it.
>
> Signed-off-by:
>
> regards,
> dan carpenter
>
