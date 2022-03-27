Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51D34E88FE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbiC0Qwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiC0Qwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:52:34 -0400
X-Greylist: delayed 317 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Mar 2022 09:50:55 PDT
Received: from infomag.iguana.be (infomag.iguana.be [185.87.124.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 600B135271;
        Sun, 27 Mar 2022 09:50:55 -0700 (PDT)
Received: by infomag.iguana.be (Postfix, from userid 1001)
        id 31DD4603CACE; Sun, 27 Mar 2022 18:45:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 infomag.iguana.be 31DD4603CACE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iguana.be;
        s=infomag-20180602; t=1648399537;
        bh=xi9ghDIL666f80ISa8o1+6wJFPc5yErjMsKA+Zk2UJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bnCdiNPytPBpdDlSylv91q4aLJjwfaWVEDN4NRA/ae1U5RsbaY+CwZRqmeqRXQa++
         Cu1+FhZhkvyQFtOEplgWESwmJeM8DlLntC0HOW9T63vbASuG8YmxBxr80aOseMMBqS
         +u16NLPDBjP9Bq6V8Thq3mWff1rFh5VxanNR1AJI=
Date:   Sun, 27 Mar 2022 18:45:37 +0200
From:   Wim Van Sebroeck <wim@iguana.be>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the watchdog tree
Message-ID: <20220327164537.GA18817@infomag.iguana.be>
References: <20220321081023.72569774@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321081023.72569774@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Sorry for the delay. Fixed now.

Kind regards,
Wim.

> Hi all,
> 
> In commit
> 
>   1f7590ac16e7 ("watchdog: rti-wdt: Add missing pm_runtime_disable() in probe function")
> 
> Fixes tag
> 
>   Fixes: 2d63908 ("watchdog: Add K3 RTI watchdog support")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     This an be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").
> 
> -- 
> Cheers,
> Stephen Rothwell


