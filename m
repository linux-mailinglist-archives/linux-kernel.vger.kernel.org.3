Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C267D51ED76
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 14:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbiEHMUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 08:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiEHMUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 08:20:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB4EC4A
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 05:17:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kx3Fk0GcDz4ySm;
        Sun,  8 May 2022 22:16:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1652012218;
        bh=nYBY4kkTsW6iuV1RCYhlkMA32XogsD8gW9xHfSRlYqo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YuT41fbmtJ/1RnF7n55wx/a/LjygvQTQvTDxf8UprGpUq2SZyf/DfNQdGBhCu1Abl
         K++UueqBZdYlVhkHnmyZnZEf/UfAXMq3+KJTUIJp04fmM8ddwQd/bKKyEN4rrV9pq9
         11CnzPUVXZ6Ptu92Zm2/qYbKJ+mMIGgk6+2nS57b4h3NdqEkGRB0Ek9rcQUtqGXN/R
         IJQvxrh4uYQBg28VHNghJzWzNteFT6oVMUZOiKTfVcRnxfwpCACKS0Ulufmkdujlam
         o91dKGvmRB604LTvkAyJDw6qHRgk+k+ndhskI54KmmwBjmn+Cmy4b0HFcEBn6xT1vT
         dxCLiMb3B99ow==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [linuxppc:next-test 75/91]
 arch/powerpc/kernel/prom_parse.c:10:6: warning: no previous prototype for
 'of_parse_dma_window'
In-Reply-To: <1e373bfc-44ec-0e3b-e667-0e56f1e91709@csgroup.eu>
References: <202205061138.zH9VucCL-lkp@intel.com>
 <1e373bfc-44ec-0e3b-e667-0e56f1e91709@csgroup.eu>
Date:   Sun, 08 May 2022 22:16:56 +1000
Message-ID: <87czgote13.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 06/05/2022 =C3=A0 05:46, kernel test robot a =C3=A9crit=C2=A0:
>> tree:   https://github.com/linuxppc/linux next-test
>> head:   1d8abffc14aef88bfe1ad036084070af62f30c03
>> commit: 34fa52eec206db38399dc9b54f2da2eed4fdad5e [75/91] powerpc: Remove=
 asm/prom.h from all files that don't need it
>> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20=
220506/202205061138.zH9VucCL-lkp@intel.com/config)
>> compiler: powerpc-linux-gcc (GCC) 11.3.0
>> reproduce (this is a W=3D1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/linuxppc/linux/commit/34fa52eec206db38399d=
c9b54f2da2eed4fdad5e
>>          git remote add linuxppc https://github.com/linuxppc/linux
>>          git fetch --no-tags linuxppc next-test
>>          git checkout 34fa52eec206db38399dc9b54f2da2eed4fdad5e
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.3.0 make.c=
ross W=3D1 O=3Dbuild_dir ARCH=3Dpowerpc SHELL=3D/bin/bash arch/powerpc/kern=
el/
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> arch/powerpc/kernel/prom_parse.c:10:6: warning: no previous prototype =
for 'of_parse_dma_window' [-Wmissing-prototypes]
>>        10 | void of_parse_dma_window(struct device_node *dn, const __be3=
2 *dma_window,
>>           |      ^~~~~~~~~~~~~~~~~~~
>>
>>
>
> Ok, so asm/prom.h must remain in arch/powerpc/kernel/prom_parse.c to get
> of_parse_dma_window() prototype.
>
> Michael, can you drop the hunk when applying ?

Yep, done.

cheers
