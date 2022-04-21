Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8F650A8DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383311AbiDUTTC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Apr 2022 15:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiDUTTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:19:00 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D140E4B40C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:16:07 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id k22so8012384wrd.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=AHLP1NJzIhUuorzbDM3B2ohS7cALSRAeCoZR22VkiWU=;
        b=OjhuWnzK+3y7brw4z4NlGnhTBLsxAwdXzVoF3wviBV1fDuuElGi/LotcK+j13mXtuy
         9MRg1+scht5dyNhsr+MJrTaQH2nsi/+ZQmWfHyZ+z7SasrTd89lFNhARAx/J+ZxjS6HS
         iA/siFNMecsM7rmz07weR7rAOdCqizv51jr1TEmlYR1cJRdZ023GcORP8mw4BbpFoOpn
         wBSxCZ1adgBK0d2v6RN3xTrjE5+FuQ+9lrca//P25OIWTf2DktRrFlvjEQ7pS0ti20qU
         tkPK7NV9HDgl4GIe+940AbxY+QmI+lJ8+Xm4glYivWaAcykvrgkaO8pF7g2/Zeu0rrEc
         heHw==
X-Gm-Message-State: AOAM530eBETtABpeEZe8JABt8OEGma43DHpsAKcFp807WwbxkfZthnJE
        NuPFunMvFx385F52+C6Il25aueDXxk0=
X-Google-Smtp-Source: ABdhPJwVWTrbptQ5HgW724jwGeCexvjlAE4JqlG/I3za3EqRCW4VVzxlGFXoXbiaA5dFfugGM/yAoQ==
X-Received: by 2002:adf:f508:0:b0:207:a8fe:c8bd with SMTP id q8-20020adff508000000b00207a8fec8bdmr857908wro.313.1650568566220;
        Thu, 21 Apr 2022 12:16:06 -0700 (PDT)
Received: from ?IPv6:2a00:23c6:c31a:b300:7e32:69f8:29ae:884a? ([2a00:23c6:c31a:b300:7e32:69f8:29ae:884a])
        by smtp.gmail.com with ESMTPSA id n42-20020a05600c3baa00b0038ffadd6e4asm2864364wms.30.2022.04.21.12.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:16:05 -0700 (PDT)
Message-ID: <3e91b72a86294b542acf460657d0fd94adeb252e.camel@welchs.me.uk>
Subject: Re: [PATCH v3 0/3] staging: vme: Cleanup driver tree old structures
From:   Martyn Welch <martyn@welchs.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bruno Moreira-Guedes <codeagain@codeagain.dev>
Cc:     Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Date:   Thu, 21 Apr 2022 20:16:05 +0100
In-Reply-To: <YmA4QIRfx2QPhEJi@kroah.com>
References: <cover.1650321310.git.codeagain@codeagain.dev>
         <YmA4QIRfx2QPhEJi@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-20 at 18:43 +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 18, 2022 at 08:29:49PM -0300, Bruno Moreira-Guedes wrote:
> > This patch series modify the vme_user driver's place in
> > menuconfig (1/3), fixes a missing `depends on` line in a Kconfig
> > file
> > (2/3), and rearrages the directory tree for the driver allowing a
> > more
> > straightforward comprehension of its contents (3/3).
> > 
> > The 'vme_user/' driver is the only remaining vme-family driver in
> > the
> > 'staging/' tree, but its structure, entry in menuconfig and
> > building
> > routines are still attached to the 'vme/' subtree now outside
> > 'staging/'. The present patchset fixes it.
> > 
> > Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
> 
> What about deleting the vme drivers entirely?

I assume you're suggesting deleting the "vme_user" driver from the
staging directory?

> Martyn, anyone still using these?
> 

I'm fairly sure that the actual VME drivers for the hardware bridges
(the bits not in staging) are still being used based on the
conversations I've had today. I'm just trying to find out whether the
vme_user bit is actively being used.

Martyn

> thanks,
> 
> greg k-h

