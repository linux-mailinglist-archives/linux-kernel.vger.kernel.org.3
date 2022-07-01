Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801D7562D0D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiGAHx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiGAHxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:53:23 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB311571B;
        Fri,  1 Jul 2022 00:53:18 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 2346041A80;
        Fri,  1 Jul 2022 09:53:16 +0200 (CEST)
Authentication-Results: ext-mx-out003.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1656661995; x=1658476396; bh=P2xW8RAKZgVCO8JagbR3K85O7/vn6UpB/KM
        K5m2zFFI=; b=hs97aeaxzPBepYy56KfzzhGl7pEh11cKV8tmCogbizWYLLTQXiS
        LSQ2kFDLQbQK7lRCx6Zy32DxrNy/CkLAANK0sycWmthAldYfZOXHxxoiEL3Q/yEj
        G2D6uZTExpGMfFtlveKvpuC5TWZ3y6MtFH/p2qYefR+qLt2ypmHusPr8DZf60J/A
        bIYdOrUtw6jxc8ElTA2u1Xn1pkGZuLfBFiyOgaOkmXL5EoxOuI1Je46CRmASqjGA
        eY8bM4R6cTxM7igXtQh586lZW+2CSAc5pOtJZbDiIag1QDAsPlF65dz4jv5Xsw/E
        Ss0J28nLr5wnvI33RyMaXdcPLDhLAvqNKvB9egXbU7tiEsPBsOWmne1VGNPK/GMu
        7B+z5B9iBlxgWKmQxUTwQ0JUeP6sB2nw37vhZ+raQCcpwszXLJAhdnbaBo0hK/xF
        qwuGkaZ/a6frztzOuCO4zDJKkbkf2QA2RcF6ZV6ikvzAkd49rFNE+XI/1m6bnmud
        5btuqOpx1jqpHmLDyxJsGPd1RRia2xfxh/8wCcp8xRKbOrJvXlacmwW0RLUnaeR5
        Ywuy00kASBIwr1SSLzjn81pr5+61RBYELtl03rdJSFzJKpOOfUhuncqHXPLk7Hhl
        C8pHHmCON5sh6Cb3NMHjWHWaKmWO1KIiNK0jtUfoqc59M0gsKhAhKlXg=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qUvTHXEY6TZy; Fri,  1 Jul 2022 09:53:15 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by mx.kolabnow.com (Postfix) with ESMTPS id 7DBF241A59;
        Fri,  1 Jul 2022 09:53:14 +0200 (CEST)
Received: from int-subm002.mykolab.com (unknown [10.9.37.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 09F5B904;
        Fri,  1 Jul 2022 09:53:13 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 01 Jul 2022 09:53:12 +0200
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: align Italian documentation
In-Reply-To: <87letenhc3.fsf@meer.lwn.net>
References: <20220628111603.603357-1-federico.vaga@vaga.pv.it>
 <87pmiqnjbz.fsf@meer.lwn.net> <87letenhc3.fsf@meer.lwn.net>
Message-ID: <672f9a07653412d359e4992eb175d792@vaga.pv.it>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-30 20:20, Jonathan Corbet wrote:
> Jonathan Corbet <corbet@lwn.net> writes:
> 
>> Federico Vaga <federico.vaga@vaga.pv.it> writes:
>> 
>>> Translation for the following patches
>>> 
>>> commit df05c0e9496c ("Documentation: Raise the minimum supported 
>>> version of LLVM to 11.0.0")
>>> commit 333b11e541fe ("Documentation: Add minimum pahole version")
>>> commit 6d6a8d6a4ed0 ("docs: Update Sphinx requirements")
>>> [...]
>> 
>> Applied, thanks.
> 
> Actually, I take that back; it creates a massive mess of docs-build
> warnings:
> 
>   MAINTAINERS:4: WARNING: duplicate label maintainers, other instance
> in /stuff/k/git/kernel/Documentation/process/maintainers.rst
>   MAINTAINERS:107: WARNING: unknown document:
> ../maintainer/maintainer-entry-profile
>   MAINTAINERS:165: WARNING: unknown document:
> ../networking/device_drivers/ethernet/3com/vortex
>   MAINTAINERS:235: WARNING: unknown document: ../networking/6lowpan
>   [...]
> 
> This all comes down to the duplicate copy of
> Documentation/process/maintainers.rst that your patch adds.  Don't do
> that, please.

I see, I think I overlooked at that because I was grepping for `it_IT` 
errors.
Sorry for the problem, and thanks for pointing it out. I will send a V2.

-- 
Federico Vaga
http://www.federicovaga.it/
