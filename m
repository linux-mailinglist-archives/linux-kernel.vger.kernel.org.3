Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09C6473B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbhLNDOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhLNDOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:14:42 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B654C061574;
        Mon, 13 Dec 2021 19:14:42 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v16so105165pjn.1;
        Mon, 13 Dec 2021 19:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EB+Ld+De3lY5Q0piAz19XcJhUCNELnN5Gy51uTE2+/Q=;
        b=Q04LLvKNAa7Ms2WjTMFargwmln5PwwfYFqFeF//4fcF+SjpixbZ9bUKeLl33TiXMPP
         AW58zTPsWPbzv307XMv7nW3hrk8FSrask0aBqKcSWp4KTL8hLTqXcmWlsgb9GAJqP6Wd
         UX+YzL9+sTb73LnR6U8CtLBCE8iUaQNFKNlAs+6UXAQidNxJ2xNnz408oR/g/Ni3QWlv
         oN0CJE/Wpjhsyz7NuIdTAmct7rKb8YO9RL8zYNy72VC2ylZKWWY4zyliyfcYhHAwcQ0w
         MuJ09K2Q8m413FdRF7HkUgyhP/lJSvysmNMdkV9vENMx2A6M8BYPfRVOBJ9m/mh25wNt
         M/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EB+Ld+De3lY5Q0piAz19XcJhUCNELnN5Gy51uTE2+/Q=;
        b=EzKJkZ+Yx0HsyNEq0RbPOpqpegX/wnSCuL+hMhKwyZfOrSjR4DvNL7mQ0xx16CYxxN
         fYlEHUc4eJqh2GaQRTV3jIy32rhk6EshXDEHnpThpsGOz2bd4axqfwCSryV1ZMr8D9OS
         lYTRz5umT2FDzNCnk2n7KBiqkjPBmm6f8SOEPYXIkcZtbqagQQB0NRBFpXJRpky06O+5
         6WQT/8E8ah9FhZDlsFmt6dhGTnfqFY8vQFiCq6tPOyIjo8irr8UAOmoxaYlJPQwV3Y+e
         SlEddbfZnWVPSndZPFPN/p4CB00TAIUqs7T3yFQDjsSZfFAOgVZgfrQ8jjhrOwPSrmig
         X7cg==
X-Gm-Message-State: AOAM5333CQgdr9wEI06+wbtFIoqHpBbGKIEnhEjqPnzDhRV7FMsZ2LMy
        dZzUmzg0UPORs2CAk39lISs=
X-Google-Smtp-Source: ABdhPJzYTxWZSIhI+VuLLHKomp7kRdo35lH/OtGcuLSPNWt+wA2XglyThfVB6YD8t5KIrUoyLlFWXQ==
X-Received: by 2002:a17:90a:db01:: with SMTP id g1mr2564340pjv.33.1639451681770;
        Mon, 13 Dec 2021 19:14:41 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id np1sm518148pjb.22.2021.12.13.19.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 19:14:41 -0800 (PST)
Subject: Re: [PATCH 5/3] docs: sphinx/kfigure.py: Delegate inkscape msgs to
 kernellog
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com>
 <ea41dd96-124a-9132-7659-1ae04d82188b@gmail.com>
 <623bad19-49e5-ee34-910c-f3caf39319f5@infradead.org>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <a2cb1a86-391e-c5f8-3147-6fd6ba902bc8@gmail.com>
Date:   Tue, 14 Dec 2021 12:14:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <623bad19-49e5-ee34-910c-f3caf39319f5@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 18:50:51 -0800, Randy Dunlap wrote:
> On 12/13/21 18:34, Akira Yokosawa wrote:
>> Instead of redirecting to /dev/null, capture inkscape messages and
>> output them via kernelloc.verbose or kerneldoc.warn depending on the
> 
>                   kernellog.verbose or kernellog.warn

Now fixed.

        Thanks, Akira
> 
>> exit code.
>>
>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> ---
>> Hi Mauro,
>>
>> On second thought, I took the path of delegating inkscape warnings
>> to kernellog.
>>
>> Now you can see those warning messages by "SPHINXOPTS=-v".
>>
>> Does this approach sound reasonable to you?
>>
>>         Thanks, Akira
>> --
>>  Documentation/sphinx/kfigure.py | 28 +++++++++++++---------------
>>  1 file changed, 13 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/sphinx/kfigure.py b/Documentation/sphinx/kfigure.py
>> index dbe75ee8ae61..a275ee0fec02 100644
>> --- a/Documentation/sphinx/kfigure.py
>> +++ b/Documentation/sphinx/kfigure.py
>> @@ -126,9 +126,6 @@ rsvg_convert_cmd = None
>>  inkscape_cmd = None
>>  # Inkscape prior to 1.0 uses different command options
>>  inkscape_ver_one = False
>> -# Show warning from inkscape(1), enabled by setting env var
>> -# SPHINX_SHOW_INKSCAPE_WARN
>> -inkscape_show_warn = False
>>  
>>  
>>  def setup(app):
>> @@ -178,7 +175,7 @@ def setupTools(app):
>>      This function is called once, when the builder is initiated.
>>      """
>>      global dot_cmd, dot_Tpdf, convert_cmd, rsvg_convert_cmd   # pylint: disable=W0603
>> -    global inkscape_cmd, inkscape_ver_one, inkscape_show_warn  # pylint: disable=W0603
>> +    global inkscape_cmd, inkscape_ver_one  # pylint: disable=W0603
>>      kernellog.verbose(app, "kfigure: check installed tools ...")
>>  
>>      dot_cmd = which('dot')
>> @@ -211,12 +208,6 @@ def setupTools(app):
>>          rsvg_convert_cmd = None
>>          dot_Tpdf = False
>>  
>> -        try:
>> -            if os.environ['SPHINX_SHOW_INKSCAPE_WARN']:
>> -                inkscape_show_warn = True
>> -        except KeyError:
>> -            pass
>> -
>>      else:
>>          if convert_cmd:
>>              kernellog.verbose(app, "use convert(1) from: " + convert_cmd)
>> @@ -384,14 +375,21 @@ def svg2pdf(app, svg_fname, pdf_fname):
>>          else:
>>              cmd = [inkscape_cmd, '-z', '--export-pdf=%s' % pdf_fname, svg_fname]
>>  
>> -    # use stdout and stderr from parent
>> -    if inkscape_show_warn:
>> -        exit_code = subprocess.call(cmd)
>> -    else:
>> -        exit_code = subprocess.call(cmd, stderr=subprocess.DEVNULL)
>> +    try:
>> +        warning_msg = subprocess.check_output(cmd, stderr=subprocess.STDOUT)
>> +        exit_code = 0
>> +    except subprocess.CalledProcessError as err:
>> +        warning_msg = err.output
>> +        exit_code = 1
>> +        pass
>>  
>>      if exit_code != 0:
>>          kernellog.warn(app, "Error #%d when calling: %s" % (exit_code, " ".join(cmd)))
>> +        kernellog.warn(app, "Warning msg from inkscape: %s" % str(warning_msg, 'utf-8'))
>> +    if warning_msg:
>> +        kernellog.verbose(app, "Warning msg from inkscape (likely harmless):\n%s"
>> +                          % str(warning_msg, 'utf-8'))
>> +
>>      return bool(exit_code == 0)
>>  
>>  def svg2pdf_by_rsvg(app, svg_fname, pdf_fname):
>>
> 
