Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97F6504998
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 23:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiDQVQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 17:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiDQVQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 17:16:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A87ADF87
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 14:14:02 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r13so23983713ejd.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 14:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kOJ6r5szSl5hkLX0n7vAIA8roZcCn9TLBxnUP06wZtQ=;
        b=It/o+QoA+oxBdSsLMAe3xm+uoil6gVs1TnMslbWSI9qDf8Su7tTlJ+YUuMUKobdzm+
         coUe9LQjIBjKPuzos8Xwr7Ai1Rsf8fVRJlD3Jcjf+KaOBUHFaRe+HXi08Mk3EzWeXtS/
         otVtI5YnMU0d+R0FPKCo3rt7/RU3sIfJGl7zwCcz4Ves5gD39UOwhiFoMj59B5PByJYF
         v5Pm1FLcQCjr5s1thdAvfo5KyWGDQ3nXYlbWt2qLeqXJ4aLut92+NqDyoKGYVFdLPfKG
         M9h7rVGRvjcJN4UJ60dWZ7Txgjq5osJ1KyqPE2/x2kuoLARxFsh0Zn0NSGcZ5VAZjl/p
         mWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kOJ6r5szSl5hkLX0n7vAIA8roZcCn9TLBxnUP06wZtQ=;
        b=pf/0E+xC5oCTe0JBjolciZIo1dgcMsTZOUtRejYZfYvdFBrtTsadXnN8fX224IDkPV
         7ieJhKlbPyovZoczvGeavgWjHUeqvWbi6lDXcKDyFohBZuDGAAWFRzlW2Ze+noY31nZf
         CQsahguO+BWb6kjpt47yjzGAOyJqDJQDMsi6UAes1fPJOT/g7+QwqqI9CKeTNXVQYd6G
         wWBZ+r2dD0j6a5sGu6jkSD5zY02sEqz452+tq0IFp5l/G7ooOB8Xa8uRtP3a2DeRWIYv
         wJN6YgtGWpXQ91UsC/fOWSh3CwIAOFiDsiPgsmxTRHtc+ffxd9MgIyBwyKWZCVuFildw
         Wy0A==
X-Gm-Message-State: AOAM530lmgVJ+EkwJ6/Hk1r/2zJv+lUe+XA95MICMriLjC94PWNIh8kz
        OZ/QbLytRIVm8y1LcfQxh5o=
X-Google-Smtp-Source: ABdhPJy/UDWFTTOqBrPTnleiR3Z+mIpy1hUK//Bf5wY4Q4r4oBwf1R1+8ODWJpR9EDfh4dJc8t6oRw==
X-Received: by 2002:a17:907:720d:b0:6e8:9f19:7520 with SMTP id dr13-20020a170907720d00b006e89f197520mr6753180ejc.552.1650230040605;
        Sun, 17 Apr 2022 14:14:00 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id c13-20020a056402100d00b0042294fdbcf9sm4125011edu.14.2022.04.17.14.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 14:13:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>,
        Jaehee Park <jhpark1013@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2 1/6] staging: r8188eu: remove unused member free_bss_buf
Date:   Sun, 17 Apr 2022 23:13:50 +0200
Message-ID: <3164900.aeNJFYEL58@leap>
In-Reply-To: <20220417204200.GA236965@jaehee-ThinkPad-X1-Extreme>
References: <cover.1649990500.git.jhpark1013@gmail.com> <a28f445f-f088-620e-6baf-4cad3e1a8146@gmail.com> <20220417204200.GA236965@jaehee-ThinkPad-X1-Extreme>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On domenica 17 aprile 2022 22:42:00 CEST Jaehee Park wrote:
> On Sun, Apr 17, 2022 at 11:16:38PM +0300, Pavel Skripkin wrote:
> > Hi Jaehee,
> > 
> > On 4/17/22 23:14, Jaehee Park wrote:
> > > My understanding of Pavel's response is the free_bss_buf member of 
the
> > > pmlmepriv structure wasn't being used anywhere and that the
> > > rtw_free_mlme_riv_ie_data function frees the memory of the pmlmepriv
> > > structure so the second check is redundant.
> > > 
> > > However, as Fabio said, the free_bss_buf member is being used and 
pbuf
> > > memory is not being freed.
> > > So I'll revert the patch as it was originally (which was just 
removing
> > > the {} around the single if statement).

No, Jaehee. This is not what I said :)

> > > 
> > 
> > Why just `pbuf` allocation can't be removed? This memory is just 
unused,
> > isn't it?

What Pavel said is what I said, but using a different argumentation.

> > 
> > 
> > With regards,
> > Pavel Skripkin
> 
> 
> The free_bss_buf member is unused.

Correct.

> So it can just be removed right?

No.


> I guess I'm confused by what Pablo is saying about causing a memory 
> leak

A memory leak is caused when you allocate some memory and then you lose any 
reference to its address so that it cannot be freed. Right?

> by getting rid of the pointer to the memory allocated by pbuf.

No.
 
> Sorry if I misunderstood. 

No problem. Let's rewind...

"pbuf" is assigned with the address of some memory allocated with a call to 
vzalloc(). Since "pbuf" is a local variable, you see that the above-
mentioned address is stored in free_bss_buf using the line "pmlmepriv-
>free_bss_buf = pbuf". Is it clear?

Well, you decided to delete the line that calls vfree(pmlmepriv-
>free_bss_buf). At this point you have that memory leak.

Pavel noted that pmlmepriv->free_bss_buf is unused, but it contains the 
address of a region of memory that was allocated for no purpose.

Therefore, a correct patch should also remove the allocation that was made 
using kzalloc(). If you merely remove the line with vfree() you cause a 
memory leak.

Please don't revert your patch. Just fix it with a new version that also 
delete the line where "pbuf" is assigned with the value returned by 
kzalloc().

I hope that now I've been clearer.

Thanks,

Fabio

> Thanks,
> Jaehee
> 




