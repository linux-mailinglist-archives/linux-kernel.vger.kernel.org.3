Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E19C47E935
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 22:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350390AbhLWVwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 16:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhLWVwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 16:52:35 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0343C061401;
        Thu, 23 Dec 2021 13:52:35 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v13-20020a17090a088d00b001b0e3a74cf7so6974238pjc.1;
        Thu, 23 Dec 2021 13:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XNJhIefDBvOLT+950YlhBTlexUY5B2BqtdVad6rn/wA=;
        b=VTQTqJ0yQ4KIqdrZXZPEZmflASknN5u60MnISGs6kVvU57fI32Uh1pxa9rswX6yFB2
         Q8f30yQKDzJvSJca0QapFAqMB4F2oQ/z6kkwvKRsD1FlLZF3yHYbzg4KAvTOLoyIM0Nc
         rHedFIOnE+77LtA6Zz/L8rEsSEe0+vh9QHadaPn1phZFJWpJ8/HpYj7QY6iJjYJyAUXa
         b37YY4LSQLPDE0Ip5scPVIS6kR+/IwJVwkiftTqGG2L0xZOTAGvcsuGrlVdwBJSHM/tU
         ojW6WVBplv6YwlcZLpL51c2Q0VA6+z/T+elbl03MeAOVAKMa9AcupZF6LvlQBMXtIBES
         mUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XNJhIefDBvOLT+950YlhBTlexUY5B2BqtdVad6rn/wA=;
        b=4tkVc//kf9CPiBWK4Qx9FLlQ8N31GAxWCLc+Ug+YhcO854syZQOoptUm0MFNEt8QFP
         lYdqQDtHB3tEW5s7euK0jqSGhxMzJim8LBGj+buZu4noQ+uY4bOw+DI4QwpbTTteWvE1
         cQLoLyCYdJ5WhR809r14o4Iud99yjLzi09V0DWfzmfEIxguR8UpXPZ+faRi3WF+WOfXo
         Xo6x+FgoKmiFxfGx3E6WqhkRsOZiiCiQiqr2euF3FhPqFp7zQ70+nweHR6Z7Yon2QBrv
         Vrtqe0BUWsKuHKymPLm6T8PukXLIH3W/uyeSMUtti34RWNAVvJuWMdU7G2naJaxUPeo3
         w7xA==
X-Gm-Message-State: AOAM5333v/CorNhfjVJ6eJK+ZI+8lN51az6+yl4LYmCEx/3XqICoMjg4
        P+BmqU+ODtZ/HXZheF7m37V7OosRyNs=
X-Google-Smtp-Source: ABdhPJw5T+hFgItPd+lI/dkK62qn+iBCy+nEz8ACDpL2c2/eGZak55ocb4OOcY3FeHuK5M63LHHjsQ==
X-Received: by 2002:a17:90b:4b0d:: with SMTP id lx13mr4852924pjb.89.1640296355204;
        Thu, 23 Dec 2021 13:52:35 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id u15sm7557613pfk.186.2021.12.23.13.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 13:52:34 -0800 (PST)
Subject: Re: [PATCH 0/3] docs: sphinx/kfigure.py: Improve conversion to PDF
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <de8def13-efbc-1d98-acb5-5cc1f6902e4b@gmail.com>
 <87r1a3drhz.fsf@meer.lwn.net>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <38207705-f72a-8d79-caf9-d995bcd2a883@gmail.com>
Date:   Fri, 24 Dec 2021 06:52:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87r1a3drhz.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2021 12:56:56 -0700, Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>> This patch set improves conversions of DOT -> PDF and SVG -> PDF
>> for PDF docs.
>>
>> * DOT -> PDF conversion
> 
> So I'm unclear on the status of these patches; Mauro, are you happy with
> them?  If so I'd like to get them in before the merge window.

Jon, whether Mauro is happy or not, I want to do a respin of this and
at least fix the typo in PATCH 5/3 Randy pointed out.
Maybe merge PATCH 5/3 with PATCH 3/3 as well. 

There is no reason to hurry, I suppose.

I was kind of distracted by a development in other project lately.

        Thanks, Akira
> 
> Thanks,
> 
> jon
> 
