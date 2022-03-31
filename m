Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98DC4ED609
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiCaIpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiCaIpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:45:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5F01E5A57
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:43:53 -0700 (PDT)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MoOIi-1oOYJE0SDY-00oqRW for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022
 10:43:52 +0200
Received: by mail-wr1-f42.google.com with SMTP id d7so32670472wrb.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:43:52 -0700 (PDT)
X-Gm-Message-State: AOAM533qVaCvbmzQiHel6NH47964D+Oshv4RiPKdr0KYpfNvlh2U9zov
        N6dpmch5v0rhArwilmMiLRj5VzVdHK62oJJPsSg=
X-Google-Smtp-Source: ABdhPJyrtpQlBduGdImQtwl3TfY7OVK8ndVvnJ/5XRBmxDFBRN2DthMS2Ieu+gTrPWm1ExwDF53U+Xfq7QQVJM2Ifeo=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr3269024wrh.407.1648716231569; Thu, 31
 Mar 2022 01:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <202203281004.InhLOFxn-lkp@intel.com>
In-Reply-To: <202203281004.InhLOFxn-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 31 Mar 2022 10:43:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0ShMf+QCHWishO9DbvRrJ5x9f=9cS9kwm_tkBqwyWtEw@mail.gmail.com>
Message-ID: <CAK8P3a0ShMf+QCHWishO9DbvRrJ5x9f=9cS9kwm_tkBqwyWtEw@mail.gmail.com>
Subject: Re: drivers/pci/proc.c:150:17: sparse: sparse: restricted __le16
 degrades to integer
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:OYPQm7H1fHgJDKBuo7XjiLKtmMHnBrn2SaM67c7pw/LPQYpcPlD
 8OV1Iz1hnYV1Zz1WJU5lyQiyqn8JMJe0UO/fE6wZcE27zRT1dN6hJ26qd8fZR2TTG4QHmzn
 3IFQFipRfGKWxogVTc5wEdbCybwJTfh5pRu/bynv45ueWdqUv1NTV1CeLbpieZycsocZKec
 FqfhgDuv1prerWAJMcN9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aWWU0dyB2l0=:J1MVAfSoCZorJcMwNp5wKK
 7gecCL9oq8NJrOfL3Pj0YEZ5T5JTcsEuERQGwGjK9WsosRuAPAyGWLVsESghQ9/PFe1eEy0ay
 P1TqQmlM5iXxo6fwlVlfEGs+KZ8N3ubIZiaHpNNIrjEYQhX6RCXnvEij5nBkpDJo/h2cpZzGC
 iZ5uW5waANHJaQ5J7F6VYC29iV02ZC3FfpL43VNTsU6nQe86UWqAfwtxS9EiAv8mZLAmjHnu3
 vKmjn18eulbjj9IfKtpeEYh3LLfwj0iJ9NVjgpfd5KH+B05gS8LzuM4Yf6mwaNWxwIdaQgsje
 +8leNZgrQUMoKQ3hSZyOJBlF+Fiv9Aqu+JgFQLb7u4m/iexDeuXpNe1FSn9F5UVi2MTIg0td3
 MPIB5/Qmb9EnxOuDMNiF3Z28Ziyx0QCUQ80GCPqoTZRqg+WgFQHzn5x7iA4Mq93JxDa6+FZ25
 ar9/JC/p3iber7X1+NNY4ZvKrZP1xW5fy6NZ2Mbj92W1JwSisbJLhJUsN1tgm9+IsvgbuGeQV
 pg4LUFgOcaFuPAHM+d3DA3LhovR6ZJ/03FGpnp9U9SAt+LvTDE1NrVFdZaPLtTS2hNL6X0CRe
 I/kv6XWqgl1D3RmzhDQE97XhZJnH0lfuplpIRHULwZBVefEbNZOe8Tdieh0PzuGfwE8iMe1yu
 yaGPUoaXHVabuV+geMrEX2/4qEYTMB/GqSKrRhY6qBxxOsSTyz+U4zsR+f1XF4ARvNvSWnlt5
 UwaEuoCgnNNLrVVIEC/UPBgQx4UumzLnIRl6X5I3AJLM4pkRMk/Tqa5GmksWCal59EhSMAH3M
 mjZwRTqc2c5sLXQrVlaQgAPeBQd6RMD35TcSuYl36KZ2okbdx0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 5:04 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f82da161ea75dc4db21b2499e4b1facd36dab275
> commit: a97b693c3712f040c5802f32b2d685352e08cefa uaccess: fix nios2 and microblaze get_user_8()
> date:   4 weeks ago
> config: microblaze-randconfig-s032-20220328 (https://download.01.org/0day-ci/archive/20220328/202203281004.InhLOFxn-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a97b693c3712f040c5802f32b2d685352e08cefa
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a97b693c3712f040c5802f32b2d685352e08cefa
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/pci/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
> >> drivers/pci/proc.c:150:17: sparse: sparse: restricted __le16 degrades to integer
> >> drivers/pci/proc.c:150:17: sparse: sparse: restricted __le16 degrades to integer
>    drivers/pci/proc.c:150:17: sparse: sparse: cast to restricted __le16
> >> drivers/pci/proc.c:159:17: sparse: sparse: restricted __le32 degrades to integer
> >> drivers/pci/proc.c:159:17: sparse: sparse: restricted __le32 degrades to integer
>    drivers/pci/proc.c:159:17: sparse: sparse: cast to restricted __le32
>    drivers/pci/proc.c:168:17: sparse: sparse: restricted __le16 degrades to integer
>    drivers/pci/proc.c:168:17: sparse: sparse: restricted __le16 degrades to integer
>    drivers/pci/proc.c:168:17: sparse: sparse: cast to restricted __le16

On Tue, Mar 29, 2022 at 8:56 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Looks like new uaccess code doesn't handle sparse __bitwise annotations.

Right. I copied the line that caused this from 32-bit riscv, which has the same
issue, same on openrisc after d877322bc1ad ("openrisc: Fix issue with
get_user for
64-bit values").

It sounds like we should fix all three of these the same way, any
suggestion which
architecture to copy from?

       Arnd
