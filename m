Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DBE51C1E1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380403AbiEEOJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380404AbiEEOJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:09:10 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9599FE7
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 07:05:28 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c5-20020a9d75c5000000b00605ff3b9997so3011153otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 07:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IsOqIa/uGmg0NObsXFVP4j0R4HBLTkyhi0oCnQBTl0c=;
        b=cunAioYbKwaE7ZgFasXUe0TNbGhgCzwtENvJTNFUdqwF0eF4wPU+9XYUSeUK3bpSzu
         7T3RWrTQv6haxnTK6RmBOofm9aLwn7v0OgT5r6sIADpd7IehU2AAtewPR5+urQZvu05k
         cOj3FQ59r5AwOrwF6cEqSg7EF5VjowYWlCHcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IsOqIa/uGmg0NObsXFVP4j0R4HBLTkyhi0oCnQBTl0c=;
        b=Sve0stdQ2y8oZf+r45mjTCYNPM80InKEvdWvlrT17850nD7R5wRpRr+VM2Xw5/8CbB
         jkw4p5QJ6XnbYsubPZVxb3G0rSCrPgQdjs50ROXoBsmkySW0j4bRvfDd5O7z4VuOmQYC
         v5sNndywA48OaeED6tps6KL/mG+yynvgZNnmUIwYEKbRUUjIHCFZ9hU7/XO75lN9ylhk
         QastXBb3IFxSlGDmLtC6Nb+FVe45Dq2fIkz7TUWjkfsJ+mT818gUWZNjsx7JTRxm+Qjq
         q1IK7jgnZPiRyNn34dQqALcYAOQ+zmnZ8AAi7mvRNU2OAOubqKhF8UGoOADMlndLwdDV
         y91Q==
X-Gm-Message-State: AOAM531pPZVtSU/ObRvKe9VyK3fk3VWO7qyfTJ7qPHhu2DCYn3aAGdXh
        feR0SpFJvpid9GoHH1Ic50Ie/Q==
X-Google-Smtp-Source: ABdhPJwOseP4YDjrLfHFg1HM982efkMpwGpsnYZxl0axyQQTH9NJYgEoiSAyfPdqvkvpiSJZybjrkQ==
X-Received: by 2002:a9d:5e11:0:b0:605:c1f4:a4e3 with SMTP id d17-20020a9d5e11000000b00605c1f4a4e3mr9297597oti.227.1651759527885;
        Thu, 05 May 2022 07:05:27 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id x7-20020a9d4587000000b0060603221274sm607296ote.68.2022.05.05.07.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 07:05:26 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Thu, 5 May 2022 09:05:23 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.17 000/225] 5.17.6-rc1 review
Message-ID: <YnPZozIsPdRiUHCg@fedora64.linuxtx.org>
References: <20220504153110.096069935@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504153110.096069935@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 06:43:58PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.17.6 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 May 2022 15:25:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.17.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Outside of the x86_64 build failure due to
[PATCH 5.17 162/225] ASoC: Intel: sof_es8336: Add a quirk for Huawei Matebook D15

All other arch seem to build fine. We just need to either drop the
sof_es8336 patch listed or add the dep patches I listed.

Justin
