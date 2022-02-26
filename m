Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747A94C530D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 02:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiBZBcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 20:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiBZBcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:32:31 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10C021F5C6;
        Fri, 25 Feb 2022 17:31:54 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id i21so6144190pfd.13;
        Fri, 25 Feb 2022 17:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UiTIaMTvadNuDOUQ+r3Z2M0FxC+WMXeVN91hyhH29N4=;
        b=k/nj7TehD2dELlWo3fRna5rKHHOykbwKtTX5OEUAwN6hqRcBG3/KgPtRiRCkd4+dVr
         A5hksvcRp1fni3oc98onIeBl5dnucyBpk+bWVKgB/7TQd4x3K64jAJSHm3iH9b2/3eAf
         sLtkWTnS5ard0bm/4h2u6eAXyqQv09L9WYhW5fmc6VIjHM6AXeJuJhJomSyPjk7AJnPs
         qYnWrrpNq9+mzHgt8XhZhsovqFNfG+SnFH0pW9bJHd+2OKFT5hFHL9UWN1N7HgobbkPJ
         APTja9yaUem2w0JMeRoTaQVhmhSgdCl2D97s8vf9YSGBuR3vWTHPZYvw86USeCXippmE
         gc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UiTIaMTvadNuDOUQ+r3Z2M0FxC+WMXeVN91hyhH29N4=;
        b=VC2xYRZQ1vdm+fqLN+T6IykTrUe90uEESd7qEgP+R7x8hdg6RJXhUeHthlahuKIq4J
         cLtf1PXHwIlnfyO/fcrYa51+TqP4WrNQ6f9D+0Ophx93vE9uz7ng4bRAVnsibiQycyTp
         1aZCZjYg8PqxBsIJ6XNkXnncOrqxibkDxZzGEdcZsLvHe7MdN1ZUTQRAHJU8JcKWEAdr
         OS5wvQvq0ov2K3+LqGPt9Xe3uXAy4Eao8iyej+DKEi9IhNJyl0Lb5giCaBc5b6GIZ2BP
         HqIXG+5bcu7PfxxD3TbL9KsMtMO4PkXX7sVD6mwrfm1EifcKw39tEDDQ8FyKZRkJzpzQ
         hB0w==
X-Gm-Message-State: AOAM531vF46ywa079lcVJP+HUhJwiOr7t7TP4K1TVOY6ylG03q1Z9lks
        DNji/dK3qF3lgVvUWCWFIwE=
X-Google-Smtp-Source: ABdhPJye1qRX60h5HMKkoRuESXrdN8yA9oNzIEO6VWtWfo9a05GKwe3lhVcVd2NPSxbz3a/Z01OXKQ==
X-Received: by 2002:a05:6a00:d5b:b0:4e1:2007:87fb with SMTP id n27-20020a056a000d5b00b004e1200787fbmr10737121pfv.38.1645839114206;
        Fri, 25 Feb 2022 17:31:54 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id p6-20020a056a000b4600b004f3bfcd8304sm4705025pfo.218.2022.02.25.17.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 17:31:53 -0800 (PST)
Message-ID: <d70b88c0-037e-13fc-667b-de71bf4f0fde@gmail.com>
Date:   Sat, 26 Feb 2022 10:31:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] docs: pdfdocs: Pull LaTeX preamble part out of
 conf.py
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <aaa9dca1-27c0-c414-77f3-c5587db0cc5b@gmail.com>
 <875yp4kqka.fsf@meer.lwn.net>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <875yp4kqka.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022 12:33:25 -0700,
Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>> Quote from Jon's remark [1]:
>>
>>     I do notice that Documentation/conf.py is getting large and
>>     unapproachable.  At some future point, it might be nice to pull
>>     all of the latex stuff out into a separate file where it won't
>>     scare people who stumble into it by accident.
>>
>> Pull LaTeX preamble settings added since commit 3b4c963243b1 ("docs:
>> conf.py: adjust the LaTeX document output") out into
>> sphinx/kerneldoc-preamble.sty.
>>
>> It will be copied to the build directory by the added
>> "latex_additional_files" setting in conf.py.
>>
>> As a bonus, LaTeX/TeX code can be maintained without escaping backslashes.
> 
> I've applied the set, thanks.  Still testing the pdfdocs build (and will
> be for some time, naturally)
> 
> One little note, since you mentioned the need for backslash escapes:
> 
>> +# Load kerneldoc specific LaTeX settings
>> +latex_elements['preamble'] += '''
>> +        % Load kerneldoc specific LaTeX settings
>> +	\\input{kerneldoc-preamble.sty}
>> +'''
> 
> You can avoid that problem in Python code with the use of raw strings:
> 
> latex_elements['preamble'] += r'''
>        % Load kerneldoc specific LaTeX settings
>        \input{kerneldoc-preamble.sty}
> '''
> 
> (note the "r" on the first line).  Something for future reference.

Thank you for the tip.

It turns out that I unknowingly used a raw string in commit
77abc2c230b1 ("docs: pdfdocs: One-half spacing for CJK translations").

I think I copy-pasted an example from "extrapackages" key documentation.

Now I understand the use of raw string.
I will convert remaining LaTeX code in conf.py to raw string(s)
when I need to edit it in the future.

        Thanks, Akira

> 
> Thanks,
> 
> jon
