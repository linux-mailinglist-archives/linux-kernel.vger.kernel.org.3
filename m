Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E444A938D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 06:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239641AbiBDFZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 00:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240152AbiBDFZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:25:15 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576D7C061714;
        Thu,  3 Feb 2022 21:25:15 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so717432ooi.7;
        Thu, 03 Feb 2022 21:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TUKQvRX1U6GmcvjaJxEx2IzhTDTMQ3YK563hjEjpZOM=;
        b=cKmNCLkhVCMsvvip3UrC/ZcYWP29MdP/u6u9dN+AcU0hgbmjxvBU4dw7aDKF552V89
         4YhSS8hJTMTEU9hZneSb8j0Exnd6PG07quTH1EyfAzu/0IA31jeXAahRVgDC6J/A6Lwi
         mljSQ5okwU1DYvmeT558JC30zgQP99PU8MMkI7PrE07oeISelqp+rN4lRMJeNAGM7pVq
         hNYbTFq1so9wKOoQbz870G2Ws9+5z4o2jcoVrOQNr1LUMye+xOVQdut/Fu26ZaAjLDxD
         v8K/YXuskSX4d19BWFciVX1g3jCRVrb+VoDIVoioPYmAeV0ijrRXm6f+RHve4hD+jziz
         /EXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TUKQvRX1U6GmcvjaJxEx2IzhTDTMQ3YK563hjEjpZOM=;
        b=Z2voYNlttCLkMh9Dklcn5QIrLZ7jOnz/nW7ZN5NQC9IwqSdxTd69eQsMmFCs0f2WuK
         i9BVoiQbvx/wrtZJJ5psxl6OGh25l26f/jY1z3yWLruKSuvYyk8DPyk+GSpEKv2H9qA9
         EEi3Jlw/L5VO6QG1Qb0lmsrj6tZYfiYOe//FCpcXE1QKpFDmO6VfkfFmPE6oqhGkdQSX
         nqtOASkeSLcezUnpoT+3YWo6td4wHn6O3LOeCBK8cjtc88pS777fJiE6bGbsjAsv5gSy
         4uQDCSC1djWQAqCnZgjZI8LrnZ58UGi5dttrk9DJrxbrkbF6oA98+B9qiyfAvKjvoFw7
         10XQ==
X-Gm-Message-State: AOAM532sGc2cggybUW/6gJP1DMWA5MFMKbeDLCr6IH5UdWIJEjXV0qwb
        eMnAiZqnworMhaLFPy384t43suu5+uBE7g==
X-Google-Smtp-Source: ABdhPJxkee50jq2bBnncWf0Mu89WO6dM1DJR3c4y92Kwf/tNzZVUY4Hx0beXkA+g9N1EZ/pBtpmA/Q==
X-Received: by 2002:a05:6870:5ab3:: with SMTP id dt51mr221270oab.17.1643952314510;
        Thu, 03 Feb 2022 21:25:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n4sm392309otq.63.2022.02.03.21.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 21:25:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b2455ff8-2e51-7680-bf7d-6aa7e2d14b7d@roeck-us.net>
Date:   Thu, 3 Feb 2022 21:25:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: linux-next: build warning after merge of the hwmon-staging tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220204161614.457ba8a9@canb.auug.org.au>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220204161614.457ba8a9@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 21:16, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the hwmon-staging tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/hwmon/index.rst:18: WARNING: toctree contains reference to nonexisting document 'hwmon/asus_wmi_ec_sensors'
> Documentation/hwmon/asus_ec_sensors.rst: WARNING: document isn't included in any toctree
> 
> Introduced by commit
> 
>    d4b4bb104d12 ("hwmon: (asus-ec-sensors) update documentation")
> 
Fixed up, thanks!

Guenter
