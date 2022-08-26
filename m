Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DA15A2CCA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344697AbiHZQvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344742AbiHZQvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:51:17 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7923374B8C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:50:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx409.security-mail.net (Postfix) with ESMTP id 6116C323748
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:50:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661532640;
        bh=AseuychHjEOpookEUFULzBTeO6LdB9Wyub4FHlDpL7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HG9lhz6OPrBnObhaNPXU3M00uxefqAicDixXM40IoBnCjHjVMrbk0mtoLNFYlGjWN
         vU2bysk/llmGC0G4kKStNuiZJjNOCTfLNF4BP0o/XovJwQF+3QF9ljOJeoZMuxnc5D
         Fnlq4h7d53AdcWqvb202XbHjR0gM6pshAPmsggec=
Received: from fx409 (localhost [127.0.0.1]) by fx409.security-mail.net
 (Postfix) with ESMTP id 093203236EB; Fri, 26 Aug 2022 18:50:39 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx409.security-mail.net (Postfix) with ESMTPS id 58F0D3236BA; Fri, 26 Aug
 2022 18:50:38 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 3822527E0392; Fri, 26 Aug 2022
 18:50:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 1D83F27E0396; Fri, 26 Aug 2022 18:50:38 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 rrSgUlqqGfIt; Fri, 26 Aug 2022 18:50:38 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 0667E27E0392; Fri, 26 Aug 2022
 18:50:38 +0200 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <12fd7.6308f9de.56d05.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 1D83F27E0396
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661532638;
 bh=Y1zQ6BNU1UVYGbj+qjtbqtKsCevuA+8wVxqT62kC9G0=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=A3COjUPswvuybrQTpDfCvgX08bvnwotI8Xq07SlG++M82n5PzCDs9pa+7clYFPTyd
 083gj3YWMwbo2dcXcu8cqtBXaN/yHBfr4p0xCBXkh4M8eiebj5GaebjAaANoiMtK12
 g5ZWJQYpOzRQERvDNg0bnomocgjrBWUFAAJ2eMZs=
Date:   Fri, 26 Aug 2022 18:50:36 +0200
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Conor.Dooley@microchip.com
Cc:     linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        bagasdotme@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] Remove duplicated words across the whole
 documentation
Message-ID: <20220826165036.GE10294@tellis.lin.mbt.kalray.eu>
References: <20220826143300.6794-1-jmaselbas@kalray.eu>
 <20220826163458.1142-1-jmaselbas@kalray.eu>
 <cccaf53c-9438-0927-b074-c74c47bfb1ec@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cccaf53c-9438-0927-b074-c74c47bfb1ec@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 04:40:50PM +0000, Conor.Dooley@microchip.com wrote:
> Hey Jules,
> On 26/08/2022 17:34, Jules Maselbas wrote:
> > Remove duplicated words (the, at, be ...) across the whole documentation.
> > In some cases the duplicated words are replaced by something that makes
> > more sense, for instance: "be be" is replaced by "can be" when possible.
> > 
> > There are likely more duplicated words to be found.
> > 
> > CC: Randy Dunlap <rdunlap@infradead.org>
> > CC: Bagas Sanjaya <bagasdotme@gmail.com>
> > CC: Jonathan Corbet <corbet@lwn.net>
> > CC: linux-doc@vger.kernel.org
> > Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> > ---
> 
> 
> >  
> >  printk_rb_static
> > diff --git a/Documentation/admin-guide/media/vivid.rst b/Documentation/admin-guide/media/vivid.rst
> > index 4f680dc9661c..a5a9c062b23f 100644
> > --- a/Documentation/admin-guide/media/vivid.rst
> > +++ b/Documentation/admin-guide/media/vivid.rst
> > @@ -392,7 +392,7 @@ Which one is returned depends on the chosen channel, each next valid channel
> >  will cycle through the possible audio subchannel combinations. This allows
> >  you to test the various combinations by just switching channels..
> >  
> > -Finally, for these inputs the v4l2_timecode struct is filled in in the
> > +Finally, for these inputs the v4l2_timecode struct is filled in the
> 
> FYI, this does not look like a typo. It reads as if the filling in happens
> in the dequeued struct.
You're right, I tought the same when seeing this elsewere, this is a mistake.

> 
> >  dequeued v4l2_buffer struct.
> >  
> >  
> 
> > diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> > index af2a97429692..ce67a03a7c80 100644
> > --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> > +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> > @@ -1090,7 +1090,7 @@ be formatted as plain text.
> >  
> >  Developing always goes hand in hand with debugging. First of all,
> >  you can always run UML under gdb and there will be a whole section
> > -later on on how to do that. That, however, is not the only way to
> 
> And neither is this. It means that there will be a later section that
> explains how to do it. Possibly there should be some punctuation in
> between though.
Yeah... I personally think that this reads badly but I don't mind dropping
this change.

> 
> > +later on how to do that. That, however, is not the only way to
> >  debug a Linux kernel. Quite often adding tracing statements and/or
> >  using UML specific approaches such as ptracing the UML kernel process
> >  are significantly more informative.
> 
> Thanks,
> Conor.
> 
> 




