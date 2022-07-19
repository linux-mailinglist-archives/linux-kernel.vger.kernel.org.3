Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD4C57AA8C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 01:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbiGSXnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 19:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiGSXnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 19:43:50 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2A64E627
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 16:43:49 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o1so12537307qkg.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 16:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ptG1sWGcXWUClftC0HzZgw9GrQMqzL3RYHOJxThs0Bs=;
        b=NPnJjmSvPURXST1OOvqVi6nREGf+RuUtgBYgcCjm2MLZmR8p3mh4hr//dO6L7qpDWF
         uyPkv4i3RKeBe03AApuq7Eq8KqX3Ie3BH3F4YZDR+Y3O8pft5tc4JToAKwKjiMTq+Lwa
         enKlJs5AISZDxLIyTMOuO1HeR9bski1YjY147S09WdBC2k2OjTrw68dVLvyp//PmSAt3
         ekPBPcf9WB6pR44AWSmMq1//3bLpcC1iRiIU95yOKmjvqwu+Ycc8R23rWdZAs6/2Q44g
         IZga40QTV/VR8PWD4oY1STpPM6dn1S4pzr+ZwbxW2w3WrZbMCO8IwwJOVE9cySvYOhav
         1isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ptG1sWGcXWUClftC0HzZgw9GrQMqzL3RYHOJxThs0Bs=;
        b=dcvdaDQkIUNuB3d38/grRVtlsKpizrPFoC6AF2WDTlyKuXR2WSdB/yKenEfRwz+7ZR
         oC5TfzqJ8Z13mBV50fwO2UiEOyIhM9eAJWbOPLDbG/EZLcUwoa3LkmnzL0SJ+bgSmNVp
         OxDmBFDiPnFgg5R1icfXkIq/AQfYdhWnFn8/cxewYUT8KWVlnNsnaHh826sF3Iw2LvLW
         H+M9MSg8AU4Jq4eUoUAxZ0989qozDWHgzwudz3CTA/5zHPMspZLF/M+ZWq7H5HB1xoiN
         WDeD8+qCKLcgNuJc9kPl1lYPpGj0A30SdLrOogKJyPMsvk+d9Are9vN3u3zl6iqSiAxe
         39xw==
X-Gm-Message-State: AJIora9kW44nN0g4oN+Hs3ct4wazKIr02WrDeZbiEdoHR47dwX90oxAX
        W9wMx7dAwN8MSW82e+Z2MGByTKj5ag==
X-Google-Smtp-Source: AGRyM1sjOie8V5VneT6+JsXjN/A9NEHbFmsmwoKBi+aMZ7OklYwakySJKtd4R65L5YcQuN7mdb0pig==
X-Received: by 2002:a37:2cc7:0:b0:6b5:508a:f471 with SMTP id s190-20020a372cc7000000b006b5508af471mr22741115qkh.273.1658274228375;
        Tue, 19 Jul 2022 16:43:48 -0700 (PDT)
Received: from [192.168.1.161] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id n24-20020ac86758000000b0031ed8ef7982sm9715714qtp.22.2022.07.19.16.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 16:43:47 -0700 (PDT)
Message-ID: <7462e934-f746-eef7-ff92-0eeb8cc08b82@gmail.com>
Date:   Tue, 19 Jul 2022 19:43:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220719191522.4002a5fb@gandalf.local.home>
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <20220719191522.4002a5fb@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/22 19:15, Steven Rostedt wrote:
> On Sun, 19 Jun 2022 20:41:59 -0400
> Kent Overstreet <kent.overstreet@gmail.com> wrote:
> 
>> Core idea: Wouldn't it be nice if we had a common data structure and calling
>> convention for outputting strings?
> 
> Because seq_buf gives us this already, the cover letter really just needs
> to state exactly what the benefit is to replace seq_buf with printbuf (and
> why seq_buf can not be simply extended to do some extra features).

  - seq_buf has the wrong semantics on overflow for what vsnprintf needs.
  - seq_buf is somewhat unnecessarily coupled to tracing needs - the 
readpos member has nothing to do with outputting formatting strings, and 
some of the pretty-printers are tracing specific and don't really belong 
in a generic pretty-printing library.

And, when I tried to talk to you about changing seq_buf to be more 
suitable you didn't respond - you just dropped off the IRC discussion we 
were having.

> 
> I just applied your series and ran the tracing selftests and several of
> them failed.
> 
>   # cd tools/testing/selftests/ftrace/
>   # ./ftracetest

Thank you for telling me where to find the tests. It would've saved us 
some back and forth (and I could've gotten on this sooner) if you'd 
responded when I asked before.

It may seem like the perfectly natural place to look to you - who works 
on the code - but to someone who works on a variety of subsystems, each 
of which puts their test code (if they have any!) in a different place, 
it wasn't.

However, when I enabled all the tracing kernel config options, your 
tests are now failing to run at all with:

db_root: cannot open: /etc/target

So now I've got to debug your tests, too. Gah.
