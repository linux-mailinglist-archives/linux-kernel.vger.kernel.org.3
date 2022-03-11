Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9514D6A36
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiCKXEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiCKXEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:04:31 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C726E61A30;
        Fri, 11 Mar 2022 15:01:17 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4C6362CD;
        Fri, 11 Mar 2022 21:06:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4C6362CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1647032761; bh=IyMpYQ9kln0EK8/pE+QsiTKmFWwoyuRDhba1yJzMID8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HWNpdeAbZ36NZaMZUDX/c7DIG4duixCytjeZQ4Igq69Ci9oTzU0PtXAOPRidn8cpU
         VV5c7E3Gz44am1BGsAlI283+UPG8FvAgoWdVE4Jmx/1SJK/2zC9uNKX+5vgK/DHG7C
         lpqQKMlM/b+q8+2UMZfTvg/BkqS3TAhrkfHgGm5byDkVF3D8zwIvphKEXzs002P9Js
         5wBpZNHn/u1yOLN0aikH7uVmHkfj3ghbCZGl8ZV/XgO8Sq6y/v36iDKAfvlzdsbQVv
         7DCS2yZ25O/a9csmYrRdGCeZju0/rXmvS3Ys48Psa30k+2fRGO2xfENxOKTJ5NQBCB
         ibz5eL7u1r1zw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@qq.com
Subject: Re: [PATCH] docs: serial: fix a reference file name in driver.rst
In-Reply-To: <f48dcaba-8015-380f-ac3b-54818c48350d@kernel.org>
References: <20220304100315.6732-1-wanjiabing@vivo.com>
 <f48dcaba-8015-380f-ac3b-54818c48350d@kernel.org>
Date:   Fri, 11 Mar 2022 14:06:00 -0700
Message-ID: <87mthw2o93.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@kernel.org> writes:

> On 04. 03. 22, 11:03, Wan Jiabing wrote:
>> Fix the following 'make refcheckdocs' warning:
>> Warning: Documentation/driver-api/serial/driver.rst references a file
>> that doesn't exist: Documentation/driver-api/serial/tty.rst
>> 
>> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

I've applied this.  But I have to wonder why Documentation/tty exists at
all; is there any reason not to move it all under driver-api?

Thanks,

jon
