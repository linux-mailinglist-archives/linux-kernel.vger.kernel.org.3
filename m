Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA064D3E5A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiCJAqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiCJAqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:46:30 -0500
X-Greylist: delayed 934 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Mar 2022 16:45:29 PST
Received: from smtpq3.tb.ukmail.iss.as9143.net (smtpq3.tb.ukmail.iss.as9143.net [212.54.57.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3B565437
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:45:29 -0800 (PST)
Received: from [212.54.57.96] (helo=smtpq1.tb.ukmail.iss.as9143.net)
        by smtpq3.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <zarniwhoop@ntlworld.com>)
        id 1nS6gl-0007ZL-6Y
        for linux-kernel@vger.kernel.org; Thu, 10 Mar 2022 01:29:55 +0100
Received: from [212.54.57.106] (helo=csmtp2.tb.ukmail.iss.as9143.net)
        by smtpq1.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <zarniwhoop@ntlworld.com>)
        id 1nS6gj-0002sG-8G
        for linux-kernel@vger.kernel.org; Thu, 10 Mar 2022 01:29:53 +0100
Received: from llamedos.mydomain ([81.97.236.130])
        by cmsmtp with ESMTPA
        id S6ginWO6qB5IlS6ginzfBV; Thu, 10 Mar 2022 01:29:53 +0100
X-SourceIP: 81.97.236.130
X-Authenticated-Sender: zarniwhoop@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=XIEj9CtE c=1 sm=1 tr=0 ts=62294681 cx=a_exe
 a=OGiDJHazYrvzwCbh7ZIPzQ==:117 a=OGiDJHazYrvzwCbh7ZIPzQ==:17
 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=pGLkceISAAAA:8 a=07d9gI8wAAAA:8
 a=VwQbUJbxAAAA:8 a=5gREawPU8w4pKPWqZwoA:9 a=QEXdDO2ut3YA:10
 a=e2CUPOnPG4QKp8I52DXD:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
        s=meg.feb2017; t=1646872193;
        bh=itlXJNpz8fUGS/shN3O1AKR2ZZ8QkAg/FhMvnKn4DDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=D+ZDBuBVvEaIi8YQ4xpbEYK4eYFqIUi42FxAXwVdx4XtOubizvEK8VvgtJC5VPe/W
         aYRx73kkjrTpYAXF/xcbSLh/++gpCg6cmoOy1pAIdlaF8p2B+24QfVTW+9LHF5yeqs
         ZnMY3zMkp/kr+8vvyx5HinJqF9wq/cQZ2AjQBsPgc1tAQWoLmM+mdikK+NZUbLg34s
         qhRP8T1zhUyd+uH9cW68b4+NzErObc7acgJn0oFf4f6cmbOUCqQuWIdFr1VHAfOtzv
         d+Zn51S9Qm2yFbKjW9D201slH+8ToJZa36SP1SPOfVwUgKOr8Wv5DdNIenYYRj7o4D
         munX5+AksRNSA==
Received: by llamedos.mydomain (Postfix, from userid 1000)
        id D5CFE60C4F; Thu, 10 Mar 2022 00:29:52 +0000 (GMT)
Date:   Thu, 10 Mar 2022 00:29:52 +0000
From:   Ken Moffat <zarniwhoop@ntlworld.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: describe how to apply incremental stable
 patches
Message-ID: <YilGgO03v+CM0aDq@llamedos.localdomain>
References: <20220307063340.256671-1-bagasdotme@gmail.com>
 <87mthy7lif.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mthy7lif.fsf@meer.lwn.net>
User-Agent: Mutt/2.2.1 (2022-02-19)
X-CMAE-Envelope: MS4xfHUqsACAFenD9OguapbTyegxxLYTnV8mJh64zwNVt3Tgg+VfIvzTPQMLGrrPy5Dtpj3sfc9VQTp8vEqAvF5E5ivkgvOhV3KN4qswmB5Ct9z5E90WdV8+
 meUWmYW7YmLfv9KuI17sJMcuS0me33iPkEaaFG0ZELukS7I/ObusBphPu+5p+1b5HdrombyZk3QUwlAnF/O4irBv1+CPfnAlKeX6nB55CTPTddH5BTWHs3+j
 8L3r21RV6puQ+pAogSm5tnY8D60/iRcpUXb/MGKBHWb3mdWyaQaqQWjiot5+ds61wpsm+an4mh4b5vwOpJTqGtrjONrzWX8uXDnhsn4KoHs=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 04:29:28PM -0700, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
> > The applying patches document
> > (Documentation/process/applying-patches.rst) mentions incremental stable
> > patches, but there is no example of how to apply them. Describe the
> > process.
> >
> > While at it, remove note about incremental patches and move the external
> > link of 5.x.y incremental patches to "Where can I download patches?"
> > section.
> >
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: SeongJae Park <sjpark@amazon.de>
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> >  Documentation/process/applying-patches.rst | 28 ++++++++++++++++++----
> >  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> I've applied this, thanks.  I do have to wonder, though, how useful this
> information is anymore.  Does anybody actually apply kernel-patch files
> this far into the Git era?
> 
> Thanks,
> 
> jon

I do.  I have several machines with multiple systems (current, old,
older, experimental) and mostly I build current kernels in the
current system, and older LTS in the old systems.  Ideally I will
find time to test an rc, but I only use git for kernels when I need
to bisect.  I find it much easier to keep the initial relase tarball
and chosen point patches on my local nfs.

My interests are userspace, and some of my machines are
comparatively slow to compile kernels.

ĸen 

-- 
The beauty of reading a page of de Selby is that it leads one
inescapably to the conclusion that one is not, of all nincompoops,
the greatest.            -- du Garbandier
