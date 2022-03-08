Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA61B4D1F64
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349257AbiCHRtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348465AbiCHRt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:49:29 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E2247AFA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:48:32 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id dr20so40867814ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 09:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U9FUzAZMnf6VpxPtQM8a5lPUpj52uUTJiKNkJ/2hPr4=;
        b=XcNDlXxBicKMqe70X9jiAWRU5iXvjGl6wJK7VEhnopHa1RAX9ggRATd4ACVxaThzbX
         pVPSHgyt3R1MA7ai0Lm1wMQC1jrcROIL6xAlWSPN9B5beLSTgc22jR54W+Vt/RlKvOAM
         TUUhGn8XtNkYO7TIHS4+ndvv0bjRexx2VFtGF8phLmrh75Usj1WQtyqqkRc2ZNkToAJF
         dK1xsk6YMBURbu87riQr0fAmc2FXMscUN5Vs38YSFdu2oszcRC9JU2EUNGWxl9msoaxb
         OxVU/7ST11QZAA116K/7x/Q9ugVPzW5tDX04V4zvF4cPeMEcXQT56zucZanwWOYF50N1
         wJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U9FUzAZMnf6VpxPtQM8a5lPUpj52uUTJiKNkJ/2hPr4=;
        b=zsRgAIp8Vhnxgp206l5+UtlcDrsum66CBm2a9OuWVgi+4uWrP7hSPDisuq/mKd8d3h
         ziCtiSVHTrpLOyt/8joe+VRBrWIG+tN29F0wE9+5WPLwBOvUNney1qLyFNT/vDLxXXfZ
         Rs0BvwWFvsimWJLOBqNlaiESkpctIcMhNmDCm7nEM4R+ZRl4X2OttGYLN0VakaP2Ob8I
         fWOUL/u0PEJ+ffy+4ARkH2jLnjHamsYG/zopk3O49PLg1nMtc6dKAJ++9/zzbwAVDm5h
         EzBt3hkYrByIwpT2MJRr87wDoXGmfzg+vSWgPs9mtFmGLgvWEE3eNjLnsMpo/DR6sUZo
         9Vrg==
X-Gm-Message-State: AOAM532zfHNAG4nrvf0ihg+LGwMEMeC//8YJF90t0gzAKd2va01MWFa2
        cAZnZ4OPx+3eF9Xl0zjDsPMyLzcwyIf8cA==
X-Google-Smtp-Source: ABdhPJzgTkrKHn4ISSql48EpVsOR/0YPXIMyz4FH3VyIbsdKr7vHvMdvZTktdFqPwPadoE36V+FPhA==
X-Received: by 2002:a17:906:3cea:b0:6da:ea45:ea9e with SMTP id d10-20020a1709063cea00b006daea45ea9emr14225027ejh.574.1646761710479;
        Tue, 08 Mar 2022 09:48:30 -0800 (PST)
Received: from pswork ([62.96.250.75])
        by smtp.gmail.com with ESMTPSA id u5-20020a170906b10500b006ce6fa4f510sm6091327ejy.165.2022.03.08.09.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:48:30 -0800 (PST)
Date:   Tue, 8 Mar 2022 18:48:29 +0100
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: tracing : bootconfig : Early boot config for non intrd systems
Message-ID: <20220308174829.GA2471@pswork>
References: <20220307184011.GA2570@pswork>
 <20220308163600.3109f19854c7b051924f262b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308163600.3109f19854c7b051924f262b@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Masami Hiramatsu,

On Tue, Mar 08, 2022 at 04:36:00PM +0900, Masami Hiramatsu wrote:
> Hello Padmanabha,
> 
> On Mon, 7 Mar 2022 19:40:11 +0100
> Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
> 
> > Hello Masami Hiramatsu,
> > 
> > Thanks for detailed explanation on boot time tracing using early boot configuration file.
> > https://linuxfoundation.org/wp-content/uploads/boottrace-LF-live-2021-update.pdf
> > 
> > Also for https://lwn.net/Articles/806002/.
> > 
> > Latter link also states we can embed boot config into the kernel image for non intrd based system.
> 
> Ah, that was an original plan, but since no one interested in, I didn't implement it.
> So we still need the initrd for bootconfig.
>
Ok.
> > 
> > I tried searching mailing lists not able to find pointer for same.
> > 
> > A hint/pointer on how-to will be very helpful. 
> 
> BTW, what is your problem, could you share your use-case?
> 

I have hetrogenous system which donot use intrd.

The use-case is to capture __system wide__ event based tracing for
boot-up sequence, which also covers early stage of default init programs
used.

As buffer size is limited, will have hand-picked events set configured.

Thanks,
Padmanabha.S

> Thank you,
> 
> > 
> > Thanks and Regards,
> > Padmanabha.S
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
