Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5E253A47E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351756AbiFAMAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbiFAMAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:00:17 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E18EA5;
        Wed,  1 Jun 2022 05:00:16 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id f21so3227442ejh.11;
        Wed, 01 Jun 2022 05:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UL5PH5i+xuc8loEy0ATOPtr6G7svIoI4YSCb5ptBF3g=;
        b=ATdhMQpSXZWzXWLgUPNrpleqYwKgREEnQCofQlEELE9GqvuT/+Vyc5EhnKa48tRJ8K
         JdSkqVCvr/+dwwelxUkpLeS7BgWyDXRjUW9sDeLaTDs4BgvGMYQocBcQxKO+wjzTggfO
         PllPOu8sMS78tRO/kPY/1Q16PQj25jt7we+DqYIojCxzPMWRJosQMEHuu5NfSKNpG60Z
         5ub2RVJbsolsY1Q7LeJUXKFzGLN/hrDlxdYUpHN4ZfDOvFReLqEMePnlMkXag/qA2vSm
         eMEtDfoYFh6BabE0pmDYfx6+V8dBdY0LoodgY1iU+SNIviDjfm+5YXKHJbiF7CJ5vyMP
         jS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UL5PH5i+xuc8loEy0ATOPtr6G7svIoI4YSCb5ptBF3g=;
        b=h/TzRiMpXpUMQ8aI2WkSY0E/giO5T9/0xD9AOFtb23S1uP+4WQukGmOJXWD0KwxI3x
         XxiweriDPzMudj1SjVIROyrwj+/IvWaNXcdDGcLcDmcPqubfD770l7RijoeOJAGGfz2C
         51zJXYMTiF65qPzDDBIuXou31oEHQe6jpKaDK3x7LPU+Wl6qws2DCkzu0GiVjtdOz3Ev
         Q6FDarbxcQEfX9Lh5hX0cf0RRoA/mOUAEghBHjZjUQM1wQAdcDdKabP8GyM9Jsf4E9TX
         XMP0D1sklybRlfvFVs/w278YS5PfpZmNWu3XWdeW/gvCX5VusUWc24+xa/ZwB2ck+ywI
         RLdg==
X-Gm-Message-State: AOAM533fAwE6M9iZarsvbom0aGM60o/7IjWDIjn7NrbdcTspLxWFEdpG
        G09lr5sFcfrp/eK1oAB8hZI=
X-Google-Smtp-Source: ABdhPJyNXEn8aIfSas+HfoTrWtTtH/NVy/28V6xdWptELRxLACgmc0IFaUXuYNbLmh57/Kxnd3yJ/w==
X-Received: by 2002:a17:907:971e:b0:6fe:b652:7d51 with SMTP id jg30-20020a170907971e00b006feb6527d51mr50437482ejc.356.1654084814668;
        Wed, 01 Jun 2022 05:00:14 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id r7-20020aa7d147000000b0042dd792b3e8sm879353edo.50.2022.06.01.05.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 05:00:14 -0700 (PDT)
Date:   Wed, 1 Jun 2022 14:00:13 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-ia64@vger.kernel.org
Subject: Re: kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes
 address space '__rcu' of expression
Message-ID: <20220601120013.bq5a3ynbkc3hngm5@mail>
References: <202205222029.xpW3PM1y-lkp@intel.com>
 <87y1yspmmh.fsf@toke.dk>
 <20220601003834.ilvx2pik672yxuxt@mail>
 <87h7547k8c.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h7547k8c.fsf@toke.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 12:26:27PM +0200, Toke Høiland-Jørgensen wrote:
> Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:
> 
> > On Mon, May 23, 2022 at 12:30:14PM +0200, Toke Høiland-Jørgensen wrote:
> >> kernel test robot <lkp@intel.com> writes:
> >> 
> >> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >> > head:   eaea45fc0e7b6ae439526b4a41d91230c8517336
> >> > commit: 782347b6bcad07ddb574422e01e22c92e05928c8 xdp: Add proper __rcu annotations to redirect map entries
> >> > date:   11 months ago
> >> > config: ia64-randconfig-s031-20220522 (https://download.01.org/0day-ci/archive/20220522/202205222029.xpW3PM1y-lkp@intel.com/config)
> >> > compiler: ia64-linux-gcc (GCC) 11.3.0
> >> 
> >> Hmm, so this is ia64-only? Some kind of macro breakage? Paul, any ideas?
> >
> > Hi,
> >
> > It's surely IA64's cmpxchg() which contains lines like:
> > 	_r_ = ia64_cmpxchg8_##sem((__u64 *) ptr, new, _o_); 
> 
> Oh, right. Hmm, well, if the cmpxchg does an internal cast that
> complicates things a bit. My immediate thought was to move the
> unrcu_pointer() inside the calls to cmpxchg(), like:
 
> But that seems to confuse sparse because these are ptr-to-ptr
> constructs:

Yes, that can't work because it applies on the wrong level (same difference as
between "int const ** ptr" and "int * const * ptr").

I've taken a quick look and the problem is really to be solved in IA64's
macros for cmpxchg() and friends. Two things need to be done:
1) avoid casts like the "(__u64 *) ptr" here above (ideally no cast would
   be needed but a "(__u64 __force *) ptr" would be pefectly acceptable in
   such macros.
2) the value returned by these macros must match the type of the pointer
   and the old/new values. For example, on x86 such macros are written as:
	({
		__typeof__ (*(ptr)) __ret = (arg);
		switch (sizeof(*(ptr))) { 
		case ...
			... use ptr without dropping the address space ..

		__ret;
	)}

See, for example, arch/x86/include/asm/cmpxchg.h

-- Luc
