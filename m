Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D744B7989
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243218AbiBOVGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:06:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238507AbiBOVGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:06:34 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CE52A721
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:06:22 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i6so284341pfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uYxiEMeJ9sW9vGfu4qaZIOlJKxZ530WArSP68U8WQTQ=;
        b=I2gXDQT+rjYnRNkwYCBsw+ST8CnBlcsFJn+npMpE8yuxzOvb2+ijoEat9pnOv4GVK7
         b3P4LlmnJAm5HJFNWnjFV45rJYa0cBAJrzDDRBuADdxTJ1RjfpcSnBYfLOIQ+UgHNx7b
         PSiSN8Dnu8BnnN+rvSqSmD4NR3AeTfzgwSOX8ws98bDhAGKzEcx7nTbjgK5rFYcZEFiQ
         ZKeztyQOlkHVEMzQQu8O8IBvMjUYdQCI4cnshW3B07gb/QvLzjXhsSSxh4zC7yehChhl
         tsi48Q3OdZE87JBra0X/90WDgaMwC/qevyqAjB2QCMlWsA03Nc5DwstKjfW9rqglmab5
         LaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uYxiEMeJ9sW9vGfu4qaZIOlJKxZ530WArSP68U8WQTQ=;
        b=yFXvo0g35znNb59EL8vUw2gPfqJspO0kQvRZbOyam0W/uQlR1I8Qp2haVUL06Ux9RL
         dTyKBQSmL67zekezRtaPFx1EnFGsOsKOEko6eJO1TLzYwfRXe/z+VkIDKpP5+Akc2huX
         uO3UIP6I/JrqK8jJurGD1PplqoPrrFNqx30ip/b0dkljszsxWqSCTDmCtpfSYsygDkhd
         hpZfMdE6fmCIaYoxzzkjIMPaBafQrj7ZkZnEZmwUoN+/Bz9JwHyj172bPJzs7ZgLMBMa
         9BiGtnpVmVj3cRxPRbBLS9n3sGFVj6VloD+afJD3vqnx+oWq7p2mjMN5sA/IcM12mXy/
         0ozg==
X-Gm-Message-State: AOAM530X88yJ/onelxCgfh6NuWrZC8Q8fGttzYZB9QhdZXofM+2r70Qc
        plX7yqT78Fw4OIiJs1RIBvU=
X-Google-Smtp-Source: ABdhPJxEhu/wcIXAOxBEHtUxWHv8XlI/se8vhaPwmgtfYL8Y4DcaxZAh6S3JeDDwqTvBwu4zsCgpbg==
X-Received: by 2002:aa7:9387:: with SMTP id t7mr776994pfe.24.1644959182287;
        Tue, 15 Feb 2022 13:06:22 -0800 (PST)
Received: from google.com ([2620:15c:202:201:4e4a:b0ff:e926:40e2])
        by smtp.gmail.com with ESMTPSA id q8sm45166893pfl.143.2022.02.15.13.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 13:06:21 -0800 (PST)
Date:   Tue, 15 Feb 2022 13:06:19 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: kernel/module_decompress.c:264:36: error: 'module_kset'
 undeclared; did you mean 'module_use'?
Message-ID: <YgwVy598bcqbaHtb@google.com>
References: <202202140027.K0xZn3T2-lkp@intel.com>
 <b45a15ec-549d-25ba-f818-ed503ba991de@infradead.org>
 <YgnEsbnHXiuanfY/@google.com>
 <YgtX9OFbeNZdCZTp@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgtX9OFbeNZdCZTp@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 11:36:20PM -0800, Luis Chamberlain wrote:
> On Sun, Feb 13, 2022 at 06:55:45PM -0800, Dmitry Torokhov wrote:
> > On Sun, Feb 13, 2022 at 04:34:49PM -0800, Randy Dunlap wrote:
> > > 
> > > 
> > > On 2/13/22 08:57, kernel test robot wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
> > > > commit: b1ae6dc41eaaa98bb75671e0f3665bfda248c3e7 module: add in-kernel support for decompressing
> > > > date:   5 weeks ago
> > > > config: sparc-randconfig-r005-20220213 (https://download.01.org/0day-ci/archive/20220214/202202140027.K0xZn3T2-lkp@intel.com/config)
> > > > compiler: sparc-linux-gcc (GCC) 11.2.0
> > > > reproduce (this is a W=1 build):
> > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b1ae6dc41eaaa98bb75671e0f3665bfda248c3e7
> > > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > >         git fetch --no-tags linus master
> > > >         git checkout b1ae6dc41eaaa98bb75671e0f3665bfda248c3e7
> > > >         # save the config file to linux build tree
> > > >         mkdir build_dir
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash
> > > 
> > > FTR/FYI:
> > > # CONFIG_SYSFS is not set
> > 
> > Ugh, why is this even a thing?
> 
> If the kconfig supports it we need to support it. If you think
> we need to remove the option to be built-in we can take that
> up separately. In the meantime it would be wonderful if you
> can address this issue for Linus' tree.

Yes, of course, I was just wondering why we still have option to disable
sysfs. I guess some very purpose-built embedded systems might still
function without it...

-- 
Dmitry
